---------------------------------
---- iv) Structural 2 bits ------
---------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ShiftLR is

    Port ( a       : in  STD_LOGIC_VECTOR(1 downto 0);
           LR_in   : in  STD_LOGIC;
           Control : in  STD_LOGIC;
           Result  : out STD_LOGIC_VECTOR(1 downto 0));
           
end ShiftLR;

architecture Behavioral of ShiftLR is

begin

    process(a, Control, LR_in)
    
    begin
    
        case Control is
        
            when '0' =>  -- Shift Left
                Result <= a(0) & '0';
            when '1' =>  -- Shift Right
                Result <= LR_in & a(1);
            when others =>
                Result <= (others => '0');
                
        end case;
        
    end process;
    
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RotateLR is

    Port ( a       : in  STD_LOGIC_VECTOR(1 downto 0);
           LR_in   : in  STD_LOGIC;
           Control : in  STD_LOGIC;
           Result  : out STD_LOGIC_VECTOR(1 downto 0));
           
end RotateLR;


architecture Behavioral of RotateLR is

begin

    process(a, Control)
    
    begin
    
        case Control is
        
            when '0' =>  -- Rotate Left
                Result <= a(0) & a(1);
            when '1' =>  -- Rotate Right
                Result <= a(1) & a(0);
            when others =>
                Result <= (others => '0');
                
        end case;
        
    end process;
    
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mux_2to1 is

    Port ( a      : in  STD_LOGIC_VECTOR(3 downto 0);
           b      : in  STD_LOGIC_VECTOR(3 downto 0);
           Sel    : in  STD_LOGIC;
           Result : out STD_LOGIC_VECTOR(3 downto 0));
           
end entity;

architecture Behavioral of Mux_2to1 is

begin

    process (a, b, Sel)
    
    begin
    
        if (Sel = '0') then
            Result <= a;
        else
            Result <= b;
        end if;
        
    end process;
    
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is

    Port ( a       : in  STD_LOGIC_VECTOR(3 downto 0);
           Control : in  STD_LOGIC_VECTOR(1 downto 0);
           Result  : out STD_LOGIC_VECTOR(3 downto 0));
           
end ALU;

architecture Structural of ALU is

    signal Shift_Result           : STD_LOGIC_VECTOR(1 downto 0);
    signal Rotate_Result          : STD_LOGIC_VECTOR(1 downto 0);
    signal Extended_Shift_Result  : STD_LOGIC_VECTOR(3 downto 0);
    signal Extended_Rotate_Result : STD_LOGIC_VECTOR(3 downto 0);
    
    component ShiftLR
    
        Port ( a       : in  STD_LOGIC_VECTOR(1 downto 0);
               LR_in   : in  STD_LOGIC;
               Control : in  STD_LOGIC;
               Result  : out STD_LOGIC_VECTOR(1 downto 0));
               
    end component;

    component RotateLR
    
        Port ( a       : in  STD_LOGIC_VECTOR(1 downto 0);
               LR_in   : in  STD_LOGIC;
               Control : in  STD_LOGIC;
               Result  : out STD_LOGIC_VECTOR(1 downto 0));
               
    end component;

    component Mux_2to1
    
        Port ( a      : in  STD_LOGIC_VECTOR(3 downto 0);
               b      : in  STD_LOGIC_VECTOR(3 downto 0);
               Sel    : in  STD_LOGIC;
               Result : out STD_LOGIC_VECTOR(3 downto 0));
               
    end component;

begin
    Extended_Shift_Result  <= a(3 downto 2) & Shift_Result;
    Extended_Rotate_Result <= a(3 downto 2) & Rotate_Result;
    
    Shift_Left_Right  : ShiftLR  port map (a => a(1 downto 0), LR_in => '0',Control => Control(0), Result => Shift_Result);
    Rotate_Left_Right : RotateLR port map (a => a(1 downto 0), LR_in => '0',Control => Control(0), Result => Rotate_Result);
    Rot_Shft_Sel      : Mux_2to1 port map (a => Extended_Shift_Result, b => Extended_Rotate_Result, Sel => Control(1), Result => Result);    
    
end Structural;
