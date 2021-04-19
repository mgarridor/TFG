----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2021 18:40:00
-- Design Name: 
-- Module Name: control_neurona - Behavioral
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

entity control_neurona is
    Port ( control_lineal : in STD_LOGIC;
           control_tramos : in STD_LOGIC;
           x_in : in STD_LOGIC_VECTOR (11 downto 0);
           sending_data:in STD_LOGIC;
           x1: out signed (11 downto 0); 
           x2: out signed (11 downto 0); 
           control_mult : out std_logic_vector(1 downto 0);
           mult_ready : in STD_LOGIC;
           sum_ready : out STD_LOGIC);
end control_neurona;

architecture Behavioral of control_neurona is


begin


end Behavioral;
