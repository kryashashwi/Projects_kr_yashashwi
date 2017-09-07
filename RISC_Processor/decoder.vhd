library ieee;
use ieee.std_logic_1164.all;

library work;
use work.components.all;

entity decoder is
port ( 
   X  : in std_logic_vector(2 downto 0);
   S : out std_logic_vector(7 downto 0));
end entity;

architecture Formula of decoder is

begin
 S(0) <= (not X(0)) and (not X(1)) and (not X(2));
  S(1) <= (X(0)) and (not X(1)) and (not X(2));
  S(2) <= (not X(0)) and (X(1)) and (not X(2));
  S(3) <= (X(0)) and (X(1)) and (not X(2));
  S(4) <= (not X(0)) and (not X(1)) and (X(2));
  S(5) <= (X(0)) and (not X(1)) and (X(2));
  S(6) <= (not X(0)) and (X(1)) and (X(2));
  S(7) <= (X(0)) and (X(1)) and (X(2));


end Formula;