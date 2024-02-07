%% PROGRAMACIÓN GENERACIÓN CONJUNTO DE DATOS X-Y

%% LECTURA AUMATIZADA DE LAS IMÁGENES DE ENTRENAMIENTO DISPONIBLES

addpath('ImagenesPractica5/Entrenamiento')
addpath('Funciones')

% CREACION DE VARIABLES
nombres{1} = 'Circulo';
nombres{2} = 'Cuadrado';
nombres{3} = 'Triangulo';

numClases = 3;
numImClase = 2;

X = [];
Y = [];

for i=1:numClases
    for j=1:numImClase
        
        % LECTURA DE IMAGENES
        nombreImagen = [nombres{i} num2str(j,'%02d') '.jpg'];
        I = imread(nombreImagen);
        
        % BINARIZACION CON SELECCION DE UMBRAL
        umbral = graythresh(I);
        % umbral = funcion_otsu(I);
        IBin = I<255*umbral;
        
        % ELIMINACION DE OUTLIERS
        IBinFilt = funcion_elimina_regiones_ruidosas(IBin);
        
        % ETIQUETAR
        if sum(IBinFilt(:))>0
            [IEtiq,N] = bwlabel(IBinFilt);
            
            % CALCULO DE DESCRIPTORES
            XImagen = funcion_calcula_descriptores_imagen(IEtiq,N);
            YImagen = i*ones(N,1);
        else
            XImagen = [];
            YImagen = [];
        end
        
        X = [X;XImagen];
        Y = [Y;YImagen];
        
    end
end

% GENERACION VARIABLE NOMBRES PROBLEMA
nombresDescriptores{1} = 'Compacticidad';
nombresDescriptores{2} = 'Excentricidad';
nombresDescriptores{3} = 'Solidez';
nombresDescriptores{4} = 'Extension';
nombresDescriptores{5} = 'ExtensionIR';
nombresDescriptores{6} = 'Hu1';
nombresDescriptores{7} = 'Hu2';
nombresDescriptores{8} = 'Hu3';
nombresDescriptores{9} = 'Hu4';
nombresDescriptores{10} = 'Hu5';
nombresDescriptores{11} = 'Hu6';
nombresDescriptores{12} = 'Hu7';
nombresDescriptores{13} = 'DF1';
nombresDescriptores{14} = 'DF2';
nombresDescriptores{15} = 'DF3';
nombresDescriptores{16} = 'DF4';
nombresDescriptores{17} = 'DF5';
nombresDescriptores{18} = 'DF6';
nombresDescriptores{19} = 'DF7';
nombresDescriptores{20} = 'DF8';
nombresDescriptores{21} = 'DF9';
nombresDescriptores{22} = 'DF10';
nombresDescriptores{23} = 'NumeroEuler';

nombresClases{1} = 'Circulo';
nombresClases{2} = 'Cuadrado';
nombresClases{3} = 'Triangulo';

simbolos{1} = '*r';
simbolos{2} = '*b';
simbolos{3} = '*g';

nombresProblema = [];
nombresProblema.descriptores = nombresDescriptores;
nombresProblema.clases = nombresClases;
nombresProblema.simbolos = simbolos;

% ALMACENAMIENTO DE CONJUNTO DE DATOS
save('./DatosGenerados/conjunto_datos','X','Y');
save('./DatosGenerados/nombresProblema','nombresProblema');