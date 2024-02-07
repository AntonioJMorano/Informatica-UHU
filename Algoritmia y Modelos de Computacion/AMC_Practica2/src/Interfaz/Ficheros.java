package Interfaz;

import Clases.AutomataD;
import Clases.AutomataND;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.Arrays;
import java.util.List;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author anton
 */
public class Ficheros {
    
    
     public static AutomataD  LeerTextoAFD(String text) throws IOException {
        StringReader sr = new StringReader(text);
        BufferedReader br = new BufferedReader(sr);
        AutomataD  automata = LeerAFD(br);
        br.close();
        sr.close();
        return automata;
    }
     
     
       public static AutomataD  LeerFicheroAFD(String dir) throws IOException {
        FileReader fr = new FileReader(new File(dir));
        BufferedReader br = new BufferedReader( new FileReader((dir)));
        AutomataD  automata = LeerAFD(br);
        br.close();
        fr.close();
        return automata;
    }
       
        private static AutomataD LeerAFD(BufferedReader file) throws IOException {
        AutomataD automata = new AutomataD();        
        String line;
        boolean modoTransiciones = false;
        
        while ((line = file.readLine()) != null) {
            line = line.trim().replaceAll("\t", " ").replaceAll(" +", " ");
            if (line.equals("FIN")) {
                modoTransiciones = false;
            } else if (modoTransiciones) {
                String[] partes = line.split("'");
                automata.anadirTransicion(partes[0].trim(), partes[1].charAt(0), partes[2].trim());
            } else {
                if (line.startsWith("ESTADOS:")) {
                    automata.anadirEstados(line.substring(8).trim().split(" "));
                } else if (line.startsWith("INICIAL:")) {
                    automata.setEstadoIni(line.substring(8).trim());
                } else if (line.startsWith("FINALES:")) {
                    automata.anadirEstadosF(line.substring(8).trim().split(" "));
                } else if (line.startsWith("TRANSICIONES:")) {
                    modoTransiciones = true;
                }
            }
        }
        return automata;
    }
        
        public static AutomataND LeerTextoAFND(String text) throws IOException {
        StringReader sr = new StringReader(text);
        BufferedReader br = new BufferedReader(sr);
        AutomataND automata = LeerAFND(br);
        br.close();
        sr.close();
        return automata;
    }

    public static AutomataND LeerFicheroAFND(String dir) throws IOException {
        FileReader fr = new FileReader(new File(dir));
        BufferedReader br = new BufferedReader(fr);
        AutomataND automata = LeerAFND(br);
        br.close();
        fr.close();
        return automata;
    }

    private static AutomataND LeerAFND(BufferedReader file) throws IOException {
        AutomataND automata = new AutomataND();

        String line;
        boolean modoTransiciones = false, modoTransicionesLambda = false;
        while ((line = file.readLine()) != null) {
            if (line.trim().equals("FIN")) {
                modoTransiciones = false;
                modoTransicionesLambda = false;
            } else if (modoTransiciones) {
                String[] partes = line.trim().split("'");
                String[] destino = automata.getTransiciones().get(AutomataND.formarCondicion(partes[0].trim(), partes[1].charAt(0)));
                if (destino == null) {
                    destino = partes[2].trim().split(" ");
                } else {
                    String[] nuevos = partes[2].trim().split(" ");
                    String[] unido = new String[nuevos.length + destino.length];
                    System.arraycopy(nuevos, 0, unido, 0, nuevos.length);
                    System.arraycopy(destino, 0, unido, nuevos.length, destino.length);
                    destino = unido;
                }
                automata.anadirTransicion(partes[0].trim(), partes[1].charAt(0), destino);
            } else if (modoTransicionesLambda) {
                String[] partes = line.trim().split(" ");
                String[] destino = automata.getTransiciones().get(AutomataND.formarCondicion(partes[0].trim(), null));
                if (destino == null) {
                    destino = Arrays.copyOfRange(partes, 1, partes.length);
                } else {
                    String[] nuevos = Arrays.copyOfRange(partes, 1, partes.length);
                    String[] unido = new String[nuevos.length + destino.length];
                    System.arraycopy(nuevos, 0, unido, 0, nuevos.length);
                    System.arraycopy(destino, 0, unido, nuevos.length, destino.length);
                    destino = unido;
                }
                automata.anadirTransicion(partes[0].trim(), null, destino);
            } else {
                if (line.startsWith("ESTADOS:")) {
                    automata.anadirEstados(line.substring(8).trim().split(" "));
                } else if (line.startsWith("INICIAL:")) {
                    automata.anadirEstadosIni(line.substring(8).trim().split(" "));
                } else if (line.startsWith("FINALES:")) {
                    automata.anadirEstadosF(line.substring(8).trim().split(" "));
                } else if (line.startsWith("TRANSICIONES:")) {
                    modoTransiciones = true;
                } else if (line.startsWith("TRANSICIONES LAMBDA:")) {
                    modoTransicionesLambda = true;
                }
            }
        }        
        return automata;
    }
}

