function funcion_representa_esferas(centroides,radio)
    
    [R,G,B] = sphere(100);
    Rc = centroides(1); Gc = centroides(2); Bc = centroides(3);
    x = radio*R(:)+Rc; y = radio*G(:)+Gc; z = radio*B(:)+Bc;
    plot3(x,y,z, '.y')

end