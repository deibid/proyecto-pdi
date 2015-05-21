function [ propiedadesColores,imBinColores ] = binarizarColores(Imagen, imBinFiguras)

se = strel('disk',2);
imBinErod = imerode(imBinFiguras, se);
imBinErod = bwareaopen(imBinErod, 80);
imBinErod = uint8(imBinErod);

[L, numObj] = bwlabel(imBinErod);
mask = cat(3, imBinErod, imBinErod, imBinErod);
mask = Imagen.*mask;


% for i=1 : numObj
%     figura = L == i;
%     [X1, R1] = 
% end

propiedadesColores = 0;
imBinColores = 0;

end

