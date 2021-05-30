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

----Descripción del módulo

--Control de las soluciones de la multiplicación.
--La multiplicación puede generar varias soluciones en paralelo si se utilizan pocos bits. 
--Este módulo se encarga de serparar los valores y enviarlos de 1 en 1 para que se acumulen posteriormente. 
--Además indica cuándo se ha terminado de acumular los valores, si se necesitan nuevos valores o si se ha terminado de acumular y se puede comenzar a hacer la función de activación


----Definición de entradas/salidas
--s_in
--Señal de entrada, son las soluciónes del multiplicador configurable

--num_bits
--numero de bits utilizados en la multipliacacion

--mult_ready
--Señal de salida que indica que el multiplicador ha terminado

--ready_in
--Señal activa cuando nuevos datos están llegando, se desactiva cuando se han completado todos los datos

--s_out
--Salida hacia el sumador

--recibir_datos
--Señal por la cual se cambian los valores de entrada 

--enable_suma
--Señal que indica cuándo se hacen las sumas

--enable_fa
--Señal que inicia el bloque de funci'on de activación

--clk
--Señal de reloj

--reset
--reset total, se ponen todos los registros a 0

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_neurona is
    Port ( s_in : in signed (23 downto 0);
           num_bits : in natural;
           mult_ready : in STD_LOGIC;
           ready_in : in std_logic;
           s_out: out signed (23 downto 0); 
           recibir_datos : out std_logic:='1';
           enable_suma : out std_logic;   
           enable_fa : out std_logic;       
           clk: in std_logic;
           reset:in std_logic
           );
end control_neurona;

architecture Behavioral of control_neurona is

signal s4_1,s4_2,s4_3:signed(7 downto 0);
signal s2_1,s2_2,s2_3,s2_4,s2_5,s2_6:signed(3 downto 0);
signal primer_valor:std_logic:='1';
type estados is (S0, S41,S42, S21,S22,S23,S24,S25);
signal estado_actual,estado_siguiente :estados:=S0;
--Se activa cuando ha terminado de procesar los datos
signal fin_proceso : std_logic;
--Se activa cuando se siguen procesando los datos.
signal enProceso : std_logic:='0';
begin

process(clk,reset)
begin
    if(reset='1') then
        estado_actual<=S0;
        primer_valor<='1';
        enable_fa<='0';
    elsif(rising_edge(clk)) then
        if enProceso='1' then
            estado_actual<=estado_siguiente;
            primer_valor<='0';
        end if;
        enable_fa<=not(enProceso); 


    end if;

end process;

--Separo los valores de x y w cuando tienen menos de 8 bits

s4_1<=s_in(7 downto 0);
s4_2<=s_in(15 downto 8);
s4_3<=s_in(23 downto 16);
s2_1<=s_in(3 downto 0);
s2_2<=s_in(7 downto 4);
s2_3<=s_in(11 downto 8);
s2_4<=s_in(15 downto 12);
s2_5<=s_in(19 downto 16);
s2_6<=s_in(23 downto 20);

--cambio de estados y de salidas
process (mult_ready,s_in,estado_actual,estado_siguiente,primer_valor,num_bits,s4_1,s4_2,s4_3,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6)
begin
estado_siguiente<=S0;
s_out<=(others=>'0');
enable_suma<='1';
if primer_valor='1' then
    fin_proceso<='1';
else
    fin_proceso<='0';
end if;
case estado_actual is
    
    when S0=>
        if mult_ready='1' then
            enable_suma<='1';
            if (num_bits=8 or num_bits=12) then
                estado_siguiente<=S0;
                s_out<=s_in;
                fin_proceso<='1';

            elsif (num_bits=4) then
                estado_siguiente<=S41;
                s_out(23 downto 8)<=(others=>'0');  
                s_out(7 downto 0)<=s4_1;  
                fin_proceso<='0';
            else
                estado_siguiente<=S21;
                s_out(23 downto 4)<=(others=>'0');
                s_out(3 downto 0)<=s2_1;  
                fin_proceso<='0';
            end if;
        else
            enable_suma<='0';
        end if;
    when S41=>
        estado_siguiente<=S42;
        s_out(23 downto 8)<=(others=>'0');  
        s_out(7 downto 0)<=s4_2;
        fin_proceso<='0';    
    when S42=>
        estado_siguiente<=S0;
        s_out(23 downto 8)<=(others=>'0');  
        s_out(7 downto 0)<=s4_3;
        fin_proceso<='1'; 
    when S21=>
        estado_siguiente<=S22;
        s_out(23 downto 4)<=(others=>'0');
        s_out(3 downto 0)<=s2_2;
        fin_proceso<='0';
    when S22=>
        estado_siguiente<=S23;
        s_out(23 downto 4)<=(others=>'0');
        s_out(3 downto 0)<=s2_3;
        fin_proceso<='0';
    when S23=>
        estado_siguiente<=S24;
        s_out(23 downto 4)<=(others=>'0');
        s_out(3 downto 0)<=s2_4;
        fin_proceso<='0';
    when S24=>
        estado_siguiente<=S25;
        s_out(23 downto 4)<=(others=>'0');
        s_out(3 downto 0)<=s2_5;
        fin_proceso<='0';
    when others=> 
        estado_siguiente<=S0;
        s_out(23 downto 4)<=(others=>'0');
        s_out(3 downto 0)<=s2_6;
        fin_proceso<='1';
    
end case;

end process;

--La señal enProceso indica que se están procesando valores provenientes del multiplicador
process (fin_proceso,ready_in)
begin 
if (rising_edge(ready_in)) then
    enProceso<='1';
end if;
if (rising_edge(fin_proceso) and ready_in='0') then
    enProceso<='0';

end if;
end process;

--Cuando se terminan de procesar datos, se piden datos nuevos
recibir_datos<=fin_proceso;

end Behavioral;
