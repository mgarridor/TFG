----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2021 20:59:46
-- Design Name: 
-- Module Name: funcion_activacion_2_tb - Behavioral
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

entity funcion_activacion_2_tb is
--  Port ( );
end funcion_activacion_2_tb;

architecture Behavioral of funcion_activacion_2_tb is

component funcion_activacion_2 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x : in signed (11 downto 0);
           y : out unsigned (11 downto 0);
           ready:out std_logic;
           control_lineal: in std_logic;
           control_T: in std_logic
           );
end component;

--señales de control

--control_lineal='1' -> función lineal
----control_T= "0" -> 4 tramos -> 4 bits
----control_T= "1" -> 16 tramos -> 8 bits

--control_lineal='0' -> funcion cuadrática
----control_T= "0" -> 4 tramos -> 8 bits
----control_T= "1" -> 16 tramos -> 12 bits

signal clk : std_logic;
signal reset: std_logic;
signal x : signed (11 downto 0);
signal y : unsigned (11 downto 0);
signal ready:std_logic;
signal control_lineal:std_logic:='0';
signal control_T:std_logic:='0';

constant clk_period : time := 100 ns; 

begin

UUT:funcion_activacion_2
Port map(clk=>clk,
        reset =>reset,
        x =>x,
        y =>y,
        control_lineal=>control_lineal,
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
    if control_lineal='1' then
        if control_T='0' then
            x(11 downto 4)<=(others=>'0');
            x(3 downto 0)<="1011"; --x=2
        else
            x(11 downto 8)<=(others=>'0');
            x(7 downto 0)<="10111000"; --x=2
        end if;
    
    else
        if control_T='0' then
            x(11 downto 8)<=(others=>'0');
            x(7 downto 0)<="10010000"; --x=2
        else
            x<="100100000000"; --x=2
        end if;
    end if; 
    reset<='1';
    wait for 10 ns;
    -- reset<='0';
    -- wait for 500 ns;
    -- reset<='1';
    -- wait for 10 ns;
    reset<='0';
    wait;
end process;

end Behavioral;
