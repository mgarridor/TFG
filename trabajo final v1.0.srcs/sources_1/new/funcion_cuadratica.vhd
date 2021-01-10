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
    Port ( clk : in std_logic;
           reset:in std_logic;
           x : in signed (11 downto 0);
           a : in signed (11 downto 0);
           b : in unsigned (11 downto 0);
           c : in unsigned (11 downto 0);
           y : out unsigned (11 downto 0));
       end funcion_cuadratica;

architecture Behavioral of funcion_cuadratica is

signal control:std_logic_vector(1 downto 0);

signal multa:signed(14 downto 0);

signal suma:signed(12 downto 0);
signal sumb:signed(12 downto 0);


signal r1_reg,r1_next: signed(26 downto 0);
signal r2_reg,r2_next: signed(12 downto 0);


begin



--registro de entrada
process(clk,reset)
begin
    if(reset = '1')then
        r1_reg<= (others=>'0');
        r2_reg<= (others=>'0');
        control<="11";
    elsif(rising_edge(clk))then
        r1_reg<=r1_next;
        r2_reg<=r2_next;
        control<=std_logic_vector(unsigned(control)+1);
    end if;
end process;

process(a,b,c,x,r1_reg,r2_reg,control)
begin

--multiplexadores del multiplicador
--numeracion de multiplicaciones

--x*b       x:S(3,8)   b:S(-1,15)
--x*a       x:S(3,8)   a:S(-1,15)
--x*a*x     x:S(3,8)   a*x:S(-1,15)


case control is 
    --b de x*b (añado 1 cero a la izda y 2 a la dcha, ahora es S(-1,15)) 
    when "00" =>multa<=signed('0'&std_logic_vector(b)&"00");
    --a de x*a (añado 3 ceros a la izda ahora es S(-1,15))
    when "01" =>multa<=signed(a(11)&a(11)&a(11)&a(11)&std_logic_vector(a(10 downto 0)));
    --a*x de x*a*x recorto 9 bits de la izquierda
    when "10" =>multa<=r1_reg(26 downto 26)&r1_reg(21 downto 8);
    --no importante
    when others =>multa<=r1_reg(26 downto 26)&r1_reg(21 downto 8);
end case;

----multiplexadores del sumador
--numeracion de suma

--(x*b)+c = r1+c    ambos(1,11)
--(x^2*b)+(x*b)+c = r1+r2   ambos(1,11)


case control(1) is 
    --c de r1+c (añado 2 ceros a la izda y quito 1 a la dcha para que sea S(1,11))
    when '0' =>suma<=signed('0'&std_logic_vector(c));
    --r2 de r1+r2
    when others =>suma<=r2_reg;
end case;

case control is 
    when "11" =>y<=unsigned(r2_reg(11 downto 0));
    when others=>y<="000000000000";
end case;

end process;

--funciones

r1_next<=(x*multa);
--r1 (recorto 1 por la izda y 13 por la dcha para que sea S(1,11))
r2_next<=(r1_reg(26 downto 26)&r1_reg(22 downto 11))+suma;


--y<= "000000000000" when x<= -"11111111111" else
--    "111111111111" when x>=  "111111111111"else
--    unsigned(r2_reg(11 downto 0));

end Behavioral;

