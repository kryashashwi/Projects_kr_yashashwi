library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;
--library work;
--use work.components.all;	

entity Testbenchadd is
end entity;
architecture Behave of Testbenchadd is
component SixteenBitAdder is
port ( 
   X , Y : in std_logic_vector(15 downto 0);
   S : out std_logic_vector(15 downto 0);
   carryflag : out std_logic);
end component;
  

  signal x0,x1: std_logic_vector(15 downto 0);
  signal x2 : std_logic_vector(15 downto 0);
  signal x3 : std_logic;
  function to_std_logic(x: bit) return std_logic is
      variable ret_val: std_logic;
  begin  
    
      if (x = '1') then
        ret_val := '1';
      else 	
        ret_val := '0';
      end if;
    
      return(ret_val);
  end to_std_logic;


  function to_string(x: string) return string is
      variable ret_val: string(1 to x'length);
      alias lx : string (1 to x'length) is x;
  begin  
      ret_val := lx;
      return(ret_val);
  end to_string;

begin
  process 
    variable err_flag : boolean := false;
    File INFILE: text open read_mode is "TRACEFILE.txt";
    FILE OUTFILE: text  open write_mode is "OUTPUTS.txt";

    ---------------------------------------------------
    -- edit the next two lines to customize
    variable input_vector: bit_vector(15 downto 0);
    variable input_vector1: bit_vector ( 15 downto 0);
    variable output_vector: bit_vector ( 15 downto 0);
    variable input_vector2: bit;
    ----------------------------------------------------
    variable INPUT_LINE: Line;
    variable OUTPUT_LINE: Line;
    variable LINE_COUNT: integer := 0;
    
  begin
   
    while not endfile(INFILE) loop 
          LINE_COUNT := LINE_COUNT + 1;
	
	  readLine (INFILE, INPUT_LINE);
          read (INPUT_LINE, input_vector);
	  read (INPUT_LINE, input_vector1);
	--  read (INPUT_LINE, input_vector2);
          read (INPUT_LINE, output_vector);

          --------------------------------------
          -- from input-vector to DUT inputs
        for i in 0 to 15 loop
      x0(i) <= to_std_logic(input_vector(i));
    end loop;
	for i in 0 to 15 loop
	x1(i) <= to_std_logic(input_vector1(i));
	end loop;

	--for i in 0 to 0 loop
	x3 <= to_std_logic(input_vector2);
	--end loop;
	  
          --------------------------------------


	  -- let circuit respond.
          wait for 5 ns;

          --------------------------------------
	  -- check outputs.
	for i in 0 to 15 loop
	  if (x2(i) /= to_std_logic(output_vector(i))) then
             write(OUTPUT_LINE,to_string("ERROR: in s0, line "));
             write(OUTPUT_LINE, LINE_COUNT);
             writeline(OUTFILE, OUTPUT_LINE);
             err_flag := true;
          end if;
	end loop;
          --------------------------------------
    end loop;

    assert (err_flag) report "SUCCESS, all tests passed." severity note;
    assert (not err_flag) report "FAILURE, some tests failed." severity error;

    wait;
  end process;

  dut: SixteenBitAdder 
     port map(X => x0,
              Y => x1,
              S=> x2,
	      carryflag=>x3
              );

end Behave;
