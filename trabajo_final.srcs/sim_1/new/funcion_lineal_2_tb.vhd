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

entity funcion_lineal_2_tb is
--  Port ( );
end funcion_lineal_2_tb;

architecture Behavioral of funcion_lineal_2_tb is

component funcion_lineal_2 is
    Port ( clk : in std_logic;
           reset:in std_logic;
           x : in signed (11 downto 0);
           a : in unsigned (11 downto 0);
           b : in unsigned (11 downto 0);
           y : out unsigned (11 downto 0);
           control_T : in std_logic_vector(1 downto 0);
           ready : out std_logic);

end component;

signal clk : std_logic;
signal reset: std_logic;
signal control_T:std_logic_vector(1 downto 0):="01";
signal ready:std_logic;
signal x : signed (11 downto 0);
signal a : unsigned (11 downto 0);
signal b : unsigned (11 downto 0);
signal y : unsigned (11 downto 0);

constant clk_period : time := 100 ns; 

begin

UUT:funcion_lineal_2
port map(
clk=>clk, 
reset=>reset,
x=>x,
a=>a, 
b=>b,
y=>y,
control_T=>control_T,
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
if control_T="00" then
    x(11 downto 4)<=(others=>'0');
    x(3 downto 0)<="1100";
    a(11 downto 4)<=(others=>'0');
    a(3 downto 0)<="0011";
    b(11 downto 4)<=(others=>'0');
    b(3 downto 0)<="0010";
 else
    x(11 downto 8)<=(others=>'0');
    x(7 downto 0)<="10100100";
    a(11 downto 8)<=(others=>'0');
    a(7 downto 0)<="01010100";
    b(11 downto 8)<=(others=>'0');
    b(7 downto 0)<="00101100";   

end if;
 reset<='1';
 wait for 10 ns;
 reset<='0';
 wait;
end process;



end Behavioral;
