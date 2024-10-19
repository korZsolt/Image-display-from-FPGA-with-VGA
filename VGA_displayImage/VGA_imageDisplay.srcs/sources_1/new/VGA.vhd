----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Korossy Zsolt
-- 
-- Create Date: 05/01/2023 07:20:52 PM
-- Design Name: 
-- Module Name: VGA - Behavioral
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


entity VGA is
Port ( 
signal clk:in std_logic;
signal no:in std_logic_vector(1 downto 0);
signal HSYNC:out std_logic;
signal VSYNC:out std_logic;
signal R, G, B:out std_logic_vector(3 downto 0)
);
end VGA;

architecture Behavioral of VGA is

constant image_size: integer:=200; --image.bmp(image.hex), 200x200 pixels
--if you have an image of different width and height, use 2 constants

--signals for monitor of 1280x1024 resolution, frequence 60hz
--HPOS=Horizontal line + front porch + back porch + sync pulse
--VPOS=Vertical line + front porch + back porch + sync pulse
--these parameters depend on the monitor used and are important for correct operation!!
signal HPOS: integer range 0 to 1688:=0; --horizontal position
signal VPOS: integer range 0 to 1066:=0; --vertical position
signal HREL: integer range 0 to 1688:=1042-image_size/2; --x coordinate relative to the place where the image starts (middle of the screen)
signal VREL: integer range 0 to 1066:=554-image_size/2; --y coordinate relative to the place where the image starts (middle of the screen)
signal draw: std_logic:='0';

--the signals for the RAM block from where we read the data
signal re: std_logic:='1'; --the signal that determines if we write/read from the RAM memory
signal addr: std_logic_vector(15 downto 0):=(others=>'0'); --2^16=65536>40000=200x200 pixels (number of memory addresses)
signal data: std_logic_vector(11 downto 0):=(others=>'0');

component RAM is
port(
signal clk:in std_logic;
signal addr:in std_logic_vector(15 downto 0);
signal r:in std_logic;
signal no:in std_logic_vector(1 downto 0);
signal data:out std_logic_vector(11 downto 0)
);
end component;

begin
wr_RAM: RAM port map(
clk=>clk,
addr=>addr,
r=>re,
no=>no,
data=>data
);

drawing:process(clk)
begin
if clk'event and clk='1' then
--going through the whole screen, pixel by pixel
    if HPOS<1688 then --horizontal
        HPOS<=HPOS+1;
    else
        HPOS<=0;
        if VPOS<1066 then --vertical
            VPOS<=VPOS+1;
        else
            VPOS<=0;
            addr<=(others=>'0');
        end if;
    end if;
    if HPOS>48 and HPOS<160 then --horizontal synchronization
        HSYNC<='0';
    else
        HSYNC<='1';
    end if;
    if VPOS>0 and VPOS<4 then --vertical synchronization
        VSYNC<='0';
    else
        VSYNC<='1';
    end if;
    if (HPOS>0 and HPOS<408) or (VPOS>0 and VPOS<42) then --from Front Porch to Back Porch
        R<=(others=>'0');
        G<=(others=>'0');
        B<=(others=>'0');
     end if;
     if(HPOS>=HREL and HPOS<HREL+image_size) and (VPOS>=VREL and VPOS<VREL+image_size) then --checking if we are in the "territory" of the image
        draw<='1';
     else
        draw<='0';
     end if;
     if draw='1' then
        if unsigned(addr)<image_size*image_size then
            R<=data(11 downto 8);
            G<=data(7 downto 4);
            B<=data(3 downto 0);
            addr<=addr+1;
        else
            R<=(others=>'0');
            G<=(others=>'0');
            B<=(others=>'0');
            addr<=(others=>'0');
         end if;
     else
        R<=(others=>'0');
        G<=(others=>'0');
        B<=(others=>'0');
     end if;
end if;
end process;
end Behavioral;
