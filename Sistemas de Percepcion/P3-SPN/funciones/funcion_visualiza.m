function Io = funcion_visualiza(Imagen,Ib,Color,flagRepresenta,varagrin)

    [IEtiq, N] = funcion_etiquetar(Ib);
    R = Imagen(:,:,1);
    G = Imagen(:,:,1);
    B = Imagen(:,:,1);
    
    for i=1:N
        Io = IEtiq==i;
        R(Io) = Color(i,1);
        G(Io) = Color(i,2);
        B(Io) = Color(i,3);
        Io = cat(3,R,G,B);
    end

    if flagRepresenta==true 
        close all
        imshow(Io)
    else
        clc
        disp('Programa terminado');
    end

end