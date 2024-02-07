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
public interface Proceso {
    public abstract boolean esFinal(String estado);
    public abstract boolean reconocer (String cadena);
    public abstract String toString();
    
}
