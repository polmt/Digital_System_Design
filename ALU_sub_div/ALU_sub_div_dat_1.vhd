--   a) Dataflow architecture without using
--      selected statements or 'resize'    

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

     a_signed <= SIGNED ('0' & a(2) & a);
     b_signed <= SIGNED ('0' & b(2) & b);
   
--   Perform 'a-b' subtraction
     Sub_ab <= a_signed - b_signed;

--   Perform 'b/2' division by shifting right 1 position
     Div_b <= shift_right (b_signed, 1);
   
--   When Control is '0' the ALU does 'a-b',
--   when Control is '1' the ALU does 'b/2'.
--   The selection between the 2 operations
--   can be selected the same way a 2 to 1 multiplexer
--   selects which input to output, depending
--   on the Select signal.
  
--   The output of the 2 to 1 multiplexer is
--   Y = ( D0 and (not S) ) or (D1 and  S)

     Result_signed(0) <= ( Sub_ab(0) and (not Control) ) or ( Div_b(0) and Control );
     Result_signed(1) <= ( Sub_ab(1) and (not Control) ) or ( Div_b(1) and Control );
     Result_signed(2) <= ( Sub_ab(2) and (not Control) ) or ( Div_b(2) and Control );
     Result_signed(3) <= ( Sub_ab(3) and (not Control) ) or ( Div_b(3) and Control );
     Result_signed(4) <= ( Sub_ab(4) and (not Control) ) or ( Div_b(4) and Control );
   
--   Making the Result a 3bit vector
     Result <= STD_LOGIC_VECTOR (Result_signed (2 downto 0));
   
--   Overflow is determined by XOR'ing the 4th and 3rd bits
--   of the signed Result.
     OVF <= Result_signed(3) xor Result_signed(2);
   
--   Carry is determined by the 5th bit.
     Carry <= Result_signed(4);

end Dataflow;
