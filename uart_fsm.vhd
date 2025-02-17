--uart_fsm.vhd: UART controller - finite state machine
-- Author(s): Dinara Garipova (xgarip00)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.numeric_std.all;


entity UART_FSM is
    port ( CLK  	       : in std_logic;
           RST             : in std_logic;
           DIN 	           : in std_logic;
           CNT_1           : in std_logic_vector(4 downto 0);
           CNT_2           : in std_logic_vector(3 downto 0);
           CNT_STOP        : in std_logic_vector(3 downto 0);
           DOUT_VLD        : out std_logic;
           CNT_OUT_COUNTER : out std_logic;
			  WAIT_END    		:out std_logic;
           BIT_TYPE_OUT    : out std_logic
		   );
end UART_FSM;

architecture behavioral of UART_FSM is
	type STATE_T is (START, START_BIT, RECEIVE_DATA, STOP_END_BIT, DOUT);
	signal state : STATE_T := START;
begin
	 BIT_TYPE_OUT     <= '1' when state = RECEIVE_DATA else '0';
     CNT_OUT_COUNTER  <= '1' when state = START_BIT or state = RECEIVE_DATA else '0';
	 DOUT_VLD         <= '1' when state = DOUT else '0';
	 WAIT_END          <= '1' when state = STOP_END_BIT else '0';
	
	
        
     process(CLK) is
	 begin
		 if rising_edge(CLK) then
		      if RST = '1' then
				 state <= START;
		      else
			  case state is
				when START => if DIN = '0' then
						state <= START_BIT;
					end if;
				when START_BIT  => if CNT_1 = "10110" then
						state <= RECEIVE_DATA;
					end if;
				when RECEIVE_DATA  => if CNT_2 = "1000" then
						state <= STOP_END_BIT;
					end if;
				when STOP_END_BIT  => 
						
						if CNT_STOP = "1000" then
							state <= DOUT;
						end if;
					
				when DOUT => state <= START;
                               
                when others => null;
			   end case;
		       end if;
            end if;
      end process;
end behavioral;

