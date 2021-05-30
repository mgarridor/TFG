%%%%%%%%%%%%%%
% Cálculo de errores, a partir de 3 puntos y un número de bits específico
% calcula el eror cuadrático medio entre las interpolaciónes y la función
% sigmoide. Además también calcula el error si se utiliza un número
% determinado de bits. 
%%%%%%%%%%%%%%



function [err_lineal,err_cuad,err_cuad_pf,err_lineal_pf]= errores(x1,x2,x3,nbits,bitslin,bitscuad)
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

%% calculo funciones
x=x1:0.001:x3;
%paso a punto fijo S(3,8)

y=sigmoid(x);
y_lineal=a1.*x+b1;
y_cuad=a2*x.^2+b2.*x+c2;
x=double(fi(x,1,nbits,nbits-4));


%% calculo error
err_lineal=sum((y-y_lineal).^2);
err_cuad=sum((y-y_cuad).^2);

[a1_pf,b1_pf,a2_pf,b2_pf,c2_pf]=punto_fijo(a1,b1,a2,b2,c2,bitslin,bitscuad);

y_cuad_pf=a2_pf*x.^2+b2_pf.*x+c2_pf;
err_cuad_pf=sum((y-y_cuad_pf).^2);

y_lineal_pf=a1_pf.*x+b1_pf;
err_lineal_pf=sum((y-y_lineal_pf).^2);



end
