----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.01.2021 20:40:59
-- Design Name: 
-- Module Name: funcion_lineal_tb - Behavioral
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

entity funcion_lineal_tb is
--  Port ( );
end funcion_lineal_tb;

architecture Behavioral of funcion_lineal_tb is

component funcion_lineal is
    generic(nbits:natural);
    Port ( clk : in std_logic;
           reset:in std_logic;
           x : in signed (nbits-1 downto 0);
           a : in unsigned (nbits-1 downto 0);
           b : in unsigned (nbits-1 downto 0);
           y : out unsigned (nbits-1 downto 0);
           ready : out std_logic);
end component;

constant num_bits:natural:=8;
signal clk : std_logic;
signal reset: std_logic;
signal x : signed (num_bits-1 downto 0);
signal a : unsigned (num_bits-1 downto 0);
signal b : unsigned (num_bits-1 downto 0);
signal y : unsigned (num_bits-1 downto 0);
signal ready:std_logic;

constant clk_period : time := 84 ns; 

begin

UUT:funcion_lineal 
generic map(nbits=>num_bits)
port map(
clk=>clk, 
reset=>reset,
x=>x,
a=>a, 
b=>b,
y=>y,
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
 x<="10100100";
 a<="01010100";
 b<="00101100";

 reset<='1';
 wait for 10 ns;
 reset<='0';
 wait;
end process;



end Behavioral;
