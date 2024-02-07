/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author anton
 */ 
public class Tanque {
    
    int Parachoques , Llantas;
    ReentrantLock rl;
    Condition colaL,colaP;
    boolean esperaP;
    
    public Tanque()
    {
        esperaP=false;
        Parachoques=0;
        Llantas = 0;
        this.rl = new ReentrantLock();
        this.colaL = rl.newCondition();
        this.colaP = rl.newCondition();
    }
    
    public void entraLlanta()
    {
        rl.lock();
        try{
             if(Llantas >= 5 || (Llantas >= 3 && Parachoques == 1) || Parachoques == 2)
        {
            try {
                System.out.println("Llanta "+Thread.currentThread().getId() + " Esperando, ya que actualmente hay "+Llantas + " llantas , y "+ Parachoques + " parachoques en el tanque");
                colaL.await();
            } catch (InterruptedException ex) {
                Logger.getLogger(Tanque.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        Llantas++;  
        colaL.signal();
        
        }finally{
            rl.unlock();
        }
       
    }
    
    public void saleLlanta()
    {
        rl.lock();
        try{
           Llantas--;
        if(esperaP)
        {
           colaP.signal(); 
        }else
        {
            colaL.signal();
        } 
        }finally{
            rl.unlock();
        }       
    }
    
    public void entraParachoque()
    {
        rl.lock();
        try{
            if(Parachoques == 2 || Llantas > 3 )
        {
            try {
                esperaP =true;
                System.out.println("Parachoque "+Thread.currentThread().getId() + " Esperando, ya que actualmente hay "+ Llantas + " llantas , y "+ Parachoques + " parachoques en el tanque");
                colaP.await();
            } catch (InterruptedException ex) {
                Logger.getLogger(Tanque.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        esperaP =false;
        Parachoques++;
        colaP.signal();
        }finally{
            rl.unlock();
        }
        
    }
    
    public void saleParachoque()
    {
        rl.lock();
        try{
            Parachoques--;
        colaP.signal();
        }finally{
            rl.unlock();
        }
        
    }
    
    
}
