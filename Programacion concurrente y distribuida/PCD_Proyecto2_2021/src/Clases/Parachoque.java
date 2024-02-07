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
public class Parachoque extends Thread{
    
    Tanque t;
    
    public Parachoque(Tanque t)
    {
        this.t = t;        
    }
    
    @Override
    public void run()
    {
        try {
            System.out.println("Soy el Parachoque "+ Thread.currentThread().getId() + "entrando");
            t.entraParachoque();
            Thread.sleep(4000);
            System.out.println("Parachoque "+Thread.currentThread().getId() + " saliendo");
            t.saleParachoque();
        } catch (InterruptedException ex) {
            Logger.getLogger(Parachoque.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
