/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Algoritmos;


import Puntos.Punto;
import Puntos.Trio;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author anton
 */
public class Algoritmos {
    
    public static int [] padres;
    
    //Implementacion del algoritmo de ordenacion quickSort para ordenar puntos segun el eje x
    public static Punto[] QuickSort(Punto[] p)
    {
        Quick_Sort(p , 0 , p.length - 1);
        return p;
    }
    
    public static void Quick_Sort(Punto[] puntos, final int e, final int d) {
        if (e < d) {
            int q = partition(puntos, e, d);
            Quick_Sort(puntos, e, q);
            Quick_Sort(puntos, q + 1, d);
        }
    }
    
    @SuppressWarnings("empty-statement")
    public static int partition(Punto[] T, final int e, final int d) {
        double x = T[e].getX();
        int i = e - 1;
        int j = d + 1;
        for (;;) {
            while (x < T[--j].getX());
            while (T[++i].getX() < x);
            if (i >= j) {
                return j;
            }
            swap(T, i, j);
        }
    }
    
    public static void swap(Punto[] T, final int i, final int j) {
        Punto aux = T[i];
        T[i] = T[j];
        T[j] = aux;
    }
    
    //Algoritmo exhaustivo
    
    public static Trio exhaustivo(Punto [] Ps,int ini , int fin)
    {
        Trio sol = new Trio(Ps[0],Ps[1],Ps[2]);
        //System.out.println("Distancia minima del primer conjunto->" + sol.DistMin);
        
        for(int i = ini ; i < fin - 2 ; i++)
        {
           for(int j = i+1 ; j < fin - 1 ; j++)
           {
               for(int k = j+1; k < fin ; k++)
               {
                   Trio t = new Trio (Ps[i], Ps[j], Ps[k]);                                   
                   
                    if(t.DistMin < sol.DistMin) 
                        sol = t;
                } 
            } 
        }          
        //System.out.println("Distancia entre los puntos de la solucion :"+sol.DistMin);
        return sol;
        
    }
    
    
    //Algoritmo Divide y vencerás
    
    public static Trio DyV (Punto [] Ps , int ini ,int fin)
    {        
        if (fin - ini + 1 <= 5) {
            return exhaustivo(Ps,ini,fin);
        }
        int m = (ini + fin) / 2;
        Trio tI = DyV(Ps, ini, m);
        Trio tD = DyV(Ps, m + 1, fin);
        Trio tMin = tD;
        if (tI.DistMin <= tD.DistMin) {
            tMin = tI;
        }
        //quedarme con los bordes en x e y
        int a=ini;
        int b=fin;
        
        
        for(int i = m;i>=ini;i--)
        {
            if(Ps[m+1].getX()-Ps[i].getX()>tMin.DistMin)
            {
                a=i+1;
                        break;
            }
        }
        for(int i =m+1;i<=fin;i++)
        {
            if(Ps[i].getX()-Ps[m].getX()>tMin.DistMin)
            {
                b=i-1;
                break;
            }
        }     
        Trio aux;
        for (int bI = a; bI <= m; bI++) {
            for (int bJ = m + 1; bJ <= b-1; bJ++) {
                for (int bK = bJ + 1; bK <= b ; bK++) {
                    aux = new Trio(Ps[bI], Ps[bJ], Ps[bK]);
                    if (aux.DistMin < tMin.DistMin) {
                        tMin = aux;
                    }
                }
            }
        }
        for (int bI2 = a; bI2 <= m; bI2++) {
            for (int bJ2 = bI2 + 1; bJ2 <= m; bJ2++) {
                for (int bK2 = m+1; bK2 <= b; bK2++) {
                    aux = new Trio(Ps[bI2], Ps[bJ2], Ps[bK2]);
                    if (aux.DistMin< tMin.DistMin) {
                        tMin = aux;
                    }
                }
            }
        }        
        return tMin;
    }
    
   
    
    //Algoritmo de Dijsktra 
    
     public static int[] Dijkstra(double[][] mAdyacente,int ini)
    {
        int[] sol = new int[mAdyacente[0].length]; //Devolver la solucion al problema
        double[] solucion = new double[mAdyacente[0].length]; //Comparar con los costes y distmins que son doubles
        boolean[] visitados = new boolean[mAdyacente[0].length]; // Saber que punto ha sido visitado y cual no
        int[] padres = new int[mAdyacente[0].length]; // Saber el recorrido realizado en todo momento
        
        for(int i = 0 ; i < visitados.length ; i++)
        {
            visitados[i] = false;
            solucion[i] = Double.MAX_VALUE;
        }
        
        solucion[ini] = 0;
        padres[ini] = -1;
        
        
        // Todos los caminos del primer punto
        
        for(int i = 0 ; i < mAdyacente[0].length;i++)
        {
            int recorrido = -1;
            double dMin = Double.MAX_VALUE;
             for(int j = 0 ; j < mAdyacente[0].length;j++)
             {
                 if(!visitados[j] && solucion[j] < dMin) //Si no lo hemos visitado y la solucion distancia es menor a la actual , nos ponemos en el y cogemos su distancia como solucion 
                 {                                       //Es decir encontramos el punto mas cercano al actual
                     recorrido = j;
                     dMin = solucion[j];
                 }
             }
             
             visitados[recorrido] = true; //Marcamos ese punto como ya visitado
             
            for(int j = 0 ; j < mAdyacente[0].length;j++)
            {
                double coste = mAdyacente[j][recorrido]; 
                    if(coste > 0 &&  ((dMin + coste) < solucion[j])) //Si el coste es mayor a 0 y la dmin + el coste son menores que el valor en solucion 
                    {                                                // añadimos a recorrido como padre del punto actual 
                        padres[j] = recorrido;
                        solucion[j] = dMin + coste;
                    }
            }
        }
        int contador=0;
        for(int i = 0 ; i < solucion.length ; i++)
        {
            sol[i] = (int) solucion[i];            
            contador += sol[i];
        }
        
        setPadres(padres); 
        System.out.println("Coste total combinado--->"+contador);
        return sol;
       
    }
     
     //Pasar de array de puntos a matriz doble para Dijkstra
     public static double[][] mAdyacencia (Punto[] p)
     {
         double[][] matriz = new double[p.length][p.length];
         
         for(int i = 0 ; i < p.length ; i++)
         {
             matriz[i][i] = Integer.MAX_VALUE;
                for(int j = 1 ; j < p.length ; j++)
                {
                    matriz[i][j] = matriz[j][i] = CalculaCoste(p[i],p[j]);
                   // System.out.println("Coste del camino "+i+""+matriz[i][j]);
                }
         }
         
         return matriz;
     }
     
      public static double CalculaCoste(Punto p1 , Punto p2)
     {
         double aux =0;
         double distP2P = Trio.CalculaDist(p1, p2);         
         aux = ((int)(distP2P * 100) % 100) + 1;         
         return aux;
     }
     //Guardar el camino seguido en cada momento
     public static String camino(int[]padres , int ini , String v)
     {
         if(ini == -1){
             return v;
         }else if (ini == 0){
             v += ini;
         } else {
             v += ini + ",";
         }
         return camino(padres , padres[ini],v);
     } 

    /**
     * @return the padres
     */
    public static int[] getPadres() {
        return padres;
    }

    /**
     * @param padres the padres to set
     */
    public static void setPadres(int[] padres) {
        Algoritmos.padres = padres;
    }
}
