/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Puntos;


import Algoritmos.*;
import Puntos.Punto;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author anton
 */
public class Ficheros {
    
    public static Punto[] leer(String archivo)
    {
        Punto[] puntos = null;
        int i = 0;
        try
        {
            BufferedReader in = new BufferedReader(new FileReader(archivo));
            String linea;
            boolean coordenadas = false;
            while((linea = in.readLine()) != null)
            {
                if(!linea.equals("EOF") && !linea.equals("")) 
               {
                   if(coordenadas)
                   {
                       String[] partida = linea.split(" "); //En el espacio 0 tenemos el numero de la coordenada que cogemos
                       puntos[i++] = new Punto(Double.parseDouble(partida[1].trim()), Double.parseDouble(partida[2].trim()));
                   }else
                   {
                    if(linea.equals("NODE_COORD_SECTION")) //EL contenido de la ultima linea antes de que se den todas las coordenadas
                    {
                        coordenadas=true;
                    } else if (linea.contains("DIMENSION")) //En la linea donde ponga dimension guardamos la cantidad de coordenadas que nos van a dar
                       {
                        String[] partes = linea.split(":");
                        puntos = new Punto[Integer.parseInt(partes[1].trim())];
                       }
                   }
                }
            }
            in.close();
            return puntos;            
        }catch(FileNotFoundException ex){
            ex.printStackTrace();
        }catch(IOException ex){
            ex.printStackTrace();
        }
        return puntos;
    }
    
    
    public static void GuardarDijkstra (int[] dists,String nombre,int [] padres,int ini) throws IOException
    {
        FileWriter fichero = null;
        PrintWriter out = null;
        try
        {         
            fichero = new FileWriter("./Solucion"+nombre);
            out=new PrintWriter(fichero);
            out.write("NAME : " + nombre + "\n");
            out.write("TYPE : TOUR\n");            
            out.write("DIMENSION : " + dists.length + "\n");
            
            int dTotal = 0;
            for(int i = 0 ; i < dists.length ; i++)
            {
                dTotal = dTotal + dists[i];
            }
            
            out.println("SOLUCION  : "+dTotal);
            out.println("TOUR_SECTION");
            
            for(int i = 0 ; i < dists.length ; i++)
            {
                if(i != ini)
                {
                    String v = Algoritmos.camino(padres , i , "");
                    out.println(dists[i] + " " + v);
                }
            }
            
            out.println("-1");
            out.println("EOF");
            
        }catch(IOException ex){
            ex.printStackTrace();
        }finally
        {
            fichero.close();
        }
    }
}
