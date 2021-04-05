----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 17:05:33
-- Design Name: 
-- Module Name: funcion_lineal - Behavioral
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

entity funcion_lineal is
    generic (nbits:natural);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x : in signed (nbits-1 downto 0);
           a : in unsigned (nbits-1 downto 0);
           b : in unsigned (nbits-1 downto 0);
           y : out unsigned (nbits-1 downto 0);
           ready:out std_logic);
end funcion_lineal;

architecture Behavioral of funcion_lineal is

signal r1_reg,r1_next: signed(nbits+nbits downto 0);

signal y_temp:signed(nbits downto 0);
signal control:std_logic;

signal primer_ciclo:std_logic:='1';
signal sumA:std_logic_vector(nbits downto 0);
begin

process(clk,reset)
begin
    if(reset = '1')then
        r1_reg<= (others=>'0');
        control<='0';
    elsif(rising_edge(clk))then
        r1_reg<=r1_next;
        control<=not(control);
    end if;
end process;


process(control,r1_reg,a,b,x)
begin

--x*a
r1_next<=signed('0'& a)*x;
--b + (x*a)

y_temp<= signed('0'& b) + signed(sumA);

--control para que la señal ready no se active en el primer ciclo
if control='0' and reset='0' then
    primer_ciclo<='0';
elsif reset='1' then 
    primer_ciclo<='1';
end if;

end process;

sumA<=std_logic_vector(r1_reg(r1_reg'left)&std_logic_vector(r1_reg(r1_reg'left-3 downto nbits-2)));

--convierto y a unsigned
y<=unsigned(y_temp(nbits-1 downto 0));

--ready se activa en una vez cada 2 ciclos cuando control sea 0    
ready<=not(control) when primer_ciclo='0' else
        '0';
end Behavioral;
