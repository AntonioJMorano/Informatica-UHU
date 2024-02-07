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
 * @author anton
 */
public class CanvasTaller extends Canvas {
     
   
    private long idRobot;
    private boolean q18,q19,q20,q21,grapar;
    private int nHojas;
    
    public CanvasTaller()
    {
       
        idRobot=0;
        q18=false;
        q19=false;
        q20=false;
        q21=false;
        grapar=false;
        nHojas=0;
        
        
    }
    
    @Override 
    public void paint(Graphics g)
    {
        Image img = createImage(getWidth(),getHeight());
        Graphics gF = img.getGraphics();
        
        Font f1 = new Font("Arial",Font.ITALIC , 30);
        Font f2 = new Font("Arial",Font.BOLD,40);
        gF.setFont(f1);
        
        gF.drawString("RobotA-1", 10, 100);
        gF.drawString("RobotA-2", 10, 200);
        gF.drawString("RobotA-3", 10, 300);
        gF.drawString("RobotA-4", 10, 400);    
        gF.drawString("Hojas en mesa --> " + nHojas , 150, 30);
        
        if(grapar)
        {    
            //Grapando
            gF.setFont(f2);
            gF.setColor(Color.red);
            gF.drawString("GRAPANDO", 300, 200);
            grapar=false;
            
        }       else{            
            //Hojas en mesa
            int px=60;
            for(int i = 0 ; i < nHojas ; i++)
            {
                
                    gF.setColor(Color.WHITE);
                    gF.fillRect(200, px, 30, 30);
                    gF.setColor(Color.black); 
                    gF.drawRect(200, px, 30,30); 
                    px+=40;
                
            }
         //Cogiendo hojas   
        if(q18)
        {
            
           gF.setColor(Color.WHITE);
            gF.fillRect(120, 100, 30, 30);
          gF.setColor(Color.black); 
            gF.drawRect(120, 100, 30,30); 
            
        }        
        
        if(q19)
        {
            
            gF.setColor(Color.WHITE);
            gF.fillRect(120, 200, 30, 30);
          gF.setColor(Color.black);
            gF.drawRect(120, 200, 30, 30); 
        }
         
            
        if(q20)
        {
            
           gF.setColor(Color.WHITE);
            gF.fillRect(120, 300, 30,30);
          gF.setColor(Color.black);
            gF.drawRect(120, 300, 30, 30); 
        }
            
                
        if(q21)
        {
            
          gF.setColor(Color.WHITE);
            gF.fillRect(120, 400, 30, 30);
          gF.setColor(Color.black);
            gF.drawRect(120, 400, 30, 30);  
        }          
            
        } 
        
    
        g.drawImage(img, 0, 0, null);
    }
    
    @Override
    public void update(Graphics g)
    {
        paint(g);
    }
    
    public void cogeHoja(long robot)
    {
        idRobot=robot;
        
        if(idRobot==18)
            q18=true;
        
        if(idRobot==19)
            q19=true;
        
        if(idRobot==20)
            q20=true;
        
        if(idRobot==21)
            q21=true;
        
        repaint();
    }    
    
    public void hojaMesa(long robot)
    {
        idRobot = robot;
        
        if(idRobot==18)
            q18=false;
        
        if(idRobot==19)
            q19=false;
        
        if(idRobot==20)
            q20=false;
        
        if(idRobot==21)
            q21=false;
        
        nHojas++;
        repaint();
    }
    
    
    public void grapar()
    {      
        nHojas=0;
        grapar=true;
        repaint();
    }
    
}
