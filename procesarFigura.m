function [ datosImagen ] = procesarFigura(L)
parametros = {'Area'
    'MajorAxisLength'
    'MinorAxisLength'
    'Eccentricity'
    'EquivDiameter'
    'Extent'
    'Perimeter'
    'ConvexArea'
    'Solidity'};
datosImagen = [];
datos = regionprops(L, parametros);
datosImagen(1,1) = datos.MajorAxisLength;%2 %%
datosImagen(2,1) = datos.MinorAxisLength;%3 %%
datosImagen(3,1) = datos.Eccentricity;%4 %%
datosImagen(4,1) = datos.EquivDiameter;%5 %%
datosImagen(5,1) = datos.Extent;%6 %%
datosImagen(6,1) = datos.Perimeter;%7 %%
datosImagen(7,1) = datos.Solidity;%9 %%
%HASTA AQUI SON PARAMETROS OBTENIDOS DIRECTAMENTE%
%ESTOS SON PARAMETROS COMBINADOS%
datosImagen(8,1) = (datos.MajorAxisLength/datos.MinorAxisLength);%AxisRatio - 10 %% major/menor
datosImagen(9,1) = ((datos.Area * 4 * pi)/(datos.Perimeter^2));%FormFact - 12 %%
datosImagen(10,1) = datos.Area/(datos.MajorAxisLength*datos.MinorAxisLength); %16 %%

end

