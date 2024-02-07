/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package p3;

/**
 *
 * @author alvar
 */
public class Consumidor implements Runnable {

    private final PilaLenta lapila;

    public Consumidor(PilaLenta lapila) {
        this.lapila = lapila;
    }

    public void consumir() {
        Thread h = Thread.currentThread();

        for (int i = 0; i < 10; i++) {
            try {
                System.out.println("Hilo cosumidor con id " + h.getId() + " elemento desapilado: " + lapila.Desapila());
            } catch (Exception e) {
                System.out.println("Hilo cosumidor con id " + h.getId() + " no se ha podido desapilar, " + e.getMessage());
            }
        }
    }

    @Override
    public void run() {
        consumir();
    }

}
