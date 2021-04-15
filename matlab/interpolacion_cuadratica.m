function [a2,b2,c2]= interpolacion_cuadratica(x1,x2,x3)
%% funcion sigmoide

y1=sigmoid(x1);
y2=sigmoid(x2);
y3=sigmoid(x3);
%% interpolacion cuadratica
% cojo 3 puntosy resuelvo el sistema de ecuaciones y=a*x^2+b*x+c
%matriz de sistema de ecuaciones

mx_cuadrado= [x1^2;x2^2;x3^2];
mx=[x1;x2;x3];
munos=[1;1;1];
my=[y1;y2;y3];
A=[mx_cuadrado,mx,munos];

%calculo a,b,c para almacenarlos en ram

a2=det([my,mx,munos])/det(A);
b2=det([mx_cuadrado,my,munos])/det(A);
c2=det([mx_cuadrado,mx,my])/det(A);


end
