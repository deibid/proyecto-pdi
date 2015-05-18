function [] = Clasifica()

close all



B1 = load('Figura.mat')
B1 = B1.Figura;
whos
imshow(B1,[])



Clasificador = load('Clasificador.mat')
Clasificador = Clasificador.Clasificador;


parametros = {'Area'
    'MajorAxisLength'
    'MinorAxisLength'
    'Eccentricity'
    'EquivDiameter'
    'Extent'
    'Perimeter'
    'ConvexArea'
    'Solidity'};





datos = regionprops(B1, parametros);


j = 1;
global datosImagen;
datosImagen = zeros(14,16,1);
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




[X1,R1]=imstack2vectors(Clasificador,datosImagen);

[C1,m1]=covmatrix(X1);

C1
m1
dY1=bayesgauss(X1,C1,m1)

IY1=find(dY1~=1)



end