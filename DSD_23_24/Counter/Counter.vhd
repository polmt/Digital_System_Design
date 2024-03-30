library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Counter is
port (
      clk                   : in std_logic;
      reset                 : in std_logic;
      direction             : in std_logic;
      led_result            : out std_logic_vector(6 downto 0); -- LED Result input
      seven_segment         : out std_logic_vector(6 downto 0); -- 7-segment output MSBit is g, LSBit is a
      digit_selection_out   : out std_logic                     -- Digit Selection Pin for PmodSSD
    );
end entity Counter;

architecture Behavioral of Counter is

signal clk_100MHz: std_logic;                             --NEW CLOCK. Ticks every sec
signal sum: unsigned(6 downto 0);                         --Running timer value
signal bcd_rd: unsigned(3 downto 0);                      --Right digit in decimal
signal bcd_ld: unsigned(3 downto 0);                      --Left digit in decimal
signal seven_segment_left: std_logic_vector(6 downto 0);  --Left Pmod Digit
signal seven_segment_right: std_logic_vector(6 downto 0); --Right Pmod Digit 
signal digit_selection: std_logic;                        --Choose pmod digit

begin

-- Insert your code here
-- Use ONLY process with case statement

-- Create NEW CLOCK that ticks every 1 sec;


-----------------------------------
---------- Original Code ----------
-----------------------------------

-------------------------------------
-- Comment out for alternative (b) --
-------------------------------------

--One_sec_clk : process (clk, reset) is

--variable clk_ticks : integer;

--begin

--	if reset = '1' then
	
--	   clk_100MHz<='0';
--       clk_ticks :=0;
       
--	elsif rising_edge(clk) then
	
--		if clk_ticks = 99999999 then
----		if clk_ticks = 1 then
--			clk_ticks := 0;
--			clk_100MHz 	<= '1';
--		else
--			clk_ticks := clk_ticks + 1;
--			clk_100MHz <= '0';
--		end if; -- clk_ticks
		
--	end if; --reset

--end process One_sec_clk;




---------------------------------------------
-- Comment out for alternative (a) and (b) --
---------------------------------------------

--count: process (clk_100MHz, reset) is

--begin

--if (reset='1') then

--    sum<=(others=>'0');

--elsif rising_edge(clk_100MHz) then

--    if direction='1' then

--        if sum<99 then 
--            sum<=sum+1;
--        else
--            sum<=(others=>'0');
--        end if; -- sum<99

--    else

--        if sum>0 then 
--            sum<=sum-1;
--        else
--            sum<="1100011";
--        end if; -- sum>0

--    end if; --direction

--end if; --reset

--end process count;






-----------------------------------
----- Use for alternative (a) -----
-----------------------------------

------------------------------
-- Start of alternative (a) --
------------------------------
--count: process (clk, reset) is

--    variable internal_counter : integer range 0 to 99999999 := 0;
    
--begin

--    if (reset = '1') then
--        sum <= (others => '0');
--        internal_counter := 0;

--    elsif rising_edge(clk) then

--        internal_counter := internal_counter + 1;
        
--        if internal_counter >= 99999999 then
--            internal_counter := 0;

--            if direction = '1' then
--                if sum < 99 then 
--                    sum <= sum + 1;
--                else
--                    sum <= (others => '0');
--                end if;
                
--            else
--                if sum > 0 then 
--                    sum <= sum - 1;
--                else
--                    sum <= "1100011";
--                end if;
                
--            end if;
            
--        end if;

--    end if;

--end process count;
----------------------------
-- End of alternative (a) --
----------------------------






-----------------------------------
----- Use for alternative (b) -----
-----------------------------------

------------------------------
-- Start of alternative (b) --
------------------------------
clk_and_count : process (clk, reset) is

    variable clk_ticks : integer;
    
begin

    if reset = '1' then
        clk_100MHz <= '0';
        clk_ticks := 0;
        sum <= (others => '0');
        
    elsif rising_edge(clk) then
    
        if clk_ticks = 99999999 then
            clk_ticks := 0;
            clk_100MHz <= '1';

            if direction = '1' then
            
                if sum < 99 then 
                    sum <= sum + 1;
                else
                    sum <= (others => '0');
                end if;
                
            else
            
                if sum > 0 then 
                    sum <= sum - 1;
                else
                    sum <= "1100011";
                end if;
                
            end if;

        else
        
            clk_ticks := clk_ticks + 1;
            clk_100MHz <= '0';
            
        end if;
        
    end if;

end process clk_and_count;
----------------------------
-- End of alternative (b) --
----------------------------


digit_process: process (clk, reset) is

variable clk_ticks : integer;

begin

	if reset = '1' then
	
       clk_ticks :=0;
       digit_selection<='0';
       seven_segment<=(others=>'0');
    
	elsif rising_edge(clk) then
	
		if clk_ticks = 500000 then
			clk_ticks := 0;
		    if digit_selection='0' then
		          digit_selection<='1';
		          seven_segment<=seven_segment_left;
		    else
		          digit_selection<='0';
		          seven_segment<=seven_segment_right;
		    end if;
		else
			clk_ticks := clk_ticks + 1;
			
		end if; -- clk_ticks
		
	end if; --reset
	
end process digit_process;


---- *************************
---- COMBINATIONAL FOR OUTPUT
---- *************************

--LED Output
led_result<=std_logic_vector(sum);      

----PMOD Output

bcd_ld<=resize(sum/10, bcd_ld'length);     --Tens
bcd_rd<=resize(sum mod 10, bcd_rd'length);                 --Units

-- create right Pmod digit
bcd_right_digit_values: process (bcd_rd) begin

case bcd_rd is

    when X"0" => seven_segment_right   <="0111111";    -- 0
    when X"1" => seven_segment_right   <="0000110";    -- 1
    when X"2" => seven_segment_right   <="1011011";    -- 2
    when X"3" => seven_segment_right   <="1001111";    -- 3
    when X"4" => seven_segment_right   <="1100110";    -- 4
    when X"5" => seven_segment_right   <="1101101";    -- 5
    when X"6" => seven_segment_right   <="1111101";    -- 6
    when X"7" => seven_segment_right   <="0000111";    -- 7
    when X"8" => seven_segment_right   <="1111111";    -- 8
    when X"9" => seven_segment_right   <="1101111";    -- 9
    when others => seven_segment_right <="0000000";
    
    
end case;

-- create left Pmod digit

end process bcd_right_digit_values;

bcd_left_digit_values: process (bcd_ld) begin

case bcd_ld is

    when X"0" => seven_segment_left   <="0111111";    -- 0
    when X"1" => seven_segment_left   <="0000110";    -- 1
    when X"2" => seven_segment_left   <="1011011";    -- 2
    when X"3" => seven_segment_left   <="1001111";    -- 3
    when X"4" => seven_segment_left   <="1100110";    -- 4
    when X"5" => seven_segment_left   <="1101101";    -- 5
    when X"6" => seven_segment_left   <="1111101";    -- 6
    when X"7" => seven_segment_left   <="0000111";    -- 7
    when X"8" => seven_segment_left   <="1111111";    -- 8
    when X"9" => seven_segment_left   <="1101111";    -- 9
    when others => seven_segment_left <="0000000";
    
    
end case;

end process bcd_left_digit_values;


digit_selection_out<=digit_selection;

-- Pmod Digit Value
--seven_segment<=seven_segment_right when digit_selection='0' else seven_segment_left when digit_selection='1' else (others=>'0');

end Behavioral;

