----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Matias Garrido Recalde
-- 
-- Create Date: 04.12.2020 14:13:13
-- Design Name: 
-- Module Name: funcion_activacion - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


--señales de control

--control_lineal='1' -> función lineal
----control_T= "00" -> 4 tramos -> 4 bits
----control_T= "01" -> 8 tramos -> 6 bits
----control_T= "10" -> 16 tramos -> 7 bits

--control_lineal='0' -> funcion cuadrática
----control_T= "00" -> 4 tramos -> 7 bits
----control_T= "01" -> 8 tramos -> 9 bits
----control_T= "10" -> 16 tramos -> 12 bits

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity funcion_activacion is
    generic(nbits_totales:natural:=7;
            control_lineal:std_logic:='0';
            control_T:std_logic_vector(1 downto 0):="00"
            );
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x : in signed (nbits_totales-1 downto 0);
           y : out unsigned (nbits_totales-1 downto 0);
           ready:out std_logic
           );
end funcion_activacion;

architecture Behavioral of funcion_activacion is

--notacion: paramx_tramos_indice

--4 tramos
constant a1_4_1:unsigned:="0000";
constant a1_4_2:unsigned:="0111";

constant b1_4_1:unsigned:="0000";
constant b1_4_2:unsigned:="1000";

constant a2_4_1:signed:="0000001";
constant a2_4_2:signed:="0100011";

constant b2_4_1:unsigned:="0000110";
constant b2_4_2:unsigned:="1000010";

constant c2_4_1:unsigned:="0001011";
constant c2_4_2:unsigned:="1000000";

--8 tramos
constant a1_8_1:unsigned:="000000"; 
constant a1_8_2:unsigned:="000001"; 
constant a1_8_3:unsigned:="001100"; 
constant a1_8_4:unsigned:="110000"; 

constant b1_8_1:unsigned:="000000"; 
constant b1_8_2:unsigned:="000011"; 
constant b1_8_3:unsigned:="001110"; 
constant b1_8_4:unsigned:="100000"; 

constant a2_8_1:signed:="000000010"; 
constant a2_8_2:signed:="000001110"; 
constant a2_8_3:signed:="001010110"; 
constant a2_8_4:signed:="010100110"; 

constant b2_8_1:unsigned:="000001000"; 
constant b2_8_2:unsigned:="000101100"; 
constant b2_8_3:unsigned:="010110101"; 
constant b2_8_4:unsigned:="100010110"; 

constant c2_8_1:unsigned:="000010000"; 
constant c2_8_2:unsigned:="001000100"; 
constant c2_8_3:unsigned:="011000111"; 
constant c2_8_4:unsigned:="100000000"; 

--16 tramos
constant a1_16_1:unsigned:="0000000"; 
constant a1_16_2:unsigned:="0000000"; 
constant a1_16_3:unsigned:="0000010"; 
constant a1_16_4:unsigned:="0000101"; 
constant a1_16_5:unsigned:="0001111"; 
constant a1_16_6:unsigned:="0100100"; 
constant a1_16_7:unsigned:="1001100"; 
constant a1_16_8:unsigned:="1110110";

constant b1_16_1:unsigned:="0000000"; 
constant b1_16_2:unsigned:="0000001"; 
constant b1_16_3:unsigned:="0000011"; 
constant b1_16_4:unsigned:="0001000"; 
constant b1_16_5:unsigned:="0010001"; 
constant b1_16_6:unsigned:="0100001"; 
constant b1_16_7:unsigned:="0110101"; 
constant b1_16_8:unsigned:="1000000"; 

constant a2_16_1:signed:="000000001001";
constant a2_16_2:signed:="000000011000";
constant a2_16_3:signed:="000001000011";
constant a2_16_4:signed:="000010110001";
constant a2_16_5:signed:="000110111100";
constant a2_16_6:signed:="001111010001";
constant a2_16_7:signed:="010111110110";
constant a2_16_8:signed:="001110001100";

constant b2_16_1:unsigned:="000000100111";
constant b2_16_2:unsigned:="000001011110";
constant b2_16_3:unsigned:="000011011011";
constant b2_16_4:unsigned:="000111101011";
constant b2_16_5:unsigned:="001111111011";
constant b2_16_6:unsigned:="011100010001";
constant b2_16_7:unsigned:="100101000011";
constant b2_16_8:unsigned:="100001000111";

constant c2_16_1:unsigned:="000001010100";
constant c2_16_2:unsigned:="000010110011";
constant c2_16_3:unsigned:="000101101101";
constant c2_16_4:unsigned:="001010111101";
constant c2_16_5:unsigned:="010011000111";
constant c2_16_6:unsigned:="011100010001";
constant c2_16_7:unsigned:="100000110000";
constant c2_16_8:unsigned:="100000000000";

--señales intermedias
signal a1_4:unsigned(3 downto 0);
signal a1_8:unsigned(5 downto 0);
signal a1_16:unsigned(6 downto 0);

signal b1_4:unsigned(3 downto 0);
signal b1_8:unsigned(5 downto 0);
signal b1_16:unsigned(6 downto 0);

signal a2_4:signed(6 downto 0);
signal a2_8:signed(8 downto 0);
signal a2_16:signed(11 downto 0);

signal b2_4:unsigned(6 downto 0);
signal b2_8:unsigned(8 downto 0);
signal b2_16:unsigned(11 downto 0);

signal c2_4:unsigned(6 downto 0);
signal c2_8:unsigned(8 downto 0);
signal c2_16:unsigned(11 downto 0);


signal b1_final_4:unsigned(3 downto 0);
signal c2_final_4:unsigned(6 downto 0);
signal a2_final_4:signed(6 downto 0);

signal b1_final_8:unsigned(5 downto 0);
signal c2_final_8:unsigned(8 downto 0);
signal a2_final_8:signed(8 downto 0);

signal b1_final_16:unsigned(6 downto 0);
signal c2_final_16:unsigned(11 downto 0);
signal a2_final_16:signed(11 downto 0);

--señales de control
signal negativo:std_logic;
signal control_4T:std_logic;
signal control_8T:std_logic_vector(1 downto 0);
signal control_16T:std_logic_vector(2 downto 0);


--señales finales
signal y_lin_4:unsigned (3 downto 0);
signal y_cuad_4:unsigned (6 downto 0);

signal y_lin_8:unsigned (5 downto 0);
signal y_cuad_8:unsigned (8 downto 0);

signal y_lin_16:unsigned (6 downto 0);
signal y_cuad_16:unsigned (11 downto 0);


component funcion_cuadratica 
    generic(nbits:natural);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x : in signed (nbits-1 downto 0);
           a : in signed (nbits-1 downto 0);
           b : in unsigned (nbits-1 downto 0);
           c : in unsigned (nbits-1 downto 0);
           y : out unsigned (nbits-1 downto 0);
           ready:out std_logic
);
end component;



component funcion_lineal is
    generic(nbits:natural);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x : in signed (nbits-1 downto 0);
           a : in unsigned (nbits-1 downto 0);
           b : in unsigned (nbits-1 downto 0);
           y : out unsigned (nbits-1 downto 0);
           ready:out std_logic
);
end component;
begin

--Control de multiplexores
--Si el numero es negativo, los parametros se niegan y pasan a ser su simetrico. 
--Algunos tienen antisimetria que controlo al elegir esos parametros.

negativo<=x(x'left);


--Se genera un circuito u otro dependiendo de las señales de control

cuadratica_4_tramos:
if control_lineal='0' and control_T="00" generate

funcion_cuad_4T:funcion_cuadratica
generic map(nbits => 7)
Port map(
clk=>clk,
reset=>reset,
x=>x,
y=>y_cuad_4,
a=>a2_final_4,
b=>b2_4,
c=>c2_final_4,
ready=>ready
);
--control
control_4T<=x(x'left-1) when negativo='1' else
            not(x(x'left-1));
--a2
with control_4T select
a2_4<=  a2_4_1 when '0',
        a2_4_2 when others;
        
a2_final_4<=a2_4 when negativo='1' else
    not(a2_4);        
--b2    
with control_4T select
b2_4<=  b2_4_1 when '0',
        b2_4_2 when others;
--c2        
with control_4T select
c2_4<=  c2_4_1 when '0',
        c2_4_2 when others;        
           
c2_final_4<=c2_4 when negativo='1' or c2_4="1000000" else
    not(c2_4);  
        
--resultado    
y<=y_cuad_4;
end generate;

cuadratica_8_tramos:
if control_lineal='0' and control_T="01" generate

funcion_cuad_8T:funcion_cuadratica
generic map(nbits => 9)
Port map(
clk=>clk,
reset=>reset,
x=>x,
y=>y_cuad_8,
a=>a2_final_8,
b=>b2_8,
c=>c2_final_8,
ready=>ready
);
--control
control_8T<=x(x'left-1)&x(x'left-2) when negativo='1' else
            not(x(x'left-1)&x(x'left-2));
--a2
with control_8T select       
a2_8<=  a2_8_1 when "00",
        a2_8_2 when "01",
        a2_8_3 when "10",
        a2_8_4 when others;
 
a2_final_8<=a2_8 when negativo='1' else
    not(a2_8);   
         
--b2
with control_8T select       
b2_8<=  b2_8_1 when "00",
        b2_8_2 when "01",
        b2_8_3 when "10",
        b2_8_4 when others;
              
--c2
with control_8T select       
c2_8<=  c2_8_1 when "00",
        c2_8_2 when "01",
        c2_8_3 when "10",
        c2_8_4 when others;
           
c2_final_8<=c2_8 when negativo='1' or c2_8="100000000" else
    not(c2_8);

--resultado        
y<=y_cuad_8;    
end generate;

cuadratica_16_tramos:
if control_lineal='0' and control_T="10" generate

funcion_cuad_16T:funcion_cuadratica
generic map(nbits => 12)
Port map(
clk=>clk,
reset=>reset,
x=>x,
y=>y_cuad_16,
a=>a2_final_16,
b=>b2_16,
c=>c2_final_16,
ready=>ready
);
--control
control_16T<=x(x'left-1)&x(x'left-2)&x(x'left-3) when negativo='1' else 
            not(x(x'left-1)&x(x'left-2)&x(x'left-3));
--a2        
with control_16T select
a2_16<= a2_16_1 when "000",  
        a2_16_2 when "001",  
        a2_16_3 when "010",  
        a2_16_4 when "011",  
        a2_16_5 when "100",  
        a2_16_6 when "101",  
        a2_16_7 when "110",  
        a2_16_8 when others;  

a2_final_16<=a2_16 when negativo='1' else
    not(a2_16);  
          
--b2
with control_16T select
b2_16<= b2_16_1 when "000",  
        b2_16_2 when "001",  
        b2_16_3 when "010",  
        b2_16_4 when "011",  
        b2_16_5 when "100",  
        b2_16_6 when "101",  
        b2_16_7 when "110",  
        b2_16_8 when others;  

--c2
with control_16T select
c2_16<= c2_16_1 when "000",  
        c2_16_2 when "001",  
        c2_16_3 when "010",  
        c2_16_4 when "011",  
        c2_16_5 when "100",  
        c2_16_6 when "101",  
        c2_16_7 when "110",  
        c2_16_8 when others;  
            
c2_final_16<=c2_16 when negativo='1' or c2_16="100000000000" else
    not(c2_16);

--resultado    
y<=y_cuad_16;
end generate;

lineal_4_tramos:
if control_lineal='1' and control_T="00" generate

funcion_lin_4T:funcion_lineal
generic map(nbits => 4)
Port map(
clk=>clk,
reset=>reset,
x=>x,
y=>y_lin_4,
a=>a1_4,
b=>b1_final_4,
ready=>ready

);
--control
control_4T<=x(x'left-1) when negativo='1' else
            not(x(x'left-1));
--a1
with control_4T select
a1_4<=  a1_4_1 when '0',
        a1_4_2 when others;
        
--b1
with control_4T select
b1_4<=  b1_4_1 when '0',
        b1_4_2 when others;

b1_final_4<=b1_4 when negativo='1' or b1_4="1000" else
    not(b1_4);

--resultado
y<= y_lin_4;
end generate;

lineal_8_tramos:
if control_lineal='1' and control_T="01" generate

funcion_lin_8T:funcion_lineal
generic map(nbits => 6)
Port map(
clk=>clk,
reset=>reset,
x=>x,
y=>y_lin_8,
a=>a1_8,
b=>b1_final_8,
ready=>ready
);
--control
control_8T<=x(x'left-1)&x(x'left-2) when negativo='1' else
            not(x(x'left-1)&x(x'left-2));
--a1
with control_8T select       
a1_8<=  a1_8_1 when "00",
        a1_8_2 when "01",
        a1_8_3 when "10",
        a1_8_4 when others;
        
--b1        
with control_8T select       
b1_8<=  b1_8_1 when "00",
        b1_8_2 when "01",
        b1_8_3 when "10",
        b1_8_4 when others;
           
b1_final_8<=b1_8 when negativo='1' or b1_8="100000" else
    not(b1_8);

--resultado    
y<=y_lin_8;            
end generate;

lineal_16_tramos:
if control_lineal='1' and control_T="10" generate

funcion_lin_16T:funcion_lineal
generic map(nbits => 7)
Port map(
clk=>clk,
reset=>reset,
x=>x,
y=>y_lin_16,
a=>a1_16,
b=>b1_final_16,
ready=>ready
);
--control
control_16T<=x(x'left-1)&x(x'left-2)&x(x'left-3) when negativo='1' else 
            not(x(x'left-1)&x(x'left-2)&x(x'left-3));
--a1        
with control_16T select
a1_16<= a1_16_1 when "000",  
        a1_16_2 when "001",  
        a1_16_3 when "010",  
        a1_16_4 when "011",  
        a1_16_5 when "100",  
        a1_16_6 when "101",  
        a1_16_7 when "110",  
        a1_16_8 when others;  

--b1
with control_16T select
b1_16<= b1_16_1 when "000",  
        b1_16_2 when "001",  
        b1_16_3 when "010",  
        b1_16_4 when "011",  
        b1_16_5 when "100",  
        b1_16_6 when "101",  
        b1_16_7 when "110",  
        b1_16_8 when others;  

b1_final_16<=b1_16 when negativo='1' or b1_16="1000000" else
    not(b1_16);

--resultado    
y<=y_lin_16;            

end generate;


end behavioral;
