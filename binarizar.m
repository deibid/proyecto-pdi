function [Propiedades] = binarizar( foto )

parametros = {'Area'
    'MajorAxisLength'
    'MinorAxisLength'
    'Eccentricity'
    'EquivDiameter'
    'Extent'
    'Perimeter'
    'ConvexArea'
    'Solidity'};

Ic = foto;
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
        
        imshow(Ic,[])
        whos
        imBin = (Ic(:,:,1)>supR  | Ic(:,:,1)<infR) | (Ic(:,:,2)>supG | Ic(:,:,2)<infG) | (Ic(:,:,3)>supB | Ic(:,:,3)<infB);
        
        imBin = imclearborder(imBin);
        
        imBin = bwareaopen(imBin, 100);
        imBin = imfill(imBin,'holes');
        imshow(imBin)
        [L, numObj] = bwlabel(imBin);
        
        Propiedades = [];
        datosImagen = zeros(16,1);
        for  l=1: numObj
        
            datos = regionprops(L == l, parametros);
            
            datosImagen(1,1) = datos.Area;%1
            datosImagen(2,1) = datos.MajorAxisLength;%2 %%
            datosImagen(3,1) = datos.MinorAxisLength;%3 %%
            datosImagen(4,1) = datos.Eccentricity;%4 %%
            datosImagen(5,1) = datos.EquivDiameter;%5 %%
            datosImagen(6,1) = datos.Extent;%6 %%
            datosImagen(7,1) = datos.Perimeter;%7 %%
            datosImagen(8,1) = datos.ConvexArea;%8 
            datosImagen(9,1) = datos.Solidity;%9 %%
            %HASTA AQUI SON PARAMETROS OBTENIDOS DIRECTAMENTE%
            %ESTOS SON PARAMETROS COMBINADOS%
            datosImagen(10,1) = (datos.MajorAxisLength/datos.MinorAxisLength);%AxisRatio - 10 %% major/menor
            datosImagen(11,1) = (datos.MajorAxisLength*datos.MinorAxisLength);%AreaRect - 11
            datosImagen(12,1) = ((datos.Area * 4 * pi)/(datos.Perimeter^2));%FormFact - 12 %%
            datosImagen(13,1) = (datos.MajorAxisLength/2);%Radio - 13
            datosImagen(14,1) = (datos.Area/(pi*(datos.MajorAxisLength/2)^2));%AreaCirc - 14 
            datosImagen(15,1) = datos.Area/datos.ConvexArea; % 15
            datosImagen(16,1) = datos.Area/datosImagen(11,1); %16 %%
            
            %rojo, naranja, yema, amarillo, limon, verde, azul, agua, turqueza, rosa,
            %morado, rosafosfo, cafe, gris, blanco, negro
            datosImagen;
            
            datos = [];
            
            
            Propiedades = cat(2,Propiedades,datosImagen);
           
        end
        Propiedades;

end

function y = mediana(x)


[a,b] = size(x.data);
tam = a*b;

x = reshape(x.data,[1,tam]);
y = median(x);


end