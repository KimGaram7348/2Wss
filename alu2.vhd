library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_bit.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.math_real.all;

entity alu2 is
  port(
    clk    : in  std_logic;
    opnd3  : in  std_logic_vector(31 downto 0);
    opnd4  : in  std_logic_vector(31 downto 0);
    opc2   : in  std_logic_vector(2 downto 0);
    addr2  : out std_logic_vector(3 downto 0);
    r_wrb2 : out std_logic;
    out2   : out std_logic_vector(31 downto 0)
    );
end entity;


architecture rtl of alu2 is

begin
  
  process(opc2, clk)
    
    variable temp       : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
    variable addr2_temp : std_logic_vector(3 downto 0)  := "0000";
  begin
    if rising_edge(clk) then
      case opc2 is
        when "000"  => temp := opnd3 + opnd4;
        when "001"  => temp := opnd3 - opnd4;
        when "010"  => temp := opnd3 * opnd4;
--        when "011"  => temp := opnd3 / opnd4;
        when "100"  => temp := opnd3 and opnd4;
        when "101"  => temp := opnd3 or opnd4;
        when "110"  => temp := opnd3 nand opnd4;
        when "111"  => temp := opnd3 xor opnd4;
        when others => temp := "00000000000000000000000000000000";
      end case;

      addr2_temp := addr2_temp+1;

    else
      temp := temp;
    end if;

    addr2  <= addr2_temp;
    out2   <= temp;
    r_wrb2 <= '0';

  end process;
end rtl;
