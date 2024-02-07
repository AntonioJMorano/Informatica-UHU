function varLogica = funcion_compara_matrices(m1,m2)

    [numFm1, numCm1] = size(m1);
    [numFm2, numCm2] = size(m2);

    if (numFm1 ~= numFm2) || (numCm1 ~= numCm2)
        clc
        disp('Las matrices con diferentes dimensiones')
        varLogica = false;
    else
        clc
        
        m1 = double(m1);
        m2 = double(m2);
        dif = m1-m2;
        
        maxdif = max(dif(:));
        mindif = min(dif(:));
        
        if (maxdif == mindif) || maxdif == 0 || mindif == 0
            disp('Las matrices son iguales')
            varLogica = true;
        else
            disp('Las matrices no son iguales')
            varLogica = false;
        end
    end

end