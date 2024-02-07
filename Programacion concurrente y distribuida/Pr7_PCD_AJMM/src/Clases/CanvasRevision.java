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
import java.awt.Canvas;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.util.ArrayList;
import Clases.*;
import static Clases.Revision.ALUMNO_TEORIA;

class Alumno{
    public long id;
    public int tipo;
    public Alumno(int tipo){
        this.id = Thread.currentThread().getId();
        this.tipo = tipo;
    }
}
public class CanvasRevision extends Canvas{
    private final ArrayList<Alumno> esperando, atendiendo;
    private static final Font fTexto = new Font("Verdana", Font.PLAIN, 18), fNumero = new Font("Consolsa", Font.BOLD, 28);
    
    public CanvasRevision(){
        esperando = new ArrayList<>();
        atendiendo = new ArrayList<>();
    }
    
   
    
    @Override
    public void update(Graphics g){
        paint(g);
    }
    
    @Override
    public void paint(Graphics og){
        Image img = createImage(getWidth(), getHeight());
        Graphics gF = img.getGraphics();
       
        
        gF.setColor(Color.WHITE);
        gF.fillRect(200, 200, 50, 20);
        gF.setColor(Color.BLACK);
        gF.drawRect(200, 200, 50, 20);  
        gF.drawString("Alumnos Practicas",255,200);
        
        
        gF.fillRect(50, 200, 50, 20);
        //gF.setColor(Color.BLACK);
        gF.drawRect(50, 200, 50, 20);        
        gF.drawString("Alumnos Teoria", 105, 200);
        
        gF.setFont(fTexto);
        gF.setColor(Color.BLACK);
        gF.drawString("Esperando", 20, 40);
        for (int i = 0; i < esperando.size(); i++) {
            drawAlumno(gF, esperando.get(i), 50, 70+35*i);
        }
        
        gF.setFont(fTexto);
        gF.setColor(Color.BLACK);
        gF.drawString("Revisando", 150, 40);
        for (int i = 0; i < atendiendo.size(); i++) {
            drawAlumno(gF, atendiendo.get(i), 180, 70+35*i);
        }
        
        gF.setFont(fTexto);
        gF.setColor(Color.BLUE);
        gF.drawString("Teoria", 280, 80);
        gF.setColor(Color.RED);
        gF.drawString("Practicas", 280, 120);
        
        og.drawImage(img, 0, 0, null);
    }
    
    private void drawAlumno(Graphics g, Alumno a, int x, int y){
        g.setFont(fNumero);
        g.setColor(a.tipo==ALUMNO_TEORIA?Color.BLACK:Color.WHITE);
        g.drawString(Long.toString(a.id), x, y);
    }
    
     public void entra(int tipo){
        esperando.add(new Alumno(tipo));
        repaint();
    }
    
    public void atendiendo(){
        Alumno a = esperando.stream().filter(v -> v.id == Thread.currentThread().getId()).findAny().get();
        esperando.remove(a);
        atendiendo.add(a);
        repaint();
    }
    
    public void sale(){
        atendiendo.removeIf(v -> v.id == Thread.currentThread().getId());
        repaint();
    }
}
