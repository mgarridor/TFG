interpolacion_total;
num_tramos=4;

if num_tramos==4 
    bitsLin=4;
    bitsCuad=8;
    num_datos=16;
else
    bitsLin=8;
    bitsCuad=12;
    num_datos=64;
end
%% Inicializo variables
convSinTexto;
x=-8:16/num_datos:7+(1-16/num_datos);
yLin= zeros(1,num_datos);
yCuad= zeros(1,num_datos);

%% Recogo los datos
%matlab
a1_matlab=load('a1_dec2.dat');
b1_matlab=load('b1_dec2.dat');

a2_matlab=load('a2_dec2.dat');
b2_matlab=load('b2_dec2.dat');
c2_matlab=load('c2_dec2.dat');

%VHDL
if num_tramos==4 
    yLineal_VHDL=load('yLin_4.dat');
    yCuad_VHDL=load('yCuad_4.dat');
elseif num_tramos==16
    yLineal_VHDL=load('yLin_16.dat');
    yCuad_VHDL=load('yCuad_16.dat');
end
%% Hago las interpolaciones 
    for i=1:1:num_datos
        a1_temp=a1_matlab(ceil(i*num_tramos/num_datos));
        b1_temp=b1_matlab(ceil(i*num_tramos/num_datos));
        a2_temp=a2_matlab(ceil(i*num_tramos/num_datos));
        b2_temp=b2_matlab(ceil(i*num_tramos/num_datos));
        c2_temp=c2_matlab(ceil(i*num_tramos/num_datos));
        
        yLin(i)=x(i) * a1_temp + b1_temp;
        yCuad(i)=x(i)^2 * a2_temp + x(i) * b2_temp + c2_temp;
               

    end

    %Convierto la solución para que tenga los mismos bits que VHDL
    sigmoide=sigmoid(x);
    yLin=double(fi(yLin,0,bitsLin,4));
    yCuad=double(fi(yCuad,0,bitsCuad,4));
    %Comparo con las operaciones en Matlab

    % Verifico el error cometido (error cuadratico medio)
%     errorLin= (1/num_datos)*sum((yLin'-yLineal_VHDL).^2);
%     errorCuad= (1/num_datos)*sum((yCuad'-yCuad_VHDL).^2);
    
    %Comparo con la sigmoide perfecta
    errorLin= (1/num_datos)*sum((sigmoide'-yLineal_VHDL).^2);
    errorCuad= (1/num_datos)*sum((sigmoide'-yCuad_VHDL).^2);
    
    
    %% display
    disp('Error lineal con respecto a VHDL: ');
    disp(errorLin);
    disp('Error cuadratico con respecto a VHDL: ');
    disp(errorCuad);
    
    subplot(2,1,1)
    plot (x,sigmoide,'r')
    hold on
    plot (x,yLineal_VHDL,'b')
    hold off
    subplot(2,1,2)
    plot (x,sigmoide,'r')
    hold on
    plot (x,yCuad_VHDL,'b')
    hold off
    
