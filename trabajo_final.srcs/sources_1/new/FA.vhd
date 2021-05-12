----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.02.2021 10:47:38
-- Design Name: 
-- Module Name: FA - Behavioral
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

----Descripción del módulo
--Full adder 

----Definición de entradas/salidas
--A
--Primer operando

--B
--Segundo operando

--S 
--Solución

--Ci
--Carry in

--Co
--carry out

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Ci : in STD_LOGIC;
           S : out STD_LOGIC;
           Co : out STD_LOGIC);
end FA;

architecture Behavioral of FA is

  signal temp1 : std_logic;
  signal temp2 : std_logic;
  signal temp3 : std_logic;
   
begin
 
  temp1 <= A xor B;
  temp2 <= temp1 and Ci;
  temp3 <= A and B;
 
  S<= temp1 xor Ci;
  Co <= temp2 or temp3;

end Behavioral;
