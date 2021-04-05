----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.01.2021 18:29:18
-- Design Name: 
-- Module Name: funcion_activacion_tb - Behavioral
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

entity funcion_activacion_tb is
--  Port ( );
end funcion_activacion_tb;

architecture Behavioral of funcion_activacion_tb is

component funcion_activacion is
    generic(nbits_totales:natural;
            control_lineal:std_logic;
            control_T:std_logic_vector(1 downto 0)
            );
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x : in signed (nbits_totales-1 downto 0);
           y : out unsigned (nbits_totales-1 downto 0);
           ready: out std_logic
           );
end component;

--señales de control

--control_lineal='1' -> función lineal
----control_T= "00" -> 4 tramos -> 4 bits
----control_T= "01" -> 8 tramos -> 6 bits
----control_T= "10" -> 16 tramos -> 7 bits

--control_lineal='0' -> funcion cuadrática
----control_T= "00" -> 4 tramos -> 7 bits
----control_T= "01" -> 8 tramos -> 9 bits
----control_T= "10" -> 16 tramos -> 12 bits
constant nbits:natural:=7;
constant control_lineal:std_logic:='0';
constant control_T:std_logic_vector:="00";

signal clk : std_logic;
signal reset: std_logic;
signal x : signed (nbits-1 downto 0):="1011100";
signal y : unsigned (nbits-1 downto 0);
signal ready:std_logic;
constant clk_period : time := 84 ns; 

begin

UUT:funcion_activacion 
generic map(nbits_totales=>nbits,
            control_lineal=>control_lineal,
            control_T=>control_T)
Port map(clk=>clk,
        reset =>reset,
        x =>x,
        y =>y,
        ready=>ready
);


clk_process:process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;


process
begin
 
 reset<='1';
 wait for 10 ns;
 reset<='0';
 wait for 500 ns;
 reset<='1';
 wait for 10 ns;
 reset<='0';
 wait;
end process;



end Behavioral;
