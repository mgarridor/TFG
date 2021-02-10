----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.02.2021 14:34:10
-- Design Name: 
-- Module Name: FA_tb - Behavioral
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

entity FA_tb is
--  Port ( );
end FA_tb;

architecture Behavioral of FA_tb is
component FA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Ci : in STD_LOGIC;
           S : out STD_LOGIC;
           Co : out STD_LOGIC);
end component;
signal A :STD_LOGIC;
signal B :STD_LOGIC;
signal Ci :STD_LOGIC;
signal S : STD_LOGIC;
signal Co : STD_LOGIC;

begin

full_adder:FA port map(
A=>A,
B=>B,
Ci=>Ci,
S=>S,
Co=>Co
);

process
begin
A<='0';
B<='0';
Ci<='0';
wait for 100 ns;

A<='0';
B<='1';
Ci<='0';
wait for 100 ns;

A<='1';
B<='0';
Ci<='0';
wait for 100 ns;

A<='0';
B<='0';
Ci<='1';
wait for 100 ns;

A<='1';
B<='0';
Ci<='1';
wait for 100 ns;

A<='1';
B<='1';
Ci<='1';
wait for 100 ns;
end process;
end Behavioral;
