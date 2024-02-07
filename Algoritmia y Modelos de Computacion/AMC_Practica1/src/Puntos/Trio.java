/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Puntos;



/**
 *
 * @author usuario
 */
public class Trio {
    private Punto [] p = new Punto[3];
    public double DistMin;
    
    
    public Trio(Punto a , Punto b , Punto c)
    {
        p[0] = a;
        p[1] = b;
        p[2] = c;
        
        DistMin = CalculaDist(this.p[0],this.p[1]) + CalculaDist(this.p[1],this.p[2]) + CalculaDist(this.p[0],this.p[2]);;  //triangulo , donde sumamos los 3 caminos entre puntos
       
    }    
    public Trio(Trio t)
    {
        p[0] = t.getP0();
        p[1] = t.getP1();
        p[2] = t.getP2();
        DistMin = t.DistMin;
    }
    
    //HALLAR LA DISTANCIA TOTAL ENTRE LOS 3 PUNTOS
      
    public static double CalculaDist(Punto p1 , Punto p2){
        double dist;
        dist = Math.hypot(p1.getX()-p2.getX(), p1.getY()-p2.getY());//Math.sqrt(   ((p2.getX() - p1.getX()) * (p2.getX() - p1.getX())) * ((p2.getY() - p1.getY())* (p2.getY() - p1.getY()))     );
        return dist;
    }    
    //UTILIDADES
    public boolean comparar(Trio t)
    {
        if(this.DistMin < t.DistMin)
        {
            return true;
        }else  
            return false ;
                    
    }  
    @Override
    public String toString()
    {
        String sol = "p1 -> " + p[0].getX() + " , " + p[0].getY() + " // " + "p2 -> " + p[1].getX() + " , " + p[1].getY() + " // " + "p3 -> " + p[2].getX() + " , " + p[2].getY();
        return sol;
    }
    
       
    public Punto[] getPuntos()
    {
        Punto[] aux = new Punto[2];
        aux[0] = this.getP0();
        aux[1] = this.getP1();
        aux[2] = this.getP2();
        
        return aux;
    }
    
    public Punto getP0()
    {
        return p[0];
    }
    public Punto getP1()
    {
        return p[1];
    }
    public Punto getP2()
    {
        return p[2];
    }
    
    
}
