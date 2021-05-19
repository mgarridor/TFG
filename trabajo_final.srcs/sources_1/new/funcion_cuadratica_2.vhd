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

----Descripción del módulo
--Modulo de función cuadrática
--Se hace la operación cuadrática y=ax^2+bx+c
--Las operaciones se hacen con 8 o 12 bits dependiendo del número de tramos en los que se divide la sigmoide para hacer la función.
--Nota: Si no se ocupan todos los bits se utilizan los bits menos significativos


----Definición de entradas/salidas

--x
--Valor de x de entrada

--a
--Valor de a de entrada

--b
--Valor de b de entrada

--c
--Valor de c de entrada

--y
--Valor de y de salida

--control_T
--Control de tramos de control.
--Si control_T ='0'--> Las operaciones son de 8 bits
--Si control_T ='1'--> Las operaciones son de 12 bits

--clk
--Reloj de control

--reset
--Si está a '1' se reinician los registros

--ready
--Cuando se pone a '1', la solución está lista

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity funcion_cuadratica_2 is
    Port ( x : in signed (11 downto 0);
           a : in signed (11 downto 0);
           b : in unsigned (11 downto 0);
           c : in unsigned (11 downto 0);
           y : out unsigned (11 downto 0);
           control_T : in std_logic;
           clk : in std_logic;
           reset:in std_logic;
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

process(a,b,c,x,r1_reg,r2_reg,control,reset,multa,suma,sumb,control_T)
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
    when "10" =>
            if control_T='1' then 
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
            if control_T='1' then 
                sumb<=signed(r1_reg(23)&r1_reg(19 downto 8));
            else 
                sumb<=signed(r1_reg(19 downto 15)&r1_reg(11 downto 4));
            end if;
end case;

end process;

--funciones
--control multiplicador
control_mult<="11" when control_T='0' else
                "00";


--la señal ready solo se activa cuando ha terminado de operar
ready<='1' when control="00" and primer_ciclo='0' else
        '0';

r2_next<=sumb+suma;

--salida
y<= (others=>'0') when (r2_reg(12)='1' and control_T='1') or (x(7)='1' and x<150 and control_T='0')else
    unsigned(r2_reg(11 downto 0))when control_T='1' else
    unsigned("0000"&r2_reg(7 downto 0));
end Behavioral;
