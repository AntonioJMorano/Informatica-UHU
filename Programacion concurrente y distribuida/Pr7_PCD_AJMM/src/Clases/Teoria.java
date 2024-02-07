/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

/**
 *
 * @author anton
 */
import java.util.Random;
import java.util.concurrent.Callable;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Teoria implements Callable<Integer>{
    private final Revision revision;
    private int tiempo;
    private int id;
    public Teoria(Revision revision,int id){
        this.revision = revision;
        tiempo = 0;
        this.id = id;
    }
    
    @Override
    public Integer call() {
        long hid= Thread.currentThread().getId();
        try {
            Random r = new Random();
            r.setSeed(System.nanoTime());
            System.out.println("Entra Alumno Teoria: "+id+"   Atendido por el hilo: "+hid);
            revision.entraTeoria();
            tiempo = 2000+r.nextInt(3001);
            Thread.sleep(tiempo);
            revision.saleTeoria();
            System.out.println("Sale Alumno Teoria");
        } catch (InterruptedException ex) {
            Logger.getLogger(Practicas.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tiempo;
    }
}
