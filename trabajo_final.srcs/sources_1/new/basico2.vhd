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

----Descripción del módulo
--Modulo básico de multiplicador de 1 bit con varias señales de control
--Sin signo

----Definición de entradas/salidas
--A
--Primer operando

--B
--Segundo operando

--Si
--Tercer operando

--Ci
--Carry in

--Co
--carry out

--So
--Solución


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


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
