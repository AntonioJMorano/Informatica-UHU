function centroides = funcion_calcula_centroides(X,idx)

    centroides = [];
    N = max(idx);

    for i=1:N
        [f,c,n] = find(idx==i);
        fmean = mean(X(f)); cmean = mean(X(c)); nmean = mean(X(n));
        x = cmean; y = fmean; z = nmean;
        centroide = [x y z];
        centroides = [centroides;centroide];
    end

end