%{
blkproc parte la imagen en bloques, func debe sacar la mediana
hacer resize del resultado y restarselo a la imagen original
%}

function [] = main()

clc 
close all
clear





Ic = imread('Imagenes/IMG_9730.jpg');
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


global count
global x
[count, x] = imhist(Ic(:,:,1));
y = find(count == max(max(count)))
[count, x] = imhist(Ic(:,:,2));
y2 = find(count == max(max(count)))
[count, x] = imhist(Ic(:,:,3));
y3 = find(count == max(max(count)))


inf = y - 30;
sup = y + 30;
inf2 = y2 - 30;
sup2 = y2 + 30;
inf3 = y3 - 30;
sup3 = y3 + 30;

ImBin = Ic(:,:,1)>sup  | Ic(:,:,1)<inf;
ImBin2= Ic(:,:,2)>sup2 | Ic(:,:,2)<inf2;
ImBin3= Ic(:,:,3)>sup3 | Ic(:,:,3)<inf3;

im = ImBin == 1 | ImBin2 == 1 | ImBin3 == 1;

figure, imshow(im);
im = imclearborder(im);
figure, imshow(im);

[L, numObj] = bwlabel(im);
F = L == 12;
figure, imshow(F);

datos = regionprops(F, 'Area','ConvexArea','Centroid','MajorAxisLength','MinorAxisLength');
disp('area');
datos.Area
disp('convexarea');
datos.ConvexArea
disp('centroid');
datos.Centroid
disp('maj axis len');
datos.MajorAxisLength
disp('min axis len');
datos.MinorAxisLength

end



function y = mediana(x)


[a,b] = size(x.data);
tam = a*b;

x = reshape(x.data,[1,tam]);
y = median(x);


end