interpolacion_total;

%% Inicializo variables
convSinTexto;
xLin=-8:16/num_datos_lin:7+(1-16/num_datos_lin);
xCuad=-8:16/num_datos_cuad:7+(1-16/num_datos_cuad);
yLin= zeros(1,num_datos_lin);
yCuad= zeros(1,num_datos_cuad);

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
    %Lineal
    for i=1:1:num_datos_lin
        a1_temp=a1_matlab(ceil(i*num_tramos/num_datos_lin));
        b1_temp=b1_matlab(ceil(i*num_tramos/num_datos_lin));

        yLin(i)=xLin(i) * a1_temp + b1_temp;
    end
    %Cuadrático
    for i=1:1:num_datos_cuad
        a2_temp=a2_matlab(ceil(i*num_tramos/num_datos_cuad));
        b2_temp=b2_matlab(ceil(i*num_tramos/num_datos_cuad));
        c2_temp=c2_matlab(ceil(i*num_tramos/num_datos_cuad));
        
        yCuad(i)=xCuad(i)^2 * a2_temp + xCuad(i) * b2_temp + c2_temp;
    end
    %Calculo la función sigmoide 
    sigmoideLin=sigmoid(xLin);
    sigmoideCuad=sigmoid(xCuad);
    
    %Convierto la solución para que tenga los mismos bits que VHDL
    yLin=double(fi(yLin,0,bitsLin,4));
    yCuad=double(fi(yCuad,0,bitsCuad,4));
    %Comparo con las operaciones en Matlab

    % Verifico el error cometido (error cuadratico medio)
    
    %Comparo con El error de la misma operacion en VHDL y en Matlab
%     errorLin= (1/num_datos)*sum((yLin'-yLineal_VHDL).^2);
%     errorCuad= (1/num_datos)*sum((yCuad'-yCuad_VHDL).^2);
    
    %Comparo con la sigmoide perfecta
    errorLin= (1/num_datos_lin)*sum((sigmoideLin'-yLineal_VHDL).^2);
    errorCuad= (1/num_datos_cuad)*sum((sigmoideCuad'-yCuad_VHDL).^2);
    
    
    %% display
    disp('Error lineal con respecto a VHDL: ');
    disp(errorLin);
    disp('Error cuadratico con respecto a VHDL: ');
    disp(errorCuad);
    
    subplot(2,1,1)
    plot (xLin,sigmoideLin,'r')
    %plot(xLin,yLin,'r')
    hold on
    plot (xLin,yLineal_VHDL,'b')
    hold off
    subplot(2,1,2)
    plot (xCuad,sigmoideCuad,'r')
    %plot (xCuad,yCuad,'r')
    hold on
    plot (xCuad,yCuad_VHDL,'b')
    hold off
    
