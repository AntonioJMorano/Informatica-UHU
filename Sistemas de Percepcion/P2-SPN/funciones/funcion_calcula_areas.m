function areas = funcion_calcula_areas(IEtiq,N)
    
    areas = [];

    for i=1:N
       figura = IEtiq==i;
       area = sum(figura(:));
       areas = [areas;area];
    end
    
end