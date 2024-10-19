----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Korossy Zsolt
-- 
-- Create Date: 05/02/2023 07:38:02 PM
-- Design Name: 
-- Module Name: write_read_ram - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;


entity RAM is
Port ( 
signal clk:in std_logic;
signal addr:in std_logic_vector(15 downto 0); --2^16=65536>40000=200x200 pixels(number of memory addresses)
signal r:in std_logic;
signal no:in std_logic_vector(1 downto 0);
signal data:out std_logic_vector(11 downto 0)
);
end RAM;

architecture Behavioral of RAM is

constant image_size:integer:=200;
type mem_type is array(0 to image_size*image_size) of std_logic_vector(11 downto 0);

impure function init_ram (mif_file_name:in string) return mem_type is
    file mif_file:text open read_mode is mif_file_name;
    variable mif_line:line;
    variable temp_bv:bit_vector(11 downto 0);
    variable temp_mem:mem_type;
begin
    for i in mem_type'range loop
        readline(mif_file, mif_line);
        read(mif_line, temp_bv);
        temp_mem(i):=to_stdlogicvector(temp_bv);
    end loop;
    return temp_mem;
end function;

--change with the names of your mif's (memory initialization files)
signal ram_block1:mem_type:=init_ram("bird1Bin.mif");
signal ram_block2:mem_type:=init_ram("bird2Bin.mif");
signal ram_block3:mem_type:=init_ram("bird3Bin.mif");

begin
process(clk)
begin
if clk'event and clk='1' then
    if r='1' then
        case no is
            when "00"=>data<=ram_block1(to_integer(unsigned(addr)));
            when "01"=>data<=ram_block2(to_integer(unsigned(addr)));
            when others=>data<=ram_block3(to_integer(unsigned(addr)));
        end case;
    end if;
end if;
end process;

end Behavioral;