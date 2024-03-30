---------------------------------
------- ii) Behavioral ----------
---------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is

    Port ( a       : in  STD_LOGIC_VECTor(3 downto 0);
           Control : in  STD_LOGIC_VECTor(1 downto 0);
           Result  : out STD_LOGIC_VECTor(3 downto 0));
         
end ALU;

architecture Behavioral of ALU is

begin

    process(a, Control)
    
        variable Result_temp : STD_LOGIC_VECTor(3 downto 0);
        
    begin

        Result_temp := (others => '0');

        -- sll
        if Control = "00" then
            Result_temp := a(2 downto 0) & "0";

        -- srl
        elsif Control = "01" then
            Result_temp := "0" & a(3 downto 1);

        -- rol
        elsif Control = "10" then
            Result_temp := a(2 downto 0) & a(3);

        -- ror
        elsif Control = "11" then
            Result_temp := a(0) & a(3 downto 1);

        end if;

        Result <= Result_temp;
        
    end process;
  
end Behavioral;
