----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2021 14:20:27
-- Design Name: 
-- Module Name: mult_4x4_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mult_4x4_tb is
--  Port ( );
end mult_4x4_tb;

architecture Behavioral of mult_4x4_tb is
component mult_4x4 is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           Ma: in std_logic;
           Mb: in std_logic
           );
end component;

signal A : STD_LOGIC_VECTOR (3 downto 0);
signal B : STD_LOGIC_VECTOR (3 downto 0);
signal S : STD_LOGIC_VECTOR (7 downto 0);
signal Ma: std_logic;
signal Mb: std_logic;


begin

comp:mult_4x4 port map(
A=>A,
B=>B,
S=>S,
Ma=>Ma,
Mb=>Mb
);

process
begin
A<="1011";
B<="0100";
Ma<='1';
Mb<='1';

wait;
end process;

end Behavioral;

