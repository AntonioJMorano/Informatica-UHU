/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.util.ArrayList;

/**
 *
 * @author anton
 */
public class Tienda {
    
    private boolean vLibre,tLibre;
    private final CanvasTienda canvas;
    private int cComprar,cReparar;
    private long comprando,reparando;
    private int quien;   
    ArrayList<Long> cCompra = new ArrayList(10);
    ArrayList<Long> cTecnico= new ArrayList(10);
    
    public Tienda (CanvasTienda cT)
    {
        vLibre = true;
        tLibre = true;
        canvas = cT;
    }
    
    public synchronized int EntraComprar() throws InterruptedException
    {
       
       long id=Thread.currentThread().getId();
       cComprar++;
       cCompra.add(id);
       canvas.representa(reparando,comprando,vLibre,tLibre, cCompra , cTecnico);
       Thread.sleep(300);
        while(!vLibre || (!tLibre && cComprar > 2))
        {    
            if(cComprar > 2 && tLibre)
            {
                break;
            }
            
            wait();            
        }
            
            cCompra.remove(id);
             
            if(vLibre)
            {
               comprando=id;
               vLibre = false;
               quien = 0;
            }else if(cComprar > 2 && tLibre)
            {
                
                tLibre = false; 
                quien = 1;
                reparando=id;
                System.out.println("Como la cola es mayor que dos, el tecnico entra a ayudar");
            }
                     
            cComprar--;
            canvas.representa(reparando,comprando,vLibre,tLibre, cCompra , cTecnico);
            
            Thread.sleep(300);
            return quien;
            
        
    }
    
    public synchronized void SaleComprar(int quien) throws InterruptedException
    {
        comprando=0;
        
        if(quien == 0)
        vLibre = true;
        else if(quien==1)         
        tLibre = true; 
        
            
        canvas.representa(reparando,comprando,vLibre,tLibre, cCompra , cTecnico);
        Thread.sleep(300);        
        notifyAll();
    }
    
    public synchronized void EntraReparar() throws InterruptedException
    {
        long id=Thread.currentThread().getId();
        cReparar++;
        cTecnico.add(id);
         canvas.representa(reparando,comprando,vLibre,tLibre, cCompra , cTecnico);
        Thread.sleep(300);
         while(!tLibre || cComprar > 2)
        {   
           // canvas.pintameT(Thread.currentThread().getId());
            
            System.out.println("Tecnico Ocupado, cliente "+Thread.currentThread().getId()+" esperando para reparar , total esperando :" + cReparar);
            wait();
        }
            cTecnico.remove(id);
            reparando = id;
            cReparar--;           
            tLibre = false;                
            canvas.representa(reparando,comprando,vLibre,tLibre, cCompra , cTecnico);
            Thread.sleep(300);
    }
    
    public synchronized void SaleReparar()
    {
        
        tLibre = true; 
        reparando=0;
        canvas.representa(reparando,comprando,vLibre,tLibre, cCompra , cTecnico);
        
        //canvas.borrameT(Thread.currentThread().getId());
        notifyAll();
    }
}
