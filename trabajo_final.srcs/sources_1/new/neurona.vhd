----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2021 21:12:18
-- Design Name: 
-- Module Name: neurona - Behavioral
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

entity neurona is
    Port ( x : in std_logic_vector (11 downto 0);
           y : out unsigned (11 downto 0);
           reset: in STD_LOGIC;
           sending_data: in STD_LOGIC;
           ready: out STD_LOGIC;
           control_lineal : in STD_LOGIC;
           control_tramos : in STD_LOGIC;
           clk : in std_logic);
end neurona;

architecture Behavioral of neurona is

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

component control_neurona is
    Port ( control_lineal : in STD_LOGIC;
           control_tramos : in STD_LOGIC;
           x_in : in STD_LOGIC_VECTOR (11 downto 0);
           sending_data:in STD_LOGIC;
           x1: out std_logic_vector (11 downto 0); 
           x2: out std_logic_vector (11 downto 0); 
           control_mult : out std_logic_vector(1 downto 0);
           mult_ready : in STD_LOGIC;
           sum_ready : out STD_LOGIC);
end component;

signal r1_reg,r1_next : signed(11 downto 0);

signal x1,x2:std_logic_vector(11 downto 0);
signal control_mult:std_logic_vector(1 downto 0);
signal s_mult:std_logic_vector(11 downto 0);
signal mult_ready:std_logic;
signal sum_ready:std_logic;

signal reset_fa:std_logic;
signal x_final:signed(11 downto 0);

signal x_in:std_logic_vector(11 downto 0);

begin

multiplicador: mult_config_3
port map(
    A=>x1,
    B=>x2,
    S=>s_mult,
    Ma=>'1',
    Mb=>'1',
    control=>control_mult,
    clk=>clk,
    reset=>reset,
    ready=>mult_ready
);

f_activacion:funcion_activacion_2
Port map(clk=>clk,
    reset =>reset_fa,
    x =>x_final,
    y =>y,
    control_lineal=>control_lineal,
    control_T=>control_tramos,
    ready=>ready
);

control:control_neurona
port map( control_lineal=>control_lineal,
    control_tramos =>control_tramos,
    x_in =>x_in,
    sending_data=>sending_data,
    x1=>x1,
    x2=>x2,
    control_mult=>control_mult,
    mult_ready=>mult_ready,
    sum_ready=>sum_ready
);

process(clk,reset)
begin
    if(reset='1') then
        r1_reg<=(others=>'0');
    elsif(rising_edge(clk)) then
        r1_reg<=r1_next;
    end if;

end process;

--sumador
r1_next<=signed(s_mult) + r1_reg;

--multiplexores
reset_fa<= not(sum_ready);
x_final<=r1_next when sum_ready='1' else
        (others=>'0');
        
        
end Behavioral;
