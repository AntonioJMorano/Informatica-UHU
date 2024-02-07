function pos_outliers = funcion_detecta_outliers(X,Y,posInteres)
    
    foI = Y == posInteres;
    R = X(:,1); G = X(:,2); B = X(:,3);

    % Calculos de medias y desviaciones tipicas
    media = mean(X(foI,:)); desv = std(double(X(foI,:)));
    Rmean = media(1); Rdesv = desv(1);
    Gmean = media(2); Gdesv = desv(2);
    Bmean = media(3); Bdesv = desv(3);

    % Calculos de valores fuera del rango "normal" de cada componente
    outR = (R>Rmean+3*Rdesv) | (R<Rmean-3*Rdesv);
    outG = (G>Gmean+3*Gdesv) | (G<Gmean-3*Gdesv);
    outB = (B>Bmean+3*Bdesv) | (B<Bmean-3*Bdesv);

    % Sacamos las posiciones de estos valores
    pos_outR = find(outR(foI));
    pos_outG = find(outG(foI));
    pos_outB = find(outB(foI));

    % Nos quedamos con los valores unicos ya que se pueden repetir
    pos_outliers = unique([pos_outR;pos_outG;pos_outB]);

end