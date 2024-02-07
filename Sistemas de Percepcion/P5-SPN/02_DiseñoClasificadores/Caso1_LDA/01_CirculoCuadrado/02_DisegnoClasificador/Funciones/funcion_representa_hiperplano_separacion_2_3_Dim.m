function funcion_representa_hiperplano_separacion_2_3_Dim(coef_d12,X)

    numAtributos = size(X,2);

    % Representacion hiperplano
    if numAtributos==2
        A = coef_d12(1); B = coef_d12(2); C = coef_d12(3);
        x1min = min(X(:,1)); x1max = max(X(:,1));
        x2min = min(X(:,2)); x2max = max(X(:,2));
        paso = ((x1max-x1min)/1000);
        valores_x1_linea = x1min:paso:x1max;
        valores_x2_linea = -(A*valores_x1_linea+C)/B;
        plot(valores_x1_linea,valores_x2_linea,'k');
        axis([x1min x1max x2min x2max]);
    else
        A = coef_d12(1); B = coef_d12(2); C = coef_d12(3); D = coef_d12(4);
        xmin = min(X(:)); xmax = max(X(:));
        paso = (xmax-xmin)/200;
        [x1P,x2P] = meshgrid(xmin:paso:xmax);
        surf(x1P,x2P, -(A*x1P+B*x2P+D)/C);
    end
    
end