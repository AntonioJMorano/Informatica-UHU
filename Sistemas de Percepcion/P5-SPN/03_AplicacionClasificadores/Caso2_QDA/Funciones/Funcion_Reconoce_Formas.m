function Funcion_Reconoce_Formas(nombre)

    % CARGAR DATOS E IMAGENES
    addpath('../ImagenesPractica5/Test')
    
    % LECTURA Y BINARIZACION DE LA IMAGEN
    I = imread(nombre);
    umbral = graythresh(I);
    % umbral = funcion_otsu(I);
    IBin = I<255*umbral;
    
    % ELIMINACION DE LAS REGIONES RUIDOSAS
    IBinFilt = funcion_elimina_regiones_ruidosas(IBin);

    % ETIQUETAR LA IMAGEN
    if sum(IBinFilt(:)>0)
        [Ietiq,N] = bwlabel(IBinFilt);
        XImagen = funcion_calcula_descriptores_imagen(Ietiq,N);
    else
        XImagen = [];
    end
    
    % CARGA Y GENERACION DE DATOS ESTANDARIZADOS
    ruta = '../../01_GeneracionDatosPractica/DatosGenerados/';
    nombreArchivo = 'datos_estandarizacion';

    load([ruta nombreArchivo]);

    numObjetos = N;
    numDescriptores = size(XImagen,2);

    XImagenS = [];
    for i=1:numDescriptores
       if desv(i)==0
           desv(i) = esp;
       end
       XImagenS(:,i) = (XImagen(:,i)-medias(i))/desv(i);
    end
    
    % CARGA INFORMACION CLASIFICADORES
    % Circulos vs Cuadrados vs Triangulos
    ruta = '../../02_DiseñoClasificadores/Caso2_QDA/02_DisegnoClasificador/DatosGenerados/';
    nombreArchivo = 'QDA_circ_cuad_tria';
    load([ruta nombreArchivo]);
    
    % EVALUAR CLASIFICADORES
    for i=1:numObjetos

        Xi = XImagenS(i,:);

        XiOI = Xi(1,espacioCcas);
        x1 = XiOI(1); x2 = XiOI(2); x3 = XiOI(3); x4 = XiOI(4);
        valor_d12 = eval(d12);
        valor_d13 = eval(d13);
        valor_d23 = eval(d23);

        if valor_d12>0 & valor_d13>0
            claseOI = nombresProblemaOIRed.clases{1};
            reconocimiento = ['Reconomiento Objeto:' claseOI];
            color = [255 0 0];
        elseif valor_d12<0 & valor_d23>0
            claseOI = nombresProblemaOIRed.clases{2};
            reconocimiento = ['Reconomiento Objeto:' claseOI];
            color = [0 0 255];
            YiOI = 2;
        elseif valor_d13<0 & valor_d23<0
            claseOI = nombresProblemaOIRed.clases{3};
            reconocimiento = ['Reconomiento Objeto:' claseOI];
            color = [0 255 0];
        else
            reconocimiento = 'No se puede determinar el objeto';
        end

        % REPRESENTACION
        Ib = Ietiq==i;
        figure, funcion_visualiza(I,Ib,color);
        title(reconocimiento)

    end

end