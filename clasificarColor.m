function [ dY1 ] = clasificarColor( propiedadesColores )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here



Matrices = load('Matrices_PD.mat');
%Covarianza = load('CovarianzaColores.mat');
CA = Matrices.matrices.CC;
MA = Matrices.matrices.MC;

%Media = load('MediaColores.mat');





dY1 = bayesgauss(propiedadesColores,CA,MA);
dY1 = mode(dY1);

end

