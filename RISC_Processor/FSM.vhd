library ieee;
use ieee.std_logic_1164.all;
library work;
use work.components.all;

entity FSM is
	port (
	clk,reset: in std_logic;
	opcode_alu,A1_op,demux_op,T4_op,D3_op,alu_b_op:out std_logic_vector(1 downto 0);
	T2_op,A3_op:out std_logic_vector(2 downto 0);
	alu_a_op,ze_en,carry_en,T1_en, T2_en,T3_en, T4_en,T5_en,ir_en,T1_op,T3_op,A2_op,MemWrite,registerWrite, mem_add_op, mem_data_op :out std_logic;
	pe_flag,carry,zero: in std_logic;
	--op1:in std_logic_vector(3 downto 0);
	--op2:in std_logic_vector(1 downto 0);
	instruction:in std_logic_vector(15 downto 0));
end entity;

architecture Formula of FSM is
	signal op1: std_logic_vector(3 downto 0);
	signal op2: std_logic_vector(1 downto 0);
	
   type FSM_State is (S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20);
 signal S: FSM_State;
begin

op1<=instruction(15 downto 12);
op2<=instruction(1 downto 0);
process(S,op1,op2,pe_flag,carry,zero,clk,reset)
      variable next_state: FSM_State;
      variable opcode_alu_var,alu_b_var,demux_op_var,T4_op_var,D3_op_var,A1_op_var : std_logic_vector(1 downto 0);
	variable alu_a_var,T1_en_var, T2_en_var,T3_en_var,ze_en_var,carry_en_var, T4_en_var,T5_en_var,ir_en_var,T1_op_var,T3_op_var,A2_op_var,MemWrite_var,registerWrite_var, mem_add_op_var, mem_data_op_var : std_logic;
	variable T2_op_var,A3_op_var: std_logic_vector(2 downto 0);	
      
   begin
	 -- defaults
opcode_alu_var:="00";A3_op_var:="000";A1_op_var:="00";demux_op_var:="00";T4_op_var:="00";D3_op_var:="00";
alu_b_var:="00";T2_op_var:="000";
alu_a_var:='0';T1_en_var:='0'; T2_en_var:='0';T3_en_var:='0'; T4_en_var:='0';T5_en_var:='0';ir_en_var:='0';T1_op_var:='0';T3_op_var:='0';A2_op_var:='0';MemWrite_var:='0';registerWrite_var:='0'; mem_add_op_var:='0'; mem_data_op_var:='0';ze_en_var:='0';carry_en_var:='0';
       next_state := S; 
	
    case S is 
	
	when S1=>
		A1_op_var:="01";
		T1_op_var:='1';
		T1_en_var:='1';
		next_state := S2;	 
		
	
	when S2 =>
			 
		opcode_alu_var:="00";
		alu_a_var:='0';
		alu_b_var:="01";
		demux_op_var:="00";
		T3_en_var:='1';
		T3_op_var:='1';
		mem_add_op_var:='0';
		--.MemWrite_var:='1';
		ir_en_var:='1';
		
		--	next_state := S11;
		
		
		next_state := S3;
	--
	when S3=>
		if (op1="1100") then 
		opcode_alu_var:="00";
		alu_a_var:='0';
		alu_b_var:="10";
		demux_op_var:="01";
		T4_en_var:='1';
		T4_op_var:="01";
		A3_op_var:="101";
		D3_op_var:="11";
		
		registerWrite_var:='1';
		next_state := S4;
		end if;
		
		--MemWrite_var:='1';
		
		D3_op_var:="11";
		registerWrite_var:='1';
		--T3_en_var:='0';
		if(op1="1000" or op1="1001") then
			A3_op_var:="000";
		else
			A3_op_var:="101";
		end if;	
		if(op1="0011") then
			next_state := S20;
		elsif(op1="0110" or op1="0111") then
			next_state := S13;
		elsif(op1="1000") then
			next_state := S18;
		else
			next_state := S4;
		end if;
		
	when S4=>
		T1_en_var:='1';
		T2_en_var:='1';
		T1_op_var:='1';
		T2_op_var:="001";
		A1_op_var:="00";
		A2_op_var:='0';
		if(op1="1001") then
			next_state := S8;
		elsif(op1="0001" or op1="0100" or op1="0101") then
			next_state := S9;
		elsif(op1="1000") then
			next_state := S18;
		else
			next_state := S5;
		end if;

	when S5=>
		alu_a_var:='0';
		alu_b_var:="00";
		if (op1="1100") then 
			opcode_alu_var:="01";
			ze_en_var:='1';
		end if;	
		if(op1="1100") then
			next_state := S7;
		elsif(op1="0000" and op2="00")then
			ze_en_var:='1';carry_en_var:='1';
			opcode_alu_var:="00";
			demux_op_var:="00";
			T3_en_var:='1';
			T3_op_var:='1';
			next_state := S6;
		elsif(op1="0000" and op2="01")then
			if(zero='1')then
				ze_en_var:='1';carry_en_var:='1';
				opcode_alu_var:="00";
				demux_op_var:="00";
				T3_en_var:='1';
				T3_op_var:='1';
				next_state := S6;
			else
				next_state := S1;
			end if;
		elsif(op1="0000" and op2="10")then
			if(carry='1')then
				ze_en_var:='1';carry_en_var:='1';
				opcode_alu_var:="00";
				demux_op_var:="00";
				T3_en_var:='1';
				T3_op_var:='1';
				next_state := S6;
				
			else
				next_state := S1;
			end if;
		elsif(op1="0010" and op2="00")then
			ze_en_var:='1';carry_en_var:='1';
			opcode_alu_var:="10";
			demux_op_var:="00";
			T3_en_var:='1';
			T3_op_var:='1';
			next_state := S6;
		elsif(op1="0010" and op2="10")then
			if(carry='1')then
				ze_en_var:='1';carry_en_var:='1';
				opcode_alu_var:="10";
				demux_op_var:="00";
				T3_en_var:='1';
				T3_op_var:='1';
				next_state := S6;
			else
				next_state := S1;
			end if;
		elsif(op1="0010" and op2="01")then
			if(zero='1')then
				ze_en_var:='1';carry_en_var:='1';
				opcode_alu_var:="10";
				demux_op_var:="00";
				T3_en_var:='1';
				T3_op_var:='1';
				next_state := S6;
			else
				next_state := S1;
			end if;
		end if;

	when S11=>
		opcode_alu_var:="01";
		alu_a_var:='0';
		alu_b_var:="10";
		demux_op_var:="01";
		T4_en_var:='1';
		T4_op_var:="01";
		A3_op_var:="101";
		D3_op_var:="11";
		mem_add_op_var:='1';
		registerWrite_var:='1';
		--MemWrite_var:='1';
		if(op1="1100") then
			next_state := S4;
		end if;	
	when S13=>
		T1_en_var:='1';
		T2_en_var:='1';
		T3_en_var:='1';
		T2_op_var:="110";
		T1_op_var:='1';
		T3_op_var:='0';
		A1_op_var:="00";
		if(op1="0110") then
			next_state := S16;
		elsif(op1="0111") then
			next_state := S14;
		end if;
	when S16=>	
		
		opcode_alu_var:="00";
		alu_a_var:='0';
		alu_b_var:="01";
		demux_op_var:="00";
		T3_en_var:='1';
		T4_en_var:='1';
		T5_en_var:='1';
		T3_op_var:='1';
		T4_op_var:="10";
		mem_add_op_var:='0';
		--MemWrite_var:='1';
		if(op1="0110") then
			next_state := S17;
		end if;
	
	when S14=>	
		T1_en_var:='1';
		T5_en_var:='1';
		T1_op_var:='0';
		if(op1="0111") then
			next_state := S15;
		end if;
	when S15=>	
		opcode_alu_var:="00";
		alu_a_var:='0';
		alu_b_var:="01";
		demux_op_var:="00";
		T3_en_var:='1';
		T4_en_var:='1';
		T3_op_var:='1';
		T4_op_var:="00";
		A1_op_var:="10";
		
 		if(op1="0111") then
			next_state := S19;
		end if;
	
	when S18=>
		opcode_alu_var:="00";
		alu_a_var:='0';
		alu_b_var:="11";
		demux_op_var:="10";
		T2_en_var:='1';	
		T2_op_var:="000";
		if(op1="1000") then
			next_state := S8;
		end if;
	when S9=>
		if(op1="0001") then
		opcode_alu_var:="00";
		alu_a_var:='0';
		alu_b_var:="10";
		demux_op_var:="10";
		T2_en_var:='1';	
		T2_op_var:="000";
		else
			
		opcode_alu_var:="00";
		alu_a_var:='1';
		alu_b_var:="10";
		demux_op_var:="00";
		T3_en_var:='1';	
		T3_op_var:='1';
		end if;
		if(op1="0100") then
			next_state := S10;
		elsif(op1="0001") then
			next_state := S8;
		elsif(op1="0101") then
			next_state := S12;
		end if;
	when S10=>
		T2_en_var:='1';	
		T2_op_var:="100";
		mem_add_op_var:='1';
		--MemWrite_var:='1';	
		if(op1="0100") then
			next_state := S8;
		end if;			
	when S12=>
		mem_add_op_var:='0';
		mem_data_op_var:='0';
		MemWrite_var:='1';
		next_state := S1;
	
	when S6=>
		next_state := S1;
		registerWrite_var:='1';
		A3_op_var:="010";
		D3_op_var:="11";	
	when S7=>
		next_state := S1;
		if(zero='1') then
		registerWrite_var:='1';
		A3_op_var:="101";
		D3_op_var:="00";
		end if;
	when S19=>
		if(pe_flag='1') then
			next_state := S1;
		else
			next_state := S14;
		end if;
		MemWrite_var:='1';
		T2_en_var:='1';	
		T2_op_var:="101";
		mem_add_op_var:='0';
		mem_data_op_var:='1';
	when S17=>
		T1_en_var:='1';	
		T2_en_var:='1';	
		T2_op_var:="101";
		T1_op_var:='0';
		registerWrite_var:='1';
		A3_op_var:="110";
		D3_op_var:="00";
		if(pe_flag='1') then
			next_state := S1;
		else
			next_state := S16;
		end if;
		
	when S8=>
		D3_op_var:="01";
		registerWrite_var:='1';
		if(op1="0100") then
			A3_op_var:="000";
		elsif(op1="0001") then
			A3_op_var:="001";
		else
			A3_op_var:="101";
		end if;	
		next_state := S1;
	when S20=>
		registerWrite_var:='1';
		A3_op_var:="000";
		D3_op_var:="10";
		next_state := S1;
   end case;

opcode_alu<=opcode_alu_var;A1_op<=A1_op_var;demux_op<=demux_op_var;T4_op<=T4_op_var;D3_op<=D3_op_var;alu_b_op<=alu_b_var;
T2_op<=T2_op_var;A3_op<=A3_op_var;
alu_a_op<=alu_a_var;T1_en<=T1_en_var;T2_en <=T2_en_var;T3_en<=T3_en_var; T4_en<=T4_en_var;T5_en<=T5_en_var;ir_en<=ir_en_var;T1_op<=T1_op_var;T3_op<=T3_op_var;A2_op<=A2_op_var;MemWrite<=MemWrite_var;registerWrite<=registerWrite_var; mem_add_op<=mem_add_op_var;mem_data_op<= mem_data_op_var;carry_en<=carry_en_var;ze_en<=ze_en_var;
if(clk'event and (clk = '1')) then
		if(reset = '1') then
             	   S <= S1;
        	else
                   S <= next_state;
        	end if;	
	end if;
   end process;
	
   
end Formula;
