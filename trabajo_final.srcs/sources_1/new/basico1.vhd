----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.02.2021 21:15:47
-- Design Name: 
-- Module Name: basico1 - Behavioral
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

entity basico1 is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Si : in STD_LOGIC;
           Ci : in STD_LOGIC;
           So : out STD_LOGIC;
           Co : out STD_LOGIC);
end basico1;

architecture Behavioral of basico1 is

component FA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Ci : in STD_LOGIC;
           S : out STD_LOGIC;
           Co : out STD_LOGIC);
end component;
signal temp:std_logic;
begin

UUT: FA 
Port map(
    A =>temp,
    B =>Si,
    Ci =>Ci,
    S =>So,
    Co =>Co
   );
       
temp<=A and B;   
end Behavioral;
