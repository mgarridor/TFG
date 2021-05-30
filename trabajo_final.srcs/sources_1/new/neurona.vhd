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

----Descripción del módulo
--Neurona configurable.

--En primer lugar se puede elegir el número de bits con la que se hace la multiplicación
--En segundo lugar se puede elegir la precisión de la función de activación

--El protocolo de este módulo se define de la siguiente manera:
--Se requieren unas entradas (x_i) y el peso de cada entrada (w_i) que pueden ser:
--    1 numero de 12 bits
--    1 numero de 8 bits (colocados en los bits menos significativos
--    3 numeros de 4 bits
--    6 numeros de 2 bits
--Mientras se estén enviando datos nuevos la señal 'ready_in' estará activa, cuando se envíen los últimos datos se desactivará
--Si hay más entradas deberán esperar y cada vez que la señal 'recibir_datos' se actualizarán con datos nuevos.
--Cuando la señal 'ready_out' se active, el resultado estará listo.

----Definición de entradas/salidas

--x
--Entrada/as de la neurona que puede ser:

--w
--Pesos de cada entrada

--num_bits
--numero de bits utilizados en la multipliacacion

--y
--Solución total de la neurona

--reset
--reset total, se ponen todos los registros a 0

--recibir_datos
--Señal por la cual se cambian los valores de entrada 

--ready_in
--Señal activa cuando nuevos datos están llegando, se desactiva cuando se han completado todos los datos

--ready_out
--Señal de salida que se activa cuando el resultado está listo

--control_lineal
--Señal de control, activa cuando se quiere una interpolación lineal, si es '0' se hará una interpolación cuadrática

--control_tramos
--Señal de control, activa cuando se quiere una interpolación dividida en 16 tramos, si es '0' se hará una división en 4 tramos

--clk
--Señal de reloj

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity neurona is
    Port ( x : in std_logic_vector (11 downto 0);
           w : in std_logic_vector (11 downto 0);
           num_bits:in natural;
           y : out unsigned (11 downto 0):=(others=>'0');
           reset : in STD_LOGIC;
           recibir_datos: out STD_LOGIC;
           ready_in : in std_logic;
           ready_out: out STD_LOGIC;
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
end component;

signal s_out : signed(23 downto 0);

signal temp  : signed(23 downto 0);
signal recibir_datos_signal : std_logic;

signal r1_reg,r1_next : signed(23 downto 0);
signal r2_reg,r2_next : signed(23 downto 0);
signal r3_reg,r3_next : signed(11 downto 0);

signal control_mult:std_logic_vector(1 downto 0);
signal s_mult:std_logic_vector(23 downto 0);
signal mult_ready:std_logic;

signal reset_fa:std_logic;
signal enable_fa : std_logic;
signal enable_suma:std_logic;
signal ready_out_final : std_logic;


signal signo : std_logic :='0';
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
    reset=>reset,
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
    ready=>ready_out_final
);

control:control_neurona
Port map(
    s_in=>r1_next,
    num_bits=>num_bits,
    mult_ready=>mult_ready,
    ready_in=>ready_in,
    s_out=>s_out,
    enable_suma=>enable_suma,
    recibir_datos=>recibir_datos_signal,
    enable_fa=>enable_fa,
    clk=>clk,
    reset=>reset
);
process(clk,reset,enable_fa,enable_suma)
begin
    if(reset='1') then
        r1_reg<=(others=>'0');
        r2_reg<=(others=>'0');
        r3_reg<=(others=>'0');
    elsif(rising_edge(clk)) then
        if enable_suma='1' then
            r2_reg<=r2_next;
        end if;
            r1_reg<=r1_next;
            r3_reg<=r3_next;
    end if;

end process;

r1_next<=signed(s_mult) when recibir_datos_signal='1' else
        r1_reg;
        
--sumador
r2_next<= s_out + r2_reg;

--multiplexores
with num_bits select control_mult<=
    "00" when 8,
    "01" when 4,
    "10" when 2,
    "11" when others;
    
reset_fa<= not(enable_fa);

--Se elige la codificación acorde al control deseado
signo<= r2_reg(3) when num_bits=2 else
        r2_reg(7) when num_bits=4 else
        r2_reg(23);

r3_next<=
--12 bits para las multiplicaciones y 12 bits para la FA
        signed(signo & r2_reg(18 downto 8))                                                         when enable_fa='0' and control_lineal='0' and control_tramos='1' and num_bits=12 else
--12 bits para las multiplicaciones y 8 bits para la FA
        signed(signo&signo&signo&signo&signo & r2_reg(18 downto 12))                                when enable_fa='0' and ((control_lineal='0' and control_tramos='0') or (control_lineal='1' and control_tramos='1')) and num_bits=12 else
--12 bits para las multiplicaciones y 4 bits para la FA
        signed(signo&signo&signo&signo&signo&signo&signo&signo&signo & r2_reg(18 downto 16))        when enable_fa='0' and control_lineal='1' and control_tramos='0' and num_bits=12 else      
--8 bits para las multiplicaciones y 8 bits para la FA
        signed(signo&signo&signo&signo&signo & r2_reg(10 downto 4))                                 when enable_fa='0' and ((control_lineal='0' and control_tramos='0') or (control_lineal='1' and control_tramos='1')) and num_bits=8 else
--8 bits para las multiplicaciones y 12 bits para la FA
        signed(signo & r2_reg(10 downto 0))                                                         when enable_fa='0' and control_lineal='0' and control_tramos='1' and num_bits=8 else 
--8 bits para las multiplicaciones y 4 bits para la FA
        signed(signo&signo&signo&signo&signo&signo&signo&signo&signo & r2_reg(10 downto 8))         when enable_fa='0' and control_lineal='1' and control_tramos='0' and num_bits=8 else    
--4 bits para las multiplicaciones y 4 bits para la FA
        signed(signo&signo&signo&signo&signo&signo&signo&signo&signo & r2_reg(2 downto 0))          when enable_fa='0' and control_lineal='1' and control_tramos='0' and num_bits=4 else 
--2 bits para las multiplicaciones y 4 bits para la FA  ---Cambiar
        signed(signo&signo&signo&signo&signo&signo&signo&signo&signo & r2_reg(2 downto 0))          when enable_fa='0' and control_lineal='1' and control_tramos='0' and num_bits=2 else 
--Se mantiene el valor sin actualizarse
        r3_reg;

recibir_datos<=recibir_datos_signal;      
 
ready_out<=ready_out_final; 
end Behavioral;
