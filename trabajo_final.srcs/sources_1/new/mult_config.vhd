----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2021 12:39:13
-- Design Name: 
-- Module Name: mult_config - Behavioral
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

entity mult_config is
    generic(control : STD_LOGIC_VECTOR (1 downto 0));
    Port ( A16 : in STD_LOGIC_VECTOR (15 downto 0);
           B16 : in STD_LOGIC_VECTOR (15 downto 0);
           A8_1 : in STD_LOGIC_VECTOR (7 downto 0);
           B8_1 : in STD_LOGIC_VECTOR (7 downto 0);
           A8_2 : in STD_LOGIC_VECTOR (7 downto 0);
           B8_2 : in STD_LOGIC_VECTOR (7 downto 0);
           A4_1 : in STD_LOGIC_VECTOR (3 downto 0);
           B4_1 : in STD_LOGIC_VECTOR (3 downto 0);
           A4_2 : in STD_LOGIC_VECTOR (3 downto 0);
           B4_2 : in STD_LOGIC_VECTOR (3 downto 0);
           A4_3 : in STD_LOGIC_VECTOR (3 downto 0);
           B4_3 : in STD_LOGIC_VECTOR (3 downto 0);
           A4_4 : in STD_LOGIC_VECTOR (3 downto 0);
           B4_4 : in STD_LOGIC_VECTOR (3 downto 0);
           S16 : out STD_LOGIC_VECTOR (31 downto 0);
           S8_1 : out STD_LOGIC_VECTOR (15 downto 0);
           S8_2 : out STD_LOGIC_VECTOR (15 downto 0);
           S4_1 : out STD_LOGIC_VECTOR (7 downto 0);
           S4_2 : out STD_LOGIC_VECTOR (7 downto 0);
           S4_3 : out STD_LOGIC_VECTOR (7 downto 0);
           S4_4 : out STD_LOGIC_VECTOR (7 downto 0);
           Ma : in std_logic;
           Mb : in std_logic
           );
end mult_config;

architecture Behavioral of mult_config is


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

--señales horizontales
signal conn11_12:std_logic_vector(6 downto 0);
signal conn21_22:std_logic_vector(6 downto 0);
signal conn12_13:std_logic_vector(6 downto 0);
signal conn31_32:std_logic_vector(6 downto 0);
signal conn22_23:std_logic_vector(6 downto 0);
signal conn32_33:std_logic_vector(6 downto 0);
signal conn13_14:std_logic_vector(6 downto 0);
signal conn23_24:std_logic_vector(6 downto 0);
signal conn33_34:std_logic_vector(6 downto 0);
signal conn41_42:std_logic_vector(6 downto 0);
signal conn42_43:std_logic_vector(6 downto 0);
signal conn43_44:std_logic_vector(6 downto 0);

--señales verticales
signal conn11_21:std_logic_vector(3 downto 0);
signal conn11_21_2:std_logic;
signal conn12_22:std_logic_vector(3 downto 0);
signal conn12_22_2:std_logic;
signal conn21_31:std_logic_vector(3 downto 0);
signal conn21_31_2:std_logic;
signal conn22_32:std_logic_vector(3 downto 0);
signal conn22_32_2:std_logic;
signal conn13_23:std_logic_vector(3 downto 0);
signal conn13_23_2:std_logic;
signal conn23_33:std_logic_vector(3 downto 0);
signal conn23_33_2:std_logic;
signal conn14_24:std_logic_vector(3 downto 0);
signal conn14_24_2:std_logic;
signal conn24_34:std_logic_vector(3 downto 0);
signal conn24_34_2:std_logic;
signal conn31_41:std_logic_vector(3 downto 0);
signal conn31_41_2:std_logic;
signal conn32_42:std_logic_vector(3 downto 0);
signal conn32_42_2:std_logic;
signal conn33_43:std_logic_vector(3 downto 0);
signal conn33_43_2:std_logic;
signal conn34_44:std_logic_vector(3 downto 0);
signal conn34_44_2:std_logic;

--señales oblicuas
signal conn21_12:std_logic;
signal conn31_22:std_logic;
signal conn22_13:std_logic;
signal conn23_14:std_logic;
signal conn32_23:std_logic;
signal conn41_32:std_logic;
signal conn33_24:std_logic;
signal conn42_33:std_logic;
signal conn43_34:std_logic;


signal aux1:std_logic_vector(3 downto 0);
signal aux2:std_logic_vector(4 downto 0);



begin


comp11: FAB
port map(
    A=>A8_1(3 downto 0),
    B=>B8_1(3 downto 0),
    left=>(others=>'0'),
    bottomL=>'0',
    bottom=>conn11_21,
    bottom4=>conn11_21_2,
    right=>conn11_12,
    sum=>open,
    top=>S8_1(3 downto 0),--solucion
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
    A=>A8_1(7 downto 4),
    B=>B8_1(3 downto 0),
    left=>conn11_12,
    bottomL=>conn21_12,
    bottom=>conn12_22,
    bottom4=>conn12_22_2,
    right=>open,
    sum=>S8_1(11 downto 7),--solucion
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
    A=>A8_1(3 downto 0),
    B=>B8_1(7 downto 4),
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
    A=>A8_1(7 downto 4),
    B=>B8_1(7 downto 4),
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

end Behavioral;
