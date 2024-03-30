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
