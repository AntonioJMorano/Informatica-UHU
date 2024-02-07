function funcion_representa_instancias_entrenamiento(XTrain,YTrain,nombresProblema)

    % Datos previos
    nombresDescriptores = nombresProblema.descriptores;
    nombresClases = nombresProblema.clases;
    simbolos = nombresProblema.simbolos;
    
    numAtributos = size(XTrain,2);
    codifClases = unique(YTrain);
    numClases = length(nombresClases);
    
    % Representacion
    for i=1:numClases
        Xi = XTrain(YTrain==codifClases(i),:);
        if numAtributos==2
            plot(Xi(:,1), Xi(:,2), simbolos{i})
        else
            plot3(Xi(:,1), Xi(:,2), Xi(:,3), simbolos{i})
        end 
    end
    
    % Descriptores
    xlabel(nombresDescriptores{1})
    ylabel(nombresDescriptores{2})
    if numAtributos==3
        zlabel(nombresDescriptores{3})
    end

end