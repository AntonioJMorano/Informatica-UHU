%% IMPLEMENTACION Y VISUALIZACION DEL ALGORITMO DE SEGUIMIENTO

clear all, clc
addpath('Funciones')

% CARGAR DATOS
ruta = '../03_DisegnoClasificador/MaterialGenerado/';
nombreArchivo = 'ParametrosCalibracion';
load([ruta nombreArchivo]);

clear ruta nombreArchivo

% LEER SECUENCIA DE VIDEO
aviobj = VideoWriter('videoFinal.avi','Uncompressed AVI');
aviobj.FrameRate = video.FrameRate;

Rc = round(centroides(1)); Gc = round(centroides(2)); Bc = round(centroides(3));

video = VideoReader('../01_GeneracionMaterial/MaterialGenerado/video.avi');

open(aviobj)

while video.hasFrame()
    
   I = video.readFrame();
   Ib = calcula_deteccion_esfera_imagen(I,centroides,umbrales(3));
   Io = funcion_visualiza(I,Ib,[0 255 0],false);
   %Io(Rc,Gc,Bc) = 0;
   writeVideo(aviobj,Io); % plot3(centroides(1),centroides(2),centroides(3),'*k');
   
end

close(aviobj)

% UTILIZANDO LA FUNCION KMEANS
clear all, clc
addpath('Funciones')

% CARGAR DATOS
ruta = '../02_ExtraerRepresentarDatos/MaterialGenerado/';
nombreArchivo = 'conjunto_de_datos';
load([ruta nombreArchivo]);

clear ruta nombreArchivo

[idx,centroides] = funcion_kmeans(X,n);

save('./MaterialGenerado/parametros_clasificador','idx','centroides');