package Clases;

import java.util.Random;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

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
    public static void main(String[] args) throws InterruptedException, ExecutionException {
        Random r = new Random();
        r.setSeed(System.nanoTime());
        Tanque t = new Tanque();
        
        Future[] hilos = new Future[10];
        ExecutorService thp = Executors.newFixedThreadPool(10);
        for(int i = 0; i < 10 ; i++)
        {
            int aux = r.nextInt(10);
            if(aux < 7)
            {
                hilos[i] = thp.submit(new Llanta(t));
            }else{
                hilos[i] = thp.submit(new Parachoque(t));
            }
            Thread.sleep((r.nextInt(2)+1)*1000);
        }
        
       int tt = 0;
       for(int i = 0 ; i < 10; i++)
       {
           tt = tt + (int) hilos[i].get();
       }
        System.out.println("El tiempo total de ocupacion , entre todos los elementos, ha sido de: "+tt/1000 + "segundos");
       thp.shutdown();
        
        
    }
    
}
