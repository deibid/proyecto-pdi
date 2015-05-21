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
CA = [];
MA = [];
for i=1:size(figuras,1)
    
    path = [figuras{i} '.mat']
    
    Clase = load(path);
    Clase = Clase.datosFinales
    
    %Clase = seleccionaPropiedades(Clase,[2,3,4,5,6,7,9,10,12,16])
    
    [covarianza,media] = covmatrix(Clase');
    
    covarianza;
    CA = cat(3,CA,covarianza);
    MA = cat(2,MA,media);
    
    
        
end


MA;


save('Covarianza','CA');
save('Media','MA');




end