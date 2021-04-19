----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Matias Garrido Recalde
-- 
-- Create Date: 04.12.2020 14:13:13
-- Design Name: 
-- Module Name: funcion_activacion_2 - Behavioral
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
----control_T= "0" -> 4 tramos -> 4 bits
----control_T= "1" -> 16 tramos -> 8 bits

--control_lineal='0' -> funcion cuadrática
----control_T= "0" -> 4 tramos -> 8 bits
----control_T= "1" -> 16 tramos -> 12 bits

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity funcion_activacion_2 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x : in signed (11 downto 0);
           y : out unsigned (11 downto 0);
           ready:out std_logic;
           control_lineal: in std_logic:='0';
           control_T: in std_logic:='0'
           );
end funcion_activacion_2;

architecture Behavioral of funcion_activacion_2 is

--notacion: paramx_tramos_indice

--4 tramos
constant a1_4_1:unsigned:="000000000000";
constant a1_4_2:unsigned:="000000001001";

constant b1_4_1:unsigned:="000000000000";
constant b1_4_2:unsigned:="000000001000";

constant a2_4_1:signed:="000000000011";
constant a2_4_2:signed:="000001000111";

constant b2_4_1:unsigned:="000000001100";
constant b2_4_2:unsigned:="000010000101";

constant c2_4_1:unsigned:="000000010110";
constant c2_4_2:unsigned:="000010000000";

--16 tramos
constant a1_16_1:unsigned:="000000000000"; 
constant a1_16_2:unsigned:="000000000001"; 
constant a1_16_3:unsigned:="000000000100"; 
constant a1_16_4:unsigned:="000000001011"; 
constant a1_16_5:unsigned:="000000011110"; 
constant a1_16_6:unsigned:="000001001001"; 
constant a1_16_7:unsigned:="000010011001"; 
constant a1_16_8:unsigned:="000011101100";

constant b1_16_1:unsigned:="000000000001"; 
constant b1_16_2:unsigned:="000000000011"; 
constant b1_16_3:unsigned:="000000000111"; 
constant b1_16_4:unsigned:="000000010000"; 
constant b1_16_5:unsigned:="000000100010"; 
constant b1_16_6:unsigned:="000001000011"; 
constant b1_16_7:unsigned:="000001101011"; 
constant b1_16_8:unsigned:="000010000000"; 

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
signal a1_4:unsigned(11 downto 0);
signal a1_16:unsigned(11 downto 0);

signal b1_4:unsigned(11 downto 0);
signal b1_16:unsigned(11 downto 0);

signal a2_4:signed(11 downto 0);
signal a2_16:signed(11 downto 0);

signal b2_4:unsigned(11 downto 0);
signal b2_16:unsigned(11 downto 0);

signal c2_4:unsigned(11 downto 0);
signal c2_16:unsigned(11 downto 0);


signal b1_final_4:unsigned(11 downto 0);
signal c2_final_4:unsigned(11 downto 0);
signal a2_final_4:signed(11 downto 0);

signal b1_final_16:unsigned(11 downto 0);
signal c2_final_16:unsigned(11 downto 0);
signal a2_final_16:signed(11 downto 0);

--señales de control
signal negativo:std_logic;
signal control_4T:std_logic;
signal control_16T:std_logic_vector(2 downto 0);
signal primerBit:natural:=11;

--señales finales
signal y_lin,y_lin_4,y_lin_16:unsigned (11 downto 0);
signal y_cuad,y_cuad_4,y_cuad_16:unsigned (11 downto 0);

signal a1_final,b1_final,b2_final,c2_final: unsigned (11 downto 0);
signal a2_final : signed (11 downto 0);

signal readyLin,readyCuad:std_logic;



component funcion_cuadratica_2 is
    Port ( clk : in std_logic;
           reset:in std_logic;
           x : in signed (11 downto 0);
           a : in signed (11 downto 0);
           b : in unsigned (11 downto 0);
           c : in unsigned (11 downto 0);
           y : out unsigned (11 downto 0);
           control_T : in std_logic;
           ready: out std_logic);
end component;



component funcion_lineal_2 is
    Port ( clk : in std_logic;
           reset:in std_logic;
           x : in signed (11 downto 0);
           a : in unsigned (11 downto 0);
           b : in unsigned (11 downto 0);
           y : out unsigned (11 downto 0);
           control_T : in std_logic;
           ready: out std_logic);
end component;
begin

--Control de multiplexores
--Si el numero es negativo, los parametros se niegan y pasan a ser su simetrico. 
--Algunos tienen antisimetria que controlo al elegir esos parametros.
primerBit<=3 when control_T='0' and control_lineal='1' else
           11 when control_T='1' and control_lineal='0' else
           7;
negativo<=x(primerBit);
control_4T<=x(primerBit-1) when negativo='1' else
            not(x(primerBit-1));   

control_16T<=x(10)&x(9)&x(8) when (negativo='1' and control_lineal='0' and control_T='1') else 
             not(x(10)&x(9)&x(8))when (negativo='0' and control_lineal='0' and control_T='1') else 
             x(6)&x(5)&x(4) when (negativo='1' and ((control_lineal='1' and control_T='1')or (control_lineal='0' and control_T='0'))) else 
             not(x(6)&x(5)&x(4))when (negativo='0' and ((control_lineal='1' and control_T='1')or (control_lineal='0' and control_T='0'))) else
             (others=>'0');


funcion_lineal:funcion_lineal_2
Port map(
    clk=>clk,
    reset=>reset,
    x=>x,
    y=>y_lin,
    a=>a1_final,
    b=>b1_final,
    control_T=>control_T,
    ready=>readyLin
);

funcion_cuadratica:funcion_cuadratica_2
Port map(
    clk=>clk,
    reset=>reset,
    x=>x,
    y=>y_cuad,
    a=>a2_final,
    b=>b2_final,
    c=>c2_final,
    control_T=>control_T,
    ready=>readyCuad
);

--eleccion de parametros en funcion de las señales de control
--a2
with control_4T select
a2_4<=  a2_4_1 when '0',
        a2_4_2 when others;
        
a2_final_4<=a2_4 when negativo='1' else
    not(a2_4);        
    
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
    
a2_final<=a2_final_4 when control_T='0' else
            a2_final_16;
    
--b2    
with control_4T select
b2_4<=  b2_4_1 when '0',
        b2_4_2 when others;
        
with control_16T select
b2_16<= b2_16_1 when "000",  
        b2_16_2 when "001",  
        b2_16_3 when "010",  
        b2_16_4 when "011",  
        b2_16_5 when "100",  
        b2_16_6 when "101",  
        b2_16_7 when "110",  
        b2_16_8 when others;  

b2_final<=b2_4 when control_T='0' else
            b2_16;        
--c2        
with control_4T select
c2_4<=  c2_4_1 when '0',
        c2_4_2 when others;        
           
c2_final_4<=c2_4 when negativo='1' or c2_4="000010000000" else
    not(c2_4);  
    
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

c2_final<=c2_final_4 when control_T='0' else
            c2_final_16;   
--a1
with control_4T select
a1_4<=  a1_4_1 when '0',
        a1_4_2 when others;

     
with control_16T select
a1_16<= a1_16_1 when "000",  
        a1_16_2 when "001",  
        a1_16_3 when "010",  
        a1_16_4 when "011",  
        a1_16_5 when "100",  
        a1_16_6 when "101",  
        a1_16_7 when "110",  
        a1_16_8 when others;  
        
        
a1_final<=a1_4 when control_T='0' else
            a1_16;
--b1

with control_4T select
b1_4<=  b1_4_1 when '0',
        b1_4_2 when others;

b1_final_4<=b1_4 when negativo='1' or b1_4="000000001000" else
    not(b1_4);
    
    
with control_16T select
b1_16<= b1_16_1 when "000",  
        b1_16_2 when "001",  
        b1_16_3 when "010",  
        b1_16_4 when "011",  
        b1_16_5 when "100",  
        b1_16_6 when "101",  
        b1_16_7 when "110",  
        b1_16_8 when others;  

b1_final_16<=b1_16 when negativo='1' or b1_16="000010000000" else
    not(b1_16);
    
b1_final<=b1_final_4 when control_T='0' else
            b1_final_16;

--soluciones
y<=y_lin when control_lineal='1' else
    y_cuad;
    

ready<=readyLin when control_lineal='1' else
    readyCuad;

end behavioral;
