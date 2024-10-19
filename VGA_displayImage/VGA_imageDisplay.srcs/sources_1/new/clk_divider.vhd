----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Korossy Zsolt
-- 
-- Create Date: 05/01/2023 08:10:24 PM
-- Design Name: 
-- Module Name: clk_divider - Behavioral
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


entity clk_divider is
Port ( 
signal clk, rst:in std_logic;
signal new_clk:out std_logic
);
end clk_divider;

architecture Behavioral of clk_divider is
signal counter:integer:=0;
signal clk_aux:std_logic:='0';

begin

new_clk<=clk_aux;

--at a screen resolution of 1280x1024 and a frequency of 60Hz, we need a pixel clock with a frequency of 108MHz (1688x1066x60=107.964.480Hz)
--on the Nexys4 board we have a 100MH clock, so a frequency of 108MHz is unobtainable -> the image display will have a frequency less than 60Hz on the screen
--in case the pixel clock is slower than your board's specification, you need to divide it accordingly
--http://www.tinyvga.com/vga-timing
process(clk, rst)
begin
if rst='1' then
    counter<=0;
elsif clk'event and clk='1' then
    if counter<1 then
        counter<=counter+1;
    else
        counter<=0;
        clk_aux<=not(clk_aux);
    end if;
end if;
end process;

end Behavioral;
