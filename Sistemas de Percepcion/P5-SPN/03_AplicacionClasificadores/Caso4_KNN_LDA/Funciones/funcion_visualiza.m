function Io = funcion_visualiza(I,Ib,Color,flagRepresenta,varargin)
% varargin para variar el numero de variables que pasamos
    [numF, numC, numCom] = size(Ib);
    if numCom == 3
        R = I(:,:,1);
        G = I(:,:,2);
        B = I(:,:,3);
    else
        R = I;
        G = I;
        B = I;
    end
    
    R(Ib) = Color(1);
    G(Ib) = Color(2);
    B(Ib) = Color(3);
     
    Io = cat(3,R,G,B);
        
    % if nargin == 4 & flagRepresenta 
        imshow(Io)
        
    % end
end