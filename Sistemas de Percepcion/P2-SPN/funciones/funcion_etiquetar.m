function [IEtiq, N] = funcion_etiquetar(Ib)
    % Ib = [1 1 1 0 0 0; 0 1 0 1 0 1; 1 1 1 1 0 1; 0 0 0 0 0 0; 1 1 1 1 1 1]
    % Ib = [0 1 1 0 1 1 0; 0 1 1 0 1 1 0; 0 1 1 1 1 1 0]
    Ib = double(Ib);
    [numF, numC] = size(Ib);
    etiqueta = 0;
    
    for i=1:numF
        for j=1:numC
            if Ib(i,j) ~= 0
                etiqueta = etiqueta+1;
                Ib(i,j) = etiqueta;
            end
        end
    end
    
    IAmp = zeros(numF+2,numC+2);
    IAmp(2:numF+1,2:numC+1) = Ib;
    
    for i=2:numF+1
        for j=2:numC+1
            if IAmp(i,j) ~= 0
                V = [IAmp(i,j-1) IAmp(i-1,j-1:j+1)];
                V = V(V>0);
                minV = min(V);
                if IAmp(i,j) > minV
                    IAmp(i,j) = minV;
                end
            end 
        end
    end
      
    for i=numF:-1:1
        for j=numC:-1:1
            if IAmp(i,j) ~= 0
                V = [IAmp(i,j-1) IAmp(i+1,j-1:j+1)];
                V = V(V>0);
                minV = min(V);
                if IAmp(i,j) > minV
                    IAmp(i,j) = minV;
                end
            end
        end
    end
    
    IEtiq = IAmp(2:numF+1,2:numC+1);
    valores = unique(IEtiq);
    valores = valores(valores>0);
    [numF, numC] = size(valores);
    for i=1:numF
        IEtiq(IEtiq==valores(i)) = i;
    end
    N = max(unique(IEtiq(:)));

end