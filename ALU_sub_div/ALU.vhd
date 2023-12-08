--   a) Dataflow architecture without using
--      selected statements or 'resize'    

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_SIGNED.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity ALU is
--     Port ( a : in STD_LOGIC_VECTOR (2 downto 0);
--            b : in STD_LOGIC_VECTOR (2 downto 0);
--            Control : in STD_LOGIC;
--            Result : out STD_LOGIC_VECTOR (2 downto 0);
--            OVF : out STD_LOGIC;
--            Carry: out STD_LOGIC );             
--end ALU;

--architecture Dataflow of ALU is

--     signal a_signed : SIGNED (4 downto 0);
--     signal b_signed : SIGNED (4 downto 0);
--     signal Result_signed : SIGNED (4 downto 0);
--     signal Sub_ab : SIGNED (4 downto 0);
--     signal Div_b : SIGNED (4 downto 0);

--begin

--     a_signed <= SIGNED ('0' & a(2) & a);
--     b_signed <= SIGNED ('0' & b(2) & b);
   
----   Perform 'a-b' subtraction
--     Sub_ab <= a_signed - b_signed;

----   Perform 'b/2' division by shifting right 1 position
--     Div_b <= shift_right (b_signed, 1);
   
----   When Control is '0' the ALU does 'a-b',
----   when Control is '1' the ALU does 'b/2'.
----   The selection between the 2 operations
----   can be selected the same way a 2 to 1 multiplexer
----   selects which input to output, depending
----   on the Select signal.
  
----   The output of the 2 to 1 multiplexer is
----   Y = ( D0 and (not S) ) or (D1 and  S)
--     Result_signed(0) <= ( Sub_ab(0) and (not Control) ) or ( Div_b(0) and Control );
--     Result_signed(1) <= ( Sub_ab(1) and (not Control) ) or ( Div_b(1) and Control );
--     Result_signed(2) <= ( Sub_ab(2) and (not Control) ) or ( Div_b(2) and Control );
--     Result_signed(3) <= ( Sub_ab(3) and (not Control) ) or ( Div_b(3) and Control );
--     Result_signed(4) <= ( Sub_ab(4) and (not Control) ) or ( Div_b(4) and Control );
   
----   Making the Result a 3bit vector
--     Result <= STD_LOGIC_VECTOR (Result_signed (2 downto 0));
   
----   Overflow is determined by XOR'ing the 4th and 3rd bits
----   of the signed Result.
--     OVF <= Result_signed(3) xor Result_signed(2);
   
----   Carry is determined by the 5th bit.
--     Carry <= Result_signed(4);

--end Dataflow;


--     b) Dataflow architecture using
--        selected statements and 'resize'

--library IEEE;                                          
--use IEEE.STD_LOGIC_1164.ALL;                           
--use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_SIGNED.ALL;                                
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--                                                       
--entity ALU is                                          
--     Port ( a : in STD_LOGIC_VECTOR (2 downto 0);      
--            b : in STD_LOGIC_VECTOR (2 downto 0);      
--            Control : in STD_LOGIC;                    
--            Result : out STD_LOGIC_VECTOR (2 downto 0);
--            OVF : out STD_LOGIC;                       
--            Carry: out STD_LOGIC );                    
--end ALU;                                               
--
--architecture Dataflow of ALU is                  
--                                                 
--     signal a_signed : SIGNED (4 downto 0);      
--     signal b_signed : SIGNED (4 downto 0);      
--     signal Result_signed : SIGNED (4 downto 0); 
--     signal Sub_ab : SIGNED (4 downto 0);        
--     signal Div_b : SIGNED (4 downto 0);                   
--
--     begin
--     
----   Resize a and b to 5 bit signed numbers  
--     a_signed <= resize (signed(a), 5);
--     b_signed <= resize (signed(b), 5);
--     
--     Sub_ab <= a_signed - b_signed;
--     Div_b <= shift_right (b_signed, 1);
--     
----   Selecting which operation will be performed
----   based on the value of Control (like a multiplexer)
--     with Control select
--     Result_signed <= Sub_ab when '0',
--                      Div_b when '1',
--                      "00000" when others;
--                           
--     Result <= STD_LOGIC_VECTOR (Result_signed (2 downto 0));
--     OVF <= Result_signed(3) xor Result_signed(2);
--     Carry <= Result_signed(4);
--     
--end Dataflow;


--     c) Behavioral architecture using only
--        if/elseif/else and only variables

--library IEEE;                                          
--use IEEE.STD_LOGIC_1164.ALL;                           
--use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_SIGNED.ALL;                                
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--                                                       
--entity ALU is                                          
--     Port ( a : in STD_LOGIC_VECTOR (2 downto 0);      
--            b : in STD_LOGIC_VECTOR (2 downto 0);      
--            Control : in STD_LOGIC;                    
--            Result : out STD_LOGIC_VECTOR (2 downto 0);
--            OVF : out STD_LOGIC;                       
--            Carry: out STD_LOGIC );                    
--end ALU;    
--                                           
--architecture Behavioral of ALU is
--
--begin
--
--     multiplexer : process (a, b, Control) is
--     
--     variable a_signed : SIGNED (4 downto 0);     
--     variable b_signed : SIGNED (4 downto 0);     
--     variable Result_signed : SIGNED (4 downto 0);
--     variable Sub_ab : SIGNED (4 downto 0);       
--     variable Div_b : SIGNED (4 downto 0);                 
--     
--     begin
--     
--          a_signed := resize (signed(a), 5);         
--          b_signed := resize (signed(b), 5);
--          
--          Sub_ab := a_signed - b_signed;     
--          Div_b := shift_right (b_signed, 1);
--          
--          if Control = '0' then
--               Result_signed := Sub_ab;
--          else
--               Result_signed := Div_b;
--          end if;
--          
--          Result <= STD_LOGIC_VECTOR (Result_signed (2 downto 0));   
--          OVF <= Result_signed(3) xor Result_signed(2);           
--          Carry <= Result_signed(4);
--          
--     end process multiplexer;
--     
--end Behavioral;         


--     d) Behavioral architecture using only                      
--        case and only internal signals

--library IEEE;                                          
--use IEEE.STD_LOGIC_1164.ALL;                           
--use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_SIGNED.ALL;  
--use IEEE.STD_LOGIC_UNSIGNED.ALL;                           
--                                                       
--entity ALU is                                          
--     Port ( a : in STD_LOGIC_VECTOR (2 downto 0);      
--            b : in STD_LOGIC_VECTOR (2 downto 0);      
--            Control : in STD_LOGIC;                    
--            Result : out STD_LOGIC_VECTOR (2 downto 0);
--            OVF : out STD_LOGIC;                       
--            Carry: out STD_LOGIC );                    
--end ALU;   
--
--architecture Behavioral of ALU is
--
--     signal a_signed : SIGNED (4 downto 0);     
--     signal b_signed : SIGNED (4 downto 0);          
--     signal Result_signed : SIGNED (4 downto 0);     
--     signal Sub_ab : SIGNED (4 downto 0);            
--     signal Div_b : SIGNED (4 downto 0);
--     
--begin
--     
--     multiplexer : process (a, b, Control) is
--     
--     begin
--     
--     a_signed <= resize (signed(a), 5);
--     b_signed <= resize (signed(b), 5);
--     
--     Sub_ab <= a_signed - b_signed;     
--     Div_b <= shift_right (b_signed, 1);
--     
--     case Control is
--          when '0' => Result_signed <= Sub_ab;
--          when others => Result_signed <= Div_b;
--     end case;
--     
--     Result <= STD_LOGIC_VECTOR (Result_signed (2 downto 0)); 
--     OVF <= Result_signed(3) xor Result_signed(2);            
--     Carry <= Result_signed(4);    
--     
--     end process multiplexer;
--     
--end Behavioral;      


--      e) Behavioral architecture using only if/elseif/else,                   
--         only variables and parameterize a, b using generic
--         to recieve various bit length values

--library IEEE;                                          
--use IEEE.STD_LOGIC_1164.ALL;                           
--use IEEE.NUMERIC_STD.ALL;                              
--use IEEE.STD_LOGIC_SIGNED.ALL;                                                         
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
--entity ALU is
--
----   Inserting generic to parameterize signals
----   Default value of signal width: 2 
--     generic (WIDTH : positive := 2);
--                                            
--     Port ( a : in STD_LOGIC_VECTOR (WIDTH downto 0);      
--            b : in STD_LOGIC_VECTOR (WIDTH downto 0);      
--            Control : in STD_LOGIC;                    
--            Result : out STD_LOGIC_VECTOR (WIDTH downto 0);
--            OVF : out STD_LOGIC;                       
--            Carry: out STD_LOGIC );                    
--end ALU;   
--                                            
--architecture Behavioral of ALU is
--
--begin                                                             
--                                                                  
--     multiplexer : process (a, b, Control) is                     
--                                                                  
--     variable a_signed : SIGNED (WIDTH+2 downto 0);                     
--     variable b_signed : SIGNED (WIDTH+2 downto 0);                     
--     variable Result_signed : SIGNED (WIDTH+2 downto 0);                
--     variable Sub_ab : SIGNED (WIDTH+2 downto 0);                       
--     variable Div_b : SIGNED (WIDTH+2 downto 0);                        
--                                                                  
--     begin                                                        
--                                                                  
--          a_signed := resize (signed(a), WIDTH+3);                      
--          b_signed := resize (signed(b), WIDTH+3);                      
--                                                                  
--          Sub_ab := a_signed - b_signed;                          
--          Div_b := shift_right (b_signed, 1);                     
--                                                                  
--          if Control = '0' then                                   
--               Result_signed := Sub_ab;                           
--          else                                                    
--               Result_signed := Div_b;                            
--          end if;                                                 
--                                                                  
--          Result <= STD_LOGIC_VECTOR (Result_signed (WIDTH downto 0));
--          OVF <= Result_signed(WIDTH+1) xor Result_signed(WIDTH);           
--          Carry <= Result_signed(WIDTH+2);                              
--                                                                  
--     end process multiplexer;                                     
--                                                                  
--end Behavioral;    


--     f) Structural architecture using generic
--        with Sub_ab and Div_b components

library IEEE;               
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;  
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is                                                 
     generic (WIDTH : positive := 2);  
     Port ( a : in STD_LOGIC_VECTOR (WIDTH downto 0);
            b : in STD_LOGIC_VECTOR (WIDTH downto 0);
            Control : in STD_LOGIC;
            Result : out STD_LOGIC_VECTOR (WIDTH downto 0);
            OVF : out STD_LOGIC;
	        Carry: out STD_LOGIC );
end ALU;

library IEEE;               
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;  
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sub_ab is     
     generic (WIDTH : positive := 2);     
     Port ( a : in STD_LOGIC_VECTOR (WIDTH downto 0);
            b : in STD_LOGIC_VECTOR (WIDTH downto 0);
            Result : out STD_LOGIC_VECTOR (WIDTH downto 0);
            OVF : out STD_LOGIC;
	        Carry: out STD_LOGIC );                
end Sub_ab;

architecture Behavioral of Sub_ab is
begin     
     subtraction : process (a, b)
     variable a_signed : SIGNED (WIDTH+2 downto 0);
     variable b_signed : SIGNED (WIDTH+2 downto 0);     
     variable Result_signed : SIGNED (WIDTH+2 downto 0);
     variable Sub_ab : SIGNED (WIDTH+2 downto 0);
     
     begin
          a_signed := resize (signed(a), WIDTH+3);
          b_signed := resize (signed(b), WIDTH+3);
               
          Sub_ab := a_signed - b_signed;
          Result_signed := Sub_ab;         
          
          Result <= STD_LOGIC_VECTOR (Result_signed (WIDTH downto 0));     
          OVF <= Result_signed(WIDTH+1) xor Result_signed(WIDTH);          
          Carry <= Result_signed(WIDTH+2);
                                                     
     end process subtraction;     
end Behavioral;

library IEEE;                                                     
use IEEE.STD_LOGIC_1164.ALL;                                      
use IEEE.NUMERIC_STD.ALL;                                         
use IEEE.STD_LOGIC_SIGNED.ALL;                                    
use IEEE.STD_LOGIC_UNSIGNED.ALL;                                  
                                                                  
entity Div_b is                                                                                                                     
     generic (WIDTH : positive := 2);                                                                                          
     Port ( b : in STD_LOGIC_VECTOR (WIDTH downto 0);        
            Result : out STD_LOGIC_VECTOR (WIDTH downto 0) );                                                                  
end Div_b;

architecture Behavioral of Div_b is
begin
     division : process (b)
     variable b_signed : SIGNED (WIDTH+2 downto 0);     
     variable Result_signed : SIGNED (WIDTH+2 downto 0);
     variable Div_b : SIGNED (WIDTH+2 downto 0);
     
     begin
          b_signed := resize (signed(b), WIDTH+3);
          
          Div_b := shift_right (b_signed, 1);          
          Result_signed := Div_b;
          
          Result <= STD_LOGIC_VECTOR (Result_signed (WIDTH downto 0));
          
     end process division;
end Behavioral;

architecture Structural of ALU is
     
     component Sub_ab     
          generic (WIDTH : positive := 2);    
          Port ( a : in STD_LOGIC_VECTOR (WIDTH downto 0);
                 b : in STD_LOGIC_VECTOR (WIDTH downto 0);
                 Result : out STD_LOGIC_VECTOR (WIDTH downto 0);
                 OVF : out STD_LOGIC;
     	         Carry: out STD_LOGIC );              
     end component;
     
     component Div_b     
          generic (WIDTH : positive := 2);    
          Port ( b : in STD_LOGIC_VECTOR (WIDTH downto 0);
                 Result : out STD_LOGIC_VECTOR (WIDTH downto 0) );                
     end component;

--   S1 and S2 are connected to Sub_ab and Div_b results and
--   driven to the inputs of a 2 to 1 multiplexer
     signal S1, S2 : STD_LOGIC_VECTOR (WIDTH downto 0);
--   S3 and S4 are the signals that connect the overflow and
--   carry of the Sub_ab components to multiplexers that 
--   select if they will be shown as outputs
     signal S3 : STD_LOGIC;
     signal S4 : STD_LOGIC;

begin
     
     D0 : Sub_ab generic map (WIDTH => WIDTH)                                 
     port map (a => a, b => b, Result => S1, OVF => S3, Carry => S4);
     D1 : Div_b generic map (WIDTH => WIDTH)                                  
     port map (b => b, Result => S2);                                    
     
     multiplexer : process (a, b, Control) is                                
                  
     begin

--        Selection of result Sub_ab or Div_b
          if Control = '0' then        
               Result <= S1;                       
          else                          
               Result <= S2;
          end if;
          
--        Choose whether the overflow is shown as an output or not
          if Control = '0' then
               OVF <= S3;
          else
               OVF <= '0';
          end if;

--        Choose whether the carry is shown as an output or not
          if Control = '0' then
               Carry <= S4;
          else
               Carry <= '0';
          end if;
 
     end process multiplexer;
                                                                                              
end Structural;
                                        