/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package p3;

import java.awt.Graphics;
import static java.lang.Thread.sleep;

/**
 *
 * @author alvar
 */
public class PilaLenta implements IPila {

    private int cima, numelementos;
    private final int capacidad;
    Object[] datos;
    private final CanvasPila canvas;

    public PilaLenta(int capacidad, CanvasPila canvas) {
        this.capacidad = capacidad;
        this.numelementos = this.cima = 0;
        this.datos = new Object[capacidad];
        this.canvas = canvas;
    }

    @Override
    public int GetNum() {
        return numelementos;
    }

    @Override
    public synchronized void Apila(Object elemento) throws Exception {
        if (pilallena()) {
            throw new Exception("La pila esta llena y no se puede apilar");
        } else {
            sleep(100);
            datos[cima] = elemento;
            sleep(100);
            cima++;
            sleep(100);
            numelementos++;
            canvas.representa(datos,cima,numelementos);
            //System.out.println(" Apilo el numero " + elemento);
        }
    }

    @Override
    public synchronized Object Desapila() throws Exception {
        if (pilavacia()) {
            throw new Exception("La pila esta vacia");
        } else {
            sleep(100);
            cima--;
            sleep(100);
            Object elemn = datos[cima];
            //System.out.println("Desapilo el elemento " + elemn);
            sleep(100);
            datos[cima] = null;
            sleep(100);
            numelementos--;
            return elemn;
        }
    }

    @Override
    public Object Primero() throws Exception {
        if (pilavacia()) {
            throw new Exception("La pila esta vacia");
        } else {
            Object elemn = datos[cima - 1];
            return elemn;
        }
    }

    private boolean pilavacia() {
        return numelementos == 0;
    }

    private boolean pilallena() {
        return numelementos == capacidad;
    }
}