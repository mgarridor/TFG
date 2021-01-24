----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 17:05:33
-- Design Name: 
-- Module Name: funcion_lineal - Behavioral
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

entity funcion_lineal is
    generic (nbits:natural);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x : in signed (11 downto 0);
           a : in unsigned (nbits-1 downto 0);
           b : in unsigned (nbits-1 downto 0);
           y : out unsigned (nbits-1 downto 0);
           ready:out std_logic);
end funcion_lineal;

--entity funcion_lineal is
--    Port ( clk : in STD_LOGIC;
--           reset : in STD_LOGIC;
--           x : in signed (11 downto 0);
--           a : in unsigned (8 downto 0);
--           b : in unsigned (8 downto 0);
--           y : out unsigned (11 downto 0));
--end funcion_lineal;

architecture Behavioral of funcion_lineal is

signal r1_reg,r1_next: signed(nbits+12 downto 0);
--signal r1_reg,r1_next: signed(19 downto 0);

signal y_temp:signed(nbits downto 0);
signal control:std_logic;
begin

process(clk,reset)
begin
    if(reset = '1')then
        r1_reg<= (others=>'0');
        control<='0';
    elsif(rising_edge(clk))then
        r1_reg<=r1_next;
        control<=not(control);
    end if;
end process;

process(control,r1_reg,a,b,x)
begin

--x*a
r1_next<=signed('0'& a)*x;
--b+ x*a
y_temp<= signed('0'& b) + signed((r1_reg(nbits+12)&std_logic_vector(r1_reg(nbits+9 downto 10))));

end process;

y<=unsigned(y_temp(nbits-1 downto 0));
    
ready<=control;
end Behavioral;
