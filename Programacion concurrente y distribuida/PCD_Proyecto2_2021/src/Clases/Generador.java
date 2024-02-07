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
    public static void main(String[] args) throws InterruptedException {
        Random r = new Random();
        r.setSeed(System.nanoTime());
        Tanque t = new Tanque();
        
        Thread[] hilos = new Thread[10];
        for(int i = 0; i < 10 ; i++)
        {
            int aux = r.nextInt(10);
            if(aux < 7)
            {
                hilos[i] = new Thread(new Llanta(t));
            }else{
                hilos[i] = new Parachoque(t);
            }
            Thread.sleep((r.nextInt(2)+1)*1000);
        }
        
        for(int i = 0 ; i < 10 ; i++)
        {
            hilos[i].start();
        }
        
        for(int i = 0 ; i < 10 ; i++)
        {
            hilos[i].join();
        }
        
        
    }
    
}
