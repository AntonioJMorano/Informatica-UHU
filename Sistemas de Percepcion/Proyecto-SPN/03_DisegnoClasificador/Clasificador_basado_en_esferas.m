%% DISEÑO Y ENTRENAMIENTO ALGORITMO DE CLASIFICACION

clear all, clc
addpath('Funciones')

% CARGAR INFORMACION
ruta = '../02_ExtraerRepresentarDatos/MaterialGenerado/';
nombreArchivo = 'conjunto_de_datos';

load([ruta nombreArchivo]);

clear ruta nombreArchivo

%% 3.1.- ELECCION ESTRATEGIA DE CLASIFICACION

valoresY = unique(Y);
foI = Y == valoresY(2);
XClase = X(foI,:);

% 1.- COMPROBACION DEL CLASIFICADOR BASADO EN UN PRISMA
valoresMinimos = min(XClase); valoresMaximos = max(XClase);

Rmin = valoresMinimos(1); Rmax = valoresMaximos(1);
Gmin = valoresMinimos(2); Gmax = valoresMaximos(2);
Bmin = valoresMinimos(3); Bmax = valoresMaximos(3);

% Representacion del prisma
figure, funcion_representa_observaciones(X,Y)
hold on, plot3(X(Rmax:Rmin),X(Gmax:Gmin),X(Bmax:Bmin),'*b')

% 2.- COMPROBACION DEL CLASIFICADOR BASADO EN UNA ESFERA
% Calculo del centroide de la esfera
valoresMedios = mean(XClase);
Rc = valoresMedios(1); Gc = valoresMedios(2); Bc = valoresMedios(3);

% Representacion del centroide
figure, funcion_representa_datos_color(X,Y,valoresY(2))
hold on, plot3(Rc,Bc,Gc,'*k')
funcion_representa_datos_color(X,Y,valoresY(1))


% FUNCION PARA CALCULAR LOS DATOS DE LA ESFERA
% Calculo de los datos de la esfera
valoresY = unique(Y);
fXColor = Y == valoresY(2);
fXFondo = Y == valoresY(1);
XColor = X(fXColor,:);
XFondo = X(fXFondo,:);

datosEsfera = calcula_datos_esfera(XColor,XFondo);

% Representacion de las esferas
centroides = datosEsfera(1:3);
radios = datosEsfera(4:6);

for i=1:length(radios)
   
    figure, funcion_representa_observaciones(X,Y)
    hold on, funcion_representa_esferas(centroides,radios(i))
    title(['Esfera con radio: ' num2str(radios(i))]), hold off
    
end

%% 3.2.- ENTRENAMIENTO DEL CLASIFICADOR

% CARGAR IMAGENES DE ENTRENAMIENTO
ruta = '../01_GeneracionMaterial/MaterialGenerado/';
nombreArchivo = 'ImagenesEntrenamiento_Calibracion';
load([ruta nombreArchivo]);

clear ruta nombreArchivo

% 1.- UMBRALES DE DISTANCIA
[numF,numC,numM,numIm] = size(I);

for i=1:numIm
   
    figure,
    Imagen = I(:,:,:,i);
    subplot(2,2,1), imshow(Imagen), title(['Imagen de calibracion nº ' num2str(i)]);
    
    for j=1:length(radios)
        
        Ib = calcula_deteccion_esfera_imagen(Imagen,centroides,radios(j));
        Io = funcion_visualiza(Imagen,Ib,[255 0 0],false);
        subplot(2,2,j+1), imshow(Io)
        title(['Radio: ' num2str(radios(j))]);
        
    end
    
end

% 2.- UMBRALES DE CONECTIVIDAD

[numF,numC,numM,numIm] = size(I);
umbrales = [55 50 45];

for i=1:numIm
   
    figure,
    Imagen = I(:,:,:,i);
    subplot(2,2,1), imshow(Imagen), title(['Imagen de calibracion nº ' num2str(i)]);
    
    for j=1:length(umbrales)
        
        Ib = calcula_deteccion_esfera_imagen(Imagen,centroides,umbrales(j));
        Io = funcion_visualiza(Imagen,Ib,[255 0 0],false);
        subplot(2,2,j+1), imshow(Io)
        title(['Radio: ' num2str(umbrales(j))]);
        
    end
    
end

% Probando he visto que los mejores umbrales son 55 50 45, destacando este
% ultimo aunque si es cierto que en algunos frames no coge bien el objeto
% creo que es mas por la calidad de las imagenes de calibracion.

% GUARDAR PARAMETROS DE CALIBRACION
save('MaterialGenerado/ParametrosCalibracion','centroides','radios','umbrales');

rmpath('Funciones')