function [espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas(X,Y,dim) 

%Individual
indicesJ = zeros(1,size(X,2));
descriptoresJ = [1:size(X,2)];
for i=1:size(X,2)
    indicesJ(i) = indiceJ(X(:,i),Y);
end

%filtro
IoI = indicesJ > 0.1;
indicesJ = indicesJ(IoI);
descriptoresJ = descriptoresJ(IoI);

%Conjunta 
combinaciones=combnk(descriptoresJ,dim);
JespacioCcas = 0;
for i=1:size(combinaciones,1)
    indiceJConjunta =  indiceJ( X(:,combinaciones(i,:)), Y);
    if(indiceJConjunta>JespacioCcas)
        JespacioCcas = indiceJConjunta;
        espacioCcas = combinaciones(i,:);
    end
end

end