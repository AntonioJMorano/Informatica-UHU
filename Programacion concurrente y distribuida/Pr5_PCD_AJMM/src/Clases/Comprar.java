/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import com.sun.istack.internal.logging.Logger;
import java.util.Random;
import sun.util.logging.PlatformLogger;

/**
 *
 * @author anton
 */
public class Comprar extends Thread {
    
    private Tienda t;
    int quien;
    
    public Comprar(Tienda t)
    {
        this.t=t;
        quien = 0;
    }
    
    @Override
    public void run()
    {
        Random r = new Random();
        r.setSeed(System.nanoTime());
        
        try
        {
            System.out.println("Cliente COMPRAR"+Thread.currentThread().getId()+"  ---llegando a la tienda");
            quien = t.EntraComprar();
            
            Thread.sleep(r.nextInt(2+1)*1000);
            
            System.out.println("Cliente COMPRAR"+Thread.currentThread().getId()+"  ---acabando la COMPRA,atendido por"+quien);
            
            t.SaleComprar(quien);
           
        }catch(InterruptedException ex){
            
        }
    }
}
