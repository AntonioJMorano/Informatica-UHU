function [d1,d2,d12,coef_d12] = funcion_calcula_hiperplanoLDA_2Clases_2_3_Dim(X,Y)

    % AJUSTA VALORES DE LDA
    valoresY = unique(Y);
    numClases = length(valoresY);
    [numDatos,numAtributos] = size(X);
    
    vectorMedias = zeros(numClases,numAtributos);
    mCov = zeros(numAtributos);
    probabilidadAPriori = zeros(numClases,1);
    
    for i=1:numClases
       
        XClase = X(Y==valoresY(i),:);
        numDatosClase = size(XClase,1);
        vectorMedias(i,:) = mean(XClase);
        mCovClase = cov(XClase);
        mCov = mCov+(numDatosClase-1)*mCovClase;
        probabilidadAPriori(i,:) = numDatosClase/numDatos;
        
    end

    mCov = mCov/(numDatos-numClases);
    
    % APLICACION DE VALORES
    x1 = sym('x1','real');
    x2 = sym('x2','real');
    xSym = [x1;x2];
    if numAtributos==3
        x3 = sym('x3','real');
        xSym = [x1;x2;x3];
    end
    
    % Funciones de decision
    M1 = vectorMedias(1,:)';
    d1 = expand(-0.5*(xSym-M1)'*pinv(mCov)*(xSym-M1)+log(probabilidadAPriori(1)));
    
    M2 = vectorMedias(2,:)';
    d2 = expand(-0.5*(xSym-M2)'*pinv(mCov)*(xSym-M2)+log(probabilidadAPriori(2)));
    
    % Funcion discriminante
    d12 = d1-d2;
    
    % Coeficientes de la frontera de decision
    if numAtributos==2 % Dimension 2: A*x1+B*x2+C
        
        x1=0; x2=0; C=eval(d12);
        x1=1; x2=0; A=eval(d12)-C;
        x1=0; x2=1; B=eval(d12)-C;
        
        coef_d12 = [A B C];
        
    else % Dimension 3: A*x1+B*x2+C*x3+D
        
        x1=0; x2=0; x3=0; D=eval(d12);
        x1=1; x2=0; x3=0; A=eval(d12)-D;
        x1=0; x2=1; x3=0; B=eval(d12)-D;
        x1=0; x2=0; x3=1; C=eval(d12)-D;
        
        coef_d12 = [A B C D];
    end

end