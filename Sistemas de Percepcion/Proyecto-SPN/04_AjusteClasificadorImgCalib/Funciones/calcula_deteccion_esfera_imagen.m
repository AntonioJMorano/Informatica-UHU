function Ib = calcula_deteccion_esfera_imagen(Imagen,centroides,radio)

    [numF,numC,numM] = size(Imagen);
    Ib = zeros(numF,numC);
    Rc = centroides(1); Gc = centroides(2); Bc = centroides(3);
    
    R = double(Imagen(:,:,1)); G = double(Imagen(:,:,2)); B = double(Imagen(:,:,3));
    MD = sqrt((R-Rc).^2 + (G-Gc).^2 + (B-Bc).^2);
    Ib = MD < radio;
    
end