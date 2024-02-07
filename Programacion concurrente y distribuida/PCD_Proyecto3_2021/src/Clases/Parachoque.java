/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.util.concurrent.Callable;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author anton
 */
public class Parachoque implements Callable<Integer>{
    
    Tanque t;
    
    public Parachoque(Tanque t)
    {
        this.t = t;        
    }
    
    @Override
    public Integer call() throws Exception
    {
        int tiempo = 0;
        try {
            System.out.println("Soy el Parachoque "+ Thread.currentThread().getId() + "entrando");
            t.entraParachoque();
            tiempo = 4000;
            Thread.sleep(tiempo);
            System.out.println("Parachoque "+Thread.currentThread().getId() + " saliendo");
            t.saleParachoque();
        } catch (InterruptedException ex) {
            Logger.getLogger(Parachoque.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tiempo;
    }
    
}
