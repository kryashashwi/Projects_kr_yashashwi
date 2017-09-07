library ieee;
use ieee.std_logic_1164.all;

library std;
use std.standard.all;

library work;
use work.components.all;


entity SignEx_6 is
   port(   
  X : in std_logic_vector(5 downto 0) ;
  S : out std_logic_vector(15 downto 0));
end entity;

architecture Extend of SignEx_6 is
   signal A : std_logic_vector(9 downto 0);
begin
	A <= ( 9 downto 0 => X(5));
	S <= A & X;	

end Extend;
