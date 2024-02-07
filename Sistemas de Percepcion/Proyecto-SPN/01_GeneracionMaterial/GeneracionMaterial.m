%% GENERACION DE MATERIAL

% CONFIGURACION DE LA CAMARA
video = videoinput('winvideo',2,'YUY2_320x240');
video.ReturnedColorSpace = 'rgb';
video.TriggerRepeat = inf;
video.FrameGrabInterval = 3;

set(video,'LoggingMode','memory');

preview(video)

% 1.- CONFIGURACION Y GRABACION DEL VIDEO
fpsMaxWebCam = 30;
fpsTrabajoWebCam = fpsMaxWebCam/video.FrameGrabInterval;
numFramesGrabacion = fpsTrabajoWebCam*25;

aviobj = VideoWriter('video.avi','Uncompressed AVI');
aviobj.FrameRate = fpsTrabajoWebCam;

open(aviobj)
start(video)

for i=1:numFramesGrabacion
    I = getdata(video,1);
    writeVideo(aviobj,I);
end

stop(video)
close(aviobj)

% 2.- GENERACION IMAGENES DE CALIBRACION
% Procedimiento: grabamos un video con una configuracion para despues
% quedarnos con las que nos interesan
video.TriggerRepeat = 3; 
video.FramesPerTrigger = 20; % tomamos 20 imagenes y luego borrare las que salgan mal
video.FrameGrabInterval = 120; % lo ponemos a 120 porque la webcam trabaja a unos 30 fps por lo que
% estariamos tomando fotos cada 4 segundos aproximadamente

start(video)
stop(video)
I = getdata(video,video.FramesAvailable);

% VISUALIZACION DE IMAGENES
% Vemos todas las imagenes para saber cuales han salido bien
[f,c,n,numI] = size(I);
for i=1:numI
    imshow(I(:,:,:,i));
    pause
end

% BORRAR IMAGENES QUE NO QUEREMOS
I(:,:,:,8) = [];

% GUARDAR IMAGENES
save('MaterialGenerado/ImagenesEntrenamiento_Calibracion.mat','I');
