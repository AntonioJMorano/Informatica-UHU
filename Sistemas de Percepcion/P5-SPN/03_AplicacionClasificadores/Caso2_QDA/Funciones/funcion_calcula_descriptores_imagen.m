function XImagen = funcion_calcula_descriptores_imagen(Ietiq,N)

    stats = regionprops(Ietiq,'Area','Perimeter','Eccentricity','Extent','Solidity','EulerNumber');
    
    areas = cat(1,stats.Area);
    perimetros = cat(1,stats.Perimeter);
    
    CompactImagen = (perimetros.^2)./areas;
    EccentricityImagen = cat(1,stats.Eccentricity);
    SolidityImagen = cat(1,stats.Solidity);
    ExtentImagen = cat(1,stats.Extent);
    EulerNumberImagen = cat(1,stats.EulerNumber);
    ExtentIR_Hu_DFImagen = funcion_calcula_ExtentIR_Hu_DF_objetos_imagen(Ietiq,N);
    
    XImagen = [CompactImagen EccentricityImagen SolidityImagen ExtentImagen ExtentIR_Hu_DFImagen EulerNumberImagen];
    
end