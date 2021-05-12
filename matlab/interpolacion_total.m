num_tramos=4;
inicio=-8;
final=8;
nbits=12;
%Variables para 4 y 16 tramos
if num_tramos==4 
    bitsLin=4;
    bitsCuad=8;
    num_datos_lin=16;
    num_datos_cuad=256;
else
    bitsLin=8;
    bitsCuad=12;
    num_datos_lin=256;
    num_datos_cuad=4096;
end
longitud_tramos=((final-inicio)/num_tramos);

err_cuad=zeros(1,num_tramos);
err_cuad_pf=zeros(1,num_tramos);
err_lineal=zeros(1,num_tramos);
err_lineal_pf=zeros(1,num_tramos);

a1=zeros(1,num_tramos);
b1=zeros(1,num_tramos);
a2=zeros(1,num_tramos);
b2=zeros(1,num_tramos);
c2=zeros(1,num_tramos);

indice=1;
for i=inicio:longitud_tramos:final-longitud_tramos
    x1=i;
    x3=i+longitud_tramos;
    x2=i+longitud_tramos/2;
    
    %calculo parametros a,b,c
    [ai1,bi1]= interpolacion_lineal(x1,x3);
    [ai2,bi2,ci2]= interpolacion_cuadratica(x1,x2,x3);

    %calculo errores
    [err_lineali,err_cuadi,err_cuad_pfi,err_lineal_pfi]= errores(x1,x2,x3,nbits,bitsLin,bitsCuad);

    err_cuad(indice)=err_cuadi;
    err_lineal(indice)=err_lineali;
    err_cuad_pf(indice)=err_cuad_pfi;
    err_lineal_pf(indice)=err_lineal_pfi;

    a1(indice)=ai1;
    b1(indice)=bi1;
    a2(indice)=ai2;
    b2(indice)=bi2;
    c2(indice)=ci2;

    indice=indice+1;
end
% 
sum_error_lineal=0.001/16*sum(err_lineal);
disp('error lineal total')
disp(sum_error_lineal)

sum_error_cuad=0.001/16*sum(err_cuad);
disp('error cuadratico total')
disp(sum_error_cuad)

sum_error_lineal_pf=0.001/16*sum(err_lineal_pf);
disp('error cuadratico total lineal con precision de punto fijo')
disp(sum_error_lineal_pf)

sum_error_cuad_pf=0.001/16*sum(err_cuad_pf);
disp('error cuadratico total con precision de punto fijo')
disp(sum_error_cuad_pf)

% 
% 
% 
