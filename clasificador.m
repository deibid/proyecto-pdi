function [] = clasificador()





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


Clasificador = [];

for i=1:size(figuras,1)
    
    path = [figuras{i} '.mat']
    
    Clase = load(path);
    Clase = Clase.datosFinales
    
    Clasificador = horzcat(Clasificador,Clase)
        
end



save('Clasificador','Clasificador')




end