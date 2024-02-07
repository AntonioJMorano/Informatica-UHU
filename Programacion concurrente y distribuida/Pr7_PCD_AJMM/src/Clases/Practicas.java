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

public class Practicas implements Callable<Integer>{
    public int tiempo;
    private int id;
    private final Revision revision;
    public Practicas(Revision revision,int id){
        this.revision = revision;
        this.id = id;
    }
    
    @Override
    public Integer call() {
        long hid = Thread.currentThread().getId();
        try {
            Random r = new Random();
            r.setSeed(System.nanoTime());
            System.out.println("Entra Alumno Practicas: "+id+"   Atendido por hilo "+hid);
            revision.entraPracticas();
            tiempo = 2000+r.nextInt(3001);
            Thread.sleep(tiempo);
            revision.salePracticas();
            System.out.println("Sale Alumno Practicas: "+id);
        } catch (InterruptedException ex) {
            Logger.getLogger(Practicas.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tiempo;
    }
    
}
