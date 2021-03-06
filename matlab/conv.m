%%%%% 
% convierte los valores de los parámetros de interpolación en binario y
% los guarda en un archivo .txt para su uso en VHDL
%%%%% 
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

a1_bin=string(cellstr(num2bin(q1a,a1)));
b1_bin=string(cellstr(num2bin(q1b,b1)));

a2_bin=string(cellstr(num2bin(q2a,a2)));
b2_bin=string(cellstr(num2bin(q2b,b2)));
c2_bin=string(cellstr(num2bin(qc,c2)));

% lo escribo en un archivo 
fileID1a = fopen('generados/a1_bin.txt','w');
fprintf(fileID1a,'constant a1_16_1:unsigned:="%s"; \n',a1_bin);

fileID1b = fopen('generados/b1_bin.txt','w');
fprintf(fileID1b,'constant b1_16_1:unsigned:="%s"; \n',b1_bin);

fileIDa = fopen('generados/a2_bin.txt','w');
fprintf(fileIDa,'constant a2_8_1:signed:="%s"; \n',a2_bin);

fileIDb = fopen('generados/b2_bin.txt','w');
fprintf(fileIDb,'constant b2_8_1:unsigned:="%s"; \n',b2_bin);

fileIDc = fopen('generados/c2_bin.txt','w');
fprintf(fileIDc,'constant c2_8_1:unsigned:="%s"; \n',c2_bin);

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
fileID1a = fopen('generados/a1_dec.txt','w');
fprintf(fileID1a,'constant a1_16_1:unsigned:="%s"; \n',a1_dec);

fileID1b = fopen('generados/b1_dec.txt','w');
fprintf(fileID1b,'constant b1_16_1:unsigned:="%s"; \n',b1_dec);

fileIDa = fopen('generados/a2_dec.txt','w');
fprintf(fileIDa,'constant a2_8_1:signed:="%s"; \n',a2_dec);

fileIDb = fopen('generados/b2_dec.txt','w');
fprintf(fileIDb,'constant b2_8_1:unsigned:="%s"; \n',b2_dec);

fileIDc = fopen('generados/c2_dec.txt','w');
fprintf(fileIDc,'constant c2_8_1:unsigned:="%s"; \n',c2_dec);
