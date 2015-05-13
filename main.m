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
figure, imshow(Ic);

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

figure, imshow(imBin);
imBin = imclearborder(imBin);
figure, imshow(imBin);

imBin = bwareaopen(imBin, 100);
imBin = imfill(imBin,'holes');
figure, imshow(imBin);


[L, numObj] = bwlabel(imBin);
F = L == 10;
figure, imshow(F);

datos = regionprops(F, 'Area','ConvexArea','Centroid','MajorAxisLength','MinorAxisLength');
datos.Area
    end
end



function y = mediana(x)


[a,b] = size(x.data);
tam = a*b;

x = reshape(x.data,[1,tam]);
y = median(x);


end