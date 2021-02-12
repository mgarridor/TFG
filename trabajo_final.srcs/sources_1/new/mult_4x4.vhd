----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2021 14:02:47
-- Design Name: 
-- Module Name: mult_4x4 - Behavioral
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

entity mult_4x4 is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           Ma: in std_logic;
           Mb: in std_logic
           );
end mult_4x4;

architecture Behavioral of mult_4x4 is

component FAB_mini is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
           B : in STD_LOGIC_VECTOR (1 downto 0);
           left : in STD_LOGIC_VECTOR (2 downto 0);
           bottomL : in STD_LOGIC;
           bottom : in STD_LOGIC_VECTOR (1 downto 0);
           bottom4 : out STD_LOGIC;
           right : out STD_LOGIC_VECTOR (2 downto 0);
           sum : out STD_LOGIC_VECTOR (2 downto 0);
           top : out STD_LOGIC_VECTOR (1 downto 0);
           top4 : in STD_LOGIC;
           topR : out STD_LOGIC;
           Cl : in STD_LOGIC;
           Cr : in STD_LOGIC;
           Ct : in STD_LOGIC;
           Cb : in STD_LOGIC;
           Ma : in STD_LOGIC;
           Mb : in STD_LOGIC);
end component;

signal conn11_12:std_logic_vector(2 downto 0);
signal conn11_21:std_logic_vector(1 downto 0);
signal conn11_21_2:std_logic;
signal conn12_22:std_logic_vector(1 downto 0);
signal conn12_22_2:std_logic;
signal conn21_12:std_logic;
signal conn21_22:std_logic_vector(2 downto 0);

signal aux1:std_logic_vector(1 downto 0);
signal aux2:std_logic_vector(2 downto 0);
signal aux3:std_logic_vector(1 downto 0);


begin

comp11: FAB_mini
port map(
    A=>A(1 downto 0),
    B=>B(1 downto 0),
    left=>(others=>'0'),
    bottomL=>'0',
    bottom=>conn11_21,
    bottom4=>conn11_21_2,
    right=>conn11_12,
    sum=>open,
    top=>S(1 downto 0),--solucion
    top4=>'0',
    topR=>open,
    Cl=>'0',
    Cr=>'1',
    Ct=>'0',
    Cb=>'1',
    Ma=>'0',
    Mb=>'0'
);
comp12: FAB_mini
port map(
    A=>A(3 downto 2),
    B=>B(1 downto 0),
    left=>conn11_12,
    bottomL=>conn21_12,
    bottom=>conn12_22,
    bottom4=>conn12_22_2,
    right=>open,
    sum=>S(5 downto 3),--solucion
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

comp21: FAB_mini
port map(
    A=>A(1 downto 0),
    B=>B(3 downto 2),
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

comp22: FAB_mini
port map(
    A=>A(3 downto 2),
    B=>B(3 downto 2),
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

--S(0)<=aux3(0);
S(2)<=aux1(0);
S(7 downto 6)<=aux2(2 downto 1);

end Behavioral;
