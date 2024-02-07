%% APLICACION CLASIFICADOR KNN CIRCULOS-CUADRADOS VS TRIANGULOS

clear all, clc

% CARGAR DATOS
addpath('Funciones')

load ('../01_SeleccionDescriptores/DatosGenerados/espacio_ccas_circ-tria_cuad');

% CALCULO DE LAS VARIABLES NECESARIAS
XoIRed = XoI(:,espacioCcas); 
YoIRed = YoI;

nombresProblemaOIRed = [];
nombresProblemaOIRed.descriptores = nombresProblemaOI.descriptores(espacioCcas);
nombresProblemaOIRed.clases = nombresProblemaOI.clases;
nombresProblemaOIRed.simbolos = nombresProblemaOI.simbolos;

% GUARDADO DE INFORMACION
save('./DatosGenerados/KNN_circ-tria_cuad.mat','espacioCcas','nombresProblemaOIRed','XoIRed','YoIRed');
