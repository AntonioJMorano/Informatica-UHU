/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author anton
 */
public class AFND implements Proceso, Cloneable{
    
    private AutomataND automata;

    public AFND(AutomataND a)
    {
        this.automata = a;
    }
    
    @Override
    public boolean esFinal(String estado) {
        return automata.getEstadosF().contains(estado);
    }

    @Override
    public boolean reconocer(String cadena) {
        char[] simbolos = cadena.toCharArray();
        List<String> estadoNSub = new ArrayList<>(automata.getEstadosIni());
        List<String> nuevosE = new ArrayList<>();
        
        for(char s : simbolos)
        {
            for(String e : estadoNSub)
            {
                lambdaClausura(e,nuevosE);
            }            
                    estadoNSub.addAll(nuevosE);
                     nuevosE.clear();
                     
           for(String e : estadoNSub)
           {
               String[] next = automata.getTransiciones().get(AutomataND.formarCondicion(e, s));
               if(next != null)
               {
                   nuevosE.addAll(Arrays.asList(next));
               }
           }           
                    estadoNSub.clear();
                    estadoNSub.addAll(nuevosE);
                    nuevosE.clear();
            
           if(estadoNSub.isEmpty())
           {
                    System.out.println("Estados vacios");
           }
        }
       
        
        for(String e : estadoNSub)
        {
           lambdaClausura(e , nuevosE);
        }
        
        estadoNSub.addAll(nuevosE);
        
        estadoNSub.retainAll(automata.getEstadosF());
        return !estadoNSub.isEmpty();
    }
    
    public void lambdaClausura(String estado , List<String> nuevosE)
    {
        String[] resultados = automata.getTransiciones().get(estado);
        if(resultados != null)
        {
            for(String r : resultados)
            {
                if(!nuevosE.contains(r))
                {
                    nuevosE.add(r);
                    lambdaClausura(r,nuevosE);
                }
            }
        }
    }
    
    @Override
    public Object clone() throws CloneNotSupportedException
    {
           AFND obj = null;
        try {
            obj = (AFND) super.clone();
            obj.automata = (AutomataND) automata.clone();
        } catch (CloneNotSupportedException ex) {
        }
        return obj;
    }

    @Override
    public String toString() {
        return automata.toString();
    
    }    
    
}
