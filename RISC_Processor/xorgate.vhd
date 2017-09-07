library ieee;
use ieee.std_logic_1164.all;

library work;
use work.components.all;

entity xorgate is
port ( 
   X , Y : in std_logic_vector(15 downto 0);
   S : out std_logic_vector(15 downto 0));
end entity;

architecture Formula of xorgate is

begin 
S(0)<=X(0) xor Y(0); 
S(1)<=X(1) xor Y(1); 
S(2)<=X(2) xor Y(2); 
S(3)<=X(3) xor Y(3); 
S(4)<=X(4) xor Y(4); 

S(5)<=X(5) xor Y(5); 
S(6)<=X(6) xor Y(6); 
S(7)<=X(7) xor Y(7); 
S(8)<=X(8) xor Y(8); 
S(9)<=X(9) xor Y(9); 

S(10)<=X(10) xor Y(10); 
S(11)<=X(11) xor Y(11); 
S(12)<=X(12) xor Y(12); 
S(13)<=X(13) xor Y(13); 
S(14)<=X(14) xor Y(14); 
S(15)<=X(15) xor Y(15); 
end Formula;
