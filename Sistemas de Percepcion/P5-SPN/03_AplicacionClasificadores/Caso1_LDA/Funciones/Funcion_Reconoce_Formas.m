function Funcion_Reconoce_Formas(nombre)

    % CARGAR DATOS E IMAGENES
    addpath('Funciones')
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
    % Circulos vs Cuadrados
    ruta = '../../02_DiseñoClasificadores/Caso1_LDA/01_CirculoCuadrado/02_DisegnoClasificador/DatosGenerados/';
    nombreArchivo = 'LDA_circ_cuad';
    load([ruta nombreArchivo]);

    d12CircCuad = d12;
    coeficientesCircCuad = coef_d12;
    espacioCcasCircCuad = espacioCcas;
    XTrainCircCuad = XoIRed;
    YTrainCircCuad = YoIRed;
    nombresCircCuad = nombresProblemaOIRed;

    % Circulos vs Triangulos
    ruta = '../../02_DiseñoClasificadores/Caso1_LDA/02_CirculoTriangulo/02_DisegnoClasificador/DatosGenerados/';
    nombreArchivo = 'LDA_circ_tria';
    load([ruta nombreArchivo]);

    d12CircTria = d12;
    coeficientesCircTria = coef_d12;
    espacioCcasCircTria = espacioCcas;
    XTrainCircTria = XoIRed;
    YTrainCircTria = YoIRed;
    nombresCircTria = nombresProblemaOIRed;

    % Cuadrados vs Triangulos
    ruta = '../../02_DiseñoClasificadores/Caso1_LDA/03_CuadradoTriangulo/02_DisegnoClasificador/DatosGenerados/';
    nombreArchivo = 'LDA_cuad_tria';
    load([ruta nombreArchivo]);

    d12CuadTria = d12;
    coeficientesCuadTria = coef_d12;
    espacioCcasCuadTria = espacioCcas;
    XTrainCuadTria = XoIRed;
    YTrainCuadTria = YoIRed;
    nombresCuadTria = nombresProblemaOIRed;
    
    % EVALUAR CLASIFICADORES
    for i=1:numObjetos

        Xi = XImagenS(i,:);

        XiOI = Xi(1,espacioCcasCircCuad);
        x1 = XiOI(1); x2 = XiOI(2); x3 = XiOI(3);
        valor_d12CircCuad = eval(d12CircCuad);

        XiOI = Xi(1,espacioCcasCircTria);
        x1 = XiOI(1); x2 = XiOI(2); x3 = XiOI(3);
        valor_d12CircTria = eval(d12CircTria);

        XiOI = Xi(1,espacioCcasCuadTria);
        x1 = XiOI(1); x2 = XiOI(2); x3 = XiOI(3);
        valor_d12CuadTria = eval(d12CuadTria);

        if valor_d12CircCuad>0 & valor_d12CircTria>0
            claseOI = nombresCircCuad.clases{1};
            reconocimiento = ['Reconomiento Objeto:' claseOI];
            color = [255 0 0];
        elseif valor_d12CircCuad<0 & valor_d12CuadTria>0
            claseOI = nombresCircCuad.clases{2};
            reconocimiento = ['Reconomiento Objeto:' claseOI];
            color = [0 0 255];
        elseif valor_d12CircTria<0 & valor_d12CuadTria<0
            claseOI = nombresCircTria.clases{2};
            reconocimiento = ['Reconomiento Objeto:' claseOI];
            color = [0 255 0];
        else
            reconocimiento = 'No se puede determinar el objeto';
        end

        % REPRESENTACION
        Ib = Ietiq==i;
        figure,
        subplot(2,2,1), funcion_visualiza(I,Ib,color);
        title(reconocimiento)
        
        % Circulos vs Cuadrados
        XiOI = Xi(1,espacioCcasCircCuad);
        textoLeyenda = nombresCircCuad.clases;
        textoLeyenda{end+1} = 'Frontera Separacion';
        textoLeyenda{end+1} = 'Datos Objeto';
        subplot(2,2,2), hold on,
        funcion_representa_instancias_entrenamiento(XTrainCircCuad,YTrainCircCuad,nombresCircCuad),
        funcion_representa_hiperplano_separacion_2_3_Dim(coeficientesCircCuad,XTrainCircCuad),
        plot3(XiOI(1),XiOI(2),XiOI(3),'ok'),
        legend(textoLeyenda),
        hold off
        
        % Circulos vs Triangulos
        XiOI = Xi(1,espacioCcasCircTria);
        textoLeyenda = nombresCircTria.clases;
        textoLeyenda{end+1} = 'Frontera Separacion';
        textoLeyenda{end+1} = 'Datos Objeto';
        subplot(2,2,3), hold on,
        funcion_representa_instancias_entrenamiento(XTrainCircTria,YTrainCircTria,nombresCircTria),
        funcion_representa_hiperplano_separacion_2_3_Dim(coeficientesCircTria,XTrainCircTria),
        plot3(XiOI(1),XiOI(2),XiOI(3),'ok'),
        legend(textoLeyenda),
        hold off
        
        % Cuadrados vs Triangulos
        XiOI = Xi(1,espacioCcasCuadTria);
        textoLeyenda = nombresCuadTria.clases;
        textoLeyenda{end+1} = 'Frontera Separacion';
        textoLeyenda{end+1} = 'Datos Objeto';
        subplot(2,2,4), hold on,
        funcion_representa_instancias_entrenamiento(XTrainCuadTria,YTrainCuadTria,nombresCuadTria),
        funcion_representa_hiperplano_separacion_2_3_Dim(coeficientesCuadTria,XTrainCuadTria),
        plot3(XiOI(1),XiOI(2),XiOI(3),'ok'),
        legend(textoLeyenda),
        hold off

    end

end