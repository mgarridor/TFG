----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2021 18:40:00
-- Design Name: 
-- Module Name: control_neurona - Behavioral
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

entity control_neurona is
    Port ( s_in : in signed (11 downto 0);
           num_bits : in natural;
           mult_ready : in STD_LOGIC;
           s_out: out signed (11 downto 0); 
           recibir_datos : out std_logic:='1';
           enable_suma : out std_logic;          
           clk: in std_logic;
           reset:in std_logic
           );
end control_neurona;

architecture Behavioral of control_neurona is

signal s4_1,s4_2,s4_3:signed(3 downto 0);
signal s2_1,s2_2,s2_3,s2_4,s2_5,s2_6:signed(1 downto 0);
signal primer_valor:std_logic:='1';
type estados is (S0, S41,S42, S21,S22,S23,S24,S25);
signal estado_actual,estado_siguiente :estados:=S0;
begin


process(clk,reset)
begin
    if(reset='1') then
        estado_actual<=S0;
    elsif(rising_edge(clk)) then
        estado_actual<=estado_siguiente;
    end if;

end process;

--Separo los valores de x y w cuando tienen menos de 8 bits

s4_1<=s_in(3 downto 0);
s4_2<=s_in(7 downto 4);
s4_3<=s_in(11 downto 8);
s2_1<=s_in(1 downto 0);
s2_2<=s_in(3 downto 2);
s2_3<=s_in(5 downto 4);
s2_4<=s_in(7 downto 6);
s2_5<=s_in(9 downto 8);
s2_6<=s_in(11 downto 10);


--cambio de estados y de salidas
process (mult_ready,s_in,estado_actual,estado_siguiente)
begin
estado_siguiente<=S0;
s_out<=(others=>'0');
enable_suma<='1';
if primer_valor='1' then
    recibir_datos<='1';
else
    recibir_datos<='0';
end if;
case estado_actual is
    
    when S0=>
        if mult_ready='1' then
            enable_suma<='1';
            if (num_bits=8 or num_bits=12) then
                estado_siguiente<=S0;
                s_out<=s_in;
                recibir_datos<='1';
                primer_valor<='0';

            elsif (num_bits=4) then
                estado_siguiente<=S41;
                s_out(11 downto 4)<=(others=>'0');  
                s_out(3 downto 0)<=s4_1;  
                recibir_datos<='0';
                primer_valor<='0';
            else
                estado_siguiente<=S21;
                s_out(11 downto 2)<=(others=>'0');
                s_out(1 downto 0)<=s2_1;  
                recibir_datos<='0';
                primer_valor<='0';
            end if;
        else
            enable_suma<='0';
        end if;
    when S41=>
        estado_siguiente<=S42;
        s_out(11 downto 4)<=(others=>'0');
        s_out(3 downto 0)<=s4_2;
        recibir_datos<='0';    
        primer_valor<='0';   
    when S42=>
        estado_siguiente<=S0;
        s_out(11 downto 4)<=(others=>'0');
        s_out(3 downto 0)<=s4_3;
        recibir_datos<='1'; 
        primer_valor<='0';
    when S21=>
        estado_siguiente<=S22;
        s_out(11 downto 2)<=(others=>'0');
        s_out(1 downto 0)<=s2_2;
        recibir_datos<='0';
        primer_valor<='0';
    when S22=>
        estado_siguiente<=S23;
        s_out(11 downto 2)<=(others=>'0');
        s_out(1 downto 0)<=s2_3;
        recibir_datos<='0';
        primer_valor<='0';
    when S23=>
        estado_siguiente<=S24;
        s_out(11 downto 2)<=(others=>'0');
        s_out(1 downto 0)<=s2_4;
        recibir_datos<='0';
        primer_valor<='0';
    when S24=>
        estado_siguiente<=S25;
        s_out(11 downto 2)<=(others=>'0');
        s_out(1 downto 0)<=s2_5;
        recibir_datos<='0';
        primer_valor<='0';
    when others=> 
        estado_siguiente<=S0;
        s_out(11 downto 2)<=(others=>'0');
        s_out(1 downto 0)<=s2_6;
        recibir_datos<='1';
        primer_valor<='0';
    
end case;

end process;

    
end Behavioral;
