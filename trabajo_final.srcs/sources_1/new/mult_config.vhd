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
    generic(control : STD_LOGIC_VECTOR (1 downto 0);
            size : natural);
    
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           S : out STD_LOGIC_VECTOR (63 downto 0);
           Ma : in std_logic;
           Mb : in std_logic
           );
end mult_config;

architecture Behavioral of mult_config is




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

--señales horizontales
signal conn11_12:std_logic_vector(2 downto 0);
signal conn21_22:std_logic_vector(2 downto 0);
signal conn12_13:std_logic_vector(2 downto 0);
signal conn31_32:std_logic_vector(2 downto 0);
signal conn22_23:std_logic_vector(2 downto 0);
signal conn32_33:std_logic_vector(2 downto 0);
signal conn13_14:std_logic_vector(2 downto 0);
signal conn23_24:std_logic_vector(2 downto 0);
signal conn33_34:std_logic_vector(2 downto 0);
signal conn41_42:std_logic_vector(2 downto 0);
signal conn42_43:std_logic_vector(2 downto 0);
signal conn43_44:std_logic_vector(2 downto 0);

--señales verticales
signal conn11_21:std_logic_vector(1 downto 0);
signal conn11_21_2:std_logic;
signal conn12_22:std_logic_vector(1 downto 0);
signal conn12_22_2:std_logic;
signal conn21_31:std_logic_vector(1 downto 0);
signal conn21_31_2:std_logic;
signal conn22_32:std_logic_vector(1 downto 0);
signal conn22_32_2:std_logic;
signal conn13_23:std_logic_vector(1 downto 0);
signal conn13_23_2:std_logic;
signal conn23_33:std_logic_vector(1 downto 0);
signal conn23_33_2:std_logic;
signal conn14_24:std_logic_vector(1 downto 0);
signal conn14_24_2:std_logic;
signal conn24_34:std_logic_vector(1 downto 0);
signal conn24_34_2:std_logic;
signal conn31_41:std_logic_vector(1 downto 0);
signal conn31_41_2:std_logic;
signal conn32_42:std_logic_vector(1 downto 0);
signal conn32_42_2:std_logic;
signal conn33_43:std_logic_vector(1 downto 0);
signal conn33_43_2:std_logic;
signal conn34_44:std_logic_vector(1 downto 0);
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

signal A11:std_logic_vector(1 downto 0);
signal A12:std_logic_vector(1 downto 0);
signal A13:std_logic_vector(1 downto 0);
signal A14:std_logic_vector(1 downto 0);
signal A21:std_logic_vector(1 downto 0);
signal A22:std_logic_vector(1 downto 0);
signal A23:std_logic_vector(1 downto 0);
signal A24:std_logic_vector(1 downto 0);
signal A31:std_logic_vector(1 downto 0);
signal A32:std_logic_vector(1 downto 0);
signal A33:std_logic_vector(1 downto 0);
signal A34:std_logic_vector(1 downto 0);
signal A41:std_logic_vector(1 downto 0);
signal A42:std_logic_vector(1 downto 0);
signal A43:std_logic_vector(1 downto 0);
signal A44:std_logic_vector(1 downto 0);

signal B11:std_logic_vector(1 downto 0);
signal B12:std_logic_vector(1 downto 0);
signal B13:std_logic_vector(1 downto 0);
signal B14:std_logic_vector(1 downto 0);
signal B21:std_logic_vector(1 downto 0);
signal B22:std_logic_vector(1 downto 0);
signal B23:std_logic_vector(1 downto 0);
signal B24:std_logic_vector(1 downto 0);
signal B31:std_logic_vector(1 downto 0);
signal B32:std_logic_vector(1 downto 0);
signal B33:std_logic_vector(1 downto 0);
signal B34:std_logic_vector(1 downto 0);
signal B41:std_logic_vector(1 downto 0);
signal B42:std_logic_vector(1 downto 0);
signal B43:std_logic_vector(1 downto 0);
signal B44:std_logic_vector(1 downto 0);

signal sum11:std_logic_vector(2 downto 0);
signal sum12:std_logic_vector(2 downto 0);
signal sum13:std_logic_vector(2 downto 0);
signal sum14:std_logic_vector(2 downto 0);
signal sum21:std_logic_vector(2 downto 0);
signal sum22:std_logic_vector(2 downto 0);
signal sum23:std_logic_vector(2 downto 0);
signal sum24:std_logic_vector(2 downto 0);
signal sum31:std_logic_vector(2 downto 0);
signal sum32:std_logic_vector(2 downto 0);
signal sum33:std_logic_vector(2 downto 0);
signal sum34:std_logic_vector(2 downto 0);
signal sum41:std_logic_vector(2 downto 0);
signal sum42:std_logic_vector(2 downto 0);
signal sum43:std_logic_vector(2 downto 0);
signal sum44:std_logic_vector(2 downto 0);

signal top11:std_logic_vector(1 downto 0);
signal top12:std_logic_vector(1 downto 0);
signal top13:std_logic_vector(1 downto 0);
signal top14:std_logic_vector(1 downto 0);
signal top21:std_logic_vector(1 downto 0);
signal top22:std_logic_vector(1 downto 0);
signal top23:std_logic_vector(1 downto 0);
signal top24:std_logic_vector(1 downto 0);
signal top31:std_logic_vector(1 downto 0);
signal top32:std_logic_vector(1 downto 0);
signal top33:std_logic_vector(1 downto 0);
signal top34:std_logic_vector(1 downto 0);
signal top41:std_logic_vector(1 downto 0);
signal top42:std_logic_vector(1 downto 0);
signal top43:std_logic_vector(1 downto 0);
signal top44:std_logic_vector(1 downto 0);


begin

--primera columna
comp11: FAB_mini
port map(
    A=>A11,
    B=>B11,
    left=>(others=>'0'),
    bottomL=>'0',
    bottom=>conn11_21,
    bottom4=>conn11_21_2,
    right=>conn11_12,
    sum=>sum11,
    top=>top11,
    top4=>'0',
    topR=>open,
    Cl=>'0',
    Cr=>'1',
    Ct=>'0',
    Cb=>'1',
    Ma=>'0',
    Mb=>'0'
);
no completo
solo C y M
comp21: FAB_mini
port map(
    A=>A21,
    B=>B21,
    left=>(others=>'0'),
    bottomL=>'0',
    bottom=>conn21_31,
    bottom4=>conn21_31_2,
    right=>conn21_22,
    sum=>sum21,
    top=>top21,
    top4=>conn11_21_2,
    topR=>conn21_12,
    Cl=>'0',
    Cr=>'1',
    Ct=>'1',
    Cb=>'0',
    Ma=>'0',
    Mb=>Mb
);
no completo
solo C y M

comp31: FAB_mini 
port map(
    A=>A31,
    B=>B31,
    left=>(others=>'0'),
    bottomL=>'0',
    bottom=>conn31_41,
    bottom4=>conn31_41_2,
    right=>conn31_32,
    sum=>sum31,
    top=>top31,
    top4=>conn21_31_2,
    topR=>conn31_22,
    Cl=>'0',
    Cr=>'1',
    Ct=>'1',
    Cb=>'0',
    Ma=>'0',
    Mb=>Mb
);
no completo
solo C y M

comp41: FAB_mini 
port map(
    A=>A41,
    B=>B41,
    left=>(others=>'0'),
    bottomL=>'0',
    bottom=>(others=>'0'),
    bottom4=>open,
    right=>conn41_42,
    sum=>open,
    top=>conn31_41,
    top4=>conn31_41_2,
    topR=>conn41_32,
    Cl=>'0',
    Cr=>'1',
    Ct=>'1',
    Cb=>'0',
    Ma=>'0',
    Mb=>Mb
);
no completo
solo C y M

--segunda columna

comp12: FAB_mini 
port map(
    A=>A12,
    B=>B12,
    left=>conn11_12,
    bottomL=>conn21_12,
    bottom=>conn12_22,
    bottom4=>conn12_22_2,
    right=>conn12_13,
    sum=>sum12,
    top=>top12,
    top4=>'0',
    topR=>open,
    Cl=>'1',
    Cr=>'0',
    Ct=>'0',
    Cb=>'1',
    Ma=>Ma,
    Mb=>'0'
);
no completo
solo C y M

comp22: FAB_mini 
port map(
    A=>A22,
    B=>B22,
    left=>conn21_22,
    bottomL=>conn31_22,
    bottom=>conn22_32,
    bottom4=>conn22_32_2,
    right=>conn22_23,
    sum=>sum22,
    top=>conn12_22,
    top4=>conn12_22_2,
    topR=>conn22_13,
    Cl=>'1',
    Cr=>'0',
    Ct=>'1',
    Cb=>'0',
    Ma=>Ma,
    Mb=>Mb
);
no completo
solo C y M

comp32: FAB_mini 
port map(
    A=>A32,
    B=>B32,
    left=>conn31_32,
    bottomL=>conn41_32,
    bottom=>conn32_42,
    bottom4=>conn32_42_2,
    right=>conn32_33,
    sum=>sum32,
    top=>top32,
    top4=>conn22_32_2,
    topR=>conn32_23,
    Cl=>'1',
    Cr=>'0',
    Ct=>'0',
    Cb=>'1',
    Ma=>Ma,
    Mb=>'0'
);
no completo
solo C y M

comp42: FAB_mini 
port map(
    A=>A42,
    B=>B42,
    left=>conn41_42,
    bottomL=>'0',
    bottom=>(others=>'0'),
    bottom4=>open,
    right=>conn42_43,
    sum=>sum42,
    top=>top42,
    top4=>conn32_42_2,
    topR=>conn42_33,
    Cl=>'1',
    Cr=>'0',
    Ct=>'1',
    Cb=>'0',
    Ma=>Ma,
    Mb=>Mb
);
no completo
solo C y M

--tercera columna

comp13: FAB_mini
port map(
    A=>A13,
    B=>B13,
    left=>conn12_13,
    bottomL=>conn22_13,
    bottom=>conn13_23,
    bottom4=>conn13_23_2,
    right=>conn13_14,
    sum=>sum13,
    top=>top13,
    top4=>'0',
    topR=>open,
    Cl=>'0',
    Cr=>'1',
    Ct=>'0',
    Cb=>'1',
    Ma=>'0',
    Mb=>'0'
);
no completo
solo C y M

comp23: FAB_mini
port map(
    A=>A23,
    B=>B23,
    left=>conn22_23,
    bottomL=>conn32_23,
    bottom=>conn23_33,
    bottom4=>conn23_33_2,
    right=>conn23_24,
    sum=>sum23,
    top=>top23,
    top4=>conn13_23_2,
    topR=>conn23_14,
    Cl=>'0',
    Cr=>'1',
    Ct=>'0',
    Cb=>'1',
    Ma=>'0',
    Mb=>'0'
);
no completo
solo C y M

comp33: FAB_mini
port map(
    A=>A33,
    B=>B33,
    left=>conn32_33,
    bottomL=>conn42_33,
    bottom=>conn33_43,
    bottom4=>conn33_43_2,
    right=>conn33_34,
    sum=>sum33,
    top=>top33,
    top4=>conn23_33_2,
    topR=>conn33_24,
    Cl=>'0',
    Cr=>'1',
    Ct=>'0',
    Cb=>'1',
    Ma=>'0',
    Mb=>'0'
);
no completo
solo C y M

comp43: FAB_mini
port map(
    A=>A43,
    B=>B43,
    left=>conn42_43,
    bottomL=>'0',
    bottom=>(others=>'0'),
    bottom4=>open,
    right=>conn43_44,
    sum=>sum43,
    top=>top43,
    top4=>conn33_43_2,
    topR=>conn43_34,
    Cl=>'0',
    Cr=>'1',
    Ct=>'0',
    Cb=>'1',
    Ma=>'0',
    Mb=>'0'
);
no completo
solo C y M
--cuarta columna

comp14: FAB_mini 
port map(
    A=>A14,
    B=>B14,
    left=>conn13_14,
    bottomL=>conn23_14,
    bottom=>conn14_24,
    bottom4=>conn14_24_2,
    right=>open,
    sum=>sum14,
    top=>top14,
    top4=>'0',
    topR=>open,
    Cl=>'1',
    Cr=>'0',
    Ct=>'0',
    Cb=>'1',
    Ma=>Ma,
    Mb=>'0'
);
no completo
solo C y M

comp24: FAB_mini 
port map(
    A=>A24,
    B=>B24,
    left=>conn23_24,
    bottomL=>conn33_24,
    bottom=>conn24_34,
    bottom4=>conn24_34_2,
    right=>open,
    sum=>sum24,
    top=>top24,
    top4=>conn14_24_2,
    topR=>open,
    Cl=>'1',
    Cr=>'0',
    Ct=>'0',
    Cb=>'1',
    Ma=>Ma,
    Mb=>'0'
);
no completo
solo C y M

comp34: FAB_mini 
port map(
    A=>A34,
    B=>B34,
    left=>conn33_34,
    bottomL=>conn43_34,
    bottom=>conn34_44,
    bottom4=>conn34_44_2,
    right=>open,
    sum=>sum34,
    top=>top34,
    top4=>conn24_34_2,
    topR=>open,
    Cl=>'1',
    Cr=>'0',
    Ct=>'0',
    Cb=>'1',
    Ma=>Ma,
    Mb=>'0'
);
no completo
solo C y M

comp44: FAB_mini 
port map(
    A=>A44,
    B=>B44,
    left=>conn43_44,
    bottomL=>'0',
    bottom=>(others=>'0'),
    bottom4=>open,
    right=>open,
    sum=>sum44,
    top=>top44,
    top4=>conn34_44_2,
    topR=>open,
    Cl=>'1',
    Cr=>'0',
    Ct=>'0',
    Cb=>'1',
    Ma=>Ma,
    Mb=>'0'
);
no completo;
solo C y M;


--control
--  si 00 => 1 multiplicador 8x8
--  si 01 => 4 multiplicadores 4x4
--``si 10 => 16 multiplicadores 2x2

--control
--  si 00 => 1 multiplicador 16x16
--  si 01 => 4 multiplicadores 8x8
--``si 10 => 16 multiplicadores 4x4
--  si 11 => 64 multiplicadores 2x2

process(A,B,Ma,Mb)
begin
if control="00" then
        
    A11<=A(1 downto 0);
    B11<=B(1 downto 0);
    A12<=A(3 downto 2);
    B12<=B(1 downto 0);
    A13<=A(5 downto 4);
    B13<=B(1 downto 0);
    A14<=A(7 downto 6);
    B14<=B(1 downto 0);
    
    A21<=A(1 downto 0);
    B21<=B(3 downto 2);
    A22<=A(3 downto 2);
    B22<=B(3 downto 2);
    A23<=A(5 downto 4);
    B23<=B(3 downto 2);
    A24<=A(7 downto 6);
    B24<=B(3 downto 2);
    
    A31<=A(1 downto 0);
    B31<=B(5 downto 4);
    A32<=A(3 downto 2);
    B32<=B(5 downto 4);
    A33<=A(5 downto 4);
    B33<=B(5 downto 4);
    A34<=A(7 downto 6);
    B34<=B(5 downto 4);
    
    A41<=A(1 downto 0);
    B41<=B(7 downto 6);
    A42<=A(3 downto 2);
    B42<=B(7 downto 6);
    A43<=A(5 downto 4);
    B43<=B(7 downto 6);
    A44<=A(7 downto 6);
    B44<=B(7 downto 6);
    
    S(1 downto 0)<=top11;
    S(3 downto 2)<=top12;
    S(5 downto 4)<=top13;
    S(6)<=top14(0);
    
    S(9 downto 7)<=sum14;
    S(11 downto 10)<=sum24(2 downto 1);
    S(13 downto 12)<=sum34(2 downto 1);
    S(15 downto 14)<=sum44(2 downto 1);
    
elsif control="01" then
    
A11<=A(1 downto 0);
B11<=B(1 downto 0);
A12<=A(3 downto 2);
B12<=B(1 downto 0);
A13<=A(5 downto 4);
B13<=B(5 downto 4);
A14<=A(7 downto 6);
B14<=B(5 downto 4);

A21<=A(1 downto 0);
B21<=B(3 downto 2);
A22<=A(3 downto 2);
B22<=B(3 downto 2);
A23<=A(5 downto 4);
B23<=B(7 downto 6);
A24<=A(7 downto 6);
B24<=B(7 downto 6);

A31<=A(9 downto 8);
B31<=B(9 downto 8);
A32<=A(11 downto 10);
B32<=B(9 downto 8);
A33<=A(13 downto 12);
B33<=B(13 downto 12);
A34<=A(15 downto 14);
B34<=B(13 downto 12);

A41<=A(9 downto 8);
B41<=B(11 downto 10);
A42<=A(11 downto 10);
B42<=B(11 downto 10);
A43<=A(13 downto 12);
B43<=B(15 downto 14);
A44<=A(15 downto 14);
B44<=B(15 downto 14);

--resultados 1 multiplicacion
S(1 downto 0)<=top11;
S(2)<=top12(0);
S(5 downto 3)<=sum12;
S(7 downto 6)<=sum22(2 downto 1);

--resultados 2 multiplicacion
S(9 downto 8)<=top13;
S(10)<=top14(0);
S(13 downto 11)<=sum14;
S(15 downto 14)<=sum24(2 downto 1);

--resultados 3 multiplicacion
S(17 downto 16)<=top31;
S(18)<=top32(0);
S(21 downto 19)<=sum32;
S(23 downto 22)<=sum34(2 downto 1);

--resultados 4 multiplicacion
S(25 downto 24)<=top33;
S(26)<=top34(0);
S(29 downto 27)<=sum42;
S(31 downto 30)<=sum44(2 downto 1);

elsif (control="10") then
    
A11<=A(1 downto 0);
B11<=B(1 downto 0);
A12<=A(3 downto 2);
B12<=B(3 downto 2);
A13<=A(5 downto 4);
B13<=B(5 downto 4);
A14<=A(7 downto 6);
B14<=B(7 downto 6);

A21<=A(9 downto 8);
B21<=B(9 downto 8);
A22<=A(11 downto 10);
B22<=B(11 downto 10);
A23<=A(13 downto 12);
B23<=B(13 downto 12);
A24<=A(15 downto 14);
B24<=B(15 downto 14);

A31<=A(17 downto 16);
B31<=B(17 downto 16);
A32<=A(19 downto 18);
B32<=B(19 downto 18);
A33<=A(21 downto 20);
B33<=B(21 downto 20);
A34<=A(23 downto 22);
B34<=B(23 downto 22);

A41<=A(25 downto 24);
B41<=B(25 downto 24);
A42<=A(27 downto 26);
B42<=B(27 downto 26);
A43<=A(29 downto 28);
B43<=B(29 downto 28);
A44<=A(31 downto 30);
B44<=B(31 downto 30);


--resultados 1 multiplicacion
S(0)<=top11(0);
S(3 downto 1)<=sum11;

--resultados 2 multiplicacion
S(4)<=top12(0);
S(7 downto 5)<=sum12;

--resultados 3 multiplicacion
S(8)<=top13(0);
S(11 downto 9)<=sum13;

--resultados 4 multiplicacion
S(12)<=top14(0);
S(15 downto 13)<=sum14;

--resultados 5 multiplicacion
S(16)<=top21(0);
S(19 downto 17)<=sum21;

--resultados 6 multiplicacion
S(20)<=top22(0);
S(23 downto 21)<=sum22;

--resultados 7 multiplicacion
S(24)<=top23(0);
S(27 downto 25)<=sum23;

--resultados 8 multiplicacion
S(28)<=top24(0);
S(31 downto 29)<=sum24;

--resultados 9 multiplicacion
S(32)<=top31(0);
S(35 downto 33)<=sum31;

--resultados 10 multiplicacion
S(36)<=top32(0);
S(39 downto 37)<=sum32;

--resultados 11 multiplicacion
S(40)<=top33(0);
S(43 downto 41)<=sum33;

--resultados 12 multiplicacion
S(44)<=top34(0);
S(47 downto 45)<=sum34;

--resultados 13 multiplicacion
S(48)<=top41(0);
S(51 downto 49)<=sum41;

--resultados 14 multiplicacion
S(52)<=top42(0);
S(55 downto 53)<=sum42;

--resultados 15 multiplicacion
S(56)<=top43(0);
S(59 downto 57)<=sum43;

--resultados 16 multiplicacion
S(60)<=top44(0);
S(63 downto 61)<=sum44;

end if;
end process;



--control Cb,Cl,Ct,Cr











end Behavioral;
