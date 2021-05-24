----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2021 20:38:09
-- Design Name: 
-- Module Name: neurona_tb - Behavioral
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

entity neurona_tb is
--  Port ( );
end neurona_tb;

architecture Behavioral of neurona_tb is

component neurona is
    Port ( x : in std_logic_vector (11 downto 0);
           w : in std_logic_vector (11 downto 0);
           num_bits:in natural;
           y : out unsigned (11 downto 0);
           reset : in STD_LOGIC;
           recibir_datos: out STD_LOGIC;
           ready_in : in std_logic;
           ready_out: out STD_LOGIC;
           control_lineal : in STD_LOGIC;
           control_tramos : in STD_LOGIC;
           clk : in std_logic);
end component;

signal x : std_logic_vector (11 downto 0):=(others=>'0');
signal w : std_logic_vector (11 downto 0):=(others=>'0');
signal y : unsigned (11 downto 0);
signal reset : STD_LOGIC;
signal fin_datos: STD_LOGIC:='0';
signal recibir_datos: STD_LOGIC;
signal ready_in : std_logic;
signal ready_out: STD_LOGIC;
signal control_lineal : STD_LOGIC:='1';
signal control_tramos : STD_LOGIC:='0';
signal clk : std_logic;
signal num_bits: natural:=4;
constant clk_period : time := 100 ns; 
signal num_entradas : natural :=4;


-- multiplicacion de 12 bits
constant time_12 : time := 1850 ns; 
-- multiplicacion de 8 bits
constant time_8 : time := 1250 ns; 
-- multiplicacion de 4 bits
constant time_4 : time := 1250 ns; 
-- multiplicacion de 2 bits
constant time_2 : time := 1850 ns; 

signal tiempo_espera :time;

begin

neuron : neurona
port map(
x=>x,
w=>w,
y=>y,
num_bits=>num_bits,
reset=>reset,
ready_in=>ready_in,
recibir_datos=>recibir_datos,
ready_out=>ready_out,
control_lineal=>control_lineal,
control_tramos=>control_tramos,
clk=>clk
);

clk_process:process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

tiempo_espera<=time_12 when num_bits=12 else
               time_8 when num_bits=8 else
               time_4 when num_bits=4 else
               time_2;
--reset
process
begin
    reset<='1';
    ready_in<='0';
    wait for 10 ns;
    reset<='0';
    ready_in<='1';
    wait for tiempo_espera;
    ready_in<='0';
    wait;
end process;

process (clk)
begin
    if rising_edge(clk) then
        if recibir_datos='1' and num_entradas>0 then
            case num_bits is
                when 2 =>   
                    x(11 downto 10)<="01"; --x=8
                    x(9 downto 8)<="01"; --x=8
                    x(7 downto 6)<="01"; --x=8
                    x(5 downto 4)<="01"; --x=8
                    x(3 downto 2)<="01"; --x=8
                    x(1 downto 0)<="01"; --x=8
                    
                    w(11 downto 10)<="01"; --x=8
                    w(9 downto 8)<="01"; --x=8
                    w(7 downto 6)<="01"; --x=8
                    w(5 downto 4)<="01"; --x=8
                    w(3 downto 2)<="01"; --x=8
                    w(1 downto 0)<="01"; --x=8
                when 4 => 
                    x(11 downto 8)<="0001"; --x=1
                    x(7 downto 4)<="0000"; --x=0
                    x(3 downto 0)<="1111"; --x=-1
                    
                    w(11 downto 8)<="0001"; --x=1
                    w(7 downto 4)<="0001"; --x=1
                    w(3 downto 0)<="0001"; --x=1
                when 8 => 
                    x(11 downto 8)<=(others=>'0');
                    x(7 downto 0)<="00010000"; --x=1
                    w(11 downto 8)<=(others=>'0');
                    w(7 downto 0)<="00010010"; --x=1
                when others => 
                    x<="000100000000"; --x=2
                    w<="000100000000"; --x=2
            end case;
            num_entradas<=num_entradas-1;
        elsif num_entradas=0 then
                fin_datos<='1';
        end if;
    end if;

end process;

end Behavioral;
