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
        control<="00";
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
    when "01" =>multa<=signed("000"&std_logic_vector(a));
    --a*x de x*a*x recorto 9 bits de la izquierda
    when "10" =>multa<=r1_reg(22 downto 8);
    --no importante
    when others =>multa<=r1_reg(22 downto 8);
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

end process;

--funciones

r1_next<=(x*multa);
--r1 (recorto 1 por la izda y 13 por la dcha para que sea S(1,11))
r2_next<=r1_reg(25 downto 13)+suma;

y<= "000000000000" when x<= -8 else
    "111111111111" when x>=8 else
    unsigned(r2_reg(11 downto 0));

end Behavioral;




------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 04.12.2020 16:08:17
---- Design Name: 
---- Module Name: funcion_cuadratica - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity funcion_cuadratica is
--    Port ( clk : in std_logic;
--           reset:in std_logic;
--           x : in signed (11 downto 0);
--           a : in signed (11 downto 0);
--           b : in unsigned (11 downto 0);
--           c : in unsigned (11 downto 0);
--           y : out unsigned (11 downto 0));
--       end funcion_cuadratica;

--architecture Behavioral of funcion_cuadratica is

--signal control:std_logic_vector(1 downto 0);

--signal multa:signed(22 downto 0);
--signal multb:signed(15 downto 0);

--signal suma:signed(34 downto 0);
--signal sumb:signed(34 downto 0);


--signal r1_reg,r1_next: signed(38 downto 0);
--signal r2_reg,r2_next: signed(35 downto 0);


--begin

----registro de entrada
--process(clk,reset)
--begin
--    if(reset = '1')then
--        r1_reg<= (others=>'0');
--        r2_reg<= (others=>'0');
--        control<="00";
--    elsif(rising_edge(clk))then
--        r1_reg<=r1_next;
--        r2_reg<=r2_next;
--        control<=std_logic_vector(unsigned(control)+1);
--    end if;
--end process;

--process(a,b,c,x,r1_reg,r2_reg,control)
--begin

----multiplexadores del multiplicador
----numeracion de multiplicaciones

----x*b    x:S(6,16)   b:S(0,15)
----x*x    x:S(3,19)   x:S(3,12)
----x^2*a    x^2:S(6,16)   a:S(0,15)


--case control is
--    --x de x*b (añado 3 ceros a la izda y 8 a la dcha, ahora es S(6,16)) 
--    when "00" =>multa<=signed("000"&std_logic_vector(x)&"00000000");
--    --primera x de x*x (añado 11 ceros a la dcha, ahora es S(3,19))
--    when "01" =>multa<=signed(std_logic_vector(x)&"00000000000");
--    --x^2 de x^2*a (lo recorto para que sea s(6,16))
--    when "10" =>multa<=r1_reg(36 downto 14);--x^2 de x^2*a
--    when "11" =>multa<=r1_reg(36 downto 14);--no importante

--end case;

--case control is 
--    --b de x*b (añado 1 cero a la izda y 2 a la dcha, ahora es S(0,15)) 
--    when "00" =>multb<=signed("00"&std_logic_vector(b)&"00");
--    --segunda x de x*x (añado 4 ceros a la dcha, ahora es S(3,12))
--    when "01" =>multb<=signed(std_logic_vector(x)&"0000");
--    --a de x^2*a (añado 4 ceros a la izda, ahora es S(0,15))
--    when "10" =>multb<=signed("0000"&std_logic_vector(a));
--    --no importante
--    when "11" =>multb<=signed("0000"&std_logic_vector(a));
--end case;

------multiplexadores del sumador
----numeracion de suma

----(x*b)+c = r1+c    ambos(3,31)
----(x^2*b)+(x*b)+c = r1+r2   ambos(3,31)


--case control(1) is 
--    --c de r1+c (añado 4 ceros a la izda y 19 a la dcha para que sea S(3,31))
--    when '0' =>suma<=signed("0000"&std_logic_vector(c)&"0000000000000000000");
--    --r2 de r1+r2 (quito 1 ceros a la izda para que sea S(3,31))
--    when '1' =>suma<=r2_reg(34 downto 0);
--end case;

----case control(1) is 
----    --r1 de r1+c (recorto 3 por la izda para que sea S(3,31))
----    when '0' =>sumb<=r1_reg(34 downto 0);
----    --r1 de r1+r2 (recorto 3 por la izda para que sea S(3,31))
----    when '1' =>sumb<=r1_reg(34 downto 0);
----end case;

--end process;

----funciones

--r1_next<=multa*multb;
----r1 (recorto 3 por la izda para que sea S(3,31))
--r2_next<=r1_reg(35 downto 0)+suma;

--y<= "000000000000" when x<= -8 else
--    "111111111111" when x>=8 else
--    unsigned(r2_reg(31 downto 20));

--end Behavioral;

