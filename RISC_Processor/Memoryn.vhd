library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memoryn is
port (clk : in std_logic;
        Address : in std_logic_vector(15 downto 0);
        Mem_Write : in std_logic;
        DataWrite: in std_logic_vector(15 downto 0);
        DataRead: out std_logic_vector(15 downto 0)
     );
end entity;

architecture Behavioral of Memoryn  is

--Declaration of type and signal of a 256 element RAM
--with each element being 8 bit wide.
type ram_t is array (0 to 200) of std_logic_vector(15 downto 0);
signal ram : ram_t := (
--0 => "0011000100000011",
--1 => "0011001100010010",
0 => "0011000000000000",
1 => "0100001000001010",
2 => "0110001000000111",
3 => "1100000001010000",
4 => "0011000000000011",
5 => "0011001000001100",
6 => "0010000001011001",
--3 => "0000000000000001",
--4 => "0000000000000011",
--5 => "0000000000000100",
--6 => "0000000000000101",
7 => "0000000000000110",
8 => "0000000000000110",
9 => "0000000101000000",
 --=> "1001001100000000",
19 => "0000000000000000",
20 => "1000110000100001",
10 => "0000000000000111",
53 => "1001010110000000",
21 => "0001000001001111",
22 => "0011000000000000",
others=>"0000000000001111"

);--(others => '0'));

begin

--process for read and write operation.
process(clk)
begin
     DataRead <= ram(to_integer(unsigned(Address)));
    if(rising_edge(clk)) then
        if(Mem_Write='1') then
            ram(to_integer(unsigned(Address))) <= DataWrite;
        end if;
    end if; 
end process;

end Behavioral;

