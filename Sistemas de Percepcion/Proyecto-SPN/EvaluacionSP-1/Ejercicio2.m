%% SCRIPT SEGUNDO EJERCICIO

clear all, clc
addpath('Funciones')

% CARGAR DATOS
ruta = 'DatosEj2/';
nombreArchivo = 'parametros_clasificador';
load([ruta nombreArchivo])
clear ruta nombreArchivo

% CARGAR VIDEO
video = VideoReader('DatosEj2/video_entrada.avi');

aviobj = VideoWriter('videoFinalEj2.avi','Uncompressed AVI');
aviobj.FrameRate = video.FrameRate(); 

umbral = 30;

open(aviobj)

I_Primera = video.readFrame();

while video.hasFrame()
   
    [nf,nc,n] = size(I_Primera);
    Io = I_Primera;
    
    % COLOR ROJO
    Medias = mean(I_Primera,3);
    IbR = Medias>85 & Medias<115;
    R = Io(:,:,1); G = Io(:,:,2); B = Io(:,:,3);
    R(IbR) = 255; G(IbR) = 0; B(IbR) = 0;
    Io = cat(3,R,G,B);
    
    % COLOR VERDE
    I = video.readFrame();
    Diferencia = abs(mean(I,3)-mean(I_Primera,3));
    IbG = Diferencia>umbral;
    R = Io(:,:,1); G = Io(:,:,2); B = Io(:,:,3);
    R(IbG) = 0; G(IbG) = 255; B(IbG) = 0;
    Io = cat(3,R,G,B);
    
    % COLOR AZUL
    IbB = IbR ==1 & IbG == 1;
    R = Io(:,:,1); G = Io(:,:,2); B = Io(:,:,3);
    R(IbB) = 0; G(IbB) = 0; B(IbB) = 255;
    Io = cat(3,R,G,B);
    
    writeVideo(aviobj,Io);
    I_Primera = I;
    
end

close(aviobj)