----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2021 15:24:37
-- Design Name: 
-- Module Name: mult_8x8_tb - Behavioral
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

entity mult_8x8_tb is
end mult_8x8_tb;

architecture Behavioral of mult_8x8_tb is

component mult_8x8 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           S : out STD_LOGIC_VECTOR (15 downto 0);
           Ma: in std_logic;
           Mb: in std_logic
           );
end component;

signal A : STD_LOGIC_VECTOR (7 downto 0);
signal B : STD_LOGIC_VECTOR (7 downto 0);
signal S : STD_LOGIC_VECTOR (15 downto 0);
signal Ma: std_logic;
signal Mb: std_logic;

begin

comp:mult_8x8 port map(
A=>A,
B=>B,
S=>S,
Ma=>Ma,
Mb=>Mb
);

process
begin
A<="10000000";
B<="10000000";
Ma<='1';
Mb<='1';

wait;
end process;

end Behavioral;
