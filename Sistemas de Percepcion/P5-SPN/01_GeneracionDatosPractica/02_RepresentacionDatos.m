%% REPRESENTACIÓN Y ANÁLISIS CUALITATIVO INICIAL DEL CONJUNTO DE DATOS X-Y

% CARGAR CONJUNTO DE DATOS Y VARIABLES DEL PROBLEMA
load ('./DatosGenerados/conjunto_datos');
load ('./DatosGenerados/nombresProblema');

% REPRESENTAR LOS DATOS EN ESPACIOS DE CARACTERISTICAS DOS A DOS
addpath('Funciones')

[numMuestras numDescriptores] = size(X);

for i=1:2:numDescriptores-1-1

    espacioCcas = [i i+1];
    funcion_representa_datos(X,Y,espacioCcas,nombresProblema)

end
    
% REPRESENTACIÓN HISTOGRAMA Y DIAGRAMA DE CAJAS DE CADA DESCRIPTOR
nombreDescriptores = nombresProblema.descriptores;
nombreClases = nombresProblema.clases;
codifClases = unique(Y);
numClases = length(codifClases);
close all
datosDescriptores = [];

for j=1:3:numDescriptores
    
    % Valores máximo y mínimos para representar en la misma escala
    vMin = min(X(:,j)); 
    vMax = max(X(:,j));
    
    hFigure = figure; hold on
    bpFigure = figure; hold on
     
    for i=1:numClases
    
        Xij = X(Y==codifClases(i),j); % datos de la clase i del descriptor j 
        numDatosClase = size(Xij,1);

        figure(hFigure)
        subplot(numClases,1,i), hist(Xij),
        xlabel(nombreDescriptores{j})
        ylabel('Histograma')
        axis([ vMin vMax 0 numMuestras/4]) % inf para escala automática del eje y
        title(nombreClases{i})
        
        figure(bpFigure)
        subplot(1,numClases,i), boxplot(Xij)
        xlabel('Diagrama de Caja')
        ylabel(nombreDescriptores{j})
        axis([ 0 2 vMin vMax ])
        title(nombreClases{i})
    end
end
