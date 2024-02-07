function [YP,d12,d13,d23] = funcion_aplica_QDA(X,vectorMedias,mCov,probabilidadAPriori,valoresClases)
    
    [numDatos,numAtributos] = size(X);
    
    x1 = sym('x1','real');
    x2 = sym('x2','real');
    x3 = sym('x3','real');
    x4 = sym('x4','real');
    xSym = [x1;x2;x3;x4];
    
    % Funciones de decision
    M1 = vectorMedias(1,:)';
    mCov1 = mCov(:,:,1);
    d1 = expand(-0.5*(xSym-M1)'*pinv(mCov1)*(xSym-M1)*-0.5*log(det(mCov1))+log(probabilidadAPriori(1)));
    
    M2 = vectorMedias(2,:)';
    mCov2 = mCov(:,:,2);
    d2 = expand(-0.5*(xSym-M2)'*pinv(mCov2)*(xSym-M2)*-0.5*log(det(mCov2))+log(probabilidadAPriori(2)));
    
    M3 = vectorMedias(3,:)';
    mCov3 = mCov(:,:,3);
    d3 = expand(-0.5*(xSym-M3)'*pinv(mCov3)*(xSym-M3)*-0.5*log(det(mCov3))+log(probabilidadAPriori(3)));
    
    % Funcion discriminante
    d12 = d1-d2;
    d13 = d1-d3;
    d23 = d2-d3;
    
    YP = zeros(numDatos,1);
    
    for i=1:numDatos
        x1=X(i,1); x2=X(i,2); x3=X(i,3); x4=X(i,4);
        s1 = eval(d12); s2 = eval(d13); s3 = eval(d23);
        if s1>0 && s2>0
            YP(i,:) = valoresClases(1);
        else if s1<0 && s3>0
            YP(i,:) = valoresClases(2);
        else
            YP(i,:) = valoresClases(3);
        end
    end
    
end