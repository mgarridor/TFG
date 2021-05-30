----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.03.2021 12:55:14
-- Design Name: 
-- Module Name: test_mult - Behavioral
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

entity test_mult is
    Port ( A : in signed (11 downto 0);
           B : in signed (11 downto 0);
           S : out signed (23 downto 0);
           clk : in std_logic);
end test_mult;

architecture Behavioral of test_mult is
signal S_reg,S_next : signed (23 downto 0);
begin
process(clk)
begin
    if (rising_edge(clk))then
    
        S_reg<=S_next;
        
        
    end if;
end process;

process(A,B)
begin 
S_next<=A*B;
end process;

S<=S_reg;
end Behavioral;
