function funcion_representa_datos_color(X,Y,posInteres)
% Pedimos la posicion de interes para con la misma funcion representar
% datos del color de seguimiento y del fondo de manera individual
    
    % Seleccion de los datos de interes
    foI = Y == posInteres;
    XClase = X(foI,:);
    
    % Representacion
    if posInteres == 1
        plot3(XClase(:,1),XClase(:,2),XClase(:,3),'*g')
    else
        plot3(XClase(:,1),XClase(:,2),XClase(:,3),'*r')
    end
    xlabel('Componente Roja'), ylabel('Componente Verde'), zlabel('Componente Azul')
    
end