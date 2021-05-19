----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2021 13:19:38
-- Design Name: 
-- Module Name: FAB_mini - Behavioral
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
--Módulo en los que se divide el multiplicador configurable.
--Se deben implementar varios bloques de este estilo formando una matriz de 2 dimensiónes n x m,
--siendo 2n el número de bits dwl primer operando y 2m el número de bits del segundo operando.

--Los diferentes módulos se conectan con sus vecinos de la matriz y las señales de control Cl, Cb, Cr y Ct 
--indican si hay módulos en cada sentido

----Definición de entradas/salidas
--A
--2 bits de entrada del operando A

--B
--2 bits de entrada del operando A

--left
--bits de entrada del módulo de la izquierda

--bottomL
--bit de entrada del módulo de debajo a la izquierda

--bottom
--bits de entrada del módulo de debajo

--bottom4
--bit de salida hacia el módulo de debajo

--right
--Bit de salida hacia el módulo de la izquierda

--sum
--Bits de suma de A+B

--top
--Bits de salida hacia el módulo de arriba

--top4
--Bit de entrada del el módulo de arriba

--topR
--Bit de salida hacia el módulo de arriba a la derecha

--Cl
--Control que indica si hay un módulo conectado a la izquierda

--Cr
--Control que indica si hay un módulo conectado a la derecha

--Ct
--Control que indica si hay un módulo conectado arriba

--Cb
--Control que indica si hay un módulo conectado debajo

--Ma
--Control de signo del operando A (si Ma='1' --> A es un numero con signo)

--Mb
--Control de signo del operando B (si Mb='1' --> B es un numero con signo)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;



entity FAB_mini is
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
end FAB_mini;

architecture Behavioral of FAB_mini is

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
signal temp1:std_logic_vector(2 downto 0);
signal temp2:std_logic;
signal temp3:std_logic;
signal temp4,temp5,temp6,temp7,temp8,temp9:std_logic;
signal temp10:std_logic;
signal temp11:std_logic_vector(2 downto 0);

signal sumTemp:unsigned(3 downto 0);
signal control1:std_logic;

signal Afinal,Bfinal:std_logic_vector(2 downto 0);

signal conn00_10:std_logic;
signal conn01_10:std_logic;

begin

--primera columna
basico00: basico1 Port map(
    A=>A(0),
    B=>B(0),
    Si=>temp1(0),
    Ci=>temp1(2),
    So=>top(0),
    Co=>conn00_10
);

basico01: basico2 Port map(
    A=>B(1),
    B=>A(0),
    I=>Mb,
    Si=>temp1(1),
    Ci=>temp2,
    So=>conn01_10,
    Co=>temp4
);

--cuarta columna
basico10: basico2 Port map(
    A=>A(1),
    B=>B(0),
    I=>Ma,
    Si=>conn00_10,
    Ci=>conn01_10,
    So=>temp10,
    Co=>temp11(0)
);

basico11: basico2 Port map(
    A=>temp7,
    B=>temp6,
    I=>temp8,
    Si=>temp5,
    Ci=>temp9,
    So=>temp11(2),
    Co=>temp11(1)
);

--calculo controles
control1<=Ma and Mb;

--calculo señales temporales

temp1<=left and (Cl&Cl&Cl);

temp2<=(B(1) and not(Cl) and not(Cb) and Mb) or (bottomL and Cb and Cl);

temp3<= bottom(0) and Cb;

temp5<= temp4 when control1='0' else
        (temp4 or not(B(1)));

temp6<= B(1) when Ma='1' else
        A(1);

temp7<= A(1) when Ma='1' else
        B(1);

temp8<= Ma xor Mb;

temp9<= temp3 when control1='0' else
        not(A(1));


Afinal(0)<= (top4 and Ct) or (A(1) and not(Ct) and Ma);
Afinal (2 downto 1)<=temp11(1)&temp11(0);

Bfinal(0)<= (top4 and Ct) or (not(Ct) and temp10);
Bfinal(1)<=temp11(2);
Bfinal(2)<= (bottom(1) and Cb) or 
            (Ma and A(1) and not(Cb) and not(Cr)) or
            (Mb and B(1) and not(Cb) and not(Cr)) or
            control1;
            
topR<=temp10;
top(1)<=temp10;
right<=temp11;
sumTemp<='0' & unsigned(Afinal)+unsigned(Bfinal);
sum<=std_logic_vector(sumTemp(2 downto 0));
bottom4<=sumTemp(3);



end Behavioral;
