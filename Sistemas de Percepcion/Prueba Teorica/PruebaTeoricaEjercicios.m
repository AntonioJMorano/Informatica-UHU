%% EJERCICIOS PRUEBA TEORICA

% EJERCICIO 1
% Cargar datos
XC1 = [1,2,2,2,2,3,3,4,5,1;3,1,2,3,4,2,3,3,2,2];
XC2 = [4,5,5,4,6,6,6,7,4,8;5,5,6,7,5,6,7,6,6,7];

% Calculo de medias
M1 = mean(XC1,2); M2 = mean(XC2,2);

% Calculo de funciones de decision
x1 = sym('x1','real');
x2 = sym('x2','real');

d1 = expand(-[x1-M1(1) x2-M1(2)]*[x1-M1(1) x2-M1(2)]');
d2 = expand(-[x1-M2(1) x2-M2(2)]*[x1-M2(1) x2-M2(2)]');

% Funcion discriminante
d12 = d1-d2

% Coeficientes frontera de decision
x1=0; x2=0; C=eval(d12);
x1=1; x2=0; A=eval(d12)-C;
x1=0; x2=1; B=eval(d12)-C;

coeficientesd12 = [A B C];

% Representacion
xmin = 0; xmax = 9;
x1Recta = xmin:0.01:xmax;
x2Recta = -(A*x1Recta+C)/B;

figure, plot(x1Recta,x2Recta,'r')
hold on, plot(XC1(1,:),XC1(2,:),'*g')
plot(XC2(1,:),XC2(2,:),'*b')
grid on, hold off

% EJERCICIO 2
clear all, clc

M1 = [0;3]; M2 = [5;2]; M3 = [1;0];
Cinv = [2 0;0 4];

x1 = sym('x1','real');
x2 = sym('x2','real');

d1 = expand(-[x1-M1(1) x2-M1(2)]*Cinv*[x1-M1(1) x2-M1(2)]');
d2 = expand(-[x1-M2(1) x2-M2(2)]*Cinv*[x1-M2(1) x2-M2(2)]');
d3 = expand(-[x1-M3(1) x2-M3(2)]*Cinv*[x1-M3(1) x2-M3(2)]');

d12 = d1-d2
d13 = d1-d3
d23 = d2-d3

x1=0; x2=0; C12=eval(d12); C13=eval(d13); C23=eval(d23);
x1=0; x2=1; B12=eval(d12)-C12; B13=eval(d13)-C13; B23=eval(d23)-C23;
x1=1; x2=0; A12=eval(d12)-C12; A13=eval(d13)-C13; A23=eval(d23)-C23;

xmin = 0; xmax = 14;
X1Recta = xmin:0.01:xmax;
X12Recta = -(A12*X1Recta+C12)/B12;
X13Recta = -(A13*X1Recta+C13)/B13;
X23Recta = -(A23*X1Recta+C23)/B23;

figure, plot(X1Recta,X12Recta,'r')
hold on, plot(X1Recta,X13Recta,'g'), plot(X1Recta,X23Recta,'b')
grid on, hold off

% EJERCICIO 3
clear all, clc

XC1 = [2,3,3,4;1,2,3,2];
XC2 = [6,5,7;1,2,3];

% Calculo de medias
M1 = mean(XC1,2);
M2 = mean(XC2,2);

mCov1 = cov(XC1');
mCov2 = cov(XC2');

mCov = ((4-1)*mCov1+(3-1)*mCov2)/(7-2);

x1 = sym('x1','real');
x2 = sym('x2','real');

d1 = expand(-[x1-M1(1) x2-M1(2)]*pinv(mCov)*[x1-M1(1) x2-M1(2)]');
d2 = expand(-[x1-M2(1) x2-M2(2)]*pinv(mCov)*[x1-M2(1) x2-M2(2)]');

d12 = d1-d2

x1=0; x2=0; C=eval(d12);
x1=0; x2=1; B=eval(d12)-C;
x1=1; x2=0; A=eval(d12)-C;

xmin = 0; xmax = 10;
X1Recta = xmin:0.01:xmax;
X2Recta = -(A*X1Recta+C)/B;

figure, plot(XC1(1,:),XC1(2,:),'*g')
hold on, plot(XC2(1,:),XC2(2,:),'*b')
plot(X1Recta,X2Recta,'r'),
grid on, hold off


% EJERCICIO 4
clear all, clc
addpath('Funciones')

% Representacion
clases1 = clases; datos1 = datos;
clases2 = clases; datos2 = datos;
clear clases datos

% Clase 1
valoresY1 = unique(clases1);
foI1 = clases1==valoresY1(1);
datos1B = datos1(foI1,:);

% Clase 2
valoresY2 = unique(clases2);
foI2 = clases2==valoresY1(1);
datos2B = datos2(foI2,:);

figure(1), plot(datos1(:,1),datos1(:,2),'*r')
hold on, plot(datos1B(:,1),datos1B(:,2),'*g')
title('Experimento 1')
legend('Personas malas','Personas buenas'), hold off

figure(2), plot(datos2(:,1),datos2(:,2),'*r')
hold on, plot(datos2B(:,1),datos2B(:,2),'*g')
title('Experimento 2')
legend('Personas malas','Personas buenas'), hold off

% Clasificador LDA
% Clase 1
[vectorMedias1,mCov1,probabilidadAPriori1] = funcion_ajusta_LDA(datos1,clases1);
[YP1,d1] = funcion_aplica_LDA(datos1,vectorMedias1,mCov1,probabilidadAPriori1,unique(clases1));
error = clases1-YP1;
numAciertos = sum(error==0);
Acc = numAciertos/length(error)

% Clase 2
[vectorMedias2,mCov2,probabilidadAPriori2] = funcion_ajusta_LDA(datos2,clases2);
[YP2,d2] = funcion_aplica_LDA(datos2,vectorMedias2,mCov2,probabilidadAPriori2,unique(clases2));
error = clases2-YP2;
numAciertos = sum(error==0);
Acc = numAciertos/length(error)

% Clasificador QDA para experimento 2
[vectorMedias,mCov,probabilidadAPriori] = funcion_ajusta_QDA(datos2,clases2);
[YP,d] = funcion_aplica_QDA(datos2,vectorMedias,mCov,probabilidadAPriori,clases2);
error = clases2-YP;
numAciertos = sum(error==0);
Acc = numAciertos/length(error)


%% APUNTES

% Hallar la matriz de covarianzas en comun de las clases
mCov = ((numDatosClase1-1)*mCov1+(numDatosClase2-1)*mCov2);


%% Clasificadores para LDA y QDA
% Funcion para que devuelva los datos que nos interesan de nuestro conjunto
[vectorMedias,mCov,probabilidadAPrioir] = funcion_ajusta_LDA(X,Y);

% Funcion para aplicar los clasificadores
[YP,d] = funcion_aplica_LDA(X,vectorMedias,mCov,probabilidadAPriori,valoresClases); % valoresclases = unique(Y)

% Verificar
error = Y-YP;
numAciertos = sum(error==0)
Acc = numAciertos/length(error)


%% Funcion KNN

YP = funcion_knn(XTest,XTrain,YTrain,11,'Euclidea');

% Funcion:
k=11;
i=1;
XTest_i = XTest(i,:)';

XTrain = XTrain';
numDatosXTrain = size(XTraint,2);

XTest_i_amp = repmat(XTest_i,1,numDatosTrain);
vectorDistancia = sqrt(sum((XTest_i_amp-XTrain).^2));

[vectorDistanciaOrd,ind] = sort(vectorDistancia,'ascend');

YTrainOrd = YTrain(ind);

clasesKNN = YTrainOrd(1:k);
valoresClasesKNN = unique(clasesKNN);
conteoValoresClasesKNN = zeros(size(valoresClasesKNN));

for j=1:length(valoresClasesKNN)
    conteoValoresClasesKNN(j) = sum(clasesKNN==valoresClasesKNN(j));
end

% Encontramos el max en conteoValoresClasesKNN y vemos a que clase
% pertenece en valoresClasesKNN, despues se la asignamos a YP
% Si ambas clases tienen el mismo valor en el conteo, debemos poner la
% clase que es mas cercana que pertencezca a una de esas 2 clases