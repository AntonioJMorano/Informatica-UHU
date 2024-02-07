package Clases;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/**
 *
 * @author jcarl
 */
public interface IPila {
    public int GetNum();
    public void Apila(Object elemento) throws Exception;
    public Object Desapila() throws Exception;
    public Object Primero() throws Exception;
}
