function [ResultadoFinal] = PROYECTO_PD(Imagen)
clc
close all

figuras = {'caracols'
    'castillos'
    'conejos'
    'corazons'
    'geckos'
    'globos'
    'huesos'
    'libelulas'
    'lunas'
    'manchas'
    'mariposas'
    'ninas'
    'ninos'
    'osos'
    'pastels'
    'tulipans'};




colores = {'rojos'
    'naranjas'
    'yemas'
    'amarillos'
    'limons'
    'verdes'
    'azuls'
    'aquas'
    'turquesas'
    'rosas'
    'morados'
    'fosfos'
    'cafes'
    'griss'
    'blancos'
    'negros'};


Imagen = imread(Imagen);

imBin = binarizarF(Imagen);
imBinColor = binarizarColorF(imBin, Imagen);
[L, numObj] = bwlabel(imBin);
%figure, imshow(imBin);
%figure, imshow(imBinColor);

cuentaFiguras = zeros(16,1);
cuentaColores = zeros(16,1);



ResultadoFinal= zeros(16,16);


%figure
for i = 1: numObj
    [propiedadesFiguras] = procesarFigura(L==i);
    %propiedadesFiguras;
    [resultadoFigura] = clasificarFigura(propiedadesFiguras);
    cuentaFiguras(resultadoFigura,1) = cuentaFiguras(resultadoFigura,1)+1;
    
    
    [propiedadesColores] = procesarColor(imBinColor,L==i);
    [resultadoColor] = clasificarColor(propiedadesColores);
    %resultadoColor
    cuentaColores(resultadoColor,1) = cuentaColores(resultadoColor,1) + 1;
    
    
    
    ResultadoFinal(resultadoFigura,resultadoColor) = ...
        ResultadoFinal(resultadoFigura,resultadoColor) + 1;
    
    
    
    %msg = [figuras{resultadoFigura} '    ' colores{resultadoColor}]
    %imshow(L==i)
    %pause
end




cuentaFiguras;
cuentaColores;

%imshow(imBinColor);



ResultadoFinal;




end