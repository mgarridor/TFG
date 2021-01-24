----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.12.2020 16:08:17
-- Design Name: 
-- Module Name: funcion_cuadratica - Behavioral
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

entity funcion_cuadratica is
    generic(nbits:natural:=12);
    Port ( clk : in std_logic;
           reset:in std_logic;
           x : in signed (11 downto 0);
           a : in signed (nbits-1 downto 0);
           b : in unsigned (nbits-1 downto 0);
           c : in unsigned (nbits-1 downto 0);
           y : out unsigned (nbits-1 downto 0);
           ready: out std_logic);
       end funcion_cuadratica;

architecture Behavioral of funcion_cuadratica is


signal control:std_logic_vector(1 downto 0);

signal multa:signed(nbits+2 downto 0);

signal suma:signed(nbits downto 0);

signal sumb:signed(nbits downto 0);


signal r1_reg,r1_next: signed(nbits+14 downto 0);
signal r2_reg,r2_next: signed(nbits downto 0);


begin



--registro de entrada
process(clk,reset)
begin
    if(reset = '1')then
        r1_reg<= (others=>'0');
        r2_reg<= (others=>'0');
        control<="11";
    elsif (rising_edge(clk))then
        r1_reg<=r1_next;
        r2_reg<=r2_next;
        control<=std_logic_vector(unsigned(control)+1);
    end if;
end process;

process(a,b,c,x,r1_reg,r2_reg,control)
begin

--multiplexadores del multiplicador

--x*b       
--x*a 
--(x*a)*x 


case control is 
    --b de x*b (añado 1 cero a la izda y 2 a la dcha) 
    when "00" =>multa<=signed('0'&std_logic_vector(b)&"00");
    --a de x*a (añado 4 bits de signo a la izda)
    when "01" =>multa<=signed(a(a'left)&a(a'left)&a(a'left)&a(a'left)&std_logic_vector(a(nbits-2 downto 0)));
    --x*a de x*a*x (añado el bit de signo y recorto 9 bits de la dcha)
    when "10" =>multa<=signed(r1_reg(r1_reg'left)&std_logic_vector(r1_reg(r1_reg'left-5 downto 8)));
    --no importante
    when others =>multa<=signed(r1_reg(r1_reg'left)&std_logic_vector(r1_reg(r1_reg'left-5 downto 8)));
end case;

----multiplexadores del sumador

--(x*b)+c = r1+c 
--(x^2*b)+(x*b)+c = r1+r2


case control(1) is 
    --c de r1+c (añado 1 cero a la izquierda como bit de signo)
    when '0' =>suma<=signed('0'&std_logic_vector(c));
    --r2 de r1+r2
    when others =>suma<=r2_reg;
end case;

case control(0) is 
    --cuando control es 00 y 10 el registro se mantiene (se suma con 0)
    when '0' =>sumb<=(others=>'0');
    --en los otros casos, sera (x*b) o (x*a*x), en ambos casos r1
    when others =>sumb<=signed(r1_reg(r1_reg'left)&std_logic_vector(r1_reg(r1_reg'left-4 downto 11)));
end case;


--multiplexador de la salida para que solo muestre el resultado cuando ha terminado de operar


end process;
y<=unsigned(r2_reg(nbits-1 downto 0));
--funciones
ready<='1' when control="11"and reset='0' else
        '0';

r1_next<=(x*multa);
r2_next<=sumb+suma;

end Behavioral;
