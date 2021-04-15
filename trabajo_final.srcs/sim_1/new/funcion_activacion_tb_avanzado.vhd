----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2021 21:53:00
-- Design Name: 
-- Module Name: funcion_activacion_tb_avanzado - Behavioral
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
use std.textio.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity funcion_activacion_tb_avanzado is
--  Port ( );
end funcion_activacion_tb_avanzado;

architecture Behavioral of funcion_activacion_tb_avanzado is

component funcion_activacion_2 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x : in signed (11 downto 0);
           y : out unsigned (11 downto 0);
           ready:out std_logic;
           control_lineal: in std_logic;
           control_T: in std_logic
           );
end component;

signal clk : std_logic;
signal reset: std_logic;
signal x : signed (11 downto 0):=(others=>'0');
signal y : unsigned (11 downto 0);
signal ready:std_logic;
signal control_lineal:std_logic:='0';
signal control_T:std_logic:='1';

constant clk_period : time := 100 ns; 
--12 bits cuad
constant frec_cambio : time := 2190 ns; 
--8 bits lin
--constant frec_cambio : time := 490 ns; 
--8 bits cuad
--constant frec_cambio : time := 1590 ns; 
--4 bits lin
--constant frec_cambio : time := 290 ns; 

begin

UUT:funcion_activacion_2
Port map(clk=>clk,
        reset =>reset,
        x =>x,
        y =>y,
        control_lineal=>control_lineal,
        control_T=>control_T,
        ready=>ready
);

clk_process:process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

--Valores iniciales
--process
--begin
--    if control_lineal='1' then
--        if control_T='0' then
--            x(11 downto 4)<=(others=>'0');
--            x(3 downto 0)<="1011"; --x=2
--        else
--            x(11 downto 8)<=(others=>'0');
--            x(7 downto 0)<="10111000"; --x=2
--        end if;
    
--    else
--        if control_T='0' then
--            x(11 downto 8)<=(others=>'0');
--            x(7 downto 0)<="10111000"; --x=2
--        else
--            x<="101100100100"; --x=2
--        end if;
--    end if; 
--wait;
--end process;

--señal de reset (antes de meter un valor nuevo se activa)
process 
begin
    reset<='1';
    --12 bits avanza de 1 en 1
    x<=x+64;
    --8 bits avanza de 1 en 1
    --x<=x+4;
    --4 bits avanza de 1 en 1
    --x<=x+1;
    
    wait for 10 ns;
    reset<='0';
    wait for frec_cambio;
end process;


WRITE_PROCESS:PROCESS(reset)
FILE out_file : text OPEN write_mode IS "yCuad_16.dat";
variable out_line : line;
variable sample_out_matlab: real;

begin
if(reset'event and reset='1')then
    --12 bits
    sample_out_matlab := real(to_integer(unsigned(y(11 downto 0))))/4096.0;
    --8 bits
    --sample_out_matlab := real(to_integer(unsigned(y(7 downto 0))))/256.0;
    --4 bits
    --sample_out_matlab := real(to_integer(unsigned(y(3 downto 0))))/16.0;
    Write(out_line, sample_out_matlab);
    WriteLine(out_file,out_line);

end if;
end process;
end Behavioral;
