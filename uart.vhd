-- uart.vhd: UART controller - receiving part
-- Author(s): Dinara Garipova (xgarip00)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

-------------------------------------------------
entity UART_RX is
port(	
    CLK     : in std_logic;
	RST     : in std_logic;
	DIN     : in std_logic;
	DOUT    : out std_logic_vector(7 downto 0);
	DOUT_VLD: out std_logic
);
end UART_RX;  

-------------------------------------------------
architecture behavioral of UART_RX is
	signal CNT_1           : std_logic_vector(4 downto 0);
	signal CNT_2           : std_logic_vector(3 downto 0); 
	signal CNT_STOP        : std_logic_vector(3 downto 0);
	signal DUT            : std_logic;
	signal wait_end 			:std_logic;
	signal DOVLD        : std_logic;
	signal CNT_OUT_COUNTER : std_logic;
    signal BIT_TYPE_OUT    : std_logic;
begin
    FSM: entity work.UART_FSM(behavioral)
    port map(
        CLK             => CLK,
        RST             => RST,
        DIN             => DIN,
        CNT_1           => CNT_1,
        CNT_2           => CNT_2,
       CNT_STOP        => CNT_STOP,
		  WAIT_END    => wait_end,
        CNT_OUT_COUNTER => CNT_OUT_COUNTER,
        BIT_TYPE_OUT    => BIT_TYPE_OUT,
        DOUT_VLD           => DOVLD
    );
	 
	 DOUT_VLD <= DOVLD;

 process(CLK) 
 begin
        if rising_edge(CLK) then
            if RST = '1' then
                CNT_1 <= "00000";
                CNT_2 <= "0000";
					 CNT_STOP <= "0000";
            else
                if CNT_OUT_COUNTER = '1' then
                    CNT_1 <= CNT_1 + 1;
                else
		          CNT_1 <= "00001";
               end if;
            end if;
				
				if wait_end ='1' then
					CNT_STOP <= CNT_STOP + 1;
				end if;
            if BIT_TYPE_OUT = '1' then
		        if CNT_1 = "11000" then
			        CNT_1 <= "01001";
                case CNT_2 is
              
                when "0000" => DOUT(0) <= DIN; 
                when "0001" => DOUT(1) <= DIN; 
                when "0010" => DOUT(2) <= DIN; 
                when "0011" => DOUT(3) <= DIN; 
                when "0100" => DOUT(4) <= DIN; 
                when "0101" => DOUT(5) <= DIN;  
                when "0110" => DOUT(6) <= DIN; 
                when "0111" => DOUT(7) <= DIN;  
                when others => null;
                end case;
                CNT_2 <= CNT_2 + 1;
               end if;
            else
                CNT_2 <= "0000";
            end if;
        end if;
    end process;
end behavioral;
