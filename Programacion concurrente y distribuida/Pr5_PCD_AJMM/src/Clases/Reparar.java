/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.util.Random;

/**
 *
 * @author anton
 */
public class Reparar implements Runnable {
     private Tienda t;
    
    public Reparar(Tienda t)
    {
        this.t=t;
    }
    
    @Override
    public void run()
    {
        Random r = new Random();
        r.setSeed(System.nanoTime());
        
        try
        {
            System.out.println("Cliente REPARAR"+Thread.currentThread().getId()+"  ---llegando a la tienda");
            t.EntraReparar();
            
            Thread.sleep(r.nextInt(2+1)*1000);
            
            System.out.println("Cliente REPARAR"+Thread.currentThread().getId()+"  ---acabando la REPARACION");
            t.SaleReparar();
            Thread.sleep(1000);
        }catch(InterruptedException ex){
            
        }
    }
}
