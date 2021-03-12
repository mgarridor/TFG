----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 13:26:27
-- Design Name: 
-- Module Name: mult_config_3 - Behavioral
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

signal left_1,left_2,left_3,left_4,left_5,left_6:std_logic_vector(2 downto 0):="000";
signal right_1,right_2,right_3,right_4,right_5,right_6:std_logic_vector(2 downto 0):="000";

signal top_1,top_2,top_3,top_4,top_5,top_6:std_logic_vector(1 downto 0);

signal top2_2,top2_3,top2_4,top2_5,top2_6:std_logic;

signal topR_2,topR_3,topR_4,topR_5,topR_6:std_logic;
signal bottomL_1,bottomL_2,bottomL_3,bottomL_4,bottomL_5:std_logic:='0';

signal sum_1,sum_2,sum_3,sum_4,sum_5,sum_6:std_logic_vector(2 downto 0);

--entradas
signal A1,A2,A3,A4,A5,A6:std_logic_vector(1 downto 0):="00";

signal B1,B2,B3,B4,B5,B6:std_logic_vector(1 downto 0):="00";

--controles de posicion
signal Ct2,Ct3,Ct4,Ct5,Ct6:std_logic;
signal Cl:std_logic;
signal Cb1,Cb2,Cb3,Cb4,Cb5:std_logic;
signal Cr:std_logic;

signal primera_cuenta:std_logic;

--controles de signo
signal Ma1,Ma2,Ma3,Ma4,Ma5,Ma6:std_logic;
signal Mb1,Mb2,Mb3,Mb4,Mb5:std_logic;

--soluciones
signal S6,S7,S8,S10,S11,S12: std_logic_vector(1 downto 0);
signal S1_reg,S1_next : std_logic_vector(1 downto 0);
signal S2_reg,S2_next : std_logic_vector(1 downto 0);
signal S3_reg,S3_next : std_logic_vector(1 downto 0);
signal S4_reg,S4_next : std_logic_vector(1 downto 0);
signal S5_reg,S5_next : std_logic_vector(1 downto 0);
signal S9_reg,S9_next : std_logic_vector(1 downto 0);

--control
type state_type is (idle, E121,E122,E123,E124,E125,E126,E81,E82,E83,E84,E41,E42,E2);
signal state, next_state : state_type;

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
    bottomL=>bottomL_4,
    bottom=>top_5,
    bottom4=>top2_5,
    right=>right_4,
    sum=>sum_4,
    top=>top_4,
    top4=>top2_4,
    topR=>topR_4,
    Cl=>Cl,
    Cr=>Cr,
    Ct=>Ct4,
    Cb=>Cb4,
    Ma=>Ma4,
    Mb=>Mb4
);


comp5: FAB_mini 
port map(
    A=>A5,
    B=>B5,
    left=>left_5,
    bottomL=>bottomL_5,
    bottom=>top_6,
    bottom4=>top2_6,
    right=>right_5,
    sum=>sum_5,
    top=>top_5,
    top4=>top2_5,
    topR=>topR_5,
    Cl=>Cl,
    Cr=>Cr,
    Ct=>Ct5,
    Cb=>Cb5,
    Ma=>Ma5,
    Mb=>Mb5
);

comp6: FAB_mini 
port map(
    A=>A6,
    B=>B6,
    left=>left_6,
    bottomL=>'0',
    bottom=>(others=>'0'),
    bottom4=>open,
    right=>right_6,
    sum=>sum_6,
    top=>top_6,
    top4=>top2_6,
    topR=>topR_6,
    Cl=>Cl,
    Cr=>Cr,
    Ct=>Ct6,
    Cb=>'0',
    Ma=>Ma6,
    Mb=>Mb
);
--registro de entrada
process(clk,reset,control)
begin
--reset asincrono
    if(reset = '1')then
                   
        left_1<= (others=>'0');
        left_2<= (others=>'0');
        left_3<= (others=>'0');
        left_4<= (others=>'0');
        
        bottomL_1<= '0';
        bottomL_2<= '0';
        bottomL_3<= '0';
        
        S1_reg<=(others=>'0');
        S2_reg<=(others=>'0');
        S3_reg<=(others=>'0');
        S4_reg<=(others=>'0');
        S5_reg<=(others=>'0');
        S9_reg<=(others=>'0');
        state<=idle;
        primera_cuenta<='1';
    elsif (rising_edge(clk))then
    
        left_1<= right_1;
        left_2<= right_2;
        left_3<= right_3;
        left_4<= right_4;
        
        bottomL_1<= topR_2;
        bottomL_2<= topR_3;
        bottomL_3<= topR_4;
        
        S1_reg<=S1_next;
        S2_reg<=S2_next;
        S3_reg<=S3_next;
        S4_reg<=S5_next;
        S5_reg<=S3_next;
        S9_reg<=S5_next;
        
        state<=next_state;
        primera_cuenta<='0';  
    end if;
end process;


--control
--  si 00 => 1 multiplicador 8x8
--  si 01 => 4 multiplicadores 4x4
--``si 10 => 16 multiplicadores 2x2
 
 --control de estado           
process (reset,state,control,A,B)
begin

    case state is 

    when idle =>
        if control="00"  then
            next_state <= E81;
        elsif control="01" then
            next_state<= E41;
        elsif control="10" then
            next_state<= E2;
        end if;
    
    when E121=>
        next_state <= E122;
    when E122=>
        next_state <= E123;
    when E123=>
        next_state <= E124;
    when E124=>
        next_state <= E125;
    when E125=>
        next_state <= E126;
    when E126=>
        if control="00" then
            next_state <= E81;
        elsif control="01" then
            next_state<= E41;
        elsif control="10" then 
            next_state<= E2;
        else 
            next_state<= E121;
        end if;
    when E81=>
        next_state <= E82;
    when E82=>        
        next_state <= E83;
    when E83=>     
        next_state <= E84;
    when E84=>
        if control="00" then
            next_state <= E81;
        elsif control="01" then
            next_state<= E41;
        elsif control="10" then 
            next_state<= E2;
        else 
            next_state<= E121;
        end if;                  
    when E41=>
        next_state <= E42;
    when E42=>
        if control="00" then
            next_state <= E81;
        elsif control="01" then
            next_state<= E41;
        elsif control="10" then 
            next_state<= E2;
        else 
            next_state<= E121;
        end if;         
    when E2=>            
        if control="00" then
            next_state <= E81;
        elsif control="01" then
            next_state<= E41;
        elsif control="10" then 
            next_state<= E2;
        else 
            next_state<= E121;
        end if;        
    end case;
end process;    
     
 --A 
 
 A1<=A(1 downto 0) when state=E121 or state=E81 or state=E41 or state=E2 else
     A(3 downto 2) when state=E122 or state=E82 or state=E42 else
     A(5 downto 4) when state=E123 or state=E83 else
     A(7 downto 6) when state=E124 or state=E84 else
     A(9 downto 8) when state=E125 else
     A(11 downto 10);
     
 A2<=A(1 downto 0) when state=E121 or state=E81 or state=E41 else
     A(3 downto 2) when state=E122 or state=E82 or state=E42 or state=E2  else
     A(5 downto 4) when state=E123 or state=E83 else
     A(7 downto 6) when state=E124 or state=E84 else
     A(9 downto 8) when state=E125 else
     A(11 downto 10);
 
 A3<=A(1 downto 0) when state=E121 or state=E81 else
     A(3 downto 2) when state=E122 or state=E82 else
     A(5 downto 4) when state=E123 or state=E83 or state=E41 or state=E2 else
     A(7 downto 6) when state=E124 or state=E84 else
     A(9 downto 8) when state=E125 else
     A(11 downto 10);

 A4<=A(1 downto 0) when state=E121 or state=E81  else
     A(3 downto 2) when state=E122 or state=E82 else
     A(5 downto 4) when state=E123 or state=E83 or state=E41 else
     A(7 downto 6) when state=E124 or state=E84 or state=E42 or state=E2 else
     A(9 downto 8) when state=E125 else
     A(11 downto 10);
     
 A5<=A(1 downto 0) when state=E121 else
     A(3 downto 2) when state=E122 else
     A(5 downto 4) when state=E123 else
     A(7 downto 6) when state=E124 else
     A(9 downto 8) when state=E125 or state=E41 or state=E2 else
     A(11 downto 10);  
     
 A6<=A(1 downto 0) when state=E121 else
     A(3 downto 2) when state=E122 else
     A(5 downto 4) when state=E123 else
     A(7 downto 6) when state=E124 else
     A(9 downto 8) when state=E125 or state=E41 else
     A(11 downto 10);       
     
----B
--control 00 01 10
        B1<=B(1 downto 0);
        B2<=B(3 downto 2);
        B3<=B(5 downto 4);
        B4<=B(7 downto 6);  
        B5<=B(9 downto 8);
        B6<=B(11 downto 10);    
        
--soluciones  
S1_next<=top_1 when state=E121 or state=E81 or state=E41 else
         sum_1(0) & top_1(0) when state=E2 else
         S1_reg;
         
S2_next<=top_1 when state=E122 or state=E82 else
         sum_1(0) & top_1(0) when state=E42 else
         sum_1(2 downto 1) when state=E2 else
         (others=>'0') when state=E121 or state=E81 or state=E41 else
         S2_reg;

S3_next<=top_1 when state=E123 or state=E83 else
         sum_1(2 downto 1) when state=E42 else
         sum_2(0) & top_2(0) when state=E2 else
         (others=>'0') when state=E121 or state=E122 or state=E81 or state=E82 or state=E41 else
         S3_reg;
         
S4_next<=top_1 when state=E124 else
         sum_1(0)&top_1(0) when state=E84 else
         sum_2(2 downto 1) when state=E42 or state=E2 else
         S4_reg when state=E125 or state=E126 else
         (others=>'0');
    
S5_next<=top_1 when state=E125 else
         sum_1(2 downto 1) when state=E83 else
         top_3 when state=E41 else
         S5_reg when state=E42 or state=E126 else
         sum_3(0) & top_3(0) when state=E2 else
         (others=>'0');

S6<=sum_1(0)&top_1(0) when state=E126 else
    sum_2(2 downto 1) when state=E84 else
    sum_3(0) & top_3(0) when state=E42 else
    sum_3(2 downto 1) when state=E2 else
    (others=>'0');
    
S7<=sum_1(2 downto 1) when state=E126 else
    sum_3(2 downto 1) when state=E84 or state=E42 else
    sum_4(0) & top_4(0) when state=E2 else
    (others=>'0');  
    
S8<=sum_2(2 downto 1) when state=E126 else
    sum_4(2 downto 1) when state=E84 or state=E42 or state=E2 else
    (others=>'0');    
    
S9_next<=sum_3(2 downto 1)when state=E126 else
    top_5 when state=E41 else
    sum_5(0) & top_5(0) when  state=E2 else
    S9_reg when state=E42 else
    (others=>'0');   

S10<=sum_4(2 downto 1)when state=E126 else
    sum_5(0) & top_5(0) when state=E42 else
    sum_5(2 downto 1) when  state=E2 else
    (others=>'0');   

S11<=sum_5(2 downto 1)when state=E126 else
    sum_5(2 downto 1) when state=E42 else
    sum_6(0) & top_6(0) when  state=E2 else
    (others=>'0');   

S12<=sum_6(2 downto 1)when state=E126 else
    sum_6(2 downto 1) when state=E42 or state=E2 else
    (others=>'0');      

--Ma
Ma1<=Ma when state=E126 or state=E84 or state=E42 or state=E2 else
    '0';
Ma2<=Ma when state=E126 or state=E84 or state=E42 or state=E2 else
    '0';
Ma3<=Ma when state=E126 or state=E84 or state=E42 or state=E2 else
    '0';    
Ma4<=Ma when state=E126 or state=E84 or state=E42 or state=E2 else
    '0';  
Ma5<=Ma when state=E126 or state=E84 or state=E42 or state=E2 else
    '0';       
Ma6<=Ma when state=E126 or state=E84 or state=E42 or state=E2 else
    '0'; 
    
--Mb
Mb1<=Mb when state=E2 else
     '0';
Mb2<=Mb when state=E2 or state=E41 or state=E42 else
     '0';
Mb3<=Mb when state=E2 else
     '0';
Mb4<=Mb when state=E2 or state=E41 or state=E42 or state=E81 or state=E82 or state=E83 or state=E84 else
     '0';
Mb5<=Mb when state=E2 else
     '0';

--Cl
 Cl<='0' when  state=E121 or state=E81 or state=E41 or state=E2 else
     '1';
--Cr   
 Cr<='0' when  state=E126 or state=E84 or state=E42 or state=E2 else
     '1';
--Ct
  Ct2<='0' when state=E2 else
       '1';  
  Ct3<='0' when state=E2 or state=E41 or state=E42 else
       '1';
  Ct4<='0' when state=E2 else
       '1';  
  Ct5<='0' when state=E2 or state=E41 or state=E42 else
       '1';
  Ct6<='0' when state=E2 else
       '1';   
--Cb
  Cb1<='0' when state=E2 else
       '1'; 
  Cb2<='0' when state=E2 or state=E41 or state=E42 else
       '1';
  Cb3<='0' when state=E2 else
       '1';  
  Cb4<='0' when state=E2 or state=E41 or state=E42 or state=E81 or state=E82 or state=E83 or state=E84 else
       '1';
  Cb5<='0' when state=E2 else
       '1';  
--ready
ready<= '1' when (state=E126 or state=E84 or state=E42 or state=E2 )and primera_cuenta='0' else
        '0';

--solucion completa   
S<=S12 & S11 & S10 & S9_next & S8 & S7 & S6 & S5_next & S4_next & S3_next & S2_next & S1_next;

end Behavioral;

