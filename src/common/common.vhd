
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- TODO: Replace STD_LOGIC by something less prone to error/forgetting cases

PACKAGE common IS
-- BASICS ----------------------------------------------------------------------
	CONSTANT DATA_WIDTH: NATURAL := 32;
	SUBTYPE data_word IS STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
	
	-- instruction memory (i.e. pc) address width
	-- out of comission - pc is just another data word
	--CONSTANT PC_WIDTH := DATA_WIDTH;
	
	CONSTANT ADDRESS_FU_WIDTH: NATURAL := 5;
	CONSTANT ADDRESS_BUFF_WIDTH: NATURAL := 1;
	SUBTYPE address_fu IS STD_LOGIC_VECTOR((ADDRESS_FU_WIDTH - 1) downto 0);
	SUBTYPE buff_num IS STD_LOGIC_VECTOR((ADDRESS_BUFF_WIDTH - 1) downto 0);
	TYPE address_fu_buff IS RECORD
		fu: address_fu;
		buff: buff_num;
	END RECORD;
	
-- MOVE INSTRUCTION BUS --------------------------------------------------------
	-- 2-phase commit for instructions required for broadcasting to work
	TYPE mib_phase IS (CHECK, COMMIT);
	
	-- input of FU, output of CTRL
	TYPE mib_ctrl_out IS RECORD
		phase: mib_phase;
		valid: STD_LOGIC;
		src: address_fu_buff;
		dest: address_fu_buff;
	END RECORD;
	
	-- output of FU, input of CTRL
	TYPE mib_stalls IS RECORD
		src_stalled: STD_LOGIC;
		dest_stalled: STD_LOGIC;
	END RECORD;
	
-- DATA NETWORK ----------------------------------------------------------------
	TYPE data_message IS RECORD
		src: address_fu_buff;
		dest: address_fu_buff;
		data: data_word;
	END RECORD;
	
	TYPE data_port_sending IS RECORD
		message: data_message;
		valid: STD_LOGIC;
	END RECORD;
	
	TYPE data_port_receiving IS RECORD
		is_read: STD_LOGIC;
	END RECORD;
	
END common;

