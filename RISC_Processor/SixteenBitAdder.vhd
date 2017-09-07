library ieee;
use ieee.std_logic_1164.all;

library work;
use work.components.all;

entity SixteenBitAdder is
port ( 
   X , Y : in std_logic_vector(15 downto 0);
   S : out std_logic_vector(15 downto 0);
   carryflag : out std_logic);
end entity;

architecture Formula of SixteenBitAdder is
signal Co :std_logic_vector(15 downto 0);

begin
A00: FullA port map (a=>X(0), b=>Y(0), c=>'0', s=>S(0), co=>Co(0));
A01: FullA port map (a=>X(1), b=>Y(1), c=>Co(0), s=>S(1), co=>Co(1));
A02: FullA port map (a=>X(2), b=>Y(2), c=>Co(1), s=>S(2), co=>Co(2));
A03: FullA port map (a=>X(3), b=>Y(3), c=>Co(2), s=>S(3), co=>Co(3));
A04: FullA port map (a=>X(4), b=>Y(4), c=>Co(3), s=>S(4), co=>Co(4));
A05: FullA port map (a=>X(5), b=>Y(5), c=>Co(4), s=>S(5), co=>Co(5));
A06: FullA port map (a=>X(6), b=>Y(6), c=>Co(5), s=>S(6), co=>Co(6));
A07: FullA port map (a=>X(7), b=>Y(7), c=>Co(6), s=>S(7), co=>Co(7));
A08: FullA port map (a=>X(8), b=>Y(8), c=>Co(7), s=>S(8), co=>Co(8));
A09: FullA port map (a=>X(9), b=>Y(9), c=>Co(8), s=>S(9), co=>Co(9));
A10: FullA port map (a=>X(10), b=>Y(10), c=>Co(9), s=>S(10), co=>Co(10));
A11: FullA port map (a=>X(11), b=>Y(11), c=>Co(10), s=>S(11), co=>Co(11));
A12: FullA port map (a=>X(12), b=>Y(12), c=>Co(11), s=>S(12), co=>Co(12));
A13: FullA port map (a=>X(13), b=>Y(13), c=>Co(12), s=>S(13), co=>Co(13));
A14: FullA port map (a=>X(14), b=>Y(14), c=>Co(13), s=>S(14), co=>Co(14));
A15: FullA port map (a=>X(15), b=>Y(15), c=>Co(14), s=>S(15), co=>Co(15));

carryflag<=Co(15);

end Formula;
