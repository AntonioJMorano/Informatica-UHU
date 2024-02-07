package Clases;


import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author usuario
 */
public class Consumidor extends Thread{
    PilaLenta pl;
    
    public Consumidor(PilaLenta p)
    {
        pl = p;
    }
    
    
    @Override 
    public void run()
    {
      for (int i = 0 ; i < 5; i++)
      {
                   
          try {          
              Random r = new Random();
              r.setSeed(System.nanoTime());
              System.out.println("Soy el hilo consumidor" + Thread.currentThread().getId() + "y desapilo: " + pl.Desapila() + "-----------Quedan:" +pl.GetNum()+" elementos en la pila" );
              sleep(r.nextInt(3+1)*1000);
              
          } catch (Exception ex) {
              Logger.getLogger(Productor.class.getName()).log(Level.SEVERE, null, ex);
          }
      }
        
    }
}
