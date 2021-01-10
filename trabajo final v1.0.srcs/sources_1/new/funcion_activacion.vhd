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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_signed.all;


entity funcion_activacion is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x : in signed (11 downto 0);
           y : out unsigned (11 downto 0);
           control_lineal:in std_logic
           );
end funcion_activacion;

architecture Behavioral of funcion_activacion is

--notacion paramx_tramos_indice

--4 tramos
constant a1_4_1:unsigned:="000001001";
constant a1_4_2:unsigned:="011110110";

constant b1_4_1:unsigned:="000010010";
constant b1_4_2:unsigned:="100000000";

constant a2_4_1:signed:="000000110110";
constant a2_4_2:signed:="010001111001";

constant b2_4_1:unsigned:="000011001000";
constant b2_4_2:unsigned:="100001010100";

constant c2_4_1:unsigned:="000101101101";
constant c2_4_2:unsigned:="100000000000";


--8 tramos
constant a1_8_1:unsigned:="000000010";
constant a1_8_2:unsigned:="000001111";
constant a1_8_3:unsigned:="001100111";
constant a1_8_4:unsigned:="110000101";

constant b1_8_1:unsigned:="000000100";
constant b1_8_2:unsigned:="000011001";
constant b1_8_3:unsigned:="001110000";
constant b1_8_4:unsigned:="100000000";

constant a2_8_1:signed:="000000010000";
constant a2_8_2:signed:="000001110011";
constant a2_8_3:signed:="001010110101";
constant a2_8_4:signed:="010100110100";

constant b2_8_1:unsigned:="000001000001";
constant b2_8_2:unsigned:="000101100001";
constant b2_8_3:unsigned:="010110101111";
constant b2_8_4:unsigned:="100010110001";

constant c2_8_1:unsigned:="000010000101";
constant c2_8_2:unsigned:="001000100100";
constant c2_8_3:unsigned:="011000111100";
constant c2_8_4:unsigned:="100000000000";

--16 tramos
constant a1_16_1:unsigned:="000000001";
constant a1_16_2:unsigned:="000000011";
constant a1_16_3:unsigned:="000001000";
constant a1_16_4:unsigned:="000010111";
constant a1_16_5:unsigned:="000111100";
constant a1_16_6:unsigned:="010010010";
constant a1_16_7:unsigned:="100110010";
constant a1_16_8:unsigned:="111011001";

constant b1_16_1:unsigned:="000000010";
constant b1_16_2:unsigned:="000000110";
constant b1_16_3:unsigned:="000001110";
constant b1_16_4:unsigned:="000100000";
constant b1_16_5:unsigned:="001000101";
constant b1_16_6:unsigned:="010000110";
constant b1_16_7:unsigned:="011010110";
constant b1_16_8:unsigned:="100000000";

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


signal a1_4:unsigned(8 downto 0);
signal a1_8:unsigned(8 downto 0);
signal a1_16:unsigned(8 downto 0);

signal b1_4:unsigned(8 downto 0);
signal b1_8:unsigned(8 downto 0);
signal b1_16:unsigned(8 downto 0);

signal a2_4:signed(11 downto 0);
signal a2_8:signed(11 downto 0);
signal a2_16:signed(11 downto 0);

signal b2_4:unsigned(11 downto 0);
signal b2_8:unsigned(11 downto 0);
signal b2_16:unsigned(11 downto 0);

signal c2_4:unsigned(11 downto 0);
signal c2_8:unsigned(11 downto 0);
signal c2_16:unsigned(11 downto 0);


signal a1,b1 :unsigned(8 downto 0);

signal a2 :signed(11 downto 0);
signal b2,c2 :unsigned(11 downto 0);

signal negativo:std_logic;
signal control_4T:std_logic;
signal control_8T:std_logic_vector(1 downto 0);
signal control_16T:std_logic_vector(2 downto 0);

signal control_T:std_logic_vector(1 downto 0);

signal y_lin:unsigned (11 downto 0);
signal y_cuad:unsigned (11 downto 0);

component funcion_cuadratica 
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x : in signed (11 downto 0);
           a : in signed (11 downto 0);
           b : in unsigned (11 downto 0);
           c : in unsigned (11 downto 0);
           y : out unsigned (11 downto 0));
end component;


component funcion_lineal is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x : in signed (11 downto 0);
           a : in unsigned (8 downto 0);
           b : in unsigned (8 downto 0);
           y : out unsigned (11 downto 0));
end component;
begin


funcion_cuad:funcion_cuadratica
Port map(
clk=>clk,
reset=>reset,
x=>x,
y=>y_cuad,
a=>a2,
b=>b2,
c=>c2
);

funcion_lin:funcion_lineal
Port map(
clk=>clk,
reset=>reset,
x=>x,
y=>y_lin,
a=>a1,
b=>b1
);

--Si el numero es negativo, si los parametros se niegan pasan a ser su simetrico. 
--Algunos tienen antisimetria que controlare mas adelante.
process (clk)
begin
negativo<=x(11);
if(negativo='0') then
  control_4T<=x(10) ;
  control_8T<=x(10)&x(9);
  control_16T<=x(10)&x(9)&x(8);
  else
  control_4T<=not(x(10)) ;
  control_8T<=not(x(10)&x(9));
  control_16T<=not(x(10)&x(9)&x(8));
  
end if;
end process;

--lo mismo, distinta manera?
--control_4T<=x(10) when negativo='0' else
--            not(x(10));
--control_8T<=x(10)&x(9) when negativo='0' else
--            not(x(10)&x(9));
--control_16T<=x(10)&x(9)&x(8) when negativo='0' else 
--            not(x(10)&x(9)&x(8));
--multiplexores para la eleccion de parametros

--control 1 fase (
process (clk)
begin
--control a1
case control_4T is 
    when '0'=>a1_4<=a1_4_1;
    when others=>a1_4<=a1_4_2;
end case;

case control_8T is 
    when "00"=>a1_8<=a1_8_1;
    when "01"=>a1_8<=a1_8_2;
    when "10"=>a1_8<=a1_8_3;
    when others=>a1_8<=a1_8_4;
end case;

case control_16T is 
    when "000"=>a1_16<=a1_16_1;
    when "001"=>a1_16<=a1_16_2;
    when "010"=>a1_16<=a1_16_3;
    when "011"=>a1_16<=a1_16_4;
    when "100"=>a1_16<=a1_16_5;
    when "101"=>a1_16<=a1_16_6;
    when "110"=>a1_16<=a1_16_6;
    when others=>a1_16<=a1_16_8;
end case;

--control b1
case control_4T is 
    when '0'=>b1_4<=b1_4_1;
    when others=>b1_4<=b1_4_2;
end case;

case control_8T is 
    when "00"=>b1_8<=b1_8_1;
    when "01"=>b1_8<=b1_8_2;
    when "10"=>b1_8<=b1_8_3;
    when others=>b1_8<=b1_8_4;
end case;

case control_16T is 
    when "000"=>b1_16<=b1_16_1;
    when "001"=>b1_16<=b1_16_2;
    when "010"=>b1_16<=b1_16_3;
    when "011"=>b1_16<=b1_16_4;
    when "100"=>b1_16<=b1_16_5;
    when "101"=>b1_16<=b1_16_6;
    when "110"=>b1_16<=b1_16_6;
    when others=>b1_16<=b1_16_8;
end case;

--control a2
case control_4T is 
    when '0'=>a2_4<=a2_4_1;
    when others=>a2_4<=a2_4_2;
end case;

case control_8T is 
    when "00"=>a2_8<=a2_8_1;
    when "01"=>a2_8<=a2_8_2;
    when "10"=>a2_8<=a2_8_3;
    when others=>a2_8<=a2_8_4;
end case;

case control_16T is 
    when "000"=>a2_16<=a2_16_1;
    when "001"=>a2_16<=a2_16_2;
    when "010"=>a2_16<=a2_16_3;
    when "011"=>a2_16<=a2_16_4;
    when "100"=>a2_16<=a2_16_5;
    when "101"=>a2_16<=a2_16_6;
    when "110"=>a2_16<=a2_16_6;
    when others=>a2_16<=a2_16_8;
end case;

--control b2
case control_4T is 
    when '0'=>b2_4<=b2_4_1;
    when others=>b2_4<=b2_4_2;
end case;

case control_8T is 
    when "00"=>b2_8<=b2_8_1;
    when "01"=>b2_8<=b2_8_2;
    when "10"=>b2_8<=b2_8_3;
    when others=>b2_8<=b2_8_4;
end case;

case control_16T is 
    when "000"=>b2_16<=b2_16_1;
    when "001"=>b2_16<=b2_16_2;
    when "010"=>b2_16<=b2_16_3;
    when "011"=>b2_16<=b2_16_4;
    when "100"=>b2_16<=b2_16_5;
    when "101"=>b2_16<=b2_16_6;
    when "110"=>b2_16<=b2_16_6;
    when others=>b2_16<=b2_16_8;
end case;

--control c2
case control_4T is 
    when '0'=>c2_4<=c2_4_1;
    when others=>c2_4<=c2_4_2;
end case;

case control_8T is 
    when "00"=>c2_8<=c2_8_1;
    when "01"=>c2_8<=c2_8_2;
    when "10"=>c2_8<=c2_8_3;
    when others=>c2_8<=c2_8_4;
end case;

case control_16T is 
    when "000"=>c2_16<=c2_16_1;
    when "001"=>c2_16<=c2_16_2;
    when "010"=>c2_16<=c2_16_3;
    when "011"=>c2_16<=c2_16_4;
    when "100"=>c2_16<=c2_16_5;
    when "101"=>c2_16<=c2_16_6;
    when "110"=>c2_16<=c2_16_6;
    when others=>c2_16<=c2_16_8;
end case;
end process;

--control 2 fase
process(clk)
begin

--control de a1
case control_T is
    when "00"=>
            a1<=a1_4;
    when "01"=>
            a1<=a1_8;
    when "10"=>
            a1<=a1_16;
    when others=> a1<=(others=>'0');  
end case;


--control b1
case control_T is
    when "00"=>
            b1<=b1_4;
    when "01"=>
            b1<=b1_8;
    when "10"=>
            b1<=b1_16;
    when others=> b1<=(others=>'0');  
end case;


--control a2
case control_T is
    when "00"=>
            a2<=a2_4;
    when "01"=>
            a2<=a2_8;
    when "10"=>
            a2<=a2_16;
    when others=> a2<=(others=>'0');  
end case;

--control b2
case control_T is
    when "00"=>
            b2<=b2_4;
    when "01"=>
            b2<=b2_8;
    when "10"=>
            b2<=b2_16;
    when others=> b2<=(others=>'0');  
end case;

--control c2
case control_T is
    when "00"=>
            c2<=c2_4;
    when "01"=>
            c2<=c2_8;
    when "10"=>
            c2<=c2_16;
    when others=> c2<=(others=>'0');  
end case;

end process;


--control de numeros negativos para los antisimetricos 
process (clk)
begin
if negativo='1' then
    b1<=not(b1);
    a2<=not(a2);
    c2<=not(c2);
end if;
end process;
--la salida sera la lineal o la cuadratica, dependiendo del control lineal
y<= y_lin when control_lineal='1' else
    y_cuad;


end Behavioral;






--case control_T is
--    when "00"=>
--        if control_4T = '0' then
--            b1<=b1_4_1;
--        else 
--            b1<=b1_4_2;
--        end if;
--    when "01"=>
--        if control_8T ="00" then
--            b1<=b1_8_1;
--        elsif control_8T="01" then
--            b1<=b1_8_2;
--        elsif control_8T="10" then
--            b1<=b1_8_3;
--        elsif control_8T="11" then
--            b1<=b1_8_4;                
--        end if;

--    when "10"=>
--        if control_16T ="000" then
--            b1<=b1_16_1;
--        elsif control_16T="001" then
--            b1<=b1_16_2;
--        elsif control_16T="010" then
--            b1<=b1_16_3;
--        elsif control_16T="011" then
--            b1<=b1_16_4;    
--        elsif control_16T="100" then
--            b1<=b1_16_5;
--        elsif control_16T="101" then
--            b1<=b1_16_6;
--        elsif control_16T="110" then
--            b1<=b1_16_7;  
--        elsif control_16T="111" then
--            b1<=b1_16_8;             
--        end if;
    
--    when others=> b1<=(others=>'0');  
--end case;