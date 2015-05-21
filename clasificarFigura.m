function [ dY1 ] = clasificarFigura( propiedadesFiguras )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here


Covarianza = load('Covarianza.mat');
Covarianza = Covarianza.CA;

Media = load('Media.mat');
Media = Media.MA;

dY1 = bayesgauss(propiedadesFiguras',Covarianza,Media);






end

