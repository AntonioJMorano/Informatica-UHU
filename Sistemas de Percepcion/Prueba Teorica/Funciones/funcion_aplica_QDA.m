function [YP,d] = funcion_aplica_QDA(X,vectorMedias,mCov,probabilidadAPriori,valoresClases)
    
    [numDatos,numAtributos] = size(X);
    
    x1 = sym('x1','real');
    x2 = sym('x2','real');
    xSym = [x1;x2];
    if numAtributos==3
        x3 = sym('x3','real');
        xSym = [xSym;x3];
    end
    
    % Funciones de decision
    M1 = vectorMedias(1,:)';
    mCov1 = mCov(:,:,1);
    d1 = expand(-0.5*(xSym-M1)'*pinv(mCov1)*(xSym-M1)*-0.5*log(det(mCov1))+log(probabilidadAPriori(1)));
    
    M2 = vectorMedias(2,:)';
    mCov2 = mCov(:,:,2);
    d2 = expand(-0.5*(xSym-M2)'*pinv(mCov2)*(xSym-M2)*-0.5*log(det(mCov2))+log(probabilidadAPriori(2)));
    
    % Funcion discriminante
    d = d1-d2;
    
    YP = zeros(numDatos,1);
    
    for i=1:numDatos
        x1=X(i,1); x2=X(i,2); x3=X(i,3);
        s = eval(d);
        if s>0
            YP(i,:) = valoresClases(1);
        else
            YP(i,:) = valoresClases(2);
        end
    end
    
end