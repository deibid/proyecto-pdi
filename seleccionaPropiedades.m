function [ Resultado ] = seleccionaPropiedades( Matriz,renglones )
%SELECCIONAPROPIEDADES Summary of this function goes here
%   Detailed explanation goes here




renglones;
Resultado  = [];
size(renglones,2);

for i=1:size(renglones,2)
   Resultado = cat(1,Resultado,Matriz(renglones(i),:));
end








end

