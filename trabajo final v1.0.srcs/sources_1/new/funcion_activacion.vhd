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
           y : out unsigned (11 downto 0));
end funcion_activacion;

architecture Behavioral of funcion_activacion is

constant a1_1:signed:="0000001001";
constant a1_2:signed:="0011110110";
constant a1_3:signed:="0011110110";
constant a1_4:signed:="0000001001";

constant a2_1:signed:="0000010010";
constant a2_2:signed:="0100000000";
constant a2_3:signed:="0011110110";
constant a2_4:signed:="0100000000";


signal a2 :signed(11 downto 0);
signal b2,c2 :unsigned(11 downto 0);

signal a1,b1 :unsigned(11 downto 0);


signal control_4T:std_logic_vector(1 downto 0);
signal control_8T:std_logic_vector(2 downto 0);
signal control_16T:std_logic_vector(3 downto 0);

signal control_T:std_logic_vector(1 downto 0);

signal control_lineal:std_logic;








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
           a : in unsigned (11 downto 0);
           b : in unsigned (11 downto 0);
           y : out unsigned (11 downto 0));
end component;
begin

control_4T<=not(x(11))&x(10);
control_8T<=not(x(11))&x(10)&x(9);
control_16T<=not(x(11))&x(10)&x(9)&x(8);


funcion_cuad:funcion_cuadratica
Port map(
clk=>clk,
reset=>reset,
x=>x,
y=>y,
a=>a2,
b=>b2,
c=>c2
);

funcion_lin:funcion_lineal
Port map(
clk=>clk,
reset=>reset,
x=>x,
y=>y,
a=>a1,
b=>b1
);




end Behavioral;
