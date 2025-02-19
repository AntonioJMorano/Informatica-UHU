/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interfaz;

import Clases.CanvasRevision;
import Clases.Practicas;
import Clases.Revision;
import Clases.Teoria;
import java.awt.Color;
import java.util.ArrayList;
import java.util.Random;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

/**
 *
 * @author anton
 */
public class Frame extends java.awt.Frame {
private static final int N_HILOS = 10;
    /**
     * Creates new form Frame
     */
    public Frame() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                exitForm(evt);
            }
        });

        pack();
    }// </editor-fold>//GEN-END:initComponents

    /**
     * Exit the Application
     */
    private void exitForm(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_exitForm
        System.exit(0);
    }//GEN-LAST:event_exitForm

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) throws InterruptedException, ExecutionException {
        Frame f = new Frame();        
        f.setResizable(false);
       
        CanvasRevision canvas = new CanvasRevision();
        
        canvas.setSize(400, 500);
        f.setBackground(Color.cyan); 
        f.add(canvas);
        f.setTitle("Practica 7 - PCD - AJMM");
        f.pack();
        f.setLocationRelativeTo(null);
        f.setVisible(true);
          
        ExecutorService thpT = Executors.newFixedThreadPool(10);
        ExecutorService thpP = Executors.newFixedThreadPool(10);
        Revision revision = new Revision(canvas);
        ArrayList<Future<Integer>> fT = new ArrayList<>();
        ArrayList<Future<Integer>> fP = new ArrayList<>();
        
        
        for(int i = 0 ; i < 10 ;i ++)
        {
            Practicas p = new Practicas(revision,i);
            fP.add(thpP.submit(p));
        }
        
        for(int i = 10 ; i < 20 ; i++)
        {
            Teoria t = new Teoria(revision,i);
            fT.add(thpT.submit(t));
        }
        
        int tiempoT=0;
        for(int i = 0 ; i < fT.size();i++)
        {
            tiempoT += fT.get(i).get();
        }        
        System.out.println("Tiempo total utilizado para revisar teoria: "+tiempoT/1000+"s");
        
        int tiempoP = 0;
        for(int i = 0 ; i < fP.size();i++)
        {
            tiempoP += fP.get(i).get();
        }
        System.out.println("Tiempo total utilizado para revisar practicas: "+tiempoP/1000+"s");
        thpP.shutdown();;
        thpT.shutdown();
    }


    // Variables declaration - do not modify//GEN-BEGIN:variables
    // End of variables declaration//GEN-END:variables
}
