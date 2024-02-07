function [idx, centroides] = funcion_kmeans(X,K)
    
    centroides = [];
    [numF,numC] = size(X);
    num = randsample(numF,K);
    
    % Sacamos 3 puntos aleatorios de para que sean los centroides
    for i=1:K
        c = X(num(i),:);
        centroides = [centroides;c];
    end
    
    % Agrupamos los puntos a los centroides mas cercanos
    idx_semilla = funcion_calcula_agrupacion(X,centroides);
    
    
    % Repetir iterativamente hasta que las matrices sean iguales
    varLogica = false;
    
    while varLogica==false
        
        centroides = funcion_calcula_centroides(X,idx_semilla);
        idx = funcion_calcula_agrupacion(X,centroides);
        varLogica = funcion_compara_matrices(idx,idx_semilla);
        idx_semilla = idx;
    
    end

end