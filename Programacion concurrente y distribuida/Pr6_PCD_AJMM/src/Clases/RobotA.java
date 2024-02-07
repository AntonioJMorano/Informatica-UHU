/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.util.Random;
import java.util.concurrent.Semaphore;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author anton
 */
public class RobotA extends Thread {
    
    private final Semaphore general;//m
    private final Semaphore propio;//r
    private final CanvasTaller cT;
    
    public RobotA(Semaphore m,Semaphore r,CanvasTaller ct)
    {
        this.propio=m;
        this.general=r;
        this.cT=ct;
    }
    @Override
    public void run()
    {
        Random r = new Random();
        r.setSeed(System.nanoTime());
        
        try
        {
            for(int i = 0; i < 10 ; i++)
            {
                
                propio.acquire();
                Thread.sleep(r.nextInt(2+1)*1000);
                
                cT.cogeHoja(Thread.currentThread().getId());
                
                Thread.sleep(2000);       
                cT.hojaMesa(Thread.currentThread().getId());
                System.out.println("Poniendo la hoja en la mesa"+Thread.currentThread().getId());
               
                general.release();
            
            }
        } catch (InterruptedException ex) {
            Logger.getLogger(RobotA.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
