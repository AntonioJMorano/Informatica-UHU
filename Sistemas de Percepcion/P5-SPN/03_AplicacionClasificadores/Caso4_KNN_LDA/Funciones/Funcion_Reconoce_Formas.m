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
    % Circulos-Triangulos vs Cuadrados
    ruta = '../../02_DiseñoClasificadores/Caso4_KNN_LDA/01_CirculosTriangulos_Cuadrados_KNN/02_DisegnoClasificador/DatosGenerados/';
    nombreArchivo = 'KNN_circ-tria_cuad';
    load([ruta nombreArchivo]);
    
    espacioCcasCircTria_Cuad = espacioCcas;
    XTrainCircTria_Cuad = XoIRed;
    YTrainCircTria_Cuad = YoIRed;
    nombresCircTria_Cuad = nombresProblemaOIRed;
    
    % Circulos vs Triangulos
    ruta = '../../02_DiseñoClasificadores/Caso4_KNN_LDA/02_Circulos_Triangulos_LDA/02_DisegnoClasificador/DatosGenerados/';
    nombreArchivo = 'LDA_circ_tria';
    load([ruta nombreArchivo]);
    
    d12CircTria = d12;
    espacioCcasCircTria = espacioCcas;
    XTrainCircTria = XoIRed;
    YTrainCircTria = YoIRed;
    nombresCircTria = nombresProblemaOIRed;
    coeficientesCircTria = coef_d12;
    
    % EVALUAR CLASIFICADORES
    for i=1:numObjetos

        Xi = XImagenS(i,:);
        XioI = Xi(1,espacioCcasCircTria_Cuad);
        
        k=5;
        YTest = funcion_knn(XioI,XTrainCircTria_Cuad,YTrainCircTria_Cuad,k);
        
        if YTest==1
            XiOI = Xi(1,espacioCcasCircTria);
            x1 = XiOI(1); x2 = XiOI(2); x3 = XiOI(3);
            valor_d12CircTria = eval(d12CircTria);
            if valor_d12CircTria>0
                claseOI = nombresCircTria.clases{1};
                reconocimiento = ['Reconomiento Objeto:' claseOI];
                color = [255 0 0];
            else
                claseOI = nombresCircTria.clases{2};
                reconocimiento = ['Reconomiento Objeto:' claseOI];
                color = [0 255 0];
            end
        elseif YTest==2
            claseOI = nombresCircTria_Cuad.clases{2};
            reconocimiento = ['Reconomiento Objeto:' claseOI];
            color = [0 0 255];
        end

        % REPRESENTACION
        Ib = Ietiq==i;
        figure,
        if YTest==2
            funcion_visualiza(I,Ib,color);
            title(reconocimiento)
        else
            subplot(1,2,1), funcion_visualiza(I,Ib,color);
            title(reconocimiento)
            
            XiOI = Xi(1,espacioCcasCircTria);
            textoLeyenda = nombresCircTria.clases;
            textoLeyenda{end+1} = 'Frontera Separacion';
            textoLeyenda{end+1} = 'Datos Objeto';
            subplot(1,2,2), hold on,
            funcion_representa_instancias_entrenamiento(XTrainCircTria,YTrainCircTria,nombresCircTria),
            funcion_representa_hiperplano_separacion_2_3_Dim(coeficientesCircTria,XTrainCircTria),
            plot3(XiOI(1),XiOI(2),XiOI(3),'ok'),
            legend(textoLeyenda),
            hold off
        end
        
    end

end