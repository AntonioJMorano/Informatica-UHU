function datosEsfera = calcula_datos_esfera(XColor,XFondo)

    % Calculo del centroide
    valoresMedios = mean(XColor);
    Rc = valoresMedios(1); Gc = valoresMedios(2); Bc = valoresMedios(3);
    
    % Calculo del radio para no perder el objeto
    R = double(XColor(:,1)); G = double(XColor(:,2)); B = double(XColor(:,3));
    MDC = sqrt((R-Rc).^2 + (G-Gc).^2 + (B-Bc).^2);
    r1 = max(MDC);
    
    % Calculo del radio para no tener ruido
    R = double(XFondo(:,1)); G = double(XFondo(:,2)); B = double(XFondo(:,3));
    MDF = sqrt((R-Rc).^2 + (G-Gc).^2 + (B-Bc).^2);
    r2 = min(MDF);
    
    % Calculo del radio promedio
    r3 = (r1+r2)/2;
    
    datosEsfera = [Rc,Gc,Bc,r1,r2,r3];

end