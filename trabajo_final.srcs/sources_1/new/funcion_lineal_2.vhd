----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 17:05:33
-- Design Name: 
-- Module Name: funcion_lineal - Behavioral
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

entity funcion_lineal_2 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x : in signed (11 downto 0);
           a : in unsigned (11 downto 0);
           b : in unsigned (11 downto 0);
           y : out unsigned (11 downto 0);
           control_T : in std_logic;
           ready : out std_logic);
end funcion_lineal_2;

architecture Behavioral of funcion_lineal_2 is


signal r1_reg,r1_next: std_logic_vector(23 downto 0);

signal y_temp:signed(8 downto 0);
signal contador:std_logic;

signal primer_ciclo:std_logic:='1';

--señales sumador
signal sumA:std_logic_vector(8 downto 0);

--señales multiplicador
signal Ma,Mb:std_logic;
signal ready_mult:std_logic;
signal control_mult:std_logic_vector(1 downto 0);


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
    B=>std_logic_vector(a),
    S=>r1_next,
    Ma=>'1',
    Mb=>'0',
    control=>control_mult,
    clk=>clk,
    reset=>reset,
    ready=>ready_mult
);



process(clk,reset)
begin
    if(reset = '1')then
        r1_reg<= (others=>'0');
        contador<='0';
        primer_ciclo<='1';
    elsif(rising_edge(clk))then
        r1_reg<=r1_next;
        primer_ciclo<='0';
        if(ready_mult='1' and contador='1') then 
            contador<='0';
        elsif contador='0' then
            contador<='1';
        else
            contador<=contador;
        end if;
    end if;
end process;
--control del multiplicador
control_mult<="01" when control_T='0' else
              "00";



--sumA puede tener 16 bits (recorto hasta tener 8) o 8 (ajusto para que la codificacion esté bien).
--repito el bit más significativo para la suma (al final lo elimino)
sumA<=r1_reg(15)& r1_reg(15)& r1_reg(12 downto 6) when control_T='1' else
      r1_reg(7)& r1_reg(7)& r1_reg(7)& r1_reg(7)& r1_reg(7)& r1_reg(5 downto 2); 

y_temp<= signed(std_logic_vector(b(8 downto 0))) + signed(sumA);


--convierto y a unsigned

y<="00000000"&unsigned(y_temp(3 downto 0)) when control_T='0' else
   "0000" &unsigned(y_temp(7 downto 0)) ;

--ready se activa en una vez cada 2 ciclos cuando contador sea 0    
ready<=not(contador) when primer_ciclo='0' else
        '0';
end Behavioral;
