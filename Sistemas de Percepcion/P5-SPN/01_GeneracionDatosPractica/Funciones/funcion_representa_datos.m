function funcion_representa_datos(X,Y, espacioCcas, nombresProblema)

    nombresDescriptores = nombresProblema.descriptores;
    nombresClases = nombresProblema.clases;
    simbolos = nombresProblema.simbolos;
    
    codifClases = unique(Y);
    numClases = length(nombresClases);
    
    figure,
    hold on, % tenemos que representar varias clases
    for i=1:numClases
        Xi = X(Y==codifClases(i),espacioCcas);
        if length(espacioCcas)==2
            plot(Xi(:,1), Xi(:,2), simbolos{i})
        else
            plot3(Xi(:,1), Xi(:,2), Xi(:,3), simbolos{i})
        end 
    end
    
    legend(nombresClases)
    xlabel(nombresDescriptores{espacioCcas(1)})
    ylabel(nombresDescriptores{espacioCcas(2)})
    if length(espacioCcas)==3
        zlabel(nombresDescriptores{espacioCcas(3)})
    end
    hold off
    
end