/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package p3;

import java.util.Random;

/**
 *
 * @author alvar
 */
public class Productor extends Thread {

    private final PilaLenta lapila;

    public Productor(PilaLenta lapila) {
        this.lapila = lapila;
    }

    public void producir() {
        Random r = new Random();
        r.setSeed(System.nanoTime());

        for (int i = 0; i < 10; i++) {
            int elemn = r.nextInt(100);
            try {
                lapila.Apila(elemn);
                System.out.println("Hilo productor con id " + getId() + " inserta: " + elemn);
            } catch (Exception e) {
                System.out.println("Hilo productor con id " + getId() + " error al insertar" + e.getMessage());
            }
        }
    }
    
    @Override
    public void run() {
        producir();
    }

}
