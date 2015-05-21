function [imBin] = binarizarF(Imagen)

Ic = Imagen;
I = rgb2gray(Imagen);



bloques = blockproc(I,[80,80],@mediana);
bloques = imresize(bloques,[427,640]);


minimo = min(min(bloques));

bloques = bloques-minimo;

Ic(:,:,1) = Ic(:,:,1)-bloques;
Ic(:,:,2) = Ic(:,:,2)-bloques;
Ic(:,:,3) = Ic(:,:,3)-bloques;



[count] = imhist(Ic(:,:,1));
yR = find(count == max(max(count)));
[count] = imhist(Ic(:,:,2));
yG = find(count == max(max(count)));
[count] = imhist(Ic(:,:,3));
yB = find(count == max(max(count)));

yR = yR(1);
yG = yG(1);
yB = yB(1);



infR = yR - 30
supR = yR + 30
infG = yG - 30
supG = yG + 30
infB = yB - 30
supB = yB + 30

imBinR = Ic(:,:,1)>supG  | Ic(:,:,1)<infG;
imBinG = Ic(:,:,2)>supG | Ic(:,:,2)<infG;
imBinB = Ic(:,:,3)>supB | Ic(:,:,3)<infB;


imBin = (Ic(:,:,1)>supG  | Ic(:,:,1)<infG) | (Ic(:,:,2)>supG | Ic(:,:,2)<infG) | (Ic(:,:,3)>supB | Ic(:,:,3)<infB);
%imBin =  (Ic(:,:,2)>supG | Ic(:,:,2)<infG) | (Ic(:,:,2)>supG | Ic(:,:,2)<infG) | (Ic(:,:,3)>supB | Ic(:,:,3)<infB);

imBin = imclearborder(imBin);

imBin = bwareaopen(imBin, 100);
imBin = imfill(imBin,'holes');


end

function y = mediana(x)


[a,b] = size(x.data);
tam = a*b;

x = reshape(x.data,[1,tam]);
y = median(x);


end
