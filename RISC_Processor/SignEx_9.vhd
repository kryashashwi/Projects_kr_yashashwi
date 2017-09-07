library ieee;
use ieee.std_logic_1164.all;

library std;
use std.standard.all;

library work;
use work.components.all;


entity SignEx_9 is
   port(   
  X : in std_logic_vector(8 downto 0) ;
  S : out std_logic_vector(15 downto 0));
end entity;

architecture Extend of SignEx_9 is
   signal A : std_logic_vector(6 downto 0);
begin
	A <= ( 6 downto 0 => X(8));
	S <= A & X;	

end Extend;
