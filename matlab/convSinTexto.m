%%%%% convierte los valores en binario y los guarda en un archivo
numero_bits_lin=8;
numero_bits_decimales_a1=numero_bits_lin+2;
numero_bits_decimales_b1=numero_bits_lin;

numero_bits=12;
numero_bits_decimales_a2=numero_bits+3;
numero_bits_decimales_b2=numero_bits+1;
numero_bits_decimales_c2=numero_bits;


q1a = quantizer([numero_bits_lin+1 numero_bits_decimales_a1]);
q1b = quantizer([numero_bits_lin+1 numero_bits_decimales_b1]);


q2a = quantizer([numero_bits numero_bits_decimales_a2]);
q2b = quantizer([numero_bits+1 numero_bits_decimales_b2]);
qc = quantizer([numero_bits+1 numero_bits_decimales_c2]);

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
fileID1a = fopen('a1_dec2.dat','w');
fprintf(fileID1a,'%d \n',a1_dec);

fileID1b = fopen('b1_dec2.dat','w');
fprintf(fileID1b,'%d \n',b1_dec);

fileIDa = fopen('a2_dec2.dat','w');
fprintf(fileIDa,'%d \n',a2_dec);

fileIDb = fopen('b2_dec2.dat','w');
fprintf(fileIDb,'%d \n',b2_dec);

fileIDc = fopen('c2_dec2.dat','w');
fprintf(fileIDc,'%d \n',c2_dec);
