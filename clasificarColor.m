function [ dY1 ] = clasificarColor( propiedadesColores )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here




Covarianza = load('CovarianzaColores.mat');
CA = Covarianza.CA;


Media = load('MediaColores.mat');
MA = Media.MA;




dY1 = bayesgauss(propiedadesColores,CA,MA);




dY1 = mode(dY1);

end

