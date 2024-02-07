function X = funcion_calcula_ExtentIR_Hu_DF_objetos_imagen(Ietiq,N)

    X = [];

    for i=1:N
        Ib = Ietiq==i;
        ExtentIR = Funcion_Calcula_Extent(Ib);
        Hu = Funcion_Calcula_Hu(Ib);
        DF = Funcion_Calcula_DF(Ib,10);
        X(i,:) = [ExtentIR Hu' DF'];
    end

end