function [imBinColor] = binarizarColorF(imBin, Imagen)

se = strel('disk',2);
imBinErod = imerode(imBin, se);
imBinErod = bwareaopen(imBinErod, 80);
imBinErod = uint8(imBinErod);

mask = cat(3, imBinErod, imBinErod, imBinErod);
imBinColor = Imagen.*mask;


end

