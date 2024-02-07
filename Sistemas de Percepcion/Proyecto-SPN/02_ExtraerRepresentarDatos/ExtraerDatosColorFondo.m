%% GENERACION DE CONJUNTO DE DATOS

clear all, clc

% CARGAR INFORMACION
ruta = '../01_GeneracionMaterial/MaterialGenerado/';
nombreArchivo = 'ImagenesEntrenamiento_Calibracion';

load([ruta nombreArchivo]);

clear ruta nombreArchivo

%% 2.1
% VISUALIZACION DE IMAGENES
[F,C,numComp,numIm] = size(I);

for i=1:numIm
   imshow(I(:,:,:,i)),title("Imagen: " + num2str(i));
   pause
end

% 1.- EXTRACCION DE LOS DATOS COLOR
% Va desde la imagen nº 6 hasta la ultima
DatosColor = [];

for i=6:numIm
   
    Iaux = I(:,:,:,i);
    R = Iaux(:,:,1);
    G = Iaux(:,:,2);
    B = Iaux(:,:,3);
    
    Ir = roipoly(Iaux);
    numPix = sum(Ir(:));
    
    Datos = [i*ones(numPix,1) R(Ir) G(Ir) B(Ir)];
    DatosColor = [DatosColor;Datos];
    
end

% 2.- EXTRACCION DE LOS DATOS FONDO
DatosFondo = [];

for i=1:5
    
    Iaux = I(:,:,:,i);
    R = Iaux(:,:,1);
    G = Iaux(:,:,2);
    B = Iaux(:,:,3);
    
    Ir = roipoly(Iaux);
    numPix = sum(Ir(:));
    
    Datos = [i*ones(numPix,1) R(Ir) G(Ir) B(Ir)];
    DatosFondo = [DatosFondo;Datos];
    
end

save('MaterialGenerado/DatosColorDatosFondo','DatosColor','DatosFondo');

% 3.- GENERACION VARIABLES X E Y
X = [DatosColor(:,2:4);DatosFondo(:,2:4)];
Y = [ones(size(DatosColor,1),1);zeros(size(DatosFondo,1),1)];

save('MaterialGenerado/conjunto_de_datos_original','X','Y');

%% 2.2
% CARGAR DATOS
clear all, clc
load 'MaterialGenerado/conjunto_de_datos_original';

% 1.- REPRESENTACION DE LOS DATOS
% Para ello utilizamos la funcion representa observaciones pasandole las
% variables X e Y por parametro
addpath('Funciones')
funcion_representa_observaciones(X,Y);

%% 2.3
% 1.- ELIMINACION OUTLIERS
valoresY = unique(Y)
foI = Y == valoresY(2);
R = X(:,1); G = X(:,2); B = X(:,3);

% Calculos de medias y desviaciones tipicas
media = mean(X(foI,:)); desv = std(double(X(foI,:)));
Rmean = media(1); Rdesv = desv(1);
Gmean = media(2); Gdesv = desv(2);
Bmean = media(3); Bdesv = desv(3);

% Calculos de valores fuera del rango "normal" de cada componente
outR = (R>Rmean+3*Rdesv) | (R<Rmean-3*Rdesv);
outG = (G>Gmean+3*Gdesv) | (G<Gmean-3*Gdesv);
outB = (B>Bmean+3*Bdesv) | (B<Bmean-3*Bdesv);

% Sacamos las posiciones de estos valores
pos_outR = find(outR(foI));
pos_outG = find(outG(foI));
pos_outB = find(outB(foI));

% Nos quedamos con los valores unicos ya que se pueden repetir
pos_outliers = unique([pos_outR;pos_outG;pos_outB]);

% HACIENDOLO MEDIANTE UNA FUNCION
posInteres = valoresY(2);
pos_outliers = funcion_detecta_outliers(X,Y,posInteres);

% Representacion
funcion_representa_observaciones(X,Y)
hold on, plot3(R(pos_outliers),G(pos_outliers),B(pos_outliers),'ok')

% 2.- GENERACION DE CONJUNTO DE DATOS SIN OUTLIERS
% Elimnacion de datos anomalos
X(pos_outliers,:) = [];
Y(pos_outliers) = [];

% 3.- REPRESENTACION DE CONJUNTO DE DATOS SIN OUTLIERS
funcion_representa_observaciones(X,Y)

% GUARDAR CONJUNTO DE DATOS
save('MaterialGenerado/conjunto_de_datos','X','Y');

rmpath('Funciones')