----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.02.2021 22:44:25
-- Design Name: 
-- Module Name: mult_config_2_tb - Behavioral
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

entity mult_config_2_tb is
--  Port ( );
end mult_config_2_tb;

architecture Behavioral of mult_config_2_tb is

component mult_config_2 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           S : out STD_LOGIC_VECTOR (15 downto 0);
           Ma : in std_logic;
           Mb : in std_logic;
           control : in STD_LOGIC_VECTOR (1 downto 0);
           clk: in std_logic;
           reset: in std_logic;
           ready: out std_logic
           );
end component;

signal A,B:std_logic_vector(7 downto 0):=(others=>'0');
signal S : STD_LOGIC_VECTOR (15 downto 0);
signal clk: std_logic;
signal reset: std_logic;
signal ready: std_logic;
           
           
signal A8,B8:std_logic_vector(7 downto 0);
signal S8:std_logic_vector(15 downto 0);

signal A41,B41,A42,B42:std_logic_vector(3 downto 0);
signal S41,S42:std_logic_vector(7 downto 0);

signal A21,A22,A23,A24:std_logic_vector(1 downto 0);
signal B21,B22,B23,B24:std_logic_vector(1 downto 0);
signal S21,S22,S23,S24:std_logic_vector(3 downto 0);

signal solucion:std_logic_vector(15 downto 0); 

signal correcto:std_logic;

constant clk_period : time := 100 ns; 
--control de la simulacion
--  si 00 => 1 multiplicador 8x8
--  si 01 => 2 multiplicadores 4x4
--``si 10 => 4 multiplicadores 2x2
constant control:std_logic_vector(1 downto 0):="01";
constant Ma : std_logic:='1';
constant Mb : std_logic:='1';

constant t1:time:=4*clk_period;
constant t2:time:=2*clk_period;
constant t3:time:=clk_period;

begin

comp:mult_config_2 
port map(
    A=>A,
    B=>B,
    S=>S,
    Ma=>Ma,
    Mb=>Mb,
    control=>control,
    clk=>clk,
    reset=>reset,
    ready=>ready
);

--control de reloj
clk_process:process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

process
begin
    reset<='1';
    wait for clk_period/50;
    reset<='0';


--1 multiplexor de 8 bits
if control="00" then
    A(7 downto 0)<="10000000";
    B(7 downto 0)<="01000000";
    
    wait for clk_period/2;
    ----bucle que prueba distintas combinaciones de A y B
    for i in 0 to 10000 loop 
    A<=std_logic_vector(unsigned(A)+1);
    B<=std_logic_vector(unsigned(B)+50);
    wait for t1;
    end loop;
elsif control="01" then

--2 multiplexores de 4 bits
    A(3 downto 0)<="0010";
    A(7 downto 4)<="0010";

    B(3 downto 0)<="0010";
    B(7 downto 4)<="0010";

    wait for clk_period/2;
    ----bucle que prueba distintas combinaciones de A y B
    for i in 0 to 10000 loop 
    A<=std_logic_vector(unsigned(A)+1+32+250+4096);
    B<=std_logic_vector(unsigned(B)+3+64+500+5500);
    wait for t2;

    end loop;
    
--4 multiplicadores de 2 bits
else
    A<=(others=>'0');
    B<=(others=>'0');
    wait for clk_period/2;
    for i in 0 to 10000 loop 
    A<=std_logic_vector(unsigned(A)+1+32+250+4096+15000);
    B<=std_logic_vector(unsigned(B)+3+64+500+2500+8000);
    wait for t3;

    end loop;
end if;


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

--------------------------

A21<=A(1 downto 0);
B21<=B(1 downto 0);
A22<=A(3 downto 2);
B22<=B(3 downto 2);
A23<=A(5 downto 4);
B23<=B(5 downto 4);
A24<=A(7 downto 6);
B24<=B(7 downto 6);

S21<=S(3 downto 0);
S22<=S(7 downto 4);
S23<=S(11 downto 8);
S24<=S(15 downto 12);
-----------------comprobacion de resultados correctos (cambiar unsigned/signed dependiendo de Ma y Mb)-------------------

--1 multiplicador 8 bits
--con signo
--solucion(15 downto 0)<=std_logic_vector(signed(A8)*signed(B8));

--sin signo
--solucion(15 downto 0)<=std_logic_vector(unsigned(A8)*unsigned(B8));


--2 multiplicadores de 4 bits        
----con signo  
solucion(7 downto 0)<=std_logic_vector(signed(A41)*signed(B41));
solucion(15 downto 8)<=std_logic_vector(signed(A42)*signed(B42));

----sin signo
--solucion(7 downto 0)<=std_logic_vector(unsigned(A41)*unsigned(B41));
--solucion(15 downto 8)<=std_logic_vector(unsigned(A42)*unsigned(B42));


--8 multiplicadores 2 bits
--con signo
--solucion(3 downto 0)<=std_logic_vector(signed(A21)*signed(B21));
--solucion(7 downto 4)<=std_logic_vector(signed(A22)*signed(B22));
--solucion(11 downto 8)<=std_logic_vector(signed(A23)*signed(B23));
--solucion(15 downto 12)<=std_logic_vector(signed(A24)*signed(B24));


----sin signo
--solucion(3 downto 0)<=std_logic_vector(unsigned(A21)*unsigned(B21));
--solucion(7 downto 4)<=std_logic_vector(unsigned(A22)*unsigned(B22));
--solucion(11 downto 8)<=std_logic_vector(unsigned(A23)*unsigned(B23));
--solucion(15 downto 12)<=std_logic_vector(unsigned(A24)*unsigned(B24));


correcto<='1' when (solucion=S and ready='1') or ready='0' else
          '0';
          
end Behavioral;