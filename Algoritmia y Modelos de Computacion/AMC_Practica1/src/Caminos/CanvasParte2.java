/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Caminos;

import Puntos.Punto;
import java.awt.Canvas;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;

/**
 *
 * @author anton
 */
public class CanvasParte2 extends Canvas {
    Punto[] puntos , solucion;
    
    public CanvasParte2(){
        this.puntos = null;
        this.solucion = null;
    }
    
    @Override
    public void paint(Graphics g)
    {
       Font f1 = new Font("Arial",Font.BOLD,40);
       int x, y;
       int indice = 0;
       int xPrincipal = (int)puntos[0].getX();
       int yPrincipal = (int)puntos[0].getY();
       g.setColor(Color.red);
       g.fillOval(xPrincipal , yPrincipal,20,20);
       
       for(Punto p: puntos)
       {
           g.setColor(Color.BLACK);
           indice++;
           x = (int) p.getX(); //Para que se vea mejor la representacion
           y = (int) p.getY();
           g.fillOval(x, y, 10, 10);
           
           g.setColor(Color.red);
           g.drawString(""+ indice , x, y);
       }     
       
       
       if(solucion!=null)
       {
           g.setColor(Color.red);
           
           int xp0 = (int) solucion[0].getX();
           int yp0 = (int) solucion[0].getY();
           
           int xp1 = (int) solucion[1].getX();
           int yp1 = (int) solucion[1].getY();
           
           int xp2 = (int) solucion[2].getX();
           int yp2 = (int) solucion[2].getY();
           g.drawLine(xp0+2, yp0+2, xp1+2, yp1+2);
           g.drawLine(xp0+2, yp0+2, xp2+2, yp2+2);
           
           for(Punto s : solucion)
           {
               x = (int) s.getX();
               y = (int) s.getY();
               g.fillOval(x, y, 10, 10);
           }       
       }else{
           g.setFont(f1);
           g.drawString("FALLO AL DIBUJAR LA SOLUCION", 50, 50);
       }
       
    }
    
    @Override
    public void update(Graphics g)
    {
        paint(g);
    }
    
    public void actualiza(Punto[] p ,Punto[] s)
    {
       
        this.puntos = p;
        this.solucion = s;
        repaint();
        
    }
    
}
