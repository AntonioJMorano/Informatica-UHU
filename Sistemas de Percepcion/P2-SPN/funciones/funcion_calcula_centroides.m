function centroides = funcion_calcula_centroides(IEtiq,N)

    centroides = [];

    for i=1:N
        [f,c] = find(IEtiq==i);
        fmean = mean(f); cmean = mean(c);
        x = cmean; y = fmean; 
        centroide = [x y];
        centroides = [centroides;centroide];
    end

end