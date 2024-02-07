%% ESTANDARIZACION DEL CONJUNTO DE DATOS
clear all, clc

addpath('Funciones');
addpath('DatosGenerados');

% CARGA DE DATOS
load ('./DatosGenerados/conjunto_datos');
load ('./DatosGenerados/nombresProblema');

% VARIABLES NECESARIAS
[numMuestras, numDescriptores] = size(X);
codifClases = unique(Y);
numClases = length(codifClases);

% CALCULO DE MEDIAS Y DESVIACION TIPICA
medias = mean(X);
desv = std(X);
medias(end) = 0;
desv(end) = 1;

Z = X;

for i=1:numDescriptores-1
    
    if desv(i)==0
        desv(i) = eps;
    end
    
    Z(:,i) = (X(:,i)-medias(i))/desv(i);
    
end

% GUARDAR DATOS
save('./DatosGenerados/conjunto_datos_estandarizados','Z','Y');
save('./DatosGenerados/datos_estandarizacion','medias','desv');
