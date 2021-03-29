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
use IEEE.NUMERIC_STD.ALL;

entity funcion_cuadratica_2 is
    Port ( clk : in std_logic;
           reset:in std_logic;
           x : in signed (11 downto 0);
           a : in signed (11 downto 0);
           b : in unsigned (11 downto 0);
           c : in unsigned (11 downto 0);
           y : out unsigned (11 downto 0);
           control_T : in std_logic_vector(1 downto 0);
           ready: out std_logic);
end funcion_cuadratica_2;

architecture Behavioral of funcion_cuadratica_2 is

--señales de control
signal primer_ciclo:std_logic:='1';
signal control:std_logic_vector(1 downto 0);

--señales de entrada a multiplicador o sumador
signal multa:signed(11 downto 0):=(others=>'0');
signal control_mult:std_logic_vector(1 downto 0);
signal ready_mult:std_logic;

signal suma:signed(12 downto 0):=(others=>'0');
signal sumb:signed(12 downto 0):=(others=>'0');

--registros
signal r1_reg,r1_next: std_logic_vector(23 downto 0);
signal r2_reg,r2_next: signed(12 downto 0);



component mult_config_3 is
    Port ( A : in STD_LOGIC_VECTOR (11 downto 0);
           B : in STD_LOGIC_VECTOR (11 downto 0);
           S : out STD_LOGIC_VECTOR (23 downto 0);
           Ma : in std_logic;
           Mb : in std_logic;
           control : in STD_LOGIC_VECTOR (1 downto 0);
           clk: in std_logic;
           reset: in std_logic;
           ready: out std_logic
           );
end component;

begin

multiplicador:mult_config_3
port map(
    A=>std_logic_vector(x),
    B=>std_logic_vector(multa),
    S=>r1_next,
    Ma=>'1',
    Mb=>'1',
    control=>control_mult,
    clk=>clk,
    reset=>reset,
    ready=>ready_mult
);



--registro de entrada
process(clk,reset)
begin
--reset asincrono
    if(reset = '1')then
        r1_reg<= (others=>'0');
        r2_reg<= (others=>'0');
        control<="00";
        primer_ciclo<='1';
    elsif (rising_edge(clk))then
        if control="11" or ready_mult ='1' then
            r1_reg<=r1_next;
            r2_reg<=r2_next;
            primer_ciclo<='0';
            control<=std_logic_vector(unsigned(control)+1);
--        else
--            r1_reg<=r1_reg;
--            r2_reg<=r2_reg;
--            control<=control;
        end if;
    end if;
end process;

process(a,b,c,x,r1_reg,r2_reg,control,reset,multa,suma,sumb)
begin

--multiplexadores del multiplicador
--x*b       
--x*a 
--(x*a)*x 
case control is 
    --b de x*b (añado 1 cero a la izda para el bit de signo y lo quito por la derecha) 
    when "00" =>multa<=signed('0'&std_logic_vector(b(11 downto 1)));
    --a de x*a (añado 3 bits de signo a la izda)
    when "01" =>multa<=a;
    --x*a de x*a*x (añado el bit de signo y recorto 9 bits de la dcha y 4 de la izda)
    when "10" =>
            if control_T="01" then 
                multa<= signed(r1_reg(23)&r1_reg(21 downto 11));
            else
                multa<= signed(r1_reg(19 downto 15)&r1_reg(13 downto 7));
            end if;
    --no importante
    when others =>multa<=signed(r1_reg(19 downto 15)&r1_reg(13 downto 7));
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
    when others =>
            if control_T="01" then 
                sumb<=signed(r1_reg(23)&r1_reg(20 downto 9));
            else 
                sumb<=signed(r1_reg(19 downto 15)&r1_reg(11 downto 4));
            end if;
end case;

end process;

--funciones
--control multiplicador
control_mult<="00" when control_T="00" else
                "11";


--la señal ready solo se activa cuando ha terminado de operar
ready<='1' when control="00" and primer_ciclo='0' else
        '0';

r2_next<=sumb+suma;

--salida
y<=unsigned(r2_reg(11 downto 0));


end Behavioral;