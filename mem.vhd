library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_bit.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.math_real.all;
use work.array_pkg.all;

entity mem is
  generic (N : integer := 15; M : integer := 31);  --N+1 is number of words in
                                                   --the memory and M+1 is the
                                        --number of bits in each word
  port(
    abus       : in    unsigned(3 downto 0);
    memory     : inout strng;
    addr1      : in    unsigned(3 downto 0);
    addr2      : in    unsigned(3 downto 0);
    R_WRB1     : in    std_logic;
    R_WRB2     : in    std_logic;
    data_in1   : in    std_logic_vector(31 downto 0);
    data_in2   : in    std_logic_vector(31 downto 0);
    --data_out1 : out   std_logic_vector(31 downto 0);  --- Read not required             
    --data_out2 : out   std_logic_vector(31 downto 0);  --- for ALU
    r_wrb_f    : in    std_logic;
    data_out_f : out   std_logic_vector(31 downto 0)  --- for General Read only
    );
end mem;
--------------------------------------------------------------------------------

architecture SRAM of mem is
begin
-----------------------------------------------
  process (data_in1, R_WRB1)
  begin

    if(r_wrb1 = '0')then
      memory(conv_integer(addr1)) <= data_in1;
    --elsif(r_wrb1='1')then            -- no read for alu1
    --  data_out1 <= memory(conv_integer(addr1);
    end if;

  end process;


  process (DATA_IN2, R_WRB2)
  begin

    if(r_wrb2 = '0')then
      memory(conv_integer(addr2)) <= data_in2;
    --elsif(r_wrb2='1')then            -- no read for alu2   
    --  data_out2 <= memory(conv_integer(addr2);
    end if;

  end process;


  process(abus)
  begin

    if(r_wrb_f = '0')then data_out_f <= memory(conv_integer(abus));
    end if;

  end process;

end SRAM;
