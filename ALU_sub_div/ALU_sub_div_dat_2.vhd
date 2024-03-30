--    b) Dataflow architecture using
--       selected statements and 'resize'

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

architecture Dataflow of ALU is                  
                                                 
     signal a_signed : SIGNED (4 downto 0);      
     signal b_signed : SIGNED (4 downto 0);      
     signal Result_signed : SIGNED (4 downto 0); 
     signal Sub_ab : SIGNED (4 downto 0);        
     signal Div_b : SIGNED (4 downto 0);                   

     begin
     
--   Resize a and b to 5 bit signed numbers  
     a_signed <= resize (signed(a), 5);
     b_signed <= resize (signed(b), 5);
     
     Sub_ab <= a_signed - b_signed;
     Div_b <= shift_right (b_signed, 1);
     
--   Selecting which operation will be performed
--   based on the value of Control (like a multiplexer)
     with Control select
     Result_signed <= Sub_ab when '0',
                      Div_b when '1',
                      "00000" when others;
                           
     Result <= STD_LOGIC_VECTOR (Result_signed (2 downto 0));
     OVF <= Result_signed(3) xor Result_signed(2);
     Carry <= Result_signed(4);
     
end Dataflow;
