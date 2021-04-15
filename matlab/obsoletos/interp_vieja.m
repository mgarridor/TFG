function [err_lineal,err_cuad,a1,b1,a2,b2,c2]= interpolacion(x1,x2,x3,precision)
%% funcion sigmoide

y1=sigmoid(x1);
y2=sigmoid(x2);
y3=sigmoid(x3);
%% interpolacion lineal
% cojo 2 puntos y resuelvo el sistema de ecuaciones y=a1*x+b1

a1=(y1-y2)/(x1-x2);
b1=(x1*y2-x2*y1)/(x1-x2);

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

%% representacion
tramox=x1:precision:x3;

y=sigmoid(tramox);
y_lineal=a1.*tramox+b1;
y_cuad=a2*tramox.^2+b2.*tramox+c2;

% %represento sigmoide
% plot(tramox,y,'red')
% hold on
% 
% %represento funcion linear
% plot(tramox,y_lineal,'blue')
% 
% %represento funcion cuadratica
%plot (tramox,y_cuad)
%hold on
% hold off
%% calculo error
err_lineal=1/(x3-x1)*sum((y-y_lineal).^2);

err_cuad=1/(x3-x1)*sum((y-y_cuad).^2);

end
