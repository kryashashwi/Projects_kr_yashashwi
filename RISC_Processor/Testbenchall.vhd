library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;

entity testbench is
end entity;
architecture Behave of testbench is

component TopLevel is
   port(clk,reset: in std_logic;
rout_0,rout_1,rout_2,rout_3,rout_4,rout_5,rout_6,rout_7: out std_logic_vector(15 downto 0));
end component;

  signal clk: std_logic := '0';
  signal reset: std_logic := '1';
  signal rout_0,rout_1,rout_2,rout_3,rout_4,rout_5,rout_6,rout_7: std_logic_vector(15 downto 0);
 begin
  clk <= not clk after 10 ns; -- assume 10ns clock.

  -- reset process
  process
  begin

     reset <= '0' after 12 ns;
     wait;
  end process;

  dut: toplevel  
     port map(clk,reset,rout_0,rout_1,rout_2,rout_3,rout_4,rout_5,rout_6,rout_7);
end Behave;

