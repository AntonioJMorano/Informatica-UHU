package Puntos;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author usuario
 */
public class Punto {
    
    private double Cx , Cy;
    private int zona;
    
    public Punto(double x , double y)
    {
        Cx=x;
        Cy=y;
        zona = 0;
    }
  
    public double getX()
    {
        return Cx;
    }
    
    public double getY()
    {
        return Cy;
    }
    
    public int getZona()
    {
        return zona;
    }
    
    public void setZona(int z)
    {
        zona = z;
    }
    
   public void setX(double x)
   {
       this.Cx = x;
   }
   
   public void setY(double y)
   {
       this.Cy = y;
   }
    
    
    
}
