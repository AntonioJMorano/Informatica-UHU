function [vectorMedias,mCov,probabilidadAPriori] = funcion_ajusta_LDA(X,Y)

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
    
end