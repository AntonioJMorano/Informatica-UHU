/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.util.concurrent.Semaphore;

/**
 *
 * @author anton
 */
public class RobotG extends Thread {
    
    private final CanvasTaller cT;
    private final Semaphore general;
    private  Semaphore[] propios = new Semaphore[4]; //Acquire = wait / release = signal;
      public boolean infinito =true;
    
    public RobotG(Semaphore general , Semaphore[] propios , CanvasTaller ct)
    {
        this.cT=ct;
        this.general=general;
        this.propios=propios;
    }
    
    @Override
    public void run()
    {
      
        while(infinito){
            try{
                for(int i = 0;i<4;i++)
                {
                    general.acquire();
                }
                Thread.sleep(1000);
                System.out.println("Robot Grapador"+Thread.currentThread().getId() +"pasando las hojas a cinta transportadora");
                cT.grapar();
                Thread.sleep(2000);
                for(int i = 0 ; i < 4 ; i++)
                {
                    propios[i].release();
                    
                }
            }catch(InterruptedException ex){
                
            }
        }
    }
    
    public void detener()
    {
        infinito = false;
    }
            
            
    
}
