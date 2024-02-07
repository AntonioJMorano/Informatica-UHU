%% SCRIPT PRIMER EJERCICIO

clear all, clc
addpath('Funciones')

% CARGAR DATOS
ruta = 'DatosEj2/';
nombreArchivo = 'parametros_clasificador';
load([ruta nombreArchivo])
clear ruta nombreArchivo

% 
centroides1 = datosMultiplesEsferas_clasificador(1,1:3); 
radios1 = datosMultiplesEsferas_clasificador(1,4);
centroides2 = datosMultiplesEsferas_clasificador(2,1:3); 
radios2 = datosMultiplesEsferas_clasificador(2,4);

% PROCESAR VIDEO
video = VideoReader('DatosEj2/video_entrada.avi');

aviobj = VideoWriter('videoFinalEj1.avi','Uncompressed AVI');
aviobj.FrameRate = video.FrameRate();

nPix = [];

open(aviobj)

while video.hasFrame()
    
    I = video.readFrame();
    Ib = mean(I,3)>=radios1;
    [IEtiq,N] = funcion_etiquetar(Ib);
    
    for i=1:N
        foI = IEtiq==i;
        np = sum(foI(:));
        nPix = [nPix;i np];
    end
    
    menosPix = min(nPix,2);
    
end

close(aviobj)