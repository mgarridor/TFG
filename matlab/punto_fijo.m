
%%%%%%%%%%%%%%%%%
% Convierte los parámetros de una interpolación en un número con la
% recisión de punto fijo con un número de bits impuesto por los argumentos.
%%%%%%%%%%%%%%%%%
function [a1_pf,b1_pf,a2_pf,b2_pf,c2_pf]=punto_fijo(a1,b1,a2,b2,c2,bitslin,bitscuad)


numero_bits_decimales_a2=bitscuad+3;
numero_bits_decimales_b2=bitscuad+1;
numero_bits_decimales_c2=bitscuad;

a2_pf=double(fi(a2,1,bitscuad,numero_bits_decimales_a2));
b2_pf=double(fi(b2,0,bitscuad,numero_bits_decimales_b2));
c2_pf=double(fi(c2,0,bitscuad,numero_bits_decimales_c2));


numero_bits_decimales_a1=bitslin+2;
numero_bits_decimales_b1=bitslin;

a1_pf=double(fi(a1,0,bitslin,numero_bits_decimales_a1));
b1_pf=double(fi(b1,0,bitslin,numero_bits_decimales_b1));


%% notas
%% para 16 tramos:
% bitscuad=12;
% numero_bits_decimales_a2=15;
% numero_bits_decimales_b2=13;
% numero_bits_decimales_c2=12;

% error cuadratico total    4.7204e-08
% error cuadratico total con precision de punto fijo    8.6926e-08

%% para 8 tramos:
% bitscuad=9;
% numero_bits_decimales_a2=12;
% numero_bits_decimales_b2=10;
% numero_bits_decimales_c2=9;

% error cuadratico total    1.4781e-06
% error cuadratico total con precision de punto fijo    1.4737e-06

%% para 4 tramos:
% bitscuad=7;
% numero_bits_decimales_a2=10;
% numero_bits_decimales_b2=8;
% numero_bits_decimales_c2=7;

% error cuadratico total    3.0429e-05
% error cuadratico total con precision de punto fijo    3.0187e-05


%% 
end
