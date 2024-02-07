package Clases;

import java.util.Random;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author anton
 */
public class Generador {

    /**
     * @param args the command line arguments
     */
   /* public static void main(String[] args) throws InterruptedException {
        // TODO code application logic here
        Thread[] clientes = new Thread[10];
        
        CanvasTienda ct = new CanvasTienda();
        Tienda tienda = new Tienda(ct);
        
        Random r = new Random();
        r.setSeed(System.nanoTime());
        
        for(int i = 0 ; i < 10 ; i++)
        {
            if(r.nextInt(10) <= 4)
            {
                clientes[i] = new Comprar(tienda);
                clientes[i].start();
                Thread.sleep(1000);
            }else
            {
                clientes[i] = new Thread (new Reparar(tienda));
                clientes[i].start();
                Thread.sleep(r.nextInt(1+1)*1000);
            }
        }
        
        for(int i = 0 ; i < 10 ;i++)
        {
            clientes[i].join();
        }
    }*/
    
}
