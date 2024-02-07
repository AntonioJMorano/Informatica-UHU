function IBinFilt = funcion_elimina_regiones_ruidosas(IBin)

    [N, M] = size(IBin);
    IBin2 = bwareaopen(IBin, round(0.001*N*M));
    
    if sum(IBin2(:)>0)
        Ietiq = bwlabel(IBin2);
        
        stats = regionprops(Ietiq,'Area');
        areas = cat(1,stats.Area);
        
        numPix = floor(max(areas)/5); % se podria hacer un round tambien para redondear
        
        IBinFilt = bwareaopen(IBin2,numPix);
    else
        IBinFilt = IBin2;
    end

end