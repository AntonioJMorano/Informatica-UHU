%% SELECCION DE DESCRIPTORES CIRCULOS-CUADRADOS VS TRIANGULOS

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
Yaux = Y==3; % Convertir circulos-Triangulos en una clase
Y(Yaux) = 1;

XoI = X(:,1:numDescriptores-1);
YoI = Y;

[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas(XoI,YoI,4);

nombresProblemaOI = [];
nombresProblemaOI.descriptores = nombresProblema.descriptores(1:numDescriptores-1);
nombresProblemaOI.clases = {'Circulo-Triangulo','Cuadrado'};
nombresProblemaOI.simbolos = {'*r','*b'};

save('./DatosGenerados/espacio_ccas_circ-tria_cuad','espacioCcas','XoI','YoI','nombresProblemaOI');
