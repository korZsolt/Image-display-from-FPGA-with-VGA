----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Korossy Zsolt
-- 
-- Create Date: 02/29/2024 10:32:24 PM
-- Design Name: 
-- Module Name: test_bench - Behavioral
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

entity Nexys4_testBench is
--  Port ( );
end Nexys4_testBench;

architecture Behavioral of Nexys4_testBench is

component Nexys4 is
    Port ( signal clk:in std_logic;
            btn:in std_logic_vector(4 downto 0);
            sw:in std_logic_vector(15 downto 0);
            led:out std_logic_vector(15 downto 0);
            cat:out std_logic_vector(6 downto 0);
            an:out std_logic_vector(7 downto 0);
            VGA_R:out std_logic_vector(3 downto 0);
            VGA_G:out std_logic_vector(3 downto 0);
            VGA_B:out std_logic_vector(3 downto 0);
            VGA_HS:out std_logic;
            VGA_VS:out std_logic
            --outt : out STD_LOGIC_VECTOR (31 downto 0);
           --outt1 : out STD_LOGIC_VECTOR (31 downto 0)
            --outt2 : out STD_LOGIC_VECTOR (31 downto 0)
            --outt3 : out STD_LOGIC_VECTOR (31 downto 0);
            --outt4 : out STD_LOGIC_VECTOR (31 downto 0);
            --outt5 : out STD_LOGIC_VECTOR (31 downto 0);
            --outt6 : out STD_LOGIC_VECTOR (31 downto 0)
           );
end component;

signal clk_test: std_logic:='0';
signal btn_test: std_logic_vector(4 downto 0):=(others=>'0');
signal sw_test: std_logic_vector(15 downto 0):=(others=>'0');
signal led_test: std_logic_vector(15 downto 0):=(others=>'0');
signal cat_test: std_logic_vector(6 downto 0):=(others=>'0');
signal an_test: std_logic_vector(7 downto 0):=(others=>'0');
signal VGA_R_test: std_logic_vector(3 downto 0):=(others=>'0');
signal VGA_G_test: std_logic_vector(3 downto 0):=(others=>'0');
signal VGA_B_test: std_logic_vector(3 downto 0):=(others=>'0');
signal VGA_HS_test: std_logic:='0';
signal VGA_VS_test: std_logic:='0';

constant period: TIME := 6ns;

begin

ust1: Nexys4 port map (
clk=>clk_test,
btn=>btn_test,
sw=>sw_test,
led=>led_test,
cat=>cat_test,
an=>an_test,
VGA_R=>VGA_R_test,
VGA_G=>VGA_G_test,
VGA_B=>VGA_B_test,
VGA_HS=>VGA_HS_test,
VGA_VS=>VGA_VS_test
);

process
begin
    clk_test <= '1';
--    btn_test(0) <= '1';
    wait for period / 2;
    clk_test <= '0';
--    btn_test(0) <= '0';
    wait for period / 2;
end process;
process
begin
    sw_test(7)<='0';
    wait;
end process;

end Behavioral;