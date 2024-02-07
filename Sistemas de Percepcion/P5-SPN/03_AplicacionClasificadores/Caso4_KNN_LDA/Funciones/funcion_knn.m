function YTest = funcion_knn(XTest,XTrain,YTrain,k)

    [numMuestrasTrain, numDatosTrain] = size(XTrain);
    vectorDistancia = [];
    XTest = XTest';
    XTrain = XTrain';
    
    % Calculo de distancias 
    dist = repmat(XTest,1,numMuestrasTrain);
    vectorDistancia = sqrt(sum((dist-XTrain).^2));
    
    % Ordenar para encontrar los mas cercanos
    [vectorDistanciaOrd,ind] = sort(vectorDistancia','ascend');
    
    % Vector codificaciones k clases mas cercanas
    YTrainOrd = YTrain(ind);

    clasesKNN = YTrainOrd(1:k);
    valoresClasesKNN = unique(clasesKNN);
    conteoValoresClasesKNN = zeros(size(valoresClasesKNN));
    
    for j=1:length(valoresClasesKNN)
        conteoValoresClasesKNN(j) = sum(clasesKNN==valoresClasesKNN(j));
    end
    
    YTest = YTrainOrd(max(conteoValoresClasesKNN));

end