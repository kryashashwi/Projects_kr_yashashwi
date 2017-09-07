library ieee;
use ieee.std_logic_1164.all;

library work;
use work.components.all;

entity FullA is
    port(a,b,c: in std_logic;
          s,co: out std_logic);
end entity FullA;
architecture Formula of FullA is
signal p: std_logic;
begin
p<= (a and (not b)) or (b and (not a));
s<= (p and (not c)) or (c and (not p));
co<= ((p and c) or (a and b));
end Formula; 	   
