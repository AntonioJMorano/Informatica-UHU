function [YP,d12] = funcion_aplica_LDA(X,vectorMedias1,mCov1,probabilidadAPriori1,valoresClases)
    
    numClases = length(valoresClases);
    
    % Funciones de decision
    x1 = sym('x1','real');
    x2 = sym('x2','real');
    xSym = [x1;x2];
    if numClases==3
        x3 = sym('x3','real');
        xSym = [xSym;x3];
    end
    
    M1 = vectorMedias1(1,:)';
    d1 = expand(-0.5*(xSym-M1)'*pinv(mCov1)*(xSym-M1)*log(probabilidadAPriori1(1)));
    
     
    M2 = vectorMedias1(2,:)';
    d2 = expand(-0.5*(xSym-M2)'*pinv(mCov1)*(xSym-M2)*log(probabilidadAPriori1(2)));
    
    % Funcion discriminante
    d12 = d1-d2;
    
    % Calculo de YP
    [numDatos,numAtributos] = size(X);
    YP = zeros(numAtributos,1);
    for i=1:numDatos
        x1=X(i,1); x2=X(i,2);
        s = eval(d12);
        if s>0
            YP(i,:) = valoresClases(1);
        else
            YP(i,:) = valoresClases(2);
        end
    end
    

end
