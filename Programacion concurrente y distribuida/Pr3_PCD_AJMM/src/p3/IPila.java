/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package p3;

/**
 *
 * @author alvar
 */
public interface IPila {

    void Apila(Object elemento) throws Exception;

    Object Desapila() throws Exception;

    int GetNum();

    Object Primero() throws Exception;
    
}