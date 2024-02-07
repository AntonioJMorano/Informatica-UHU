%% SELECCION DE DESCRIPTORES CIRCULOS VS TRIANGULOS

clear all, clc

% CARGAR DATOS

addpath('Funciones')

ruta = '../../../../01_GeneracionDatosPractica/DatosGenerados/';
nombreArchivo1 = 'conjunto_datos_estandarizados.mat';
nombreArchivo2 = 'nombresProblema.mat';

load([ruta nombreArchivo1]);
load([ruta nombreArchivo2]);

X = Z;

numDescriptores = size(X,2);
numDescriptoresOI = 9;
nombreDescriptores = nombresProblema.descriptores;

% SELECCION DE DESCRIPTORES

clasesOI = [1 3];
codifClases = unique(Y);
codifClasesOI = codifClases(clasesOI);

filasOI = false(size(Y));
for i=1:length(clasesOI)
   filasOI_i = Y==codifClasesOI(i); 
   filasOI = or(filasOI,filasOI_i);
end

XoI = X(filasOI,1:numDescriptores-1);
YoI = Y(filasOI);

[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas(XoI,YoI,3);

numDescriptores = size(X,2);
nombresProblemaOI = [];
nombresProblemaOI.descriptores = nombresProblema.descriptores(1:numDescriptores-2);
nombresProblemaOI.clases = nombresProblema.clases(clasesOI);
nombresProblemaOI.simbolos = nombresProblema.simbolos(clasesOI);

save('./DatosGenerados/espacio_ccas_circ_tria','espacioCcas','XoI','YoI','nombresProblemaOI');
