%% PRACTICA 1 - SISTEMAS DE PERCEPCION

% 1. Con la instrucci�n imfinfo de Matlab obt�n la siguiente informaci�n de la imagen �P1_1.jpg�: anchura en p�xeles, 
% altura en p�xeles, tipo de imagen y profundidad de bit.
imfinfo('P1_1.jpg')

% 2. Lee la imagen y gu�rdala en una variable de Matlab de nombre Imagen1.
Imagen1 = imread('P1_1.jpg');

% 3. Visualiza esta imagen con la instrucci�n imtool y con la instrucci�n imshow. Familiar�zate con los entornos gr�ficos 
% de salida de cada una de estas instrucciones.
imshow(Imagen1)
imtool(Imagen1)

% 4. Con la instrucci�n whos obt�n la siguiente informaci�n de la variable Matlab Imagen1: tipo de dato y rango.
whos I1

% 5. Utilizando la instrucci�n max, calcula el valor m�ximo de la variable Imagen1 (m�ximo nivel de intensidad).
max(Imagen1(:))

% 6. Calcula en Matlab la imagen complementaria de Imagen1, denomin�ndola Imagen2. Visualiza esta imagen y gu�rdala 
% en un fichero de imagen del mismo formato que la imagen original empleando la instrucci�n imwrite.
Imagen2 = uint8(zeros(size(Imagen1)));
R = Imagen1(:,:,1);
G = Imagen1(:,:,2);
B = Imagen1(:,:,3);
Rc = 255-R; Gc = 255-G; Bc = 255-B;
Imagen2(:,:,1) = Rc;
Imagen2(:,:,2) = Gc;
Imagen2(:,:,3) = Bc;

% Otra fomar de unir las matrices:
Imagen2 = cat(3, Rc, Gc, Bc);

imshow(Imagen1), figure, imshow(Imagen2)
imwrite(Imagen2, 'ImagenComplementaria.tif'); 

% 7. Crea y visualiza una matriz, de nombre Imagen3, con los niveles de rojo de la imagen Imagen1. Notar que esta 
% nueva matriz es una imagen en niveles de gris.
Imagen3 = Imagen1(:,:,1);
imshow(Imagen3);

% 8. Utiliza la funci�n imadjust con la configuraci�n ImagenSalida=imadjust(ImagenEntrada,[],[],gamma) para, mediante 
% la modificaci�n del par�metro gamma, obtener una imagen Imagen4 m�s clara (asignar gamma=0.5) y una imagen Imagen5 m�s 
% oscura (asignar gamma=1.5)que Imagen3.
gamma = 0.5;
Imagen4 = imadjust(Imagen3,[],[],gamma);
imshow(Imagen4)
gamma = 1.5;
Imagen5 = imadjust(Imagen3,[],[],gamma);
imshow(Imagen5)

% 9. Utiliza la funci�n imabsdiff, para crear una nueva imagen Imagen6 que refleje la diferencia absoluta de Imagen4 
% e Imagen5. Interpreta los resultados. Realiza la misma operaci�n sin utilizar la funci�n imabsdiff y comprueba que 
% obtienes los mismos resultados.
% Para ello, implementa y utiliza la siguiente funci�n que permite saber si el contenido de dos matrices de la misma 
% dimensi�n es el mismo:
% varLogica = funcion_compara_matrices(M1, M2)
% donde varLogica es una variable l�gica indica si M1 y M2 son iguale s (valor true) o diferentes (valor false)
Imagen6 = imabsdiff(Imagen5,Imagen4);
imshow(Imagen6)
addpath('funciones')
Imagen6f = funcion_imabsdiff(Imagen5,Imagen4);
imshow(Imagen6f)
varLogica = funcion_compara_matrices(Imagen6,Imagen6f)

% 10. Implementaci�n de histograma de una imagen:
% a. Implementa una funci�n que tenga como objetivo calcular el histograma de una imagen de intensidad I. La funci�n 
% debe devolver un vector h con la informaci�n num�rica del histograma.
% h = funci�n_histograma(I)
% Deben implementarse dos versiones de la funci�n: la primera, que realiza un recorrido por cada p�xel de la imagen 
% para generar el histograma; la segunda, que realiza un recorrido por cada posible nivel de gris que puede estar 
% presente en la imagen de entrada.

% b. Aplica la funci�n anterior para generar y visualizar el histograma de la componente verde de la imagen de la pr�ctica.
Imagen = Imagen1(:,:,2);
h = imhist(Imagen);
h1 = funcion_histograma(Imagen);
h2 = funcion_histogramav2(Imagen);

% c. Comprueba que obtienes los mismos resultados que genera la funci�n Matlab imhist. La comprobaci�n debe realizarse 
% visualmente, representando los histogramas en una misma gr�fica, y num�ricamente, utilizando la funci�n 
% funcion_compara_matrices.varLogica = funcion_compara_matrices(h,h1)
varLogica = funcion_compara_matrices(h,h1)
varLogica = funcion_compara_matrices(h,h2)
rmpath('funciones')