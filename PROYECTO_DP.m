function [ResultadoFinal] = PROYECTO_PD(Imagen)



%recibir sstring
%binarizar para figuras
    %procesas para figura
    %devuelve vector de resultado

%binariazar para colores
    %procesas para color
    %devuelve vector de resultado

    
%recibe vectores 
%procesa resultado final



Imagen = imread(Imagen);


[propiedadesFiguras,imBinFiguras] = binarizarFiguras(Imagen);

imshow(imBinFiguras,[])
propiedadesFiguras

[propiedadesColores,imBinColores] = binarizarColores(Imagen);

resultadoFiguras = procesarFiguras(propiedadesFiguras);
resultadoColores = procesarColores(propiedadesColores);


ResultadoFinal = analizarDatos(resultadoFiguras,resultadoColores);





end