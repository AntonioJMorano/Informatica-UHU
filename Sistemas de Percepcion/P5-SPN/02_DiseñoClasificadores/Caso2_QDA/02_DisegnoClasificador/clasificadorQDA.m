%% APLICACION CLASIFICADOR LDA PARA CIRCULOS VS CUADRADOS

clear all, clc

% CARGAR DATOS
addpath('Funciones')

load ('../01_SeleccionDescriptores/DatosGenerados/espacio_ccas_circ_cuad.mat');

% CALCULO DE LAS VARIABLES NECESARIAS
XoIRed = XoI(:,espacioCcas); 
YoIRed = YoI;

nombresProblemaOIRed = [];
nombresProblemaOIRed.descriptores = nombresProblemaOI.descriptores(espacioCcas);
nombresProblemaOIRed.clases = nombresProblemaOI.clases;
nombresProblemaOIRed.simbolos = nombresProblemaOI.simbolos;

% APLICAMOS CLASIFICADOR
[vectorMedias, matrizCovarianza, probabilidadPriori] = funcion_ajusta_QDA(XoIRed,YoIRed);
[YQDA,d12,d13,d23] = funcion_aplica_QDA(XoIRed,vectorMedias,matrizCovarianza,probabilidadPriori,unique(YoIRed));

% GUARDADO DE INFORMACION
save('./DatosGenerados/QDA_circ_cuad_tria.mat','d12','d13','d23','espacioCcas','nombresProblemaOIRed','XoIRed','YoIRed','YQDA');
