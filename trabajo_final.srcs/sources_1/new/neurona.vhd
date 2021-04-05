----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2021 21:12:18
-- Design Name: 
-- Module Name: neurona - Behavioral
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

entity neurona is
    Port ( x : in STD_LOGIC_VECTOR (11 downto 0);
           y : out STD_LOGIC_VECTOR (11 downto 0);
           lineal : in STD_LOGIC;
           control_tramos : in STD_LOGIC);
end neurona;

architecture Behavioral of neurona is

begin


end Behavioral;
