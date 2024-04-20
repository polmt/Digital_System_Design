library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use STD.ENV.ALL;

entity counter_TB is

end counter_TB;

architecture Behavioral of counter_TB is

component Counter is
port (
      clk                   : in std_logic;
      reset                 : in std_logic;
      direction             : in std_logic;
      led_result            : out std_logic_vector(6 downto 0); -- LED Result input
      seven_segment         : out std_logic_vector(6 downto 0); -- 7-segment output MSBit is g, LSBit is a
      digit_selection_out   : out std_logic                     -- Digit Selection Pin for PmodSSD
    );
end component Counter;

signal clk                   : std_logic;                    
signal reset                 : std_logic;                    
signal direction             : std_logic;                    
signal led_result            :  std_logic_vector(6 downto 0);
signal seven_segment         :  std_logic_vector(6 downto 0);
signal digit_selection_out   :  std_logic;                    

-- Internal Outputs from UUT
signal Y     : STD_LOGIC;

-- Clock period definitions
constant CLK_period : time := 10 ns;

begin
-- Instantiate the Unit Under Test (UUT)
uut: Counter 	port map (clk, reset, direction, led_result, seven_segment,digit_selection_out);

-- Clock process definition
CLK_process : process
    begin
		CLK <= '0';
		wait for clk_period/2;
		CLK <= '1';
		wait for clk_period/2;
    end process;
   
-- Stimulus process definition
Stimulus_process: process
	begin
-- 	Syncrhonous RESET is deasserted on CLK falling edge 
-- after GSR signal disable (it remains enabled for 100 ns)
		RESET <= '1';
        wait for 100 ns;
        wait until (CLK = '0' and CLK'event);
		RESET <= '0';
		direction<='1';
        assert (unsigned(led_result)<=99) and (unsigned(led_result)>=0) report "out of bounds" severity note;	    
        wait for 50 sec;
		direction<='0';
        assert (unsigned(led_result)<=99) and (unsigned(led_result)>=0) report "out of bounds" severity note;	    
        wait for 20 sec;
		direction<='1';
        assert (unsigned(led_result)<=99) and (unsigned(led_result)>=0) report "out of bounds" severity note;	    
        wait for 80 sec;
		direction<='0';
        assert (unsigned(led_result)<=99) and (unsigned(led_result)>=0) report "out of bounds" severity note;	    
        wait for 20 sec;
                                    
-- Message and simulation end
	report "TESTS COMPLETED";
	stop(2);	
	end process;

end Behavioral;
