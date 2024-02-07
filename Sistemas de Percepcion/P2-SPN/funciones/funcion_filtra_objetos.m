function IbFilt = funcion_filtra_objetos(Ib,numPix)

    [IEtiq,N] = funcion_etiquetar(Ib);
    IbFilt = zeros(size(Ib));
    areas = funcion_calcula_areas(IEtiq,N);
    
    for i=1:N
        if areas(i) >= numPix
           IbFilt(IEtiq==i) = 1;
        end
    end

end