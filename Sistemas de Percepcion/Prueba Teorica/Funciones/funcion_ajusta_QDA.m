function [vectorMedias,mCov,probabilidadAPriori] = funcion_ajusta_QDA(X,Y)

    valoresY = unique(Y);
    numClases = length(valoresY);
    [numDatos,numAtributos] = size(X);
    
    vectorMedias = zeros(numClases,numAtributos);
    probabilidadAPriori = zeros(numClases,1);
    mCov = zeros(numAtributos,numAtributos,numClases);
    
    XClase = X(Y==valoresY(1),:);
    numDatosClase = size(XClase,1);
    vectorMedias(1,:) = mean(XClase);
    mCov(:,:,1) = cov(XClase);
    probabilidadAPriori(1,:) = numDatosClase/numDatos;
    
    XClase = X(Y==valoresY(2),:);
    numDatosClase = size(XClase,2);
    vectorMedias(2,:) = mean(XClase);
    mCov(:,:,2) = cov(XClase);
    probabilidadAPriori(2,:) = numDatosClase/numDatos;

end