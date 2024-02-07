%% PRACTICA 3 - SISTEMAS DE PERCEPCION

% PRIMERA PARTE
addpath('funciones');

video = videoinput('winvideo',1,'YUY2_320x240');
video.ReturnedColorSpace = 'rgb';
preview(video)
I = getsnapshot(video);

% 1.- Utilizando  la  funci�n  de  Matlab  subplot,  muestre  en  una  misma  ventana  tipo  figure  la 
% imagen  capturada  y  3 im�genes que resalten, sobre la imagen original, aquellos  p�xeles cuya 
% intensidad  sea  mayor  que  un  determinado  umbral  (asigne  para  esas  3  im�genes,  valores  de 
% umbral:  70,  140  y  210,  respectivamente).  La  intensidad  de  un  p�xel  se  calcular�  como  la 
% media de los niveles de gris de las componentes roja, verde y azul.
figure, hold on,
subplot(2,2,1), imshow(I),

I = ((double(I(:,:,1))+double(I(:,:,2))+double(I(:,:,3)))/3);
umbrales = [70;140;210];

for i=1:length(umbrales)
   Ib = I>umbrales(i);
   subplot(2,2,i+1), funcion_visualiza(I,Ib,[255 0 0],true),
end

% 2.- Para cada una de las im�genes generadas en el apartado anterior: 
% ? Visualice sobre la imagen original las 5 agrupaciones mayores de p�xeles conectados. 
[IEtiq70 N70] = bwlabel(I70);
[IEtiq140 N140] = bwlabel(I140);
[IEtiq210 N210] = bwlabel(I210);

stats70 = regionprops(IEtiq70,'Area','Centroid');
stats140 = regionprops(IEtiq140,'Area','Centroid');
stats210 = regionprops(IEtiq210,'Area','Centroid');

areas70 = sort(cat(1,stats70.Area),'descend');
areas140 = sort(cat(1,stats140.Area),'descend');
areas210 = sort(cat(1,stats210.Area),'descend');

Imod = bwareaopen(I,areas);
imshow(Imod)

% ? Localice  a  trav�s  de  su  centroide  las  agrupaciones  anteriores  y,  en  otro  color,  el 
% centroide de la mayor agrupaci�n para distinguirla.



%% SEGUNDA PARTE
video = videoinput('winvideo',1,'YUY2_320x240');
video.ReturnedColorSpace = 'rgb';
video.FramesPerTrigger = inf;
video.TriggerRepeat = 1;
video.FrameGrabInterval = 3;

preview(video)

% 3.- La  escena  inicialmente  oscurecida  y  aclar�ndose  progresivamente  (utilizar  la  instrucci�n 
% imadjust y valores de gamma entre 0 y 4 con pasos de 0.05).  
start(video)
for gamma=4:-0.05:0
    I = getdata(video,1);
    Imod = imadjust(I,[],[],gamma);
    imshow(Imod);
end
stop(video)

% 4.- Todos  los  p�xeles  que  tengan  una  intensidad  mayor  que  un  determinado  umbral.  Asignar 
% inicialmente el valor 0 a este umbral e ir aument�ndolo progresivamente con pasos de unidad 
% hasta el 255. 
video.ReturnedColorSpace = 'grayscale';
start(video)
for umbral=0:255
    I = getdata(video,1);
    Imod = I>umbral;
    imshow(Imod);
end
stop(video)

% 5.1.- Las  diferencias  que  se  producen  entre  los  distintos  frames  de  intensidad  que  captura  la 
% webcam (utilizar la instrucci�n imabsdiff para hacer la diferencia entre el frame actual y el 
% adquirido previamente).
video.ReturnedColorSpace = 'rgb';
start(video)
I1 = getdata(video,1);
for i=1:50
    I2 = getdata(video,1);
    Imod = imabsdiff(I1,I2);
    imshow(Imod);
    I1 = I2;
end
stop(video)

% 5.2.- Los  p�xeles  cuyas  diferencias  de  intensidad  son  significativas  (considerar  un  umbral  de 
% 100 para establecer de diferencias de intensidad significativas).
video.ReturnedColorSpace = 'grayscale';
start(video)
for i=0:50
    I = getdata(video,1);
    Imod = I<100;
    imshow(Imod);
end
stop(video)

% 5.3.- El  seguimiento  de  la  agrupaci�n  mayor  de  p�xeles  que  presenta  una  diferencia  de 
% intensidad significativa. El seguimiento debe visualizarse a trav�s de un punto rojo situado en 
% el centroide de la agrupaci�n. 
