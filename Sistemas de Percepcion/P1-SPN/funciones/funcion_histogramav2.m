function  h = funcion_histogramav2(Imagen)
    
    h = zeros(256,1);

    for k=0:255
        ImagenB = Imagen==k;
        h(k+1) = sum(ImagenB(:));
    end
        
end