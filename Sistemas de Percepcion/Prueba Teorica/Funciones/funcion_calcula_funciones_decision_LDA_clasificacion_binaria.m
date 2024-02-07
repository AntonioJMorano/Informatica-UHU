function [d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_LDA_clasificacion_binaria(X,Y)
    valoresY = unique(Y);
    numClases = length(valoresY);
    [numDatos,numAtributos] = size(X);
    
    x1 = sym('x1','real');
    x2 = sym('x2','real');
    
    Xsym = [x1;x2];
    
    if numAtributos==3
        x3 = sym('x3','real');
        Xsym = [Xsym;x3];
    end
    
    M = zeros(numClases,numAtributos); % Vector prototipo
    mCov = zeros(numAtributos); % Matriz de covarianza
    pClases = zeros(numClases,1); % Probabilidad a priori
    
    for i=1:numAtributos-1
        
        XClase = X(Y==valoresY(i),:);
        M(i,:) = mean(XClase);
        mCovClase = cov(XClase);
        numDatosClase = size(XClase,1);
        
        mCov = mCov + (numDatosClase-1)*mCovClase;
        pClases(i) = numDatosClase/numDatos;
        
    end
    
    % Matriz de covarianzas
    mCov = mCov/(numDatos-numClases);
    
    % Funciones de decision
    M1 = M(1,:)';
    d1 = expand(-0.5*(Xsym-M1)'*pinv(mCov)*(Xsym-M1)+log(pClases(1)));
    
    M2 = M(2,:)';
    d2 = expand(-0.5*(Xsym-M2)'*pinv(mCov)*(Xsym-M2)+log(pClases(2)));
    
    % Frontera de decision
    d12 = d1-d2;
    
    % Coeficientes de la frontera de decision
    if numAtributos==2 % Dimension 2: A*x1+B*x2+C
        
        x1=0; x2=0; C=eval(d12);
        x1=1; x2=0; A=eval(d12)-C;
        x1=0; x2=1; B=eval(d12)-C;
        
        coeficientes_d12 = [A B C];
        
    else % Dimension 3: A*x1+B*x2+C*x3+D
        
        x1=0; x2=0; x3=0; D=eval(d12);
        x1=1; x2=0; x3=0; A=eval(d12)-D;
        x1=0; x2=1; x3=0; B=eval(d12)-D;
        x1=0; x2=0; x3=1; C=eval(d12)-D;
        
        coeficientes_d12 = [A B C D];
    end
end