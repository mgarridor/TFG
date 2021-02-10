----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2021 14:07:08
-- Design Name: 
-- Module Name: mult_8x8 - Behavioral
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

entity mult_8x8 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           S : out STD_LOGIC_VECTOR (15 downto 0);
           Ma: in std_logic;
           Mb: in std_logic
           );
end mult_8x8;

architecture Behavioral of mult_8x8 is

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

signal conn11_12:std_logic_vector(6 downto 0);
signal conn11_21:std_logic_vector(3 downto 0);
signal conn11_21_2:std_logic;
signal conn12_22:std_logic_vector(3 downto 0);
signal conn12_22_2:std_logic;
signal conn21_12:std_logic;
signal conn21_22:std_logic_vector(6 downto 0);

signal aux1:std_logic_vector(3 downto 0);
signal aux2:std_logic_vector(4 downto 0);

begin

comp11: FAB
port map(
    A=>A(3 downto 0),
    B=>B(3 downto 0),
    left=>(others=>'0'),
    bottomL=>'0',
    bottom=>conn11_21,
    bottom4=>conn11_21_2,
    right=>conn11_12,
    sum=>open,
    top=>S(3 downto 0),--solucion
    top4=>'0',
    topR=>open,
    Cl=>'0',
    Cr=>'1',
    Ct=>'0',
    Cb=>'1',
    Ma=>'0',
    Mb=>'0'
);
comp12: FAB 
port map(
    A=>A(7 downto 4),
    B=>B(3 downto 0),
    left=>conn11_12,
    bottomL=>conn21_12,
    bottom=>conn12_22,
    bottom4=>conn12_22_2,
    right=>open,
    sum=>S(11 downto 7),--solucion
    top=>aux1,--solucion
    top4=>'0',
    topR=>open,
    Cl=>'1',
    Cr=>'0',
    Ct=>'0',
    Cb=>'1',
    Ma=>Ma,
    Mb=>'0'
);

comp21: FAB 
port map(
    A=>A(3 downto 0),
    B=>B(7 downto 4),
    left=>(others=>'0'),
    bottomL=>'0',
    bottom=>(others=>'0'),
    bottom4=>open,
    right=>conn21_22,
    sum=>open,
    top=>conn11_21,
    top4=>conn11_21_2,
    topR=>conn21_12,
    Cl=>'0',
    Cr=>'1',
    Ct=>'1',
    Cb=>'0',
    Ma=>'0',
    Mb=>Mb
);

comp22: FAB 
port map(
    A=>A(7 downto 4),
    B=>B(7 downto 4),
    left=>conn21_22,
    bottomL=>'0',
    bottom=>(others=>'0'),
    bottom4=>open,
    right=>open,
    sum=>aux2,--solucion
    top=>conn12_22,
    top4=>conn12_22_2,
    topR=>open,
    Cl=>'1',
    Cr=>'0',
    Ct=>'1',
    Cb=>'0',
    Ma=>Ma,
    Mb=>Mb
);

S(6 downto 4)<=aux1(2 downto 0);
S(15 downto 12)<=aux2(4 downto 1);

end Behavioral;
