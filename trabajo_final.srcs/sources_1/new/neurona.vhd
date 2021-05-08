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
           w : in std_logic_vector (11 downto 0);
           num_bits:in natural;
           y : out unsigned (11 downto 0);
           reset : in STD_LOGIC;
           fin_datos: in STD_LOGIC;
           recibir_datos: out STD_LOGIC;
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
    Port ( s_in : in signed (11 downto 0);
           num_bits : in natural;
           mult_ready : in STD_LOGIC;
           s_out: out signed (11 downto 0); 
           recibir_datos : out std_logic;
           enable_suma : out std_logic;          
           clk: in std_logic;
           reset:in std_logic
           );
end component;

signal s_out : signed(11 downto 0);

signal temp  : signed(11 downto 0);
signal temp2 : std_logic;
signal r2_reg,r2_next : signed(11 downto 0);
signal r3_reg,r3_next : signed(11 downto 0);

signal control_mult:std_logic_vector(1 downto 0);
signal s_mult:std_logic_vector(23 downto 0);
signal mult_ready:std_logic;
signal sum_ready:std_logic;

signal reset_fa:std_logic;
signal x_final:signed(11 downto 0);

signal enable_suma:std_logic;

begin

multiplicador: mult_config_3
port map(
    A=>x,
    B=>w,
    S=>s_mult,
    Ma=>'1',
    Mb=>'1',
    control=>control_mult,
    clk=>clk,
    reset=>temp2,
    ready=>mult_ready
);

f_activacion:funcion_activacion_2
Port map(
    clk=>clk,
    reset =>reset_fa,
    x =>r3_reg,
    y =>y,
    control_lineal=>control_lineal,
    control_T=>control_tramos,
    ready=>ready
);

control:control_neurona
Port map(
    s_in=>temp,
    num_bits=>num_bits,
    mult_ready=>mult_ready,
    s_out=>s_out,
    enable_suma=>enable_suma,
    recibir_datos=>temp2,
    clk=>clk,
    reset=>reset
);
process(clk,reset)
begin
    if(reset='1') then
        r2_reg<=(others=>'0');
        r3_reg<=(others=>'0');
    elsif(rising_edge(clk)) then
        if enable_suma='1' then
            r2_reg<=r2_next;
        end if;
        if fin_datos='1' then 
            r3_reg<=r3_next;
        end if;
    end if;

end process;

--sumador
temp<=signed(s_mult(s_mult'left)&s_mult(10 downto 0));
r2_next<= s_out + r2_reg;

--multiplexores
with num_bits select control_mult<=
    "00" when 8,
    "01" when 4,
    "10" when 2,
    "11" when others;
    
reset_fa<= not(sum_ready);
r3_next<=r2_reg when sum_ready='1' else
        r3_reg;
        
        
 recibir_datos<=temp2;       
end Behavioral;
