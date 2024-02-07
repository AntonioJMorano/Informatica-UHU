
function u = funcion_otsu(I)
    h = imhist(I); h = h(:);

    o2max = -inf;
    u = 0;
    for i = 1:256
        w1 = sum(h(1:i)) / sum(h);
        w2 = sum(h(i+1:256)) / sum(h);

        m = sum(h.*0:255') / sum(h);
        m1 = sum(h(1:i).*(0:i-1)') / sum(h(1:i));
        m2 = sum(h(i+1:256).*(i:255)') / sum(h(i+1:256));

        o2 = w1*(m1-m)^2 + w2*(m2-m)^2;
        if o2 > o2max
            o2max = o2;
            u = i-1; % -1 para pasar de la posicion al nivel de gris
        end
    end
end
