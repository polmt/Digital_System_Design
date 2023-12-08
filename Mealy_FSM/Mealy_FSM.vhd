library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mealy_FSM is
     Port ( CLK :   in STD_LOGIC;
            RESET : in STD_LOGIC;
            X :     in STD_LOGIC;
            Y :     out STD_LOGIC );
end Mealy_FSM;

architecture Behavioral of Mealy_FSM is
    type state_type is (S0, S1, S2, S3, S4, S5);
    signal current_state, next_state : state_type;
begin

process(CLK, RESET)
begin
    if (RESET = '1') then
        current_state <= S0;
    elsif (CLK'event and CLK = '1') then
        current_state <= next_state;
    end if;
end process;

process(current_state, X)
begin
    case current_state is
        when S0 =>
            if (X = '0') then
                next_state <= S0;
                Y <= '0';
            else
                next_state <= S1;
                Y <= '0';
            end if;
        when S1 =>
            if (X = '0') then
                next_state <= S2;
                Y <= '0';
            else
                next_state <= S0;
                Y <= '0';
            end if;
        when S2 =>
            if (X = '0') then
                next_state <= S3;
                Y <= '0';
            else
                next_state <= S0;
                Y <= '0';
            end if;
        when S3 =>
            if (X = '0') then
                next_state <= S4;
                Y <= '0';
            else
                next_state <= S0;
                Y <= '0';
            end if;
        when S4 =>
            if (X = '0') then
                next_state <= S5;
                Y <= '1';
            else
                next_state <= S0;
                Y <= '0';
            end if;
        when S5 =>
            if (X = '0') then
                next_state <= S0;
                Y <= '1';
            else
                next_state <= S0;
                Y <= '0';
            end if;
        when others =>
            next_state <= S0;
            Y <= '0';
    end case;
end process;
end Behavioral;
