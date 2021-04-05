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

entity funcion_cuadratica_2_tb is
--  Port ( );
end funcion_cuadratica_2_tb;

architecture Behavioral of funcion_cuadratica_2_tb is
component funcion_cuadratica_2 is
    Port ( clk : in std_logic;
           reset:in std_logic;
           x : in signed (11 downto 0);
           a : in signed (11 downto 0);
           b : in unsigned (11 downto 0);
           c : in unsigned (11 downto 0);
           y : out unsigned (11 downto 0);
           control_T : in std_logic_vector(1 downto 0);
           ready: out std_logic);
end component;

signal clk : std_logic;
signal reset: std_logic;
signal x : signed (11 downto 0);
signal a : signed (11 downto 0);
signal b : unsigned (11 downto 0);
signal c : unsigned (11 downto 0);
signal y : unsigned (11 downto 0);
signal control_T : std_logic_vector(1 downto 0):="00";
signal ready: std_logic;

constant clk_period : time := 100 ns; 

begin

UUT:funcion_cuadratica_2 
port map(
clk=>clk, 
reset=>reset,
x=>x,
a=>a, 
b=>b,
c=>c,
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
    x(11 downto 8)<=(others=>'0');
    x(7 downto 0)<="00010000";
    a(11 downto 8)<=(others=>'0');
    a(7 downto 0)<="01000000";
    b(11 downto 8)<=(others=>'0');
    b(7 downto 0)<="10000000";
    c(11 downto 8)<=(others=>'0');
    c(7 downto 0)<="10000000";
 else
    x<="010000000000";
    a<="010000000000";
    b<="010000000000";   
    c<="010000000000";
end if;

 reset<='1';
 wait for 10 ns;
 reset<='0';
 wait;
end process;



end Behavioral;





