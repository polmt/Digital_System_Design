--      e) Behavioral architecture using only if/elseif/else,                   
--         only variables and parameterize a, b using generic
--         to recieve various bit length values

library IEEE;                                          
use IEEE.STD_LOGIC_1164.ALL;                           
use IEEE.NUMERIC_STD.ALL;                              
use IEEE.STD_LOGIC_SIGNED.ALL;                                                         
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is

--   Inserting generic to parameterize signals
--   Default value of signal width: 2 
     generic (WIDTH : positive := 2);
                                            
     Port ( a : in STD_LOGIC_VECTOR (WIDTH downto 0);      
            b : in STD_LOGIC_VECTOR (WIDTH downto 0);      
            Control : in STD_LOGIC;                    
            Result : out STD_LOGIC_VECTOR (WIDTH downto 0);
            OVF : out STD_LOGIC;                       
            Carry: out STD_LOGIC );                    
end ALU;   
                                            
architecture Behavioral of ALU is

begin                                                             
                                                                  
     multiplexer : process (a, b, Control) is                     
                                                                  
     variable a_signed : SIGNED (WIDTH+2 downto 0);                     
     variable b_signed : SIGNED (WIDTH+2 downto 0);                     
     variable Result_signed : SIGNED (WIDTH+2 downto 0);                
     variable Sub_ab : SIGNED (WIDTH+2 downto 0);                       
     variable Div_b : SIGNED (WIDTH+2 downto 0);                        
                                                                  
     begin                                                        
                                                                  
          a_signed := resize (signed(a), WIDTH+3);                      
          b_signed := resize (signed(b), WIDTH+3);                      
                                                                  
          Sub_ab := a_signed - b_signed;                          
          Div_b := shift_right (b_signed, 1);                     
                                                                  
          if Control = '0' then                                   
               Result_signed := Sub_ab;                           
          else                                                    
               Result_signed := Div_b;                            
          end if;                                                 
                                                                  
          Result <= STD_LOGIC_VECTOR (Result_signed (WIDTH downto 0));
          OVF <= Result_signed(WIDTH+1) xor Result_signed(WIDTH);           
          Carry <= Result_signed(WIDTH+2);                              
                                                                  
     end process multiplexer;                                     
                                                                  
end Behavioral;
