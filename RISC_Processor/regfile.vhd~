library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.components.all;

entity registerfile is   
    port
    (
       A1  : in  std_logic_vector(2 downto 0);
       A2  : in  std_logic_vector(2 downto 0);
       A3  : in  std_logic_vector(2 downto 0);
       D3  : in  std_logic_vector(15 downto 0);
       D1  : out std_logic_vector(15 downto 0);
       D2  : out std_logic_vector(15 downto 0);
        registerWrite : in std_logic;
	rout_0,rout_1,rout_2,rout_3,rout_4,rout_5,rout_6,rout_7: out std_logic_vector(15 downto 0);
        clk,reset : in std_logic);
end entity;

architecture Formula of registerfile is
	signal r_en,r_sel: std_logic_vector(7 downto 0);
	type a_vector is array(7 downto 0) of std_logic_vector(15 downto 0);
	signal r_out: a_vector;
	signal D_in,R7_in: std_logic_vector(15 downto 0);
	constant c0: std_logic_vector(15 downto 0):=(others=>'0');

begin

	R0: DataRegister generic map(data_width=>16) port map(Din=>D_in , Dout=>r_out(0) , enable=>r_en(0) , clk=>clk);
	R1: DataRegister generic map(data_width=>16) port map(Din=>D_in , Dout=>r_out(1) , enable=>r_en(1) , clk=>clk);
	R2: DataRegister generic map(data_width=>16) port map(Din=>D_in , Dout=>r_out(2) , enable=>r_en(2) , clk=>clk);
	R3: DataRegister generic map(data_width=>16) port map(Din=>D_in , Dout=>r_out(3) , enable=>r_en(3) , clk=>clk);
	R4: DataRegister generic map(data_width=>16) port map(Din=>D_in , Dout=>r_out(4) , enable=>r_en(4) , clk=>clk);
	R5: DataRegister generic map(data_width=>16) port map(Din=>D_in , Dout=>r_out(5) , enable=>r_en(5) , clk=>clk);
	R6: DataRegister generic map(data_width=>16) port map(Din=>D_in , Dout=>r_out(6) , enable=>r_en(6) , clk=>clk);
	R7: DataRegister generic map(data_width=>16) port map(Din=>R7_in , Dout=>r_out(7) , enable=>r_en(7) , clk=>clk);

--enable signals
	dec: decoder port map(X=>A3, S=>r_sel);
	r_en(0)<=(r_sel(0) and registerWrite) or reset;
	r_en(1)<=(r_sel(1) and registerWrite) or reset;
	r_en(2)<=(r_sel(2) and registerWrite) or reset;
	r_en(3)<=(r_sel(3) and registerWrite) or reset;
	r_en(4)<=(r_sel(4) and registerWrite) or reset;
	r_en(5)<=(r_sel(5) and registerWrite) or reset;
	r_en(6)<=(r_sel(6) and registerWrite) or reset;
	r_en(7)<=(r_sel(7) and registerWrite) or reset;


--ouput data
	D1<=r_out(0) when A1="000" else
	    r_out(1) when A1="001" else
	    r_out(2) when A1="010" else
	    r_out(3) when A1="011" else
	    r_out(4) when A1="100" else
	    r_out(5) when A1="101" else
	    r_out(6) when A1="110" else
	    r_out(7) when A1="111";

	D2<=r_out(0) when A2="000" else
	    r_out(1) when A2="001" else
	    r_out(2) when A2="010" else
	    r_out(3) when A2="011" else
	    r_out(4) when A2="100" else
	    r_out(5) when A2="101" else
	    r_out(6) when A2="110" else
	    r_out(7) when A2="111";

	D_in<=c0 when reset='1' else D3;	
	R7_in<=c0 when reset='1' else D3;
	rout_0<=r_out(0);
	rout_1<=r_out(1);
	rout_2<=r_out(2);
	rout_3<=r_out(3);
	rout_4<=r_out(4);
	rout_5<=r_out(5);
	rout_6<=r_out(6);
	rout_7<=r_out(7);
	
 
   --process(clk)
    --begin
      --  if falling_edge(clk) then
        --        D1 <= registers(to_integer(unsigned(A1)));
          --      D2 <= registers(to_integer(unsigned(A2)));
           --     if(registerWrite = '1') then
             --       registers(to_integer(unsigned(A3))) <= D3;
               -- end if;

       -- end if;
    --end process;
end Formula;
