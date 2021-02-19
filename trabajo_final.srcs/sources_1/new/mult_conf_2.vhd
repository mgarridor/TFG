----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2021 12:39:13
-- Design Name: 
-- Module Name: mult_config - Behavioral
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

entity mult_config_2 is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           S : out STD_LOGIC_VECTOR (63 downto 0);
           Ma : in std_logic;
           Mb : in std_logic;
           control : in STD_LOGIC_VECTOR (1 downto 0);
           clk: in std_logic;
           reset: in std_logic;
           ready: out std_logic
           );
end mult_config_2;

architecture Behavioral of mult_config_2 is
component FAB_mini is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
           B : in STD_LOGIC_VECTOR (1 downto 0);
           left : in STD_LOGIC_VECTOR (2 downto 0);
           bottomL : in STD_LOGIC;
           bottom : in STD_LOGIC_VECTOR (1 downto 0);
           bottom4 : out STD_LOGIC;
           right : out STD_LOGIC_VECTOR (2 downto 0);
           sum : out STD_LOGIC_VECTOR (2 downto 0);
           top : out STD_LOGIC_VECTOR (1 downto 0);
           top4 : in STD_LOGIC;
           topR : out STD_LOGIC;
           Cl : in STD_LOGIC;
           Cr : in STD_LOGIC;
           Ct : in STD_LOGIC;
           Cb : in STD_LOGIC;
           Ma : in STD_LOGIC;
           Mb : in STD_LOGIC);
end component;


signal left_1,left_2,left_3,left_4:std_logic_vector(2 downto 0);
signal right_1,right_2,right_3,right_4:std_logic_vector(2 downto 0);

signal top_1,top_2,top_3,top_4:std_logic_vector(1 downto 0);

signal top2_1,top2_2,top2_3,top2_4:std_logic;

signal topR_2,topR_3,topR_4:std_logic;
signal bottomL_1,bottomL_2,bottomL_3:std_logic;

signal sum_1,sum_2,sum_3,sum_4:std_logic_vector(2 downto 0);

--entradas
signal A1,A2,A3,A4:std_logic_vector(1 downto 0);

signal B1,B2,B3,B4:std_logic_vector(1 downto 0);

--salidas
signal sum1:std_logic_vector(2 downto 0);
signal sum2:std_logic_vector(2 downto 0);
signal sum3:std_logic_vector(2 downto 0);
signal sum4:std_logic_vector(2 downto 0);

--controles de posicion
signal Ct2,Ct3,Ct4:std_logic;
signal Cl1,Cl2,Cl3,Cl4:std_logic;
signal Cb1,Cb2,Cb3:std_logic;
signal Cr1,Cr2,Cr3,Cr4:std_logic;

signal contador:unsigned(1 downto 0);

--controles de signo
signal Ma11,Ma12,Ma13,Ma21,Ma22,Ma23,Ma31,Ma32,Ma33,Ma41,Ma42,Ma43:std_logic;
signal Mb11,Mb12,Mb13,Mb14,Mb21,Mb22,Mb23,Mb24,Mb31,Mb32,Mb33,Mb34:std_logic;




begin

--primera columna
comp1: FAB_mini
port map(
    A=>A1,
    B=>B1,
    left=>left_1,
    bottomL=>bottomL_1,
    bottom=>top_2,
    bottom4=>top2_2,
    right=>right_1,
    sum=>sum_1,
    top=>top_1,
    top4=>top2_1,
    topR=>open,
    Cl=>Cl1,
    Cr=>Cr1,
    Ct=>'0',
    Cb=>Cb1,
    Ma=>Ma11,
    Mb=>Mb11
);

comp2: FAB_mini
port map(
    A=>A2,
    B=>B2,
    left=>left_2,
    bottomL=>bottomL_2,
    bottom=>top_3,
    bottom4=>top2_3,
    right=>right_2,
    sum=>sum_2,
    top=>top_2,
    top4=>top2_2,
    topR=>topR_2,
    Cl=>Cl2,
    Cr=>Cr2,
    Ct=>Ct2,
    Cb=>Cb2,
    Ma=>Ma21,
    Mb=>Mb21
);

comp3: FAB_mini 
port map(
    A=>A3,
    B=>B3,
    left=>left_3,
    bottomL=>bottomL_3,
    bottom=>top_4,
    bottom4=>top2_4,
    right=>right_3,
    sum=>sum_3,
    top=>top_3,
    top4=>top2_3,
    topR=>topR_3,
    Cl=>Cl3,
    Cr=>Cr3,
    Ct=>Ct3,
    Cb=>Cb3,
    Ma=>Ma31,
    Mb=>Mb31
);

comp4: FAB_mini 
port map(
    A=>A4,
    B=>B4,
    left=>left_4,
    bottomL=>'0',
    bottom=>(others=>'0'),
    bottom4=>open,
    right=>right_4,
    sum=>sum_4,
    top=>top_4,
    top4=>top2_4,
    topR=>topR_4,
    Cl=>Cl4,
    Cr=>Cr4,
    Ct=>Ct4,
    Cb=>'0',
    Ma=>Ma41,
    Mb=>Mb
);

--registro de entrada
process(clk,reset)
begin
--reset asincrono
    if(reset = '1')then
    
        right_1<= (others=>'0');
        right_2<= (others=>'0');
        right_3<= (others=>'0');
        right_4<= (others=>'0');
        
        topR_2<= '0';
        topR_3<= '0';
        topR_4<= '0';
        
        contador<="00";
        
    elsif (rising_edge(clk))then
    
        right_1<= left_1;
        right_2<= left_2;
        right_3<= left_3;
        right_4<= left_4;
        
        topR_2<= bottomL_1;
        topR_3<= bottomL_2;
        topR_4<= bottomL_3;
        
        contador<=contador+1;
                
    end if;
end process;


--control
--  si 00 => 1 multiplicador 8x8
--  si 01 => 4 multiplicadores 4x4
--``si 10 => 16 multiplicadores 2x2
     
    --entradas  
process(clk)
begin 
 
if contador="00" then
    A1<=A(1 downto 0);
elsif contador="01" and control="00" then
    A1<=A(3 downto 2);
elsif contador="10" and control="00" then
    A1<=A(5 downto 4);
elsif contador="11" and control="00" then
    A1<=A(7 downto 6);
    
elsif contador(0)='0' and control="01" then
    A1<=A(3 downto 2);
elsif contador="10" and control="01" then
    A1<=A(5 downto 4);
elsif contador="11" and control="00" then
    A1<=A(7 downto 6);  
 
 
 
 
if(control="00")then
    if(contador="00") then
    A1<=A(1 downto 0);
    A2<=A(1 downto 0);
    A3<=A(1 downto 0);
    A3<=A(1 downto 0);
    
    B1<=B(1 downto 0);
    B1<=B(3 downto 2);
    B1<=B(5 downto 4);
    B1<=B(7 downto 6);
    end if;
    
    if(contador="01") then
    A1<=A(3 downto 2);
    A2<=A(3 downto 2);
    A3<=A(3 downto 2);
    A3<=A(3 downto 2);
    
    B1<=B(1 downto 0);
    B1<=B(3 downto 2);
    B1<=B(5 downto 4);
    B1<=B(7 downto 6);
    end if;

    if(contador="10") then
    A1<=A(5 downto 4);
    A2<=A(5 downto 4);
    A3<=A(5 downto 4);
    A3<=A(5 downto 4);
    
    B1<=B(1 downto 0);
    B1<=B(3 downto 2);
    B1<=B(5 downto 4);
    B1<=B(7 downto 6);
    end if;
    
    if(contador="11") then
    A1<=A(7 downto 6);
    A2<=A(7 downto 6);
    A3<=A(7 downto 6);
    A3<=A(7 downto 6);
    
    B1<=B(1 downto 0);
    B1<=B(3 downto 2);
    B1<=B(5 downto 4);
    B1<=B(7 downto 6);
    end if;   
    
end if;






end process;
end Behavioral;
