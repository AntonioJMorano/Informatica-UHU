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
public class AutomataD implements Cloneable {
    
    private List<String> estados,estadosF;
    private String estadoIni;
    private List<Character> simbolos;
    private Map<String/*clave*/,String/*valor*/> transiciones; 
    
    public AutomataD()
    {
        estados = new ArrayList<>();
        estadosF = new ArrayList<>();
        estadoIni = null;
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
    
    public String getEstadoIni()
    {
        return estadoIni;
    }
    
    public Map<String,String> getTransiciones()
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
    
    public void setEstadoIni(String e)
    {
        this.estadoIni = e;
    }
    
    public void anadirTransicion(String ini , char simbolo , String dest)
    {
        transiciones.put(formarCondicion(ini,simbolo),dest);
            if(!simbolos.contains(simbolo))
            {
                simbolos.add(simbolo);
            }
            
           
    }
    
    public static String formarCondicion(String ini , char simbolo)
    {                
        return new StringBuilder().append(ini).append('-').append(simbolo).toString();
    }

    
    @Override
    public Object clone() throws CloneNotSupportedException {
        AutomataD obj = null;
        try {
            obj = (AutomataD) super.clone();
          /*obj.estados = estados;
            obj.estadosF = estadosF;
            obj.simbolos = simbolos;
            obj.transiciones = transiciones;*/
        } catch (CloneNotSupportedException ex) {
        }
        return obj;
    }
}
