function Io = funcion_visualiza(Imagen,Ib,Color,flagRepresenta,varagrin)

    [IEtiq, N] = funcion_etiquetar(Ib);
    R = Imagen(:,:,1);
    G = Imagen(:,:,2);
    B = Imagen(:,:,3);
    
    if N==0
        Io = Imagen;
    else
        for i=1:N
            Ioaux = IEtiq==i;
            R(Ioaux) = Color(1);
            G(Ioaux) = Color(2);
            B(Ioaux) = Color(3);
            Io = cat(3,R,G,B);
        end
    end

    if flagRepresenta==true 
        imshow(Io)
    else
        clc
        disp('Programa terminado');
    end

end