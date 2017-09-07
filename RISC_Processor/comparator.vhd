library ieee;
use ieee.std_logic_1164.all;
library work;
use work.components.all;
entity comparator is
   port(X: in std_logic_vector(15 downto 0);
        Y: in std_logic_vector(15 downto 0);
	--eq: out std_logic);
	S: out std_logic_vector(15 downto 0));
end entity;
architecture Formula of comparator is 
 signal A,B,C,D,E : std_logic_vector(15 downto 0);
 signal te1,te2 : std_logic;
begin		
A(0) <= not(Y(0));
A(1) <= not(Y(1));
A(2) <= not(Y(2));
A(3) <= not(Y(3));
A(4) <= not(Y(4));
A(5) <= not(Y(5));
A(6) <= not(Y(6));
A(7) <= not(Y(7));
A(8) <= not(Y(8));
A(9) <= not(Y(9));
A(10) <= not(Y(10));
A(11) <= not(Y(11));
A(12) <= not(Y(12));
A(13) <= not(Y(13));
A(14) <= not(Y(14));
A(15) <= not(Y(15));
B<="0000000000000001";

A00: SixteenBitAdder port map (X=>A, Y=>B, S=>D,carryflag=>te1);
A01: SixteenBitAdder port map (X=>X, Y=>D, S=>S,carryflag=>te2);
--eq<=not(E(0)) and not(E(1)) and not(E(2)) and not(E(3)) and not(E(4)) and not(E(5)) and not(E(6)) and not(E(7)) and not(E(7)) and not(E(8)) and not(E(9)) and not(E(10)) and not(E(11)) and not(E(12)) and not(E(13)) and not(E(14))and not(E(15));
end Formula;
