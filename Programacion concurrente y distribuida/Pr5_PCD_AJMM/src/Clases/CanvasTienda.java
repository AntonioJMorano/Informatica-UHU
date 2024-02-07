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
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

/**
 *
 * @author anton
 */
public class CanvasTienda extends Canvas{
    boolean tLibre , vLibre;
    private long comprando,reparando;       
    private ArrayList<Long> cCompra,cTecnico;

    
    public CanvasTienda()
    {
        tLibre = true;
        vLibre = true;
        comprando = 0;
        reparando = 0;
        
    }
    
    //Mostrar cliente actual en vendedor e ids clientes en cola.
    @Override
    public void paint(Graphics g)
    {
        Image img = createImage(getWidth() , getHeight());
        Graphics gF = img.getGraphics();        
        
        Font f1 = new Font("Arial",Font.ITALIC , 30);
        gF.setFont(f1);
        
            
            
        gF.drawString("Vendedor", 10, 60);       
        gF.drawString("Tecnico", 310, 60);
        
        Font f2 = new Font("Arial",Font.ITALIC , 20);
        gF.setColor(Color.black);
        gF.setFont(f2);
       
        int px=100;
       for(Long compra : cCompra)
       {
           
          gF.drawString("Cliente -> " +compra, 10, px);
          px += 40; 
       }               
       
       
       int px2=100;
       for(Long tecnico : cTecnico)
       {           
            gF.drawString("Cliente -> "+tecnico, 310, px2);   
            px2+=40;
               
       } 
        
        
        if(comprando != 0)
        {
            gF.setColor(Color.WHITE);
            gF.drawString(""+comprando, 170, 60);
        }
        
        if(reparando != 0)
        {
            gF.setColor(Color.white);
            gF.drawString(""+reparando, 440, 60);
        }
        
        
            
        
        g.drawImage(img, 0, 0, null);
    }
    
    @Override
    public void update(Graphics g)
    {
        paint(g);
    }
    
    public void representa(long r,long c,boolean t , boolean v, ArrayList<Long> cc , ArrayList<Long> ct)
    {        
        
        comprando = c;
        reparando=r;
        tLibre = t;
        vLibre = v;
        cCompra = cc;
        cTecnico = ct;
        repaint();
    }
    
   /* public ArrayList pintameV (long id)            
    {
        
        cCompra.add(id);        
        return cCompra;
    }
    
      
    public ArrayList pintameT (long id)            
    {
        cTecnico.add(id);        
        return cTecnico;
    }
    
      
    public ArrayList borrameV (long id)            
    {
        
        cCompra.remove(id);  
        return cCompra;
    }
    
      
    public ArrayList borrameT (long id)            
    {
        
        cCompra.remove(id);        
        return cTecnico;
    }*/
}
