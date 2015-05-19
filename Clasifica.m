function [] = Clasifica(Imagen)

close all


nombre = 'tulipans';

archivo = [nombre,'.mat']
B1 = load(archivo)
B1 = B1.datosFinales;
whos


B1 = Imagen;
%imshow(B1,[])




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

%index = find([figuras{1,:}] == nombre);


%index = strfind(figuras,nombre)
index = find(ismember(figuras,nombre))
%Clasificador = load('Clasificador.mat')
%Clasificador = Clasificador.Clasificador;

Covarianza = load('Covarianza.mat');
Covarianza = Covarianza.CA;

Media = load('Media.mat');
Media = Media.MA;

% 
% parametros = {'Area'
%     'MajorAxisLength'
%     'MinorAxisLength'
%     'Eccentricity'
%     'EquivDiameter'
%     'Extent'
%     'Perimeter'
%     'ConvexArea'
%     'Solidity'};
% 
% 
% 
% 
% 
% %datos = regionprops(B1, parametros)
% 
% 
% 
% global datosImagen;
% datosImagen = [];
% 
% 
% l = 1;
% datosImagen(1,l) = datos.Area;
% datosImagen(2,l) = datos.MajorAxisLength;
% datosImagen(3,l) = datos.MinorAxisLength;
% datosImagen(4,l) = datos.Eccentricity;
% datosImagen(5,l) = datos.EquivDiameter;
% datosImagen(6,l) = datos.Extent;
% datosImagen(7,l) = datos.Perimeter;
% datosImagen(8,l) = datos.ConvexArea;
% datosImagen(9,l) = datos.Solidity;
% %HASTA AQUI SON PARAMETROS OBTENIDOS DIRECTAMENTE%
% %ESTOS SON PARAMETROS COMBINADOS%
% datosImagen(10,l) = (datos.MinorAxisLength/datos.MajorAxisLength);%AxisRatio
% datosImagen(11,l) = (datos.MajorAxisLength*datos.MinorAxisLength);%AreaRect
% datosImagen(12,l) = ((datos.Area * 4 * pi)/(datos.Perimeter^2));%FormFact
% datosImagen(13,l) = (datos.MajorAxisLength/2);%Radio
% datosImagen(14,l) = (datos.Area/(pi*(datos.MajorAxisLength/2)^2));
% datosImagen(15,l) = datos.Area/datos.ConvexArea;
% 
% 
% %[X1,R1]=imstack2vectors(Clasificador,datosImagen);
% 
% %[C1,m1]=covmatrix(X1);
% 
% %C1
% %m1
% whos
% 
% 
% 
% datosImagen = seleccionaPropiedades(datosImagen,[2,3,4,5])



Covarianza
Media



%dY1=bayesgauss(datosImagen',Covarianza,Media)

%IY1=find(dY1~=1);
%dY1


res = 0;


Resultado = [];

for l=1:size(B1,2)
    
    datos = seleccionaPropiedades(B1,[2,3,4,5,6,7,9,10,12,16]);
    datos;
    dY1 = bayesgauss(datos(:,l)',Covarianza,Media);

    
    Resultado = cat(1,Resultado,dY1);
    if not(isempty(find(dY1~=index)))
       res = res+1; 
    end
    
end


Cuenta = zeros(16,1)
for i = 1:size(Resultado,1)
   
    Cuenta(Resultado(i,1)) = Cuenta(Resultado(i,1))+1;
    
end


Cuenta



res
size(B1,2)







end