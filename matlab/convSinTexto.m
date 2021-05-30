%%%%% 
% convierte los valores de los parámetros de interpolación en coma flotante
% y después los pasa a decimal de nuevo para ver su precisión. Por último
% se guardan en un archivo .dat
%%%%% 

%%%%% convierte los valores en binario y los guarda en un archivo
numero_bits_decimales_a1=bitsLin+2;
numero_bits_decimales_b1=bitsLin;

numero_bits_decimales_a2=bitsCuad+3;
numero_bits_decimales_b2=bitsCuad+1;
numero_bits_decimales_c2=bitsCuad;


q1a = quantizer([bitsLin+1 numero_bits_decimales_a1]);
q1b = quantizer([bitsLin+1 numero_bits_decimales_b1]);


q2a = quantizer([bitsCuad numero_bits_decimales_a2]);
q2b = quantizer([bitsCuad+1 numero_bits_decimales_b2]);
qc = quantizer([bitsCuad+1 numero_bits_decimales_c2]);

% % pasar de decimal a binario o complemento a 2.
% % el primer bit de b2 y c2 siempre es 0, habria que quitarselo para que sea
% % unsigned

a1_bin=num2bin(q1a,a1);
b1_bin=num2bin(q1b,b1);

a2_bin=num2bin(q2a,a2);
b2_bin=num2bin(q2b,b2);
c2_bin=num2bin(qc,c2);

a1_dec=bin2num(q1a,a1_bin);
b1_dec=bin2num(q1b,b1_bin);

a2_dec=bin2num(q2a,a2_bin);
b2_dec=bin2num(q2b,b2_bin);
c2_dec=bin2num(qc,c2_bin);

% lo escribo en un archivo 
fileID1a = fopen('generados/a1_dec2.dat','w');
fprintf(fileID1a,'%d \n',a1_dec);

fileID1b = fopen('generados/b1_dec2.dat','w');
fprintf(fileID1b,'%d \n',b1_dec);

fileIDa = fopen('generados/a2_dec2.dat','w');
fprintf(fileIDa,'%d \n',a2_dec);

fileIDb = fopen('generados/b2_dec2.dat','w');
fprintf(fileIDb,'%d \n',b2_dec);

fileIDc = fopen('generados/c2_dec2.dat','w');
fprintf(fileIDc,'%d \n',c2_dec);
