function idx = funcion_calcula_agrupacion(X,centroides)

    [numF,numC] = size(X);
    idx = zeros(numF,1);
    R = double(X(:,1)); G = double(X(:,2)); B = double(X(:,3));
    MD = [];
    
    % Calculo de distancias respecto al centroide
    for i=1:size(centroides,1)
        
        Rc = double(centroides(i,1)); Gc = double(centroides(i,2)); Bc = double(centroides(i,3));
        MDAux = sqrt((R-Rc).^2 + (G-Gc).^2 + (B-Bc).^2);
        MD = [MD,MDAux];
        
    end
    
    % Clasificacion en idx por distancia menor
    [numF,numC] = size(MD);
    
    for i=1:numF
        
       minimo = min(MD(i,:));
       [nf,nc] = find(MD(i,:)==minimo);
       % Ponemos nc(1) por si en caso de que tenga exactamente la misma
       % distancia a dos puntos coja el primer indice
       idx(i) = nc(1);
       
    end
    
end