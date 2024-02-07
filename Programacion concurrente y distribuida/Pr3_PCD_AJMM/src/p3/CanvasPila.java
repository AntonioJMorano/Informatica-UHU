/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package p3;

import java.awt.Canvas;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;

/**
 *
 * @author alvar
 */
public class CanvasPila extends Canvas {

    private int cima, capacidad, numelementos;
    private String mensaje;
    Object[] datos;

    public CanvasPila(int capacidad) {
        this.capacidad = capacidad;
        cima = numelementos = 0;
        datos = new Object[capacidad];
        mensaje = "";
    }

    @Override
    public void paint(Graphics g) {
        //Image imagen = createImage(getWidth(), getHeight());
        //Graphics ig = imagen.getGraphics();
        
        g.drawRect(50, 50, 50, 50);

        Font f1 = new Font("Arial", Font.ITALIC + Font.BOLD, 10);

        g.setFont(f1);
        g.setColor(Color.BLACK);
        g.drawString("Pila", 50, 50);
        //ig.fillRect(10, 10, 20, 20);
        //g.drawImage(imagen, 0, 0, null);
    }

    @Override
    public void update(Graphics g) {
        paint(g);
    }

    public void avisa(String mensaje) {
        this.mensaje = mensaje;
        repaint();
    }

    public void representa(Object[] datos, int cima, int numelementos) {
        this.datos = datos;
        this.cima = cima;
        this.numelementos = numelementos;
        System.arraycopy(datos, 0, this.datos, 0, capacidad);
        repaint();
    }
}
