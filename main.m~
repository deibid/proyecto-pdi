%{
blkproc parte la imagen en bloques, func debe sacar la mediana
hacer resize del resultado y restarselo a la imagen original
%}

function [] = main()

clc
close all
clear

figuras = {'caracol '
    'castillo '
    'conejo '
    'corazon '
    'flor '
    'gecko '
    'globo '
    'hombre '
    'hueso '
    'libelula '
    'luna '
    'mancha '
    'mariposa '
    'nina '
    'oso '
    'pastel '};

parametros = {'Area'
    'MajorAxisLength'
    'MinorAxisLength'
    'Eccentricity'
    'EquivDiameter'
    'Extent'
    'Perimeter'};

jpg = '.jpg';


k = 1;

%for i = 1:16
a = figuras{10};
for j = 1:1
    path = [a  num2str(j) jpg];
    k = k+1;
    %end
    %end
    
    Ic = imread(path);
    I = rgb2gray(Ic);
    
    bloques = blockproc(I,[70,70],@mediana);
    bloques = imresize(bloques,[427,640]);
    
    % I = I-bloques;
    % maximo = max(max(bloques));
    
    minimo = min(min(bloques));
    
    bloques = bloques-minimo;
    
    Ic(:,:,1) = Ic(:,:,1)-bloques;
    Ic(:,:,2) = Ic(:,:,2)-bloques;
    Ic(:,:,3) = Ic(:,:,3)-bloques;
    %figure, imshow(Ic);
    
    [count] = imhist(Ic(:,:,1));
    yR = find(count == max(max(count)));
    [count] = imhist(Ic(:,:,2));
    yG = find(count == max(max(count)));
    [count] = imhist(Ic(:,:,3));
    yB = find(count == max(max(count)));
    
    
    infR = yR - 30;
    supR = yR + 30;
    infG = yG - 30;
    supG = yG + 30;
    infB = yB - 30;
    supB = yB + 30;
    
    imBin = (Ic(:,:,1)>supR  | Ic(:,:,1)<infR) | (Ic(:,:,2)>supG | Ic(:,:,2)<infG) | (Ic(:,:,3)>supB | Ic(:,:,3)<infB);
    
    %figure, imshow(imBin);
    imBin = imclearborder(imBin);
    %figure, imshow(imBin);
    
    imBin = bwareaopen(imBin, 100);
    imBin = imfill(imBin,'holes');
    %figure, imshow(imBin);
    
    
    [L, numObj] = bwlabel(imBin);
    global datosImagen;
    %EN CASO DE TERMINAR USANDO ESTRUCTURAS..%
    %datosImagen = struct('Area',{0},'MajorAxisLength',{0},'MinorAxisLength',{0},'Eccentricity',{0},'EquivDiameter',{0},'Extent',{0},'Perimeter',{0},'AxisRatio',{0});
    
    datosImagen = zeros(8,1,3);
    
    %CAPA 1 - PROMEDIOS
    %CAPA 2 - MINIMOS
    %CAPA 3 - MAXIMOS
    
    for l=1 :numObj
        
        %datos = regionprops(L == l, 'Area', 'MajorAxisLength','MinorAxisLength','Eccentricity','EquivDiameter','Extent','Perimeter');
        datos = regionprops(L == l, parametros);
        
        %%min y max de cada campo
        
        
        datosImagen(1,1,1) = datosImagen(1,1,1) + datos.Area;
        datosImagen(2,1,1) = datosImagen(2,1,1) + datos.MajorAxisLength;
        datosImagen(3,1,1) = datosImagen(3,1,1) + datos.MinorAxisLength;
        datosImagen(4,1,1) = datosImagen(4,1,1) + datos.Eccentricity;
        datosImagen(5,1,1) = datosImagen(5,1,1) + datos.EquivDiameter;
        datosImagen(6,1,1) = datosImagen(6,1,1) + datos.Extent;
        datosImagen(7,1,1) = datosImagen(7,1,1) + datos.Perimeter;
        datosImagen(8,1,1) = datosImagen(8,1,1) + (datos.MajorAxisLength/datos.MinorAxisLength);
        
        
        %         datosImagen.Area = datosImagen.Area + datos.Area;
        %         datosImagen.MajorAxisLength = datosImagen.MajorAxisLength + datos.MajorAxisLength;
        %         datosImagen.MinorAxisLength = datosImagen.MinorAxisLength + datos.MinorAxisLength;
        %         datosImagen.Eccentricity = datosImagen.Eccentricity + datos.Eccentricity;
        %         datosImagen.EquivDiameter = datosImagen.EquivDiameter + datos.EquivDiameter;
        %         datosImagen.Extent = datosImagen.Extent + datos.Extent;
        %         datosImagen.Perimeter = datosImagen.Perimeter + datos.Perimeter;
        %         datosImagen.AxisRatio = datosImagen.AxisRatio + (datos.MajorAxisLength/datos.MinorAxisLength);
        
        
%         if(datosImagen(1,1,2) == 0 || datos.Area < datosImagen(1,1,2))
%            datosImagen(1,1,2)
%         else
%             
%             
%         end
        
    end
    
    fields = fieldnames(datosImagen);
    for l=1 : 8
        disp('dividir ')
        datosImagen.(fields{l})
        numObj
        datosImagen.(fields{l}) = datosImagen.(fields{l})/numObj;
    end
    
    
end
end



function y = mediana(x)


[a,b] = size(x.data);
tam = a*b;

x = reshape(x.data,[1,tam]);
y = median(x);


end