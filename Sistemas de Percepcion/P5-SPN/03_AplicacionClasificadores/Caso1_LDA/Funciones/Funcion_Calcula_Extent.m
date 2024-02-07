function ExtentIR = Funcion_Calcula_Extent(Ib)

    Ib2 = Funcion_Centra_Objeto(Ib);
    AreaObj = sum(double(Ib2(:)));
    Datos = [];
    
    for i=0:5:355
        IbR = imrotate(Ib,i);
        [f c] = find(IbR==1);
        fmin = min(f)-0.5;
        fmax = max(f)+0.5;
        cmin = min(c)-0.5;
        cmax = max(c)+0.5;
        AreaBB = (fmax-fmin)*(cmax-cmin);
        Datos = [Datos; AreaObj/AreaBB];
    end
    
    ExtentIR = max(Datos);

end