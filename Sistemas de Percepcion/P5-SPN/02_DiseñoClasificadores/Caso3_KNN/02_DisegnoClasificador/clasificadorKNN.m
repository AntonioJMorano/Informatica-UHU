%% APLICACION CLASIFICADOR KNN 

clear all, clc

% CARGAR DATOS
addpath('Funciones')

load ('../01_SeleccionDescriptores/DatosGenerados/espacio_ccas_circ_cuad_tria');

% CALCULO DE LAS VARIABLES NECESARIAS
XoIRed = XoI(:,espacioCcas); 
YoIRed = YoI;

nombresProblemaOIRed = [];
nombresProblemaOIRed.descriptores = nombresProblemaOI.descriptores(espacioCcas);
nombresProblemaOIRed.clases = nombresProblemaOI.clases;
nombresProblemaOIRed.simbolos = nombresProblemaOI.simbolos;

% GUARDADO DE INFORMACION
save('./DatosGenerados/KNN_circ_cuad_tria.mat','espacioCcas','nombresProblemaOIRed','XoIRed','YoIRed');
