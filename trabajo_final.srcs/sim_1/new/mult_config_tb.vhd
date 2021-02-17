----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.02.2021 17:51:45
-- Design Name: 
-- Module Name: mult_config_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity mult_config_tb is
end mult_config_tb;

architecture Behavioral of mult_config_tb is

component mult_config is
    generic(control : STD_LOGIC_VECTOR (1 downto 0)
           );
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           S : out STD_LOGIC_VECTOR (63 downto 0);
           Ma : in std_logic;
           Mb : in std_logic
           );
end component;

signal A,B:std_logic_vector(31 downto 0);
signal S : STD_LOGIC_VECTOR (63 downto 0);


signal A8,B8:std_logic_vector(7 downto 0);
signal S8:std_logic_vector(15 downto 0);

signal A41,B41,A42,B42,A43,B43,A44,B44:std_logic_vector(3 downto 0);
signal S41,S42,S43,S44:std_logic_vector(7 downto 0);

signal A21,A22,A23,A24,A25,A26,A27,A28,A29,A210,A211,A212,A213,A214,A215,A216:std_logic_vector(1 downto 0);
signal B21,B22,B23,B24,B25,B26,B27,B28,B29,B210,B211,B212,B213,B214,B215,B216:std_logic_vector(1 downto 0);
signal S21,S22,S23,S24,S25,S26,S27,S28,S29,S210,S211,S212,S213,S214,S215,S216:std_logic_vector(3 downto 0);

signal solucion8:std_logic_vector(63 downto 0); 
signal solucion4:std_logic_vector(63 downto 0); 
signal solucion2:std_logic_vector(63 downto 0); 

signal correcto:std_logic;

--control de la simulacion
--  si 00 => 1 multiplicador 8x8
--  si 01 => 4 multiplicadores 4x4
--``si 10 => 16 multiplicadores 2x2
constant control:std_logic_vector(1 downto 0):="10";
constant Ma : std_logic:='1';
constant Mb : std_logic:='1';
begin

comp:mult_config 
generic map(
    control=>control
    )
port map(
    A=>A,
    B=>B,
    S=>S,
    Ma=>Ma,
    Mb=>Mb
);

process
begin

--1 multiplexor de 8 bits
if control="00" then
    A(31 downto 8)<=(others=>'0');
    A(7 downto 0)<="10000000";
    
    B(31 downto 8)<=(others=>'0');
    B(7 downto 0)<="10000000";

elsif control="01" then

--4 multiplexores de 4 bits
    A(31 downto 15)<=(others=>'0');
    A(3 downto 0)<="1000";
    A(7 downto 4)<="1000";
    A(11 downto 8)<="1000";
    A(15 downto 12)<="1000";
    
    B(31 downto 15)<=(others=>'0');
    B(3 downto 0)<="1000";
    B(7 downto 4)<="1000";
    B(11 downto 8)<="1000";
    B(15 downto 12)<="1000";

--16 multiplicadores de 2 bits
else
    A<=(others=>'0');
    B<=(others=>'0');
end if;

wait for 10 ns;

--bucle que prueba distintas combinaciones de A y B
for i in 0 to 10000 loop 
A<=std_logic_vector(unsigned(A)+128);
B<=std_logic_vector(unsigned(B)+256);

wait for 50 ns;
end loop;

wait;
end process;

--conexiones de las señales de entrada
----------------------------
A8<=A(7 downto 0);
B8<=B(7 downto 0);
S8<=S(15 downto 0);

---------------------------
A41<=A(3 downto 0);
B41<=B(3 downto 0);
S41<=S(7 downto 0);

A42<=A(7 downto 4);
B42<=B(7 downto 4);
S42<=S(15 downto 8);

A43<=A(11 downto 8);
B43<=B(11 downto 8);
S43<=S(23 downto 16);

A44<=A(15 downto 12);
B44<=B(15 downto 12);
S44<=S(31 downto 24);

--------------------------

A21<=A(1 downto 0);
B21<=B(1 downto 0);
A22<=A(3 downto 2);
B22<=B(3 downto 2);
A23<=A(5 downto 4);
B23<=B(5 downto 4);
A24<=A(7 downto 6);
B24<=B(7 downto 6);

A25<=A(9 downto 8);
B25<=B(9 downto 8);
A26<=A(11 downto 10);
B26<=B(11 downto 10);
A27<=A(13 downto 12);
B27<=B(13 downto 12);
A28<=A(15 downto 14);
B28<=B(15 downto 14);

A29<=A(17 downto 16);
B29<=B(17 downto 16);
A210<=A(19 downto 18);
B210<=B(19 downto 18);
A211<=A(21 downto 20);
B211<=B(21 downto 20);
A212<=A(23 downto 22);
B212<=B(23 downto 22);

A213<=A(25 downto 24);
B213<=B(25 downto 24);
A214<=A(27 downto 26);
B214<=B(27 downto 26);
A215<=A(29 downto 28);
B215<=B(29 downto 28);
A216<=A(31 downto 30);
B216<=B(31 downto 30);


-----------------comprobacion de resultados correctos (cambiar unsigned/signed dependiendo de Ma y Mb)-------------------

---------------1 multiplicador 8 bits
----con signo
--solucion8(15 downto 0)<=std_logic_vector(signed(A8)*signed(B8));

----sin signo
--solucion8(15 downto 0)<=std_logic_vector(unsigned(A8)*unsigned(B8));

--solucion8(63 downto 16)<=(others=>'0');
--correcto<='1' when solucion8=S else
--          '0';
          
---------------4 multiplicadores de 4 bits        
----con signo  
--solucion4(7 downto 0)<=std_logic_vector(signed(A41)*signed(B41));
--solucion4(15 downto 8)<=std_logic_vector(signed(A42)*signed(B42));
--solucion4(23 downto 16)<=std_logic_vector(signed(A43)*signed(B43));
--solucion4(31 downto 24)<=std_logic_vector(signed(A44)*signed(B44));

----sin signo
--solucion4(7 downto 0)<=std_logic_vector(unsigned(A41)*unsigned(B41));
--solucion4(15 downto 8)<=std_logic_vector(unsigned(A42)*unsigned(B42));
--solucion4(23 downto 16)<=std_logic_vector(unsigned(A43)*unsigned(B43));
--solucion4(31 downto 24)<=std_logic_vector(unsigned(A44)*unsigned(B44));

--solucion4(63 downto 32)<=(others=>'0');
--correcto<='1' when solucion4=S else
--          '0';

--16 multiplicadores 2 bits
--con signo
solucion2(3 downto 0)<=std_logic_vector(signed(A21)*signed(B21));
solucion2(7 downto 4)<=std_logic_vector(signed(A22)*signed(B22));
solucion2(11 downto 8)<=std_logic_vector(signed(A23)*signed(B23));
solucion2(15 downto 12)<=std_logic_vector(signed(A24)*signed(B24));
solucion2(19 downto 16)<=std_logic_vector(signed(A25)*signed(B25));
solucion2(23 downto 20)<=std_logic_vector(signed(A26)*signed(B26));
solucion2(27 downto 24)<=std_logic_vector(signed(A27)*signed(B27));
solucion2(31 downto 28)<=std_logic_vector(signed(A28)*signed(B28));
solucion2(35 downto 32)<=std_logic_vector(signed(A29)*signed(B29));
solucion2(39 downto 36)<=std_logic_vector(signed(A210)*signed(B210));
solucion2(43 downto 40)<=std_logic_vector(signed(A211)*signed(B211));
solucion2(47 downto 44)<=std_logic_vector(signed(A212)*signed(B212));
solucion2(51 downto 48)<=std_logic_vector(signed(A213)*signed(B213));
solucion2(55 downto 52)<=std_logic_vector(signed(A214)*signed(B214));
solucion2(59 downto 56)<=std_logic_vector(signed(A215)*signed(B215));
solucion2(63 downto 60)<=std_logic_vector(signed(A216)*signed(B216));

----sin signo
--solucion2(3 downto 0)<=std_logic_vector(unsigned(A21)*unsigned(B21));
--solucion2(7 downto 4)<=std_logic_vector(unsigned(A22)*unsigned(B22));
--solucion2(11 downto 8)<=std_logic_vector(unsigned(A23)*unsigned(B23));
--solucion2(15 downto 12)<=std_logic_vector(unsigned(A24)*unsigned(B24));
--solucion2(19 downto 16)<=std_logic_vector(unsigned(A25)*unsigned(B25));
--solucion2(23 downto 20)<=std_logic_vector(unsigned(A26)*unsigned(B26));
--solucion2(27 downto 24)<=std_logic_vector(unsigned(A27)*unsigned(B27));
--solucion2(31 downto 28)<=std_logic_vector(unsigned(A28)*unsigned(B28));
--solucion2(35 downto 32)<=std_logic_vector(unsigned(A29)*unsigned(B29));
--solucion2(39 downto 36)<=std_logic_vector(unsigned(A210)*unsigned(B210));
--solucion2(43 downto 40)<=std_logic_vector(unsigned(A211)*unsigned(B211));
--solucion2(47 downto 44)<=std_logic_vector(unsigned(A212)*unsigned(B212));
--solucion2(51 downto 48)<=std_logic_vector(unsigned(A213)*unsigned(B213));
--solucion2(55 downto 52)<=std_logic_vector(unsigned(A214)*unsigned(B214));
--solucion2(59 downto 56)<=std_logic_vector(unsigned(A215)*unsigned(B215));
--solucion2(63 downto 60)<=std_logic_vector(unsigned(A216)*unsigned(B216));

correcto<='1' when solucion2=S else
          '0';
          
end Behavioral;
