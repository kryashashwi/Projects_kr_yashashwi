library ieee;
use ieee.std_logic_1164.all;

library std;
use std.standard.all;

library work;
use work.components.all;


entity LeftS_7 is
   port(   
  X : in std_logic_vector(8 downto 0) ;
  S : out std_logic_vector(15 downto 0));
end entity;

architecture Formula of LeftS_7 is
begin
	S <= X & "0000000";	

end Formula;
