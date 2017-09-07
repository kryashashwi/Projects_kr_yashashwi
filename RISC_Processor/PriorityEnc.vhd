library ieee ;
use ieee . std_logic_1164 . all ;
library work;
use work.components.all;

entity PriorityEnc is
port ( X: in std_logic_vector(7 downto 0);
       S: out std_logic_vector(2 downto 0));
--N: out std_logic);

end PriorityEnc ;
architecture Formula of PriorityEnc is
begin
--N <= not ( X(7) or X(6) or X(5) or X(4) or X(3) or X(2) or X(1) or X(0) ) ;
S(0) <= ( X(1) and not X(0) ) or ( X(3) and not X(2) and not X(1) and not X(0) ) or ( X(5) and not X(4) and not X(3) and not X(2) and not X(1) and not X(0) ) or
( X(7) and not X(6) and not X(5) and not X(4)
and not X(3) and not X(2) and not X(1)
and not X(0) ) ;

S(1) <= ( X(2) and not X(1) and not X(0) ) or
( X(3) and not X(2) and not X(1) and not X(0) ) or
( X(6) and not X(5) and not X(4) and not X(3) and
not X(2) and not X(1) and not X(0) ) or
( X(7) and not X(6) and not X(5) and not X(4) and
not X(3) and not X(2) and not X(1) and not X(0) ) ;

S(2) <= ( X(4) and not X(3) and not X(2) and
not X(1) and not X(0) ) or
( X(5) and not X(4) and not X(3) and not X(2) and
not X(1) and not X(0) ) or
( X(6) and not X(5) and not X(4) and not X(3)
and not X(2) and not X(1) and not X(0) ) or
( X(7) and not X(6) and not X(5) and not X(4) and not X(3)
and not X(2) and not X(1) and not X(0) ) ;
end Formula ;