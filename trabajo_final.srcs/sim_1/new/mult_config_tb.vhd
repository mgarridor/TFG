----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.02.2021 17:51:45
-- Design Name: 
-- Module Name: mult_config_tb - Behavioral
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

entity mult_config_tb is
--  Port ( );
end mult_config_tb;

architecture Behavioral of mult_config_tb is

component mult_config is
    generic(control : STD_LOGIC_VECTOR (1 downto 0)
           );
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           S : out STD_LOGIC_VECTOR (63 downto 0);
           Ma : in std_logic;
           Mb : in std_logic
           );
end component;

signal A,B:std_logic_vector(31 downto 0);
signal S : STD_LOGIC_VECTOR (63 downto 0);
signal Ma : std_logic;
signal Mb : std_logic;

signal A8,B8:std_logic_vector(7 downto 0);
signal S8:std_logic_vector(15 downto 0);

signal A41,B41,A42,B42,A43,B43,A44,B44:std_logic_vector(3 downto 0);
signal S41,S42,S43,S44:std_logic_vector(7 downto 0);
begin

comp:mult_config 
generic map(
    control=>"01"
    )
port map(
    A=>A,
    B=>B,
    S=>S,
    Ma=>Ma,
    Mb=>Mb
);

process
begin

--1 multiplexor de 8 bits
A(31 downto 8)<=(others=>'0');
A(7 downto 0)<="10000000";

B(31 downto 8)<=(others=>'0');
B(7 downto 0)<="10000000";


--4 multiplexores de 4 bits
A(31 downto 15)<=(others=>'0');
A(3 downto 0)<="1000";
A(7 downto 4)<="1000";
A(11 downto 8)<="1000";
A(15 downto 12)<="1000";

B(31 downto 15)<=(others=>'0');
B(3 downto 0)<="1000";
B(7 downto 4)<="1000";
B(11 downto 8)<="1000";
B(15 downto 12)<="1000";




Ma<='0';
Mb<='0';
wait for 10 ns;

for i in 0 to 100 loop 
A<=std_logic_vector(unsigned(A)+3);
B<=std_logic_vector(unsigned(B)+5);

wait for 50 ns;
end loop;

wait;
end process;

----------------------------
A8<=A(7 downto 0);
B8<=B(7 downto 0);
S8<=S(15 downto 0);

---------------------------
A41<=A(3 downto 0);
B41<=B(3 downto 0);
S41<=S(7 downto 0);

A42<=A(7 downto 4);
B42<=B(7 downto 4);
S42<=S(15 downto 8);

A43<=A(11 downto 8);
B43<=B(11 downto 8);
S43<=S(23 downto 16);

A44<=A(15 downto 12);
B44<=B(15 downto 12);
S44<=S(31 downto 24);







end Behavioral;
