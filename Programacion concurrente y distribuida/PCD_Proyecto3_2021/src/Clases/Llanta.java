/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.util.Random;
import java.util.concurrent.Callable;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author anton
 */
public class Llanta implements Callable<Integer>{
    Tanque t;
    
    public Llanta(Tanque t)
    {
        this.t = t;
    }
    
    
    @Override
    public Integer call() throws Exception
    {
        int tiempo = 0;
        try {
            Random r = new Random();
            r.setSeed(System.nanoTime());
            System.out.println("Llanta "+Thread.currentThread().getId() + " ENTRANDO");
            t.entraLlanta();
            tiempo=(r.nextInt(2)+2)*1000;
            Thread.sleep(tiempo);
            System.out.println("Llanta " + Thread.currentThread().getId() + " SALIENDO");
            t.saleLlanta();
        } catch (InterruptedException ex) {
            Logger.getLogger(Llanta.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tiempo;
    }
    
    
}
