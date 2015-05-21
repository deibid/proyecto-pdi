function [ ] = coloriza(Imagen)

Covarianza = load('CovarianzaColores.mat');
CA = Covarianza.CA;


Media = load('MediaColores.mat');
MA = Media.MA;



[trash, imBin] = binarizar(Imagen);
se = strel('disk',2);
imBinErod = imerode(imBin, se);
inBinErod = bwareaopen(imBinErod, 80);

imBinErod = uint8(inBinErod);
[L, numObj] = bwlabel(imBinErod);
mask = cat(3, imBinErod, imBinErod, imBinErod);
mask = Imagen.*mask;
imshow(mask)


Resultado = [];

whos
pause
for i=1 : 12
    
    
    
end

