library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Accumulator is

    Port ( CLK   : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           X     : in  STD_LOGIC_VECTOR (2 downto 0);
           Y     : out STD_LOGIC_VECTOR (4 downto 0);
           OVF   : out STD_LOGIC );
           
end Accumulator;

architecture Behavioral of Accumulator is

    signal sum : SIGNED(5 downto 0) := "000000";
    
begin

    process(CLK, Reset)
    
    begin
    
        if Reset = '1' then
            sum <= "000000";
            OVF <= '0';
            
        elsif rising_edge(CLK) then
        
            sum <= sum + SIGNED(X);

            if sum > "001111" or sum < "100000" then
                OVF <= '1';
                sum <= "000000";
            else
                OVF <= '0';
                Y <= STD_LOGIC_VECTOR(sum(5) & sum(3 downto 0));
            end if;
            
        end if;
        
    end process;
    
end Behavioral;
