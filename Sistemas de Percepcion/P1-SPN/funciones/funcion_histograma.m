function  h = funcion_histograma(Imagen)
    
    [numF, numC] = size(Imagen);
    h = zeros(256,1);

    for i=1:numF
       for j=1:numC
          valor = double(Imagen(i,j));
          h(valor+1) = h(valor+1)+1;
       end
    end

end