library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.components.all;
--type arr is array(0 to 65535) of std_logic_vector(15 downto 0);
entity Memory is
    port (
        Address:   in std_logic_vector(15 downto 0);
        DataWrite: in std_logic_vector(15 downto 0);
        registers : inout arr;
	DataRead:  out std_logic_vector(15 downto 0);
	clk: in std_logic;
        Mem_Write : in std_logic);
end entity;

architecture Formula of Memory is
begin
    process(clk)
    begin
        DataRead <= registers(to_integer(unsigned(Address)));
        if falling_edge(clk) then
             if (Mem_Write = '1') then
                 registers(to_integer(unsigned(Address))) <= DataWrite  ;
             end if;
        end if;
    end process;
end Formula;
