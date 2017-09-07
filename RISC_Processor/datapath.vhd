library ieee;
use ieee.std_logic_1164.all;
library work;
use work.components.all;
entity datapath is
port(clk,reset: in std_logic; 
--register control signals
	opcode_alu,A1_op,demux_op,T4_op,D3_op,alu_b_op:in std_logic_vector(1 downto 0);
	T2_op,A3_op:in std_logic_vector(2 downto 0);
	alu_a_op,ze_en,carry_en,T1_en, T2_en,T3_en, T4_en,T5_en,ir_en,T1_op,T3_op,A2_op,MemWrite,registerWrite, mem_add_op, mem_data_op :in std_logic;
	rout_0,rout_1,rout_2,rout_3,rout_4,rout_5,rout_6,rout_7: out std_logic_vector(15 downto 0);
	pe_flag,carry,zero: out std_logic;
	instruction:out std_logic_vector(15 downto 0));
end entity;

architecture Formula of datapath is
signal rout_0s,rout_1s,rout_2s,rout_3s,rout_4s,rout_5s,rout_6s,rout_7s,T1in,T1ou,T2in,T2ou,T3in,T3ou,T4in,T4ou,T5in,T5ou,irin,irout,lshou,mem_data,mem_add,ALU_a,ALU_b,ALUou,demuxo1,demuxo2,demuxo3,se9ou,se9in,se6in,se6ou,D1ou,D2ou,D3in,memou:std_logic_vector(15 downto 0);
signal T5temp1,T5temp2,T5temp: std_logic_vector(7 downto 0);
signal A1in,A2in,A3in,pe_out : std_logic_vector(2 downto 0);
signal carryout,zeout,zein,carryin :std_logic_vector(0 downto 0);
constant c1: std_logic_vector(15 downto 0):=(0=>'1',others=>'0');
constant c0: std_logic_vector(15 downto 0):=(others=>'0');
	
begin

--data registers
	T1: DataRegister generic map(data_width=>16) port map(Din=>T1in , Dout=>T1ou , Enable=>T1_en , clk=>clk);
	T2: DataRegister generic map(data_width=>16) port map(Din=>T2in , Dout=>T2ou , Enable=>T2_en , clk=>clk);
	T3: DataRegister generic map(data_width=>16) port map(Din=>T3in , Dout=>T3ou , Enable=>T3_en , clk=>clk);
	T4: DataRegister generic map(data_width=>16) port map(Din=>T4in , Dout=>T4ou , Enable=>T4_en , clk=>clk);
	T5: DataRegister generic map(data_width=>16) port map(Din=>T5in , Dout=>T5ou , Enable=>T5_en , clk=>clk);
	ir: DataRegister generic map(data_width=>16) port map(Din=>irin , Dout=>irout , Enable=>ir_en , clk=>clk);	
	ze: DataRegister generic map(data_width=>1) port map(Din=>zein , Dout=>zeout , Enable=>ze_en , clk=>clk);
	ca: DataRegister generic map(data_width=>1) port map(Din=>carryin , Dout=>carryout , Enable=>carry_en , clk=>clk);
--alus
	ALU_a<= T1ou when alu_a_op='0' else
		--T2ou when alu_a_op='1';
		T2ou;
	ALU_b<= T2ou  when alu_b_op="00" else
		c1   when alu_b_op="01" else
		se6ou when alu_b_op="10"else
		--se9ou when alu_b_op="11";
		se9ou;
	ALU_main:ALU port map(I1=>ALU_a,I2=>ALU_b,Ou=>ALUou,op=>opcode_alu,zeroflag=>zein(0),carryflag=>carryin(0));
	carry<=carryout(0);
	zero<=zeout(0);
--Demux
	demuxo1<=ALUou when demux_op="00" else
		c0;
	demuxo2<=ALUou when demux_op="01" else
		c0;
	demuxo3<=ALUou when demux_op="10" else
		c0;

--MUX_t1

	T1in<=T3ou when T1_op='0' else
		--D1ou when T1_op='1';
		D1ou;
--MUX_t2	
	T2in<=demuxo3 when T2_op="000" else
		D2ou when T2_op="001" else
		irin when T2_op="100" else
		T5ou when T2_op="101" else
		se9ou when T2_op="110" else
		c0;

--MUX_t3
	T3in<=D1ou when T3_op='0' else
	    --demuxo1 when T3_op='1';
		demuxo1;
--MUX_t4
	T4in<=D1ou when T4_op="00" else
	      demuxo2 when T4_op="01" else
		mem_data when T4_op="11" else
		--irin when T4_op="10";
		irin;
--registerfile

  --MUX_A1
	A1in<=irout(11 downto 9) when A1_op="00" else
	    "111" when A1_op="01" else	
	    pe_out when A1_op="10" else
		"000";
   --MUX A2
	A2in<=irout(8 downto 6);			

    --MUX A3
	A3in<=irout(11 downto 9) when A3_op="000" else
	      irout(8 downto 6) when A3_op="001" else
	      irout(5 downto 3) when A3_op="010" else
		"111" when A3_op="101" else
	      pe_out when A3_op="110" else
		"000";
	
    --MUX D3
	D3in<=T4ou when D3_op="00" else
	      T2ou when D3_op="01" else
	      lshou when D3_op="10" else
	    --  T3ou when D3_op="11"; 	
		T3ou;

lsh7:LeftS_7 port map(X=>irout(8 downto 0), S=>lshou);
regf:registerfile port map(reset=>reset,A1=>A1in,A2=>A2in,A3=>A3in,D3=>D3in,D1=>D1ou,D2=>D2ou,clk=>clk,registerWrite=>registerWrite,rout_0=>rout_0s,rout_1=>rout_1s,rout_2=>rout_2s,rout_3=>rout_3s,rout_4=>rout_4s,rout_5=>rout_5s,rout_6=>rout_6s,rout_7=>rout_7s);
sgn6:SignEx_6 port map(X=>irout(5 downto 0), S=>se6ou);
sgn9:SignEx_9 port map(X=>irout(8 downto 0), S=>se9ou); 
	


--PE
pe:Priorityenc port map(X=>T2ou(7 downto 0),S=>pe_out);
de:decoder port map(X=>pe_out,S=>T5temp);
T5temp1(0)<=not T5temp(0);
T5temp1(1)<=not T5temp(1);
T5temp1(2)<=not T5temp(2);
T5temp1(3)<=not T5temp(3);
T5temp1(4)<=not T5temp(4);
T5temp1(5)<=not T5temp(5);
T5temp1(6)<=not T5temp(6);
T5temp1(7)<=not T5temp(7);

T5temp2(0)<=T5temp1(0) and T2ou(0);
T5temp2(1)<=T5temp1(1) and T2ou(1);
T5temp2(2)<=T5temp1(2) and T2ou(2);
T5temp2(3)<=T5temp1(3) and T2ou(3);
T5temp2(4)<=T5temp1(4) and T2ou(4);
T5temp2(5)<=T5temp1(5) and T2ou(5);
T5temp2(6)<=T5temp1(6) and T2ou(6);
T5temp2(7)<=T5temp1(7) and T2ou(7);

T5in<= T2ou(15 downto 8) & T5temp2; 
pe_flag<=not(T5in(0)) and not(T5in(1)) and not(T5in(2)) and not(T5in(3)) and not(T5in(4)) and not(T5in(5)) and not(T5in(6))  and not(T5in(7)) and not(T5in(8));

Mem: Memoryn port map(Address=>mem_add,DataWrite=>mem_data,DataRead=>irin,clk=>clk,Mem_Write=>MemWrite);				

--MUX_mem_add	
	mem_add<=T1ou when mem_add_op='0' else
		--T3ou when mem_add_op='1';
		T3ou;

--MUX_mem_data	
	mem_data<=T3ou when mem_data_op='0' else
		--T4ou when mem_data_op='1';
		  T4ou;
rout_0<=rout_0s;
rout_1<=rout_1s;
rout_2<=rout_2s;
rout_3<=rout_3s;
rout_4<=rout_4s;
rout_5<=rout_5s;
rout_6<=rout_6s;
rout_7<=rout_7s;
instruction<=irout;
--rout_7<="0000000000000000";
end Formula;

