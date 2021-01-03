----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.12.2020 12:17:42
-- Design Name: 
-- Module Name: funcion_cuad_tb - Behavioral
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

entity funcion_cuad_tb is
--  Port ( );
end funcion_cuad_tb;

architecture Behavioral of funcion_cuad_tb is
component funcion_cuadratica is
    Port ( clk : in std_logic;
           reset:in std_logic;
           x : in signed (11 downto 0);
           a : in signed (11 downto 0);
           b : in unsigned (11 downto 0);
           c : in unsigned (11 downto 0);
           y : out unsigned (11 downto 0));
end component;


signal clk : std_logic;
signal reset: std_logic;
signal x : signed (11 downto 0);
signal a : signed (11 downto 0);
signal b : unsigned (11 downto 0);
signal c : unsigned (11 downto 0);
signal y : unsigned (11 downto 0);

constant clk_period : time := 84 ns; 

begin

UUT:funcion_cuadratica port map(
clk=>clk, 
reset=>reset,
x=>x,
a=>a, 
b=>b,
c=>c,
y=>y
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
 x<="001000000000";
 a<="101110000110";
 b<="100001010100";
 c<="100000000000";

 reset<='1';
 wait for 100 ns;
 reset<='0';
 wait;
end process;



end Behavioral;





