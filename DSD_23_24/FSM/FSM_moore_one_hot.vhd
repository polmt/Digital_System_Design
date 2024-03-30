--------------------------------------
---------- Moore One-Hot -------------
--------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM is

    Port ( CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           X     : in  STD_LOGIC;
           Y     : out STD_LOGIC );
           
end FSM;

architecture Behavioral of FSM is

    type state_type is (S0, S1, S2, S3, S4);
    
    attribute enum_encoding: string;
    attribute enum_encoding of state_type: type is "00001 00010 00100 01000 10000";

    signal state, next_state : state_type := S0;
    
begin

    process(CLK, RESET)
    
    begin
    
        if RESET = '1' then
            state <= S0;
        elsif rising_edge(CLK) then
            state <= next_state;
        end if;
        
    end process;

    process(state, X)
    
    begin
    
        case state is
        
            when S0 =>
                if X = '1' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
                
            when S1 =>
                if X = '1' then
                    next_state <= S2;
                else
                    next_state <= S0;
                end if;
                
            when S2 =>
                if X = '0' then
                    next_state <= S3;
                else
                    next_state <= S2;
                end if;
                
            when S3 =>
                if X = '1' then
                    next_state <= S4;
                else
                    next_state <= S0;
                end if;
                
            when S4 =>
                next_state <= S0;

            when others =>
                next_state <= S0;
                
        end case;
        
    end process;

    Y <= '1' when state = S4 else '0';
    
end Behavioral;
