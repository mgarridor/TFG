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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
           x : in signed (11 downto 0);
           y : out unsigned (nbits_totales-1 downto 0)
           );
end component;

signal clk : std_logic;
signal reset: std_logic;
signal x : signed (11 downto 0);
signal y : unsigned (11 downto 0);
constant clk_period : time := 84 ns; 

begin

UUT:funcion_activacion 
generic map(nbits_totales=>12,
            control_lineal=>'0',
            control_T=>"10")
Port map(clk=>clk,
        reset =>reset,
        x =>x,
        y =>y
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

 x<="001100000000";
 
 reset<='1';
 wait for 10 ns;
 reset<='0';
 wait;
end process;



end Behavioral;
