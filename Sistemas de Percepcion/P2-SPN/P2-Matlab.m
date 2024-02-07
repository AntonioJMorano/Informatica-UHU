%% ACTIVIDADES PREVIAS CON LA IMAGEN DEL CIRCULO

% IMAGEN CIRCULO
% Lectura de la imagen
I = imread('Circulo1.JPG');

% Calculo area
imhist(I);
Ib = I<100;
A = sum(I(:));

% Calculo de centroide
[f,c] = find(Ib);
fmean = mean(f); cmean = mean(c);
x = cmean; y = fmean;
figure, imshow(I), hold on, plot(x,y,'*r')

% IMAGEN X
% Lectura de la imagen
clear all, clc
I = imread('X.jpg');

% Calcular el �rea de cada letra X
Ib = I<100;
imshow(Ib)

% Pixeles conectados con la misma etiqueta
f = 280; c = 576; Ib(f,c) % Pixel con uno logico de ejemplo

% Vecindad tipo 8
v8 = Ib(f-1:f+1,c-1:c+1)
% Vecindad tipo 4
v4 = [Ib(f-1:2:f+1,c);Ib(f,c-1:2:c+1)']


%% PRACTICA 2 - SISTEMAS DE PERCEPCION

addpath('funciones')

% 1. Lee la imagen del fichero �ImagenBinaria.tif�. Comprueba que es una imagen binaria
% en la que est�n localizados los p�xeles que integran los objetos que se muestran en la imagen.
Imagen = imread('ImagenBinaria.tif');

% 2. Genera una matriz binaria tipo double o logical donde: el valor 0 signifique p�xel de
% fondo; el valor 1 signifique p�xel de objeto.
Ib = Imagen>0;

% 3. Genera una imagen en color, donde se visualice con un color diferente los objetos
% presentes en la imagen (al haber 6 objetos, pueden utilizarse los colores primarios y secundarios).
% Para ello, se deben implementar las siguientes funciones:
% ? Funci�n Visualiza:
% Io = funcion_visualiza(Ii,Ib, Color, flagRepresenta)
% donde:
% ? Ii: imagen de entrada, que puede ser en color o en escala de grises.
% ? Ib: matriz binaria del mismo n�mero de filas y columnas que la imagen de
% entrada, puede ser tipo logical o double.
% ? Color: vector con 3 valores de 0 a 255, con la codificaci�n RGB de un
% determinado color.
% ? flagRepresenta: variable opcional que, cuando se pasa como un true
% l�gico, indica a la funci�n que debe generar una ventana tipo figure con la
% representaci�n de la imagen de salida.
% ? Io: imagen en color de salida que representa la informaci�n de Ib (�1s�
% binarios) en el color especificado en Color, sobre la imagen de entrada Ii.

% ? Funci�n Etiquetar (ver documentaci�n adjunta):
% [IEtiq, N] = funcion_etiquetar (Ib)
% donde:
% ? Ib: matriz binaria con dos posibles valores, 0�s y 1�s, puede ser tipo logical
% o double.
% ? N: n�mero de agrupaciones conexas de 1�s presentes en la Ib, atendiendo a
% conectividad tipo 4.
% ? IEtiq: matriz tipo double, de las mismas dimensiones que Ib, con N+1
% posibles valores, 0 para identificar los 0�s de Ib y valores de etiqueta de 1 a N
% (n�meros enteros) para identificar los p�xeles de las agrupaciones conexas 1�s
% detectadas en Ib.
Color = [255,0,0;0,255,0;0,0,255;255,255,0;255,0,255;0,255,255];
flagRepresenta=true;

Io = funcion_visualiza(Imagen,Ib,Color,flagRepresenta);

% 4. Genera una imagen donde se localicen, a trav�s de su centroide, los objetos de mayor
% y menor �rea (ver documentaci�n para la definici�n de �rea y centroide).
% Para ello, se deben implementar las siguientes funciones:
% ? Funci�n Calcula �reas (ver documentaci�n definici�n de �rea):
% areas = funci�n_calcula_areas (IEtiq, N)
% donde:
% ? IEtiq, N: informaci�n generada con funcion_etiquetar.
% ? areas: matriz de N filas y una columna (vector fila) con los valores de �reas
% de las agrupaciones de IEtiq almacenados en la posici�n del vector fila
% correspondiente al valor de las etiquetas.
[IEtiq,N] = funcion_etiquetar(Ib);

areas = funcion_calcula_areas(IEtiq,N);

% ? Funci�n Calcula Centroides (ver documentaci�n definici�n de �rea):
% centroides = funci�n_calcula_centroides (IEtiq, N)
% donde:
% ? IEtiq, N: informaci�n generada con funcion_etiquetar.
% ? Centroides: matriz de N filas y dos columnas; cada fila contiene la
% coordenada x (primera columna) e y (segunda columna) del centroide de la
% agrupaci�n etiquetada con el valor de la posici�n de su fila.
[IEtiq,N] = funcion_etiquetar(Ib);

centroides = funcion_calcula_centroides(IEtiq,N);

% 5. Genera una imagen binaria donde s�lo se visualicen los dos objetos de �rea mayor.
% Para ello, se debe implementar la siguiente funci�n:
% IbFilt = funci�n_filtra_objetos (Ib , numPix)
% donde:
% ? Ib: matriz binaria con dos posibles valores, 0�s y 1�s, puede ser tipo
% logical o double.
% ? numPix: se eliminar�n todas las agrupaciones de 1�s de Ib que tengan un
% �rea menor a este valor.
% ? IbFilt: matriz binaria, de las mismas dimensiones que IbFilt, con dos
% posibles valores, 0�s y 1�s, con el valor 1 indicando las agrupaciones de Ib
% cuya �rea es mayor o igual a NumPix.
IbFilt = funcion_filtra_objetos(Ib,numPix);
imshow(IbFilt)

rmpath('funciones')