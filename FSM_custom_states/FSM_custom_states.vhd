library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED;
use IEEE.STD_LOGIC_UNSIGNED;

entity FSM is
     Port ( CLK : in STD_LOGIC;
            RESET : in STD_LOGIC;
            X : in STD_LOGIC;
            Y : out STD_LOGIC );
end FSM;

--Binary

--architecture Behavioral of FSM is
--    type FSM_states is (S0, S1, S2, S3, S4);
--    signal current_state, next_state : FSM_states;
--begin
--    process(CLK, RESET)
--    begin
--        if (RESET = '1') then
--            current_state <= S0;
--        elsif (CLK'event and CLK = '1') then
--            current_state <= next_state;
--        end if;
--    end process;

--    process(current_state, X)
--    begin
--        case current_state is
--            when S0 =>
--                if (X = '0') then
--                    next_state <= S0;
--                else
--                    next_state <= S1;
--                end if;
--                Y <= '0';
--            when S1 =>
--                if (X = '1') then
--                    next_state <= S1;
--                else
--                    next_state <= S2;
--                end if;
--                Y <= '0';
--            when S2 =>
--                if (X = '0') then
--                    next_state <= S2;
--                else
--                    next_state <= S3;
--                end if;
--                Y <= '0';
--            when S3 =>
--                if (X = '1') then
--                    next_state <= S3;
--                else
--                    next_state <= S4;
--                end if;
--                Y <= '0';
--            when S4 =>
--                if (X = '1') then
--                    next_state <= S4;
--                else
--                    next_state <= S0;
--                end if;
--                Y <= '1';
--            when others =>
--                next_state <= S0;
--                Y <= '0';
--        end case;
--    end process;
--end Behavioral;

--Gray

architecture Behavioral of FSM is
    type FSM_states is (S0, S1, S2, S3, S4);
    signal current_state, next_state : FSM_states;
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
                else
                    next_state <= S1;
                end if;
                Y <= '0';
            when S1 =>
                if (X = '1') then
                    next_state <= S1;
                else
                    next_state <= S2;
                end if;
                Y <= '0';
            when S2 =>
                if (X = '0') then
                    next_state <= S2;
                else
                    next_state <= S3;
                end if;
                Y <= '0';
            when S3 =>
                if (X = '1') then
                    next_state <= S3;
                else
                    next_state <= S4;
                end if;
                Y <= '0';
            when S4 =>
                if (X = '1') then
                    next_state <= S4;
                else
                    next_state <= S0;
                end if;
                Y <= '1';
            when others =>
                next_state <= S0;
                Y <= '0';
        end case;
    end process;
end Behavioral;


--One-Hot

--architecture Behavioral of FSM is
--    type FSM_states is (S0, S1, S2, S3, S4);
--    attribute enum_encoding: string;
--    attribute enum_encoding of FSM_states: type is "00001 00010 00100 01000 10000";
--    signal current_state, next_state : FSM_states;
--begin
--    process(CLK, RESET)
--    begin
--        if (RESET = '1') then
--            current_state <= S0;
--        elsif (CLK'event and CLK = '1') then
--            current_state <= next_state;
--        end if;
--    end process;

--    process(current_state, X)
--    begin
--        case current_state is
--            when S0 =>
--                if (X = '0') then
--                    next_state <= S0;
--                else
--                    next_state <= S1;
--                end if;
--                Y <= '0';
--            when S1 =>
--                if (X = '1') then
--                    next_state <= S1;
--                else
--                    next_state <= S2;
--                end if;
--                Y <= '0';
--            when S2 =>
--                if (X = '0') then
--                    next_state <= S2;
--                else
--                    next_state <= S3;
--                end if;
--                Y <= '0';
--            when S3 =>
--                if (X = '1') then
--                    next_state <= S3;
--                else
--                    next_state <= S4;
--                end if;
--                Y <= '0';
--            when S4 =>
--                if (X = '1') then
--                    next_state <= S4;
--                else
--                    next_state <= S0;
--                end if;
--                Y <= '1';
--            when others =>
--                next_state <= S0;
--                Y <= '0';
--        end case;
--    end process;
--end Behavioral;
