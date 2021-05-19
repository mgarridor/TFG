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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
signal control_lineal : STD_LOGIC:='0';
signal control_tramos : STD_LOGIC:='0';
signal clk : std_logic;
signal num_bits: natural:=8;
constant clk_period : time := 100 ns; 
signal num_entradas : natural :=4;

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

--reset
process
begin
reset<='1';
ready_in<='0';
wait for 10 ns;
reset<='0';
ready_in<='1';
wait for 1850 ns;
ready_in<='0';
wait;
end process;
--Test 1 valor
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
                    x(7 downto 4)<="0001"; --x=1
                    x(3 downto 0)<="0001"; --x=1
                    
                    w(11 downto 8)<="0001"; --x=1
                    w(7 downto 4)<="0001"; --x=1
                    w(3 downto 0)<="0001"; --x=1
                when 8 => 
                    x(11 downto 8)<=(others=>'0');
                    x(7 downto 0)<="00010000"; --x=2
                    w(11 downto 8)<=(others=>'0');
                    w(7 downto 0)<="00010000"; --x=2
                when others => 
                    x<="000001000000"; --x=2
                    w<="000001000000"; --x=2
            end case;
            num_entradas<=num_entradas-1;
        elsif num_entradas=0 then
                fin_datos<='1';
        end if;
    end if;
--    if control_lineal='1' then
--        if control_tramos='0' then
--            x(11 downto 2)<=(others=>'0');
--            x(1 downto 0)<="01"; --x=8
--            w(11 downto 2)<=(others=>'0');
--            w(1 downto 0)<="01"; --x=8
--        else
--            x(11 downto 4)<=(others=>'0');
--            x(3 downto 0)<="0001"; --x=1
--            w(11 downto 4)<=(others=>'0');
--            w(3 downto 0)<="0001"; --x=1
--        end if;
    
--    else
--        if control_tramos='0' then
--            x(11 downto 8)<=(others=>'0');
--            x(7 downto 0)<="0001"; --x=2
--            w(11 downto 8)<=(others=>'0');
--            w(7 downto 0)<="0001"; --x=2
--        else
--            x<="100100000000"; --x=2
--            w<="100100000000"; --x=2
--        end if;
--    end if; 
    
--    x<=std_logic_vector(signed(x)+1);
--    w<=std_logic_vector(signed(w)+2);


--    wait;
end process;


--Test varios valores
--process
--begin
--    reset<='1';
--    wait for 10 ns;
--    reset<='0';
--    for item in 1 to num_entradas loop 
--        if recibir_datos='1' then
--            x<=std_logic_vector(signed(x)+1);
--            w<=std_logic_vector(signed(w)+2);
--        end if;
        
--    end loop;
--    fin_datos<='1';
--    wait;
--end process;


end Behavioral;
