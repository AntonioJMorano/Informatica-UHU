%% SELECCION DESCRIPTORES CIRCULOS VS CUADRADOS VS TRIANGULOS

clear all, clc

% CARGAR DATOS
addpath('Funciones')

ruta = '../../../01_GeneracionDatosPractica/DatosGenerados/';
nombreArchivo1 = 'conjunto_datos_estandarizados.mat';
nombreArchivo2 = 'nombresProblema.mat';

load([ruta nombreArchivo1]);
load([ruta nombreArchivo2]);

X = Z;

numDescriptores = size(X,2);
numDescriptoresOI = 9;
nombreDescriptores = nombresProblema.descriptores;

% SELECCION DE DESCRIPTORES
XoI = X(:,1:numDescriptores-1);
YoI = Y;

[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas(XoI,YoI,5);

nombresProblemaOI = [];
nombresProblemaOI.descriptores = nombresProblema.descriptores(1:numDescriptores-1);
nombresProblemaOI.clases = nombresProblema.clases;
nombresProblemaOI.simbolos = nombresProblema.simbolos;

save('./DatosGenerados/espacio_ccas_circ_cuad_tria','espacioCcas','XoI','YoI','nombresProblemaOI');
