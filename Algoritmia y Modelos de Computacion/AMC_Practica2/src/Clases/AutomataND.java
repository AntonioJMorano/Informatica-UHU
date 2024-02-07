/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author anton
 */
public class AutomataND implements Cloneable {
    
    private List<String> estados,estadosF,estadosIni;    
    private List<Character> simbolos;
    private Map<String/*clave*/,String[]/*valor*/> transiciones;     
    
    public AutomataND()
    {
        estados = new ArrayList<>();
        estadosF = new ArrayList<>();
        estadosIni = new ArrayList<>();
        simbolos = new ArrayList<>();
        transiciones = new HashMap<>();
    }

    public List<String> getEstados()
    {
        return estados;
    }
    
    public  List<String> getEstadosF()
    {
        return estadosF;
    }
    
    public  List<Character> getSimbolos()
    {
        return simbolos;        
    }
    
    public List<String> getEstadosIni()
    {
        return estadosIni;
    }
    
    public Map<String,String[]> getTransiciones()
    {
        return transiciones;
    }
    
    public void anadirEstados(String[] e)
    {                
        this.estados = Arrays.asList(e);
    }
    
    public void anadirEstadosF(String[] eF)
    {
        this.estadosF = Arrays.asList(eF);
    }
    
    public void anadirEstadosIni(String[] eI)
    {
        this.estadosIni = Arrays.asList(eI);
    }
    
    public void setEstadoIni(String[] e)
    {
        this.estadosIni = Arrays.asList(e);
    }
    
    public void anadirTransicion(String ini , Character simbolo , String[] destinos)
    {
        transiciones.put(formarCondicion(ini,simbolo),destinos);
            if(!simbolos.contains(simbolo))
            {
                simbolos.add(simbolo);
            }
    }
    
    public static String formarCondicion(String ini , Character simbolo)
    {                
        return new StringBuilder().append(ini).append('-').append(simbolo).toString();
    }

    
    @Override
    public Object clone() throws CloneNotSupportedException {
        AutomataND obj = null;
        try {
            obj = (AutomataND) super.clone();
            obj.estados = estados;
            obj.estadosF = estadosF;
            obj.simbolos = simbolos;
            obj.transiciones = transiciones;
        } catch (CloneNotSupportedException ex) {
        }
        return obj;
    }

    
}
