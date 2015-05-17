%{
blkproc parte la imagen en bloques, func debe sacar la mediana
hacer resize del resultado y restarselo a la imagen original
%}

function [] = main()


tic

clc
close all
clear

figuras = {'caracol '
    'castillo '
    'conejo '
    'corazon '
    'gecko '
    'globo '
    'hueso '
    'libelula '
    'luna '
    'mancha '
    'mariposa '
    'nina '
    'nino '
    'oso '
    'pastel '
    'tulipan '};

parametros = {'Area'
    'MajorAxisLength'
    'MinorAxisLength'
    'Eccentricity'
    'EquivDiameter'
    'Extent'
    'Perimeter'
    'ConvexArea'
    'Solidity'};

jpg = '.jpg';


global datosImagen;
global datosFinales;

global clasificador;
clasificador = zeros(14,16);



k = 1;
saveFlag = 0;

[tipos,trash] = size(figuras);

for k = 15:tipos
    
    datosImagen = zeros(14,1,6);
    %14 caracteristicas, 1 tipo de figura, 6 imagenes
    datosFinales = zeros(14,1);

    
    %iteracion sobre las fotos del mismo tipo
    a = figuras{k};
    for j = 1:6
        
        path = [a  num2str(j) jpg];
        k = k+1;
        
        
        Ic = imread(path);
        %if(j==6)figure,imshow(Ic)
        %end
        I = rgb2gray(Ic);
        
        bloques = blockproc(I,[80,80],@mediana);
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
        
        yR = yR(1);
        yG = yG(1);
        yB = yB(1);
        
        
        
        infR = yR - 30;
        supR = yR + 30;
        infG = yG - 30;
        supG = yG + 30;
        infB = yB - 30;
        supB = yB + 30;
        
        %imshow(Ic,[])
        %whos
        imBin = (Ic(:,:,1)>supR  | Ic(:,:,1)<infR) | (Ic(:,:,2)>supG | Ic(:,:,2)<infG) | (Ic(:,:,3)>supB | Ic(:,:,3)<infB);
        
        %figure, imshow(imBin);
        imBin = imclearborder(imBin);
        %figure, imshow(imBin);
        
        imBin = bwareaopen(imBin, 100);
        imBin = imfill(imBin,'holes');
        %figure, imshow(imBin);
        
        %if(j==6 || j==3)figure,imshow(imBin)
        %end
        
        
        [L, numObj] = bwlabel(imBin);
        
        %EN CASO DE TERMINAR USANDO ESTRUCTURAS..%
        %datosImagen = struct('Area',{0},'MajorAxisLength',{0},'MinorAxisLength',{0},'Eccentricity',{0},'EquivDiameter',{0},'Extent',{0},'Perimeter',{0},'AxisRatio',{0});
        
        
        
        
        
        for l=1 :numObj
            
            
            datos = regionprops(L == l, parametros);
            
            
            if saveFlag == 0
               disp('guardar')
                Figura = L==1;
                save('Figura','Figura');
                saveFlag = 1;
            end
            
            datosImagen(1,1,j) = datosImagen(1,1,j) + datos.Area;
            datosImagen(2,1,j) = datosImagen(2,1,j) + datos.MajorAxisLength;
            datosImagen(3,1,j) = datosImagen(3,1,j) + datos.MinorAxisLength;
            datosImagen(4,1,j) = datosImagen(4,1,j) + datos.Eccentricity;
            datosImagen(5,1,j) = datosImagen(5,1,j) + datos.EquivDiameter;
            datosImagen(6,1,j) = datosImagen(6,1,j) + datos.Extent;
            datosImagen(7,1,j) = datosImagen(7,1,j) + datos.Perimeter;
            datosImagen(8,1,j) = datosImagen(8,1,j) + datos.ConvexArea;
            datosImagen(9,1,j) = datosImagen(9,1,j) + datos.Solidity;
            %HASTA AQUI SON PARAMETROS OBTENIDOS DIRECTAMENTE%
            %ESTOS SON PARAMETROS COMBINADOS%
            datosImagen(10,1,j) = datosImagen(10,1,j) + (datos.MinorAxisLength/datos.MajorAxisLength);%AxisRatio
            datosImagen(11,1,j) = datosImagen(11,1,j) + (datos.MajorAxisLength*datos.MinorAxisLength);%AreaRect
            datosImagen(12,1,j) = datosImagen(12,1,j) + ((datos.Area * 4 * pi)/(datos.Perimeter^2));%FormFact
            datosImagen(13,1,j) = datosImagen(13,1,j) + (datos.MajorAxisLength/2);%Radio
            datosImagen(14,1,j) = datosImagen(14,1,j) + (datos.Area/(pi*(datos.MajorAxisLength/2)^2));%AreaCirc
            
            
            %rojo, naranja, yema, amarillo, limon, verde, azul, agua, turqueza, rosa,
            %morado, rosafosfo, cafe, gris, blanco, negro
            
            datos = [];
        end
        
        datosImagen(:,:,j) = datosImagen(:,:,j)./numObj;
        
    end
    
    
    
    
    datosFinales = sum(datosImagen,3);
    datosFinales = datosFinales./6;
    
    
    
    nombreFinal = strrep(a,' ','s');
    %nombreFinal
    %whos
    save(nombreFinal,'datosFinales');
    
    
    
        %imshow(Ic,[])
        %figure,imshow(imBin,[])
        %datosFinales
        
    
   
    
end

toc
end



function y = mediana(x)


[a,b] = size(x.data);
tam = a*b;

x = reshape(x.data,[1,tam]);
y = median(x);


end