/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import Interfaz.Frame;
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
public class Generador {
    public static void main(String args[]) throws InterruptedException, ExecutionException {
       
       
        CanvasRevision canvas = new CanvasRevision();
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
}
