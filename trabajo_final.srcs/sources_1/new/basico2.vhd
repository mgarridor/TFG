----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.02.2021 10:37:13
-- Design Name: 
-- Module Name: basico2 - Behavioral
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

entity basico2 is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           I : in STD_LOGIC;
           Si : in STD_LOGIC;
           Ci : in STD_LOGIC;
           So : out STD_LOGIC;
           Co : out STD_LOGIC);
end basico2;

architecture Behavioral of basico2 is

component FA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Ci : in STD_LOGIC;
           S : out STD_LOGIC;
           Co : out STD_LOGIC);
end component;
signal temp1:std_logic;
signal temp2:std_logic;

begin

UUT: FA 
Port map(
    A =>temp2,
    B =>Si,
    Ci =>Ci,
    S =>So,
    Co =>Co
   );
       
temp1<=B xor I; 
temp2<=temp1 and A; 
end Behavioral;
