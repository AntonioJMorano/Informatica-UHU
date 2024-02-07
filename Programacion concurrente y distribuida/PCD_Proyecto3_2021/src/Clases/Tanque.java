/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author anton
 */ 
public class Tanque {
    
    int Parachoques , Llantas;
    
    public synchronized void entraLlanta()
    {
        while(Llantas >= 5 || (Llantas >= 3 && Parachoques == 1) || Parachoques == 2)
        {
            try {
                System.out.println("Llanta "+Thread.currentThread().getId() + " Esperando, ya que actualmente hay "+Llantas + " llantas , y "+ Parachoques + " parachoques en el tanque");
                wait();
            } catch (InterruptedException ex) {
                Logger.getLogger(Tanque.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        Llantas++;
        notifyAll();
    }
    
    public synchronized void saleLlanta()
    {
        Llantas--;
        
        notifyAll();
    }
    
    public synchronized void entraParachoque()
    {
        while(Parachoques == 2 || Llantas > 3 )
        {
            try {
                System.out.println("Parachoque "+Thread.currentThread().getId() + " Esperando, ya que actualmente hay "+ Llantas + " llantas , y "+ Parachoques + " parachoques en el tanque");
                wait();
            } catch (InterruptedException ex) {
                Logger.getLogger(Tanque.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        Parachoques++;
        notifyAll();
    }
    
    public synchronized void saleParachoque()
    {
        Parachoques--;
        
        notifyAll();
    }
    
    
}
