---------------------------------
--------- i) Dataflow -----------
---------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is

    Port ( a       : in  STD_LOGIC_VECTOR(3 downto 0);
           Control : in  STD_LOGIC_VECTOR(1 downto 0);
           Result  : out STD_LOGIC_VECTOR(3 downto 0));
           
end ALU;

architecture Dataflow of ALU is

begin

    Result(3) <= (a(2) and not Control(1) and not Control(0)) or -- sll
                 ('0'  and not Control(1) and     Control(0)) or -- srl
                 (a(2) and     Control(1) and not Control(0)) or -- rol
                 (a(0) and     Control(1) and     Control(0));   -- ror

    Result(2) <= (a(1) and not Control(1) and not Control(0)) or -- sll
                 (a(3) and not Control(1) and     Control(0)) or -- srl
                 (a(1) and     Control(1) and not Control(0)) or -- rol
                 (a(3) and     Control(1) and     Control(0));   -- ror

    Result(1) <= (a(0) and not Control(1) and not Control(0)) or -- sll
                 (a(2) and not Control(1) and     Control(0)) or -- srl
                 (a(0) and     Control(1) and not Control(0)) or -- rol
                 (a(2) and     Control(1) and     Control(0));   -- ror

    Result(0) <= ('0'  and not Control(1) and not Control(0)) or  -- sll
                 (a(1) and not Control(1) and     Control(0)) or  -- srl
                 (a(3) and     Control(1) and not Control(0)) or  -- rol
                 (a(1) and     Control(1) and     Control(0));    -- ror

end Dataflow;
