----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.02.2021 12:40:11
-- Design Name: 
-- Module Name: FAB_tb - Behavioral
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

entity FAB_tb is
end FAB_tb;

architecture Behavioral of FAB_tb is

component FAB is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           left : in STD_LOGIC_VECTOR (6 downto 0);
           bottomL : in STD_LOGIC;
           bottom : in STD_LOGIC_VECTOR (3 downto 0);
           bottom4 : out STD_LOGIC;
           right : out STD_LOGIC_VECTOR (6 downto 0);
           sum : out STD_LOGIC_VECTOR (4 downto 0);
           top : out STD_LOGIC_VECTOR (3 downto 0);
           top4 : in STD_LOGIC;
           topR : out STD_LOGIC;
           Cl : in STD_LOGIC;
           Cr : in STD_LOGIC;
           Ct : in STD_LOGIC;
           Cb : in STD_LOGIC;
           Ma : in STD_LOGIC;
           Mb : in STD_LOGIC);
end component;

signal A : STD_LOGIC_VECTOR (3 downto 0);
signal B : STD_LOGIC_VECTOR (3 downto 0);
signal left : STD_LOGIC_VECTOR (6 downto 0);
signal bottomL : STD_LOGIC;
signal bottom : STD_LOGIC_VECTOR (3 downto 0);
signal bottom4 : STD_LOGIC;
signal right : STD_LOGIC_VECTOR (6 downto 0);
signal sum : STD_LOGIC_VECTOR (4 downto 0);
signal top : STD_LOGIC_VECTOR (3 downto 0);
signal top4 : STD_LOGIC;
signal topR : STD_LOGIC;
signal Cl :STD_LOGIC;
signal Cr : STD_LOGIC;
signal Ct : STD_LOGIC;
signal Cb : STD_LOGIC;
signal Ma : STD_LOGIC;
signal Mb : STD_LOGIC;

signal solucion:std_logic_vector(7 downto 0);

begin

comp: FAB 
port map(
    A=>A,
    B=>B,
    left=>left,
    bottomL=>bottomL,
    bottom=>bottom,
    bottom4=>bottom4,
    right=>right,
    sum=>sum,
    top=>top,
    top4=>top4,
    topR=>topR,
    Cl=>Cl,
    Cr=>Cr,
    Ct=>Ct,
    Cb=>Cb,
    Ma=>Ma,
    Mb=>Mb
);
process
begin
--entradas
    A<="1110";
    B<="1001";
    
    left<=(others=>'0');
    bottomL<='0';
    bottom<=(others=>'0');
    top4<='0';

--control
    Cl<='0';
    Cr<='0';
    Ct<='0';
    Cb<='0';
    Ma<='1';
    Mb<='1';

--solucion
    solucion<= sum& top(2 downto 0);

wait;
end process;
end Behavioral;
