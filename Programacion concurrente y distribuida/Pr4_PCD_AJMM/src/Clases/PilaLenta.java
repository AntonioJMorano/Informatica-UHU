package Clases;


import static java.lang.Thread.sleep;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/**
 *
 * @author jcarl
 */
public class PilaLenta implements IPila {

    private int cima, numelementos;
    private final int capacidad;
    private final Object[] datos;
    private final CanvasPila cP;

    public PilaLenta(int c, CanvasPila cp) {
        this.cima = 0;
        this.numelementos = 0;
        this.capacidad = c;
        this.datos = new Object[c];
        this.cP = cp;
    }

    @Override
    public int GetNum() {
        return numelementos;
    }

    @Override
    public synchronized void Apila(Object elemento) throws Exception {
        
        int intentos = 0;
        
        while(numelementos == capacidad) 
         {
             if (intentos >= 3) 
            {      
                
                System.out.println("El productor "+Thread.currentThread().getId()+" se ha cansado de intentar apilar con la pila llena");                

            }
            System.out.println("La pila está llena, productor "+Thread.currentThread().getId() +" esperando para insetar");
            intentos++;
            wait();
         }  
                   
                    datos[cima] = elemento;
                    Thread.sleep(1000);
                    cima++; 
                    Thread.sleep(1000);
                    numelementos++;                   
                    notifyAll();
                    cP.representa(datos, cima, numelementos, capacidad);
                
        
    }

    @Override
    public synchronized Object Desapila() throws Exception {
        
        int intentos = 0;
        Object obj = null;
        
        while (numelementos == 0) 
        {
            if(intentos >= 3)
            {
                
                System.out.println("El consumidor "+Thread.currentThread().getId()+ " se ha cansado de intentar desapilar con la pila vacia");
                
            }
            System.out.println("La pila esta vacía , consumidor "+Thread.currentThread().getId()+ " esperando para desapilar");
            intentos++;
            wait();            
            
        }          
                cima--;
                sleep(1000);
                obj = datos[cima];
                sleep(1000);
                datos[cima]=null;
                numelementos--;                  
                sleep(1000);
                //cima++;        
                
                notifyAll();
                cP.representa(datos, cima, numelementos, capacidad);
                 
        
        return obj;
    }

    @Override
    public Object Primero() throws Exception {
        if (numelementos == 0) {
            throw new Exception("La pila se encuentra vacia (PRIMERO).");
        } else {
            return datos[cima-1]; //Se resta uno ya que cima marca el ultimo elemento del array, de la
                                  //forma que hemos añadido sería igual al numero de elementos.
                                  //Si hay 3 elementos, la cima debería marcar la posición 2.
        }
    }
}
