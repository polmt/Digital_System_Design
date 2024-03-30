library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FSM_tb is

end FSM_tb;

architecture Behavioral of FSM_tb is 

    component FSM
    
    Port ( CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           X     : in  STD_LOGIC;
           Y     : out STD_LOGIC );
           
    end component;

   signal CLK   : STD_LOGIC := '0';
   signal RESET : STD_LOGIC := '1';
   signal X     : STD_LOGIC := '0';

   signal Y : STD_LOGIC;

   constant CLK_period : time := 10 ns;

begin

   uut : FSM PORT MAP ( CLK   => CLK,
                        RESET => RESET,
                        X     => X,
                        Y     => Y );

   CLK_process : process
   
   begin
   
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
		
   end process;

   stim_proc: process
   
   begin		

      wait for 10 ns;	
      RESET <= '0'; 

      -- Wrong sequence
      X <= '1';
      wait for 10 ns;
      X <= '1';
      wait for 10 ns;
      X <= '1';
      wait for 10 ns;
      X <= '0';
      wait for 10 ns;
      X <= '0';
      wait for 10 ns;
      
      -- Correct sequence
      X <= '1';
      wait for 10 ns;     
      X <= '1';
      wait for 10 ns;
      X <= '0';
      wait for 10 ns;
      X <= '1';
      wait for 10 ns;

      wait for 10 ns;
      RESET <= '1';
      wait for 10 ns;
      RESET <= '0';
      
   end process;

end Behavioral;
