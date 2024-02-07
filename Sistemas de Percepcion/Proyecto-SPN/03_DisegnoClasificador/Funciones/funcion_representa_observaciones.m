function funcion_representa_observaciones(X,Y)
    valoresY = unique(Y);
    foI = Y == valoresY(2); 
    
    % Sacamos cada componente
    RoI = X(foI,1); GoI = X(foI,2); BoI = X(foI,3);

    plot3(RoI,GoI,BoI,'*r')
    
    foI = Y == valoresY(1); 
    RoI = X(foI,1); GoI = X(foI,2); BoI = X(foI,3);
    
    hold on, plot3(RoI,GoI,BoI,'*g'), title('Valores RGB pixeles de seguimiento')
    xlabel('Componente Roja'), ylabel('Componente Verde'), zlabel('Componente Azul')
    legend('Datos Color','Datos Fondo')
end