/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.awt.Canvas;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;

/**
 *
 * @author usuario
 */
public class CanvasPila extends Canvas {
    
    int cima,capacidad,numelementos;
    Object[] datos ;
    String mensaje;
    
    public CanvasPila(int c)
    {
        this.capacidad = c ;
        cima = 0;
        numelementos = 0;
        mensaje="";
        datos = new Object[c];
        super.setSize(500,600);
        
    }
    
    @Override
    public void paint(Graphics g)
    {
        
        Image img = createImage(getWidth(), getHeight());
        Graphics gF = img.getGraphics();
        
        Font f1 = new Font("Arial",Font.ITALIC ,20);        
        gF.setFont(f1); //Todo lo que se dibuje se hace con esta fuente , hasta que hagamos otro setFont.        
        
        gF.drawString("Pila con "+numelementos +" elementos y capacidad para "+ capacidad , 10 , 50);
        
       
        
               
        
        gF.drawString("NUMELEMENTOS", 10, 150);
        gF.drawString( "-----> " + numelementos , 50 , 175);
        
        
        gF.drawString("Valores en la pila", 10, 300);
        
        int px=10;
            for (int i = 0 ; i < numelementos ; i++)
            {               
                gF.drawString("" + datos[i], px, 325);
                px+=50;
            }
        
        
        if(numelementos <= 0)        
            gF.setColor(Color.red);
        else
            gF.setColor(Color.black);
        
        
            gF.drawString("PILA VACIA", 210, 500);
        
           
        
        if(numelementos >= capacidad)        
           gF.setColor(Color.red);
        else
            gF.setColor(Color.black);
        
        
            gF.drawString("PILA LLENA", 10, 500); 
        
            
       
        
        
        gF.drawImage(img, 0, 0,null);
        g.drawImage(img, 0, 0, null);

    }
    
    @Override
    public void update(Graphics g)
    {
        paint(g);
    }
    
     public void mensajes(String mensaje){
        this.mensaje = mensaje;
        repaint();
    }
    
    public void representa(Object[] b , int cima , int numelem , int capacidad)
    {
        this.cima = cima;
        this.numelementos = numelem;
        this.capacidad = capacidad;
        this.mensaje ="";
        System.arraycopy(b, 0, this.datos, 0, capacidad);
        repaint();
    }
}
