function [ dY1 ] = clasificarFigura( propiedadesFiguras )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here


Matrices = load('Matrices_PD.mat');
Covarianza = Matrices.matrices.CF;

%Covarianza = load('Covarianza.mat');
%Covarianza = Covarianza.CA;

%Media = load('Media.mat');
%Media = Media.MA;
Media = Matrices.matrices.MF;
dY1 = bayesgauss(propiedadesFiguras',Covarianza,Media);






end

