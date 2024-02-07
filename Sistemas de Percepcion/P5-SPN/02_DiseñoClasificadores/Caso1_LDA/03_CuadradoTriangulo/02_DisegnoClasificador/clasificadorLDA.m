%% APLICACION CLASIFICADOR LDA PARA CUADRADOS VS TRIANGULOS

clear all, clc

% CARGAR DATOS
addpath('Funciones')

load ('../01_SeleccionDescriptores/DatosGenerados/espacio_ccas_cuad_tria.mat');

% CALCULO DE LAS VARIABLES NECESARIAS
XoIRed = XoI(:,espacioCcas); 
YoIRed = YoI;

nombresProblemaOIRed = [];
nombresProblemaOIRed.descriptores = nombresProblemaOI.descriptores(espacioCcas);
nombresProblemaOIRed.clases = nombresProblemaOI.clases;
nombresProblemaOIRed.simbolos = nombresProblemaOI.simbolos;

% APLICAMOS CLASIFICADOR
% [vectorMedias, matrizCovarianza, probabilidadPriori] = funcion_ajusta_LDA(XoIRed,YoIRed);
% [YLDA,d12] = funcion_aplica_LDA(XoIRed,vectorMedias,matrizCovarianza,probabilidadPriori,unique(YoIRed));
[d1,d2,d12,coef_d12] = funcion_calcula_hiperplanoLDA_2Clases_2_3_Dim(XoIRed,YoIRed);

% REPRESENTACION
% Leyenda
textoLeyenda = nombresProblemaOIRed.clases;
textoLeyenda{end+1} = 'Frontera Separacion';

figure, hold on,
funcion_representa_instancias_entrenamiento(XoIRed,YoIRed,nombresProblemaOIRed),
funcion_representa_hiperplano_separacion_2_3_Dim(coef_d12,XoIRed),
title('Frontera Separacion LDA cuadrados vs triangulos'),
legend(textoLeyenda)
grid on, hold off

% GUARDADO DE INFORMACION
save('./DatosGenerados/LDA_cuad_tria.mat','d12','espacioCcas','nombresProblemaOIRed','XoIRed','YoIRed','coef_d12');
