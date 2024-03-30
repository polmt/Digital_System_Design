library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_tb is

end ALU_tb;

architecture testbench of ALU_tb is

    signal a_tb       : STD_LOGIC_VECTOR(3 downto 0);
    signal Control_tb : STD_LOGIC_VECTOR(1 downto 0);
    signal Result_tb  : STD_LOGIC_VECTOR(3 downto 0);

    component ALU
    
        Port ( a       : in  STD_LOGIC_VECTOR(3 downto 0);
               Control : in  STD_LOGIC_VECTOR(1 downto 0);
               Result  : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

begin

    uut: ALU port map (a => a_tb, Control => Control_tb, Result => Result_tb);

    process
    
    begin
    
        -- test sll
        a_tb <= "1101";
        Control_tb <= "00";
        wait for 10 ns;
        
        a_tb <= "0011";
        Control_tb <= "00";
        wait for 10 ns;

        -- test srl
        a_tb <= "1101";
        Control_tb <= "01";
        wait for 10 ns;
        
        a_tb <= "1010";
        Control_tb <= "01";
        wait for 10 ns;

        -- test rol
        a_tb <= "1101";
        Control_tb <= "10";
        wait for 10 ns;
        
        a_tb <= "1110";
        Control_tb <= "10";
        wait for 10 ns;

        -- test ror
        a_tb <= "1101";
        Control_tb <= "11";
        wait for 10 ns;
        
        a_tb <= "0101";
        Control_tb <= "11";
        wait for 10 ns;
                
    end process;
            
end testbench;
