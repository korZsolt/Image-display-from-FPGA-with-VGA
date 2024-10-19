----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Korossy Zsolt
-- 
-- Create Date: 05/12/2023 03:00:05 PM
-- Design Name: 
-- Module Name: MPG - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--the Monopulse Generator ensures that pushing a button registers only once, otherwise we would have an oscillating signal
entity MPG is
port(
signal clk:in std_logic;
signal btn:in std_logic;
signal en:out std_logic
);
end MPG;

architecture Behavioral of MPG is
signal counter:std_logic_vector(15 downto 0):=(others=>'0');
signal Q1, Q2, Q3: std_logic;

begin
en<=Q2 and not(Q3);

process(clk)
begin
if clk'event and clk='1' then
    counter<=counter+1;
    if counter="1111111111111111" then
        Q1<=btn;
    end if;
    Q2<=Q1;
    Q3<=Q2;
end if;
end process;
end Behavioral;
