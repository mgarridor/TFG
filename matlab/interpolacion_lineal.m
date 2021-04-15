function [a1,b1]= interpolacion_lineal(x1,x2)
%% funcion sigmoide

y1=sigmoid(x1);
y2=sigmoid(x2);
%% interpolacion lineal
% cojo 2 puntos y resuelvo el sistema de ecuaciones y=a1*x+b1

a1=(y1-y2)/(x1-x2);
b1=(x1*y2-x2*y1)/(x1-x2);


end
