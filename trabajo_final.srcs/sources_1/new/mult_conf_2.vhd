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

entity mult_config_2 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           S : out STD_LOGIC_VECTOR (15 downto 0);
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
signal Mb1,Mb2,Mb3:std_logic;

--soluciones
signal S4,S6,S7,S8: std_logic_vector(1 downto 0);
signal S1_reg,S1_next : std_logic_vector(1 downto 0);
signal S2_reg,S2_next : std_logic_vector(1 downto 0);
signal S3_reg,S3_next : std_logic_vector(1 downto 0);
signal S5_reg,S5_next : std_logic_vector(1 downto 0);




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
        S5_reg<=(others=>'0');
        if control="00" then
            contador<="11";
        elsif control="01" then
            contador<="01";
        end if;
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
        S5_reg<=S5_next;
        
        
        if control="00" then
            contador<=contador+1;
        elsif control="01" then
            if contador="00" then
                contador<="01";
            else
                contador<="00";
            end if;
        else 
            contador<="00";
        end if; 
        primera_cuenta<='0';  
    end if;
end process;


--control
--  si 00 => 1 multiplicador 8x8
--  si 01 => 4 multiplicadores 4x4
--``si 10 => 16 multiplicadores 2x2
    
    
--A 
 
 A1<=A(1 downto 0) when contador="00" else
     A(3 downto 2) when contador="01" else
     A(5 downto 4) when contador="10" else
     A(7 downto 6) ;
     
 A2<=A(1 downto 0) when (control="00" or control="01") and contador="00"  else
     A(3 downto 2) when contador="01" or control="10" else
     A(5 downto 4) when control="00" and contador="10" else
     A(7 downto 6);
 
 A3<=A(1 downto 0) when control="00" and contador="00"  else
     A(3 downto 2) when control="00" and contador="01" else
     A(5 downto 4) when (control="00" and contador="10" )or (control="01" and contador="00") or control="10" else
     A(7 downto 6);

 A4<=A(1 downto 0) when control="00" and contador="00"  else
     A(3 downto 2) when control="00" and contador="01" else
     A(5 downto 4) when (control="00" and contador="10" )or (control="01" and contador="00") else
     A(7 downto 6);
----B
--control 00 01 10
        B1<=B(1 downto 0);
        B2<=B(3 downto 2);
        B3<=B(5 downto 4);
        B4<=B(7 downto 6);  
    
        
--soluciones  
S1_next<=top_1 when (control="00" or control="01") and contador="00"  else
         S1_reg when (control="00" or control="01") and contador/="00" else
         sum_1(0) & top_1(0);
         
S2_next<=top_1 when control="00" and contador="01" else
         S2_reg when control="00" and (contador="10" or contador="11") else
         sum_1(0) & top_1(0) when control="01" and contador="01" else
         sum_1(2 downto 1) when control="10" else
         (others=>'0');

S3_next<=top_1 when control="00" and contador="10" else
         S3_reg when control="00" and contador="11" else
         sum_1(2 downto 1) when control="01" and control="01" else
         sum_2(0) & top_2(0) when control="10" else
         (others=>'0');
         
S4<=sum_1(0)&top_1(0) when control="00" and contador="11" else
    sum_2(2 downto 1) when (control="01" and contador="01") or control="10" else
    (others=>'0');
    
S5_next<=sum_1(2 downto 1) when control="00" and contador="11" else
         top_3 when control="01" and contador="00" else
         S5_reg when control="01" and contador="01" else
         sum_3(0) & top_3(0) when control="10" else
         (others=>'0');

S6<=sum_2(2 downto 1) when control="00" and contador="11" else
    sum_3(0) & top_3(0) when control="01" and contador="01" else
    sum_3(2 downto 1) when control="10" else
    (others=>'0');
    
S7<=sum_3(2 downto 1) when (control="00" and contador="11") or (control="01" and contador="01") else
    sum_4(0) & top_4(0) when control="10" else
    (others=>'0');  
    
S8<=sum_4(2 downto 1) when (control="00" and contador="11") or (control="01" and contador="01") or control="10" else
    (others=>'0');    
    

--Ma
Ma1<='0' when (control="00" and contador/="11") or 
              (control="01" and contador="00") else
    Ma;
Ma2<='0' when (control="00" and contador/="11") or 
              (control="01" and contador="00") else
    Ma;
Ma3<='0' when (control="00" and contador/="11") or 
              (control="01" and contador="00") else
    Ma;
Ma4<='0' when (control="00" and contador/="11") or 
              (control="01" and contador="00") else
    Ma;
    

--Mb
Mb1<='0' when control/="10" else
     Mb;
Mb2<='0' when control="00" else
     Mb;
Mb3<='0' when control/="10" else
     Mb;



--Cl
 Cl<='0' when  (control="00" and contador="00") or 
               (control="01" and contador(0)='0') or 
               control="10" else
     '1';
--Cr   
 Cr<='0' when  (control="00" and contador="11") or 
               (control="01" and contador(0)='1') or 
               control="10" else
     '1';
--Ct
  Ct2<='0' when control="10" else
       '1';  
  Ct3<='0' when control="01" or control="10" else
       '1';
  Ct4<='0' when control="10" else
       '1';  
--Cb
  Cb1<='0' when control="10" else
       '1'; 
  Cb2<='0' when control="01" or control="10" else
       '1';
  Cb3<='0' when control="10" else
       '1';  

--ready
ready<= '1' when ((contador="11" and control="00" )or 
                 (contador="01" and control="01") or 
                 (control="10")) and primera_cuenta='0' else
        '0';
   
    
     
----A 
 
-- A1<=A(1 downto 0) when contador="00" else
--     A(3 downto 2) when contador="01" else
--     A(5 downto 4) when contador="10" else
--     A(7 downto 6) ;
     
-- A2<=A(1 downto 0) when (control="00" or control="01") and contador="00"  else
--     A(3 downto 2) when contador="01" or control="10" else
--     A(5 downto 4) when control="00" and contador="10" else
--     A(7 downto 6);
 
-- A3<=A(1 downto 0) when control="00" and contador="00"  else
--     A(3 downto 2) when control="00" and contador="01" else
--     A(5 downto 4) when (control="00" and contador="10" )or (control="01" and contador="00") or control="10" else
--     A(7 downto 6);

-- A4<=A(1 downto 0) when control="00" and contador="00"  else
--     A(3 downto 2) when control="00" and contador="01" else
--     A(5 downto 4) when (control="00" and contador="10" )or (control="01" and contador="00") else
--     A(7 downto 6);
------B
----control 00 01 10
--        B1<=B(1 downto 0);
--        B2<=B(3 downto 2);
--        B3<=B(5 downto 4);
--        B4<=B(7 downto 6);     
        
----soluciones  
--S1_next<=top_1 when (control="00" or control="01") and contador="00"  else
--         S1_reg when (control="00" or control="01") and contador/="00" else
--         sum_1(0) & top_1(0);
         
--S2_next<=top_1 when control="00" and contador="01" else
--         S2_reg when control="00" and (contador="10" or contador="11") else
--         sum_1(0) & top_1(0) when control="01" and contador="01" else
--         sum_1(2 downto 1) when control="10" else
--         (others=>'0');

--S3_next<=top_1 when control="00" and contador="10" else
--         S3_reg when control="00" and contador="11" else
--         sum_1(2 downto 1) when control="01" and control="01" else
--         sum_2(0) & top_2(0) when control="10" else
--         (others=>'0');
         
--S4<=sum_1(0)&top_1(0) when control="00" and contador="11" else
--    sum_2(2 downto 1) when (control="01" and contador="01") or control="10" else
--    (others=>'0');
    
--S5_next<=sum_1(2 downto 1) when control="00" and contador="11" else
--         top_3 when control="01" and contador="00" else
--         S5_reg when control="01" and contador="01" else
--         sum_3(0) & top_3(0) when control="10" else
--         (others=>'0');

--S6<=sum_2(2 downto 1) when control="00" and contador="11" else
--    sum_3(0) & top_3(0) when control="01" and contador="01" else
--    sum_3(2 downto 1) when control="10" else
--    (others=>'0');
    
--S7<=sum_3(2 downto 1) when (control="00" and contador="11") or (control="01" and contador="01") else
--    sum_4(0) & top_4(0) when control="10" else
--    (others=>'0');  
    
--S8<=sum_4(2 downto 1) when (control="00" and contador="11") or (control="01" and contador="01") or control="10" else
--    (others=>'0');    
    

----Ma
--Ma1<='0' when (control="00" and contador/="11") or 
--              (control="01" and contador="00") else
--    Ma;
--Ma2<='0' when (control="00" and contador/="11") or 
--              (control="01" and contador="00") else
--    Ma;
--Ma3<='0' when (control="00" and contador/="11") or 
--              (control="01" and contador="00") else
--    Ma;
--Ma4<='0' when (control="00" and contador/="11") or 
--              (control="01" and contador="00") else
--    Ma;
    

----Mb
--Mb1<='0' when control/="10" else
--     Mb;
--Mb2<='0' when control="00" else
--     Mb;
--Mb3<='0' when control/="10" else
--     Mb;



----Cl
-- Cl<='0' when  (control="00" and contador="00") or 
--               (control="01" and contador(0)='0') or 
--               control="10" else
--     '1';
----Cr   
-- Cr<='0' when  (control="00" and contador="11") or 
--               (control="01" and contador(0)='1') or 
--               control="10" else
--     '1';
----Ct
--  Ct2<='0' when control="10" else
--       '1';  
--  Ct3<='0' when control="01" or control="10" else
--       '1';
--  Ct4<='0' when control="10" else
--       '1';  
----Cb
--  Cb1<='0' when control="10" else
--       '1'; 
--  Cb2<='0' when control="01" or control="10" else
--       '1';
--  Cb3<='0' when control="10" else
--       '1';  

----ready
--ready<= '1' when ((contador="11" and control="00" )or 
--                 (contador="01" and control="01") or 
--                 (control="10")) and primera_cuenta='0' else
--        '0';

--solucion completa   
S<=S8 & S7 & S6 & S5_next & S4 & S3_next & S2_next & S1_next;

end Behavioral;

