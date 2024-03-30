--  c) Behavioral architecture using only
--     if/elseif/else and only variables

library IEEE;                                          
use IEEE.STD_LOGIC_1164.ALL;                           
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;                                
use IEEE.STD_LOGIC_UNSIGNED.ALL;
                                                       
entity ALU is                                          
     Port ( a : in STD_LOGIC_VECTOR (2 downto 0);      
            b : in STD_LOGIC_VECTOR (2 downto 0);      
            Control : in STD_LOGIC;                    
            Result : out STD_LOGIC_VECTOR (2 downto 0);
            OVF : out STD_LOGIC;                       
            Carry: out STD_LOGIC );                    
end ALU;    
                                           
architecture Behavioral of ALU is

begin

     multiplexer : process (a, b, Control) is
     
     variable a_signed : SIGNED (4 downto 0);     
     variable b_signed : SIGNED (4 downto 0);     
     variable Result_signed : SIGNED (4 downto 0);
     variable Sub_ab : SIGNED (4 downto 0);       
     variable Div_b : SIGNED (4 downto 0);                 
     
     begin
     
          a_signed := resize (signed(a), 5);         
          b_signed := resize (signed(b), 5);
          
          Sub_ab := a_signed - b_signed;     
          Div_b := shift_right (b_signed, 1);
          
          if Control = '0' then
               Result_signed := Sub_ab;
          else
               Result_signed := Div_b;
          end if;
          
          Result <= STD_LOGIC_VECTOR (Result_signed (2 downto 0));   
          OVF <= Result_signed(3) xor Result_signed(2);           
          Carry <= Result_signed(4);
          
     end process multiplexer;
     
end Behavioral;
