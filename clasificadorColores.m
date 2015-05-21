function [ ] = clasificadorColores( )

Colores = {'rojos'
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

CA = [];
MA = [];
for i=1 : size(Colores,1)
    i
    path = [Colores{i} '.mat']
    Clase = load(path);
    Clase = Clase.Valores;
    whos
    [covarianza,media] = covmatrix(Clase);
    covarianza;
    CA = cat(3,CA,covarianza);
    MA = cat(2,MA,media);
    
end

save('CovarianzaColores','CA');
save('MediaColores','MA');

end

