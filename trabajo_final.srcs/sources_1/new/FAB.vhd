----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.02.2021 21:32:34
-- Design Name: 
-- Module Name: FAB - Behavioral
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

entity FAB is
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
end FAB;

architecture Behavioral of FAB is

component basico1 is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Si : in STD_LOGIC;
           Ci : in STD_LOGIC;
           So : out STD_LOGIC;
           Co : out STD_LOGIC);
end component;

component basico2 is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           I : in STD_LOGIC;
           Si : in STD_LOGIC;
           Ci : in STD_LOGIC;
           So : out STD_LOGIC;
           Co : out STD_LOGIC);
end component;

--señales 
signal temp1:std_logic_vector(6 downto 0);
signal temp2:std_logic;
signal temp3:std_logic_vector(2 downto 0);
signal temp4,temp5,temp6,temp7,temp8,temp9:std_logic;
signal temp10:std_logic;
signal temp11:std_logic_vector(6 downto 0);

signal sumTemp:unsigned(5 downto 0);
signal control1:std_logic;

signal Afinal,Bfinal:std_logic_vector(4 downto 0);

--señales entre basicos
signal conn00_10:std_logic;
signal conn01_11:std_logic;
signal conn02_12:std_logic;
signal conn03_13:std_logic;
signal conn01_10:std_logic;
signal conn02_11:std_logic;
signal conn03_12:std_logic;

signal conn10_20:std_logic;
signal conn11_21:std_logic;
signal conn12_22:std_logic;
signal conn13_23:std_logic;
signal conn11_20:std_logic;
signal conn12_21:std_logic;
signal conn13_22:std_logic;

signal conn20_30:std_logic;
signal conn21_31:std_logic;
signal conn22_32:std_logic;
signal conn21_30:std_logic;
signal conn22_31:std_logic;
signal conn23_32:std_logic;


begin

--nomenclatura:
 --   basico + indice(A) + indice(B)

--primera columna
basico00: basico1 Port map(
    A=>A(0),
    B=>B(0),
    Si=>temp1(0),
    Ci=>temp1(4),
    So=>top(0),
    Co=>conn00_10
);

basico01: basico1 Port map(
    A=>A(0),
    B=>B(1),
    Si=>temp1(1),
    Ci=>temp1(5),
    So=>conn01_10,
    Co=>conn01_11
);

basico02: basico1 Port map(
    A=>A(0),
    B=>B(2),
    Si=>temp1(2),
    Ci=>temp1(6),
    So=>conn02_11,
    Co=>conn02_12
);

basico03: basico2 Port map(
    A=>B(3),
    B=>A(0),
    I=>Mb,
    Si=>temp1(3),
    Ci=>temp2,
    So=>conn03_12,
    Co=>conn03_13
);

--segunda columna
basico10: basico1 Port map(
    A=>A(1),
    B=>B(0),
    Si=>conn00_10,
    Ci=>conn01_10,
    So=>top(1),
    Co=>conn10_20
);

basico11: basico1 Port map(
    A=>A(1),
    B=>B(1),
    Si=>conn01_11,
    Ci=>conn02_11,
    So=>conn11_20,
    Co=>conn11_21
);

basico12: basico1 Port map(
    A=>A(1),
    B=>B(2),
    Si=>conn02_12,
    Ci=>conn03_12,
    So=>conn12_21,
    Co=>conn12_22
);

basico13: basico2 Port map(
    A=>B(3),
    B=>A(1),
    I=>Mb,
    Si=>conn03_13,
    Ci=>temp3(0),
    So=>conn13_22,
    Co=>conn13_23
);

--tercera columna
basico20: basico1 Port map(
    A=>A(2),
    B=>B(0),
    Si=>conn10_20,
    Ci=>conn11_20,
    So=>top(2),
    Co=>conn20_30
);

basico21: basico1 Port map(
    A=>A(2),
    B=>B(1),
    Si=>conn11_21,
    Ci=>conn12_21,
    So=>conn21_30,
    Co=>conn21_31
);

basico22: basico1 Port map(
    A=>A(2),
    B=>B(2),
    Si=>conn12_22,
    Ci=>conn13_22,
    So=>conn22_31,
    Co=>conn22_32
);

basico23: basico2 Port map(
    A=>B(3),
    B=>A(2),
    I=>Mb,
    Si=>conn13_23,
    Ci=>temp3(1),
    So=>conn23_32,
    Co=>temp4
);

--cuarta columna
basico30: basico2 Port map(
    A=>A(3),
    B=>B(0),
    I=>Ma,
    Si=>conn20_30,
    Ci=>conn21_30,
    So=>temp10,
    Co=>temp11(0)
);

basico31: basico2 Port map(
    A=>A(3),
    B=>B(1),
    I=>Ma,
    Si=>conn21_31,
    Ci=>conn22_31,
    So=>temp11(4),
    Co=>temp11(1)
);

basico32: basico2 Port map(
    A=>A(3),
    B=>B(2),
    I=>Ma,
    Si=>conn22_32,
    Ci=>conn23_32,
    So=>temp11(5),
    Co=>temp11(2)
);

basico33: basico2 Port map(
    A=>temp7,
    B=>temp6,
    I=>temp8,
    Si=>temp5,
    Ci=>temp9,
    So=>temp11(6),
    Co=>temp11(3)
);

--calculo controles
control1<=Ma and Mb;

--calculo señales temporales

temp1<=left and (Cl&Cl&Cl&Cl&Cl&Cl&Cl);

temp2<=(B(3) and not(Cl) and not(Cb) and Mb) or bottomL;

temp3<= (bottom(2 downto 0)) and (Cb&Cb&Cb);

temp5<= temp4 when control1='0' else
        (temp4 or not(B(3)));

temp6<= B(3) when Ma='1' else
        A(3);

temp7<= A(3) when Ma='1' else
        B(3);

temp8<= Ma xor Mb;

temp9<= temp3(2) when control1='0' else
        not(A(3));


Afinal(0)<= (top4 and Ct) or (A(3) and not(Ct) and Ma);
Afinal (4 downto 1)<=temp11(3)&temp11(2)&temp11(1)&temp11(0);

Bfinal(0)<= (top4 and Ct) or (not(Ct) and temp10);
Bfinal (3 downto 1)<=temp11(6)&temp11(5)&temp11(4);
Bfinal(4)<= (bottom(3) and Cb) or 
            (Ma and A(3) and not(Cb) and not(Cr)) or
            (Mb and B(3) and not(Cb) and not(Cr)) or
            control1;
            
topR<=temp10;
top(3)<=temp10;
right<=temp11;
sumTemp<='0' & unsigned(Afinal)+unsigned(Bfinal);
sum<=std_logic_vector(sumTemp(4 downto 0));
bottom4<=sumTemp(5);

end Behavioral;
