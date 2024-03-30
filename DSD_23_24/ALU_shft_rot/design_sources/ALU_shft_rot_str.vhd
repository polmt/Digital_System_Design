---------------------------------
------- iii) Structural ---------
---------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ShiftLR_4bit is
    
    Port ( a       : in  STD_LOGIC_VECTor(3 downto 0);
           Control : in  STD_LOGIC;
           Result  : out STD_LOGIC_VECTor(3 downto 0));
               
end entity;

architecture Behavioral of ShiftLR_4bit is

begin

    process(a, Control)
    
        variable Result_temp : STD_LOGIC_VECTor(3 downto 0);
        
    begin

        Result_temp := (others => '0');

        case Control is
        
            -- sll
            when '0' =>
                Result_temp := a(2 downto 0) & "0";

            -- srl
            when '1' =>
                Result_temp := "0" & a(3 downto 1);
            
            when others =>
                Result_temp := (others => '0');
                
            end case;

        Result <= Result_temp;
        
    end process;
    
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RotateLR_4bit is
    
    Port ( a       : in  STD_LOGIC_VECTor(3 downto 0);
           Control : in  STD_LOGIC;
           Result  : out STD_LOGIC_VECTor(3 downto 0));
               
end entity;

architecture Behavioral of RotateLR_4bit is

begin

    process(a, Control)
    
        variable Result_temp : STD_LOGIC_VECTor(3 downto 0);
        
    begin

        Result_temp := (others => '0');

        case Control is
        
            -- rol
            when '0' =>
                Result_temp := a(2 downto 0) & a(3);

            -- ror
            when '1' =>
                Result_temp := a(0) & a(3 downto 1);

            when others =>
                Result_temp := (others => '0');
                               
        end case;

        Result <= Result_temp;
        
    end process;
    
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mux_2to1 is

    Port ( a      : in  STD_LOGIC_VECTor(3 downto 0);
           b      : in  STD_LOGIC_VECTor(3 downto 0);
           Sel    : in  STD_LOGIC;
           Result : out STD_LOGIC_VECTor(3 downto 0));

end Mux_2to1;

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
  
    Port ( a       : in  STD_LOGIC_VECTor(3 downto 0);
           Control : in  STD_LOGIC_VECTor(1 downto 0);
           Result  : out STD_LOGIC_VECTor(3 downto 0));
           
end ALU;

architecture Structural of ALU is

    signal Shift_Result  : STD_LOGIC_VECTor(3 downto 0);
    signal Rotate_Result : STD_LOGIC_VECTor(3 downto 0);
    
    component ShiftLR_4bit
    
        Port ( a       : in  STD_LOGIC_VECTor(3 downto 0);
               Control : in  STD_LOGIC;
               Result  : out STD_LOGIC_VECTor(3 downto 0));
               
    end component;

    component RotateLR_4bit
    
        Port ( a       : in  STD_LOGIC_VECTor(3 downto 0);
               Control : in  STD_LOGIC;
               Result  : out STD_LOGIC_VECTor(3 downto 0));
               
    end component;
    
    component Mux_2to1
    
        Port ( a      : in  STD_LOGIC_VECTor(3 downto 0);
               b      : in  STD_LOGIC_VECTor(3 downto 0);
               Sel    : in  STD_LOGIC;
               Result : out STD_LOGIC_VECTor(3 downto 0));
               
    end component;

begin

    Shift_Left_Right  : ShiftLR_4bit  port map (a => a,
                                                Control => Control(0),
                                                Result => Shift_Result);
    Rotate_Left_Right : RotateLR_4bit port map (a => a,
                                                Control => Control(0),
                                                Result => Rotate_Result);
    Rot_Shift_Sel     : Mux_2to1      port map (a => Shift_Result,
                                                b => Rotate_Result,
                                                Sel => Control(1),
                                                Result => Result);
    
end Structural;
