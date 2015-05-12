%{
blkproc parte la imagen en bloques, func debe sacar la mediana
hacer resize del resultado y restarselo a la imagen original
%}

function [] = main()

clc 
close all
clear

Ic = imread('nina 1.jpg');
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
imshow(Ic);

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

im = (Ic(:,:,1)>supR  | Ic(:,:,1)<infR) | (Ic(:,:,2)>supG | Ic(:,:,2)<infG) | (Ic(:,:,3)>supB | Ic(:,:,3)<infB);

figure, imshow(im);
im = imclearborder(im);
figure, imshow(im);

[L, numObj] = bwlabel(im);
F = L == 12;
figure, imshow(F);

datos = regionprops(F, 'Area','ConvexArea','Centroid','MajorAxisLength','MinorAxisLength');

end



function y = mediana(x)


[a,b] = size(x.data);
tam = a*b;

x = reshape(x.data,[1,tam]);
y = median(x);


end