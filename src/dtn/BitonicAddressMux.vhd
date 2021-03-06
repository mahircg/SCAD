--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- The module feeds invalid address to the sorter for incomplete inputs					+
--																												+
-- File : BitonicAddressMux.vhd																		+
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library IEEE;
use IEEE.std_logic_1164.all;

library work;
--use work.glbSharedTypes.all;
use work.common.all;

entity BitonicAddressMux is
	port(
		vld_vector : in	 validVector_t;
		inp_vector : in  bitonStageBus_t;
		out_vector : out bitonStageBus_t
	);
end entity;

architecture Behaviour of BitonicAddressMux is	
begin
	gen_main:for i in 0 to FU_INPUT_W generate
					out_vector(i).tarAddr	<=  ( (not vld_vector(i)) & InvAddr(i) ) when (vld_vector(i) = '0') else inp_vector(i).tarAddr ;
					out_vector(i).srcAddr	<= inp_vector(i).srcAddr;
					out_vector(i).data	<= inp_vector(i).data ;
					out_vector(i).tarfifoIdx<= inp_vector(i).tarfifoIdx ;
					out_vector(i).srcfifoIdx<= inp_vector(i).srcfifoIdx ;
				end generate;
end architecture;
