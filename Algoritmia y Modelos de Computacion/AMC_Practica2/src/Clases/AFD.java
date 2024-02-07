/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.awt.List;
import java.util.ArrayList;

/**
 *
 * @author anton
 */
public class AFD implements Proceso , Cloneable {
    
    private AutomataD a;
            
    public AFD(AutomataD a)
    {
        this.a=a;        
    }    
   
    //estado es final o no
    @Override
    public boolean esFinal(String estado)
    {
       return a.getEstadosF().contains(estado);
    }
    
    //Comprobar que la cadena entra en el lenguaje
    @Override
    public boolean reconocer(String cadena)
    {
        char[] simbolos = cadena.toCharArray();
        String estado = a.getEstadoIni();
        
        for(char simbolo : simbolos)
        {
            if(!a.getSimbolos().contains(simbolo))
             {
                System.out.println("El simbolo no se reconoce");
             }            
            
            estado = a.getTransiciones().get(AutomataD.formarCondicion(estado, simbolo));
        }
        
        return a.getEstadosF().contains(estado);
    }
  
    
      @Override
    public Object clone() throws CloneNotSupportedException 
    {
        AFD obj = null;
        try {
            obj = (AFD) super.clone();
            obj.a = (AutomataD) a.clone();
        } catch (CloneNotSupportedException ex) {
        }
        return obj;
    }
    
    @Override
    public String toString() 
    {
        return a.toString();
    }

    
}
