


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

entity mult_config_3 is
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
end mult_config_3;

architecture Behavioral of mult_config_3 is
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


signal left_1,left_2,left_3,left_4:std_logic_vector(2 downto 0):="000";
signal right_1,right_2,right_3,right_4:std_logic_vector(2 downto 0):="000";

signal top_1,top_2,top_3,top_4:std_logic_vector(1 downto 0);

signal top2_2,top2_3,top2_4:std_logic;

signal topR_2,topR_3,topR_4:std_logic;
signal bottomL_1,bottomL_2,bottomL_3:std_logic:='0';

signal sum_1,sum_2,sum_3,sum_4:std_logic_vector(2 downto 0);

--entradas
signal A1,A2,A3,A4:std_logic_vector(1 downto 0):="00";

signal B1,B2,B3,B4:std_logic_vector(1 downto 0):="00";

--controles de posicion
signal Ct2,Ct3,Ct4:std_logic;
signal Cl:std_logic;
signal Cb1,Cb2,Cb3:std_logic;
signal Cr:std_logic;

signal contador:unsigned(1 downto 0);
signal primera_cuenta:std_logic;

--controles de signo
signal Ma1,Ma2,Ma3,Ma4:std_logic;
signal Mb1,Mb2,Mb3,Mb4:std_logic;




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
    top4=>'0',
    topR=>open,
    Cl=>Cl,
    Cr=>Cr,
    Ct=>'0',
    Cb=>Cb1,
    Ma=>Ma1,
    Mb=>Mb1
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
    Cl=>Cl,
    Cr=>Cr,
    Ct=>Ct2,
    Cb=>Cb2,
    Ma=>Ma2,
    Mb=>Mb2
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
    Cl=>Cl,
    Cr=>Cr,
    Ct=>Ct3,
    Cb=>Cb3,
    Ma=>Ma3,
    Mb=>Mb3
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
    Cl=>Cl,
    Cr=>Cr,
    Ct=>Ct4,
    Cb=>'0',
    Ma=>Ma4,
    Mb=>Mb4
);

--registro de entrada
process(clk,reset)
begin
--reset asincrono
    if(reset = '1')then
--        A1<= (others=>'0');
--        A2<= (others=>'0');
--        A3<= (others=>'0');
--        A4<= (others=>'0');
        
--        B1<= (others=>'0');
--        B2<= (others=>'0');
--        B3<= (others=>'0');
--        B4<= (others=>'0'); 
               
        left_1<= (others=>'0');
        left_2<= (others=>'0');
        left_3<= (others=>'0');
        left_4<= (others=>'0');
        
        bottomL_1<= '0';
        bottomL_2<= '0';
        bottomL_3<= '0';
        
        
        
        contador<="00";
        primera_cuenta<='1';
    elsif (rising_edge(clk))then
    
        right_1<= left_1;
        right_2<= left_2;
        right_3<= left_3;
        right_4<= left_4;
        
        topR_2<= bottomL_1;
        topR_3<= bottomL_2;
        topR_4<= bottomL_3;
        
        contador<=contador+1;
        primera_cuenta<='0';  
    end if;
end process;


--control
--  si 00 => 1 multiplicador 8x8
--  si 01 => 4 multiplicadores 4x4
--``si 10 => 16 multiplicadores 2x2
     
--entradas  
process(clk)
begin 
     
    --A1
    --control 00,01,10
    if contador="00" then
        A1<=A(1 downto 0);
    elsif contador="01" then
        A1<=A(3 downto 2);
    elsif contador="10" then
        A1<=A(5 downto 4);
    elsif contador="11" then
        A1<=A(7 downto 6);
    end if;
    
    --A2
    --control 00,01
    if contador="00" and control(0)='0' then
        A2<=A(1 downto 0);
    elsif contador="01" and control(0)='0' then
        A2<=A(3 downto 2);
    elsif contador="10" and control(0)='0' then
        A2<=A(5 downto 4);
    elsif contador="11" and control(0)='0' then
        A2<=A(7 downto 6);
    end if;
    
    --control 10
    if contador="00" and control="10" then
        A2<=A(9 downto 8);
    elsif contador="01" and control="10" then
        A2<=A(11 downto 10);
    elsif contador="10" and control="10" then
        A2<=A(13 downto 12);
    elsif contador="11" and control="10" then
        A2<=A(15 downto 14);
    end if;
    
    --A3
    --control 00
    if contador="00" and control="00" then
        A3<=A(1 downto 0);
    elsif contador="01" and control="00" then
        A3<=A(3 downto 2);
    elsif contador="10" and control="00" then
        A3<=A(5 downto 4);
    elsif contador="11" and control="00" then
        A3<=A(7 downto 6);
    end if;
        
    --control 01
    if contador="00" and control="01" then
        A3<=A(9 downto 8);
    elsif contador="01" and control="01" then
        A3<=A(11 downto 10);
    elsif contador="10" and control="01" then
        A3<=A(13 downto 12);
    elsif contador="11" and control="01" then
        A3<=A(15 downto 14);
    end if;
        
    --control 10
    if contador="00" and control="10" then
        A3<=A(17 downto 16);
    elsif contador="01" and control="10" then
        A3<=A(19 downto 18);
    elsif contador="10" and control="10" then
        A3<=A(21 downto 20);
    elsif contador="11" and control="10" then
        A3<=A(23 downto 22);
    end if;
    
    --A4
    --control 00
    if contador="00" and control="00" then
        A4<=A(1 downto 0);
    elsif contador="01" and control="00" then
        A4<=A(3 downto 2);
    elsif contador="10" and control="00" then
        A4<=A(5 downto 4);
    elsif contador="11" and control="00" then
        A4<=A(7 downto 6);
    end if;
        
    --control 01
    if contador="00" and control="01" then
        A4<=A(9 downto 8);
    elsif contador="01" and control="01" then
        A4<=A(11 downto 10);
    elsif contador="10" and control="01" then
        A4<=A(13 downto 12);
    elsif contador="11" and control="01" then
        A4<=A(15 downto 14);
    end if;
        
    --control 10
    if contador="00" and control="10" then
        A4<=A(25 downto 24);
    elsif contador="01" and control="10" then
        A4<=A(27 downto 26);
    elsif contador="10" and control="10" then
        A4<=A(29 downto 28);
    elsif contador="11" and control="10" then
        A4<=A(31 downto 30);
    end if;
    
    --B1
    --control 00
    if control="00" then
        B1<=B(1 downto 0);
    end if;
        
    --control 01
    if contador(1)='0' and control="01" then
        B1<=B(1 downto 0);
    elsif contador(1)='1' and control="01" then
        B1<=B(5 downto 4);
    end if;
    
    --control 10
    if contador="00" and control="10" then
        B1<=A(1 downto 0);
    elsif contador="01" and control="10" then
        B1<=A(3 downto 2);
    elsif contador="10" and control="10" then
        B1<=A(5 downto 4);
    elsif contador="11" and control="10" then
        B1<=A(7 downto 6);
    end if;
    
    --B2
    --control 00
    if control="00" then
        B2<=B(3 downto 2);
    end if;    
        
    --control 01
    if contador(1)='0' and control="01" then
        B2<=B(3 downto 2);
    elsif contador(1)='1' and control="01" then
        B2<=B(7 downto 6);
    end if;
    
    --control 10
    if contador="00" and control="10" then
        B2<=A(9 downto 8);
    elsif contador="01" and control="10" then
        B2<=A(11 downto 10);
    elsif contador="10" and control="10" then
        B2<=A(13 downto 12);
    elsif contador="11" and control="10" then
        B2<=A(15 downto 14);
    end if;
    
    --B3
    --control 00
    if control="00" then
        B3<=B(5 downto 4);
    end if;    
        
    --control 01
    if contador(1)='0' and control="01" then
        B3<=B(9 downto 8);
    elsif contador(1)='1' and control="01" then
        B3<=B(13 downto 12);
    end if;
    
    --control 10
    if contador="00" and control="10" then
        B3<=A(17 downto 16);
    elsif contador="01" and control="10" then
        B3<=A(19 downto 18);
    elsif contador="10" and control="10" then
        B3<=A(21 downto 20);
    elsif contador="11" and control="10" then
        B3<=A(23 downto 22);
    end if;
    
    --B4
    --control 00
    if control="00" then
        B4<=B(7 downto 6);        
    --control 01
    elsif contador(1)='0' and control="01" then
        B4<=B(11 downto 10);
    elsif contador(1)='1' and control="01" then
        B4<=B(15 downto 14);    
    --control 10
    elsif contador="00" and control="10" then
        B4<=A(25 downto 24);
    elsif contador="01" and control="10" then
        B4<=A(27 downto 26);
    elsif contador="10" and control="10" then
        B4<=A(29 downto 28);
    elsif contador="11" and control="10" then
        B4<=A(31 downto 30);
    else
        B4<=(others=>'0');
    end if;
    
    
 
    --soluciones
    --control 00
    if contador="00" and control="00"then
        S(1 downto 0)<=top_1;
    elsif contador="01" and control="00"then
        S(3 downto 2)<=top_1;
    elsif contador="10" and control="00"then
        S(5 downto 4)<=top_1;    
    elsif contador="11" and control="00"then
        S(15 downto 6)<=sum_4(2 downto 1) & sum_3(2 downto 1) & sum_2(2 downto 1) & sum_1 & top_1(0);
    end if;
    
    --control 01
    if contador="00" and control="01" then
        S(1 downto 0)<=top_1;
        S(17 downto 16)<=top_3;
    elsif contador="01" and control="01" then
        S(7 downto 2)<=sum_2(2 downto 1) & sum_1 & top_1(0);
        S(23 downto 18)<=sum_4(2 downto 1) & sum_3 & top_3(0);
    elsif contador="10" and control="01" then
        S(9 downto 8)<=top_1;
        S(25 downto 24)<=top_3;
    elsif contador="11" and control="01" then
        S(15 downto 10)<=sum_2(2 downto 1) & sum_1 & top_1(0);
        S(31 downto 26)<=sum_4(2 downto 1) & sum_3 & top_3(0);
    end if;
    
    --control 10
    if contador="00" and control="10" then
        S(3 downto 0)<=sum_1 & top_1(0);
        S(19 downto 16)<=sum_2 & top_2(0);
        S(35 downto 32)<=sum_3 & top_3(0);
        S(51 downto 48)<=sum_4 & top_4(0);
    elsif contador="01" and control="10" then
        S(7 downto 4)<=sum_1 & top_1(0);
        S(23 downto 20)<=sum_2 & top_2(0);
        S(39 downto 36)<=sum_3 & top_3(0);
        S(55 downto 52)<=sum_4 & top_4(0);    
    elsif contador="10" and control="10" then
        S(11 downto 8)<=sum_1 & top_1(0);
        S(27 downto 24)<=sum_2 & top_2(0);
        S(43 downto 40)<=sum_3 & top_3(0);
        S(59 downto 56)<=sum_4 & top_4(0);    
    elsif contador="11" and control="10" then
        S(15 downto 12)<=sum_1 & top_1(0);
        S(31 downto 28)<=sum_2 & top_2(0);
        S(47 downto 44)<=sum_3 & top_3(0);
        S(63 downto 60)<=sum_4 & top_4(0);    
    end if;
    
    --Ma,Mb
    if (control="00" and (contador="00" or contador="01" or contador="10")) or
       (control="01" and contador(0)='0') then
        Ma1<='0';
        Ma2<='0';
        Ma3<='0';
        Ma4<='0';
        
        Mb1<='0';
        Mb2<='0';
        Mb3<='0';
        Mb4<='0';
    else
        Ma1<=Ma;
        Ma2<=Ma;
        Ma3<=Ma;
        Ma4<=Ma;  
        
        Mb1<=Mb;
        Mb2<=Mb;
        Mb3<=Mb;
        Mb4<=Mb;  
    end if;
    
    --Cl
    if  (control="00" and contador="00") or 
        (control="01" and contador(0)='0') or 
        control="10" then
        
        Cl<='0';
    else 
        Cl<='1';
    end if;
    
    --Cr
    if  (control="00" and contador="11") or 
        (control="01" and contador(0)='1') or 
        control="10" then
        
        Cr<='0';
    else 
        Cr<='1';
    end if;
    
    --Ct
    if  control="01" then
        Ct2<='1';
        Ct3<='0';
        Ct4<='1';
    elsif control="10" then
        Ct2<='0';
        Ct3<='0';
        Ct4<='0';
    elsif control="00" then
        Ct2<='1';
        Ct3<='1';
        Ct4<='1';
    end if;
    
    --Cb
    if  control="01" then
        Cb1<='1';
        Cb2<='0';
        Cb3<='1';
    elsif control="10" then
        Cb1<='0';
        Cb2<='0';
        Cb3<='0';
    elsif control="00" then
        Cb1<='1';
        Cb2<='1';
        Cb3<='1';
    end if;
    
end process;

process (clk)
begin
if contador="00" then
        left_1<= (others=>'0');
        left_2<= (others=>'0');
        left_3<= (others=>'0');
        left_4<= (others=>'0');
        
        bottomL_1<= '0';
        bottomL_2<= '0';
        bottomL_3<= '0';
end if;    
end process;


ready<= '1' when contador="00" and primera_cuenta='0' else
        '0';

end Behavioral;



