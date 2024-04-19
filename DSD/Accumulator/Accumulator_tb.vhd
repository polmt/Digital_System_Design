library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Accumulator_tb is

end Accumulator_tb;

architecture Behavioral of Accumulator_tb is 

    component Accumulator
    
        Port ( CLK   : in  STD_LOGIC;
               Reset : in  STD_LOGIC;
               X     : in  STD_LOGIC_VECTOR (2 downto 0);
               Y     : out STD_LOGIC_VECTOR (4 downto 0);
               OVF   : out STD_LOGIC );
               
    end component;

    signal CLK   : STD_LOGIC := '0';
    signal Reset : STD_LOGIC := '0';
    signal X     : STD_LOGIC_VECTOR (2 downto 0) := "000";

    signal Y     : STD_LOGIC_VECTOR (4 downto 0);
    signal OVF   : STD_LOGIC;

    constant CLK_period : time := 10 ns;

begin

    uut : Accumulator
    
        Port map ( CLK   => CLK,
                   Reset => Reset,
                   X     => X,
                   Y     => Y,
                   OVF   => OVF );

    CLK_process : process
    
    begin
    
        CLK <= '0';
        wait for CLK_period;
        CLK <= '1';
        wait for CLK_period;
        
    end process;

    stim_proc : process
    
    begin
           
        X <= "000";
        wait for CLK_period*4;
        X <= "001";
        wait for CLK_period*4;
        X <= "010";
        wait for CLK_period*4;
        X <= "011";
        wait for CLK_period*4;
        X <= "011";
        wait for CLK_period*4;
        X <= "010";
        wait for CLK_period*4;
        X <= "011";
        wait for CLK_period*4;
        X <= "011";
        wait for CLK_period*4;
        X <= "001";
        wait for CLK_period*4;
        X <= "010";
        wait for CLK_period*4;
        X <= "011";
        wait for CLK_period*4;
        X <= "011";
        wait for CLK_period*4;
        X <= "011";
        wait for CLK_period*4;
       
        X <= "100";
        wait for CLK_period*4;
        X <= "110";
        wait for CLK_period*4;
        X <= "101";
        wait for CLK_period*4;
        X <= "111";
        wait for CLK_period*4;
        X <= "100";
        wait for CLK_period*4;
        X <= "110";
        wait for CLK_period*4;
        X <= "101";
        wait for CLK_period*4;
        X <= "111";
        wait for CLK_period*4;
        X <= "100";
        wait for CLK_period*4;
        X <= "110";
        wait for CLK_period*4;
        X <= "101";
        wait for CLK_period*4;
        X <= "111";
        wait for CLK_period*4;
        
        Reset <= '1';
        wait for CLK_period;
        Reset <= '0';
        wait for CLK_period;
               
    end process;
    
end Behavioral;
