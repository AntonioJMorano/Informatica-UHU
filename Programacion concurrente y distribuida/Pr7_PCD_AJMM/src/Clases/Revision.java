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
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class Revision {

    public static final int ALUMNO_TEORIA = 1, ALUMNO_PRACTICAS = 2;
    private int libreTeorias, librePracticas, esperandoPr;
    private final CanvasRevision canvas;
    private final ReentrantLock Rl;
    private final Condition cTeoria, cPracticas;

    public Revision(CanvasRevision canvas) {
        this.canvas = canvas;
        libreTeorias = 3;
        librePracticas = 2;
        esperandoPr = 0;
        Rl = new ReentrantLock(true);
        cTeoria = Rl.newCondition();
        cPracticas = Rl.newCondition();
    }

    public void entraTeoria() throws InterruptedException {
        Rl.lock();
        try {
            canvas.entra(ALUMNO_TEORIA);
            if (libreTeorias < 1) {
                cTeoria.await();
                System.out.println("Alumno"+ Thread.currentThread().getId() + "Esperando para la teoria");
            }
            libreTeorias--;
            canvas.atendiendo();
        } finally {
            Rl.unlock();
        }
    }

    public void entraPracticas() throws InterruptedException {
        Rl.lock();
        try {
            canvas.entra(ALUMNO_PRACTICAS);
            esperandoPr++;
            if (libreTeorias < 1 || librePracticas < 1) {
                cPracticas.await();
                System.out.println("Alumno"+Thread.currentThread().getId() + " Esperando para las practicas, total esperando:"+esperandoPr);
            }
            esperandoPr--;
            libreTeorias--;
            librePracticas--;
            canvas.atendiendo();
        } finally {
            Rl.unlock();
        }
    }

    public void saleTeoria() {
        Rl.lock();
        try {
            libreTeorias++;
            canvas.sale();
            if (esperandoPr > 0 && librePracticas > 0) {
                cPracticas.signal();
            } else {
                cTeoria.signal();
            }
        } finally {
            Rl.unlock();
        }
    }

    public void salePracticas() {
        Rl.lock();
        try {
            libreTeorias++;
            librePracticas++;
            canvas.sale();
            if (esperandoPr > 0) {
                cPracticas.signal();
            } else {
                cTeoria.signal();
            }
        } finally {
            Rl.unlock();
        }
    }
}
