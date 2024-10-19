----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Korossy Zsolt
-- 
-- Create Date: 04/30/2023 01:00:29 PM
-- Design Name: 
-- Module Name: Nexys4 - Behavioral
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


entity Nexys4 is
Port ( 
signal clk:in std_logic;
signal btn:in std_logic_vector(4 downto 0);
signal sw:in std_logic_vector(15 downto 0);
signal led:out std_logic_vector(15 downto 0);
signal cat:out std_logic_vector(6 downto 0);
signal an:out std_logic_vector(7 downto 0);
signal VGA_R:out std_logic_vector(3 downto 0);
signal VGA_G:out std_logic_vector(3 downto 0);
signal VGA_B:out std_logic_vector(3 downto 0);
signal VGA_HS:out std_logic;
signal VGA_VS:out std_logic
);
end Nexys4;

architecture Behavioral of Nexys4 is

--signal new_clk:std_logic;
--signal rst:std_logic:='0';
signal no:std_logic_vector(1 downto 0):="00";
signal btn_l:std_logic;
signal btn_r:std_logic;

component VGA is
port(
signal clk:in std_logic;
signal no:in std_logic_vector(1 downto 0);
signal HSYNC:out std_logic;
signal VSYNC:out std_logic;
signal R, G, B:out std_logic_vector(3 downto 0)
);
end component VGA;

component MPG is
port(
signal clk:in std_logic;
signal btn:in std_logic;
signal en:out std_logic
);
end component MPG;

component clk_divider is
port(
signal clk, rst:in std_logic;
signal new_clk:out std_logic
);
end component clk_divider;


begin
--divclk:clk_divider port map(
--clk=>clk,
--rst=>rst,
--new_clk=>new_clk
--);

display:VGA port map(
clk=>clk, --new_clk
no=>no,
HSYNC=>VGA_HS,
VSYNC=>VGA_VS,
R=>VGA_R,
G=>VGA_G,
B=>VGA_B
);

btn_left:MPG port map(
clk=>clk,
btn=>btn(2),
en=>btn_l
);

btn_right:MPG port map(
clk=>clk,
btn=>btn(4),
en=>btn_r
);

left_right:process(clk)
begin
if btn_l='1' then
    if no="00" then
        no<="10";
    else
        no<=no-1;
    end if;
elsif btn_r='1' then
    if no="10" then
        no<="00";
    else
        no<=no+1;
    end if;
end if;
end process;

end Behavioral;
