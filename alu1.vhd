library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_bit.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.math_real.all;

entity alu1 is
  port(
    clk    : in  std_logic;
    opnd1  : in  std_logic_vector(31 downto 0);
    opnd2  : in  std_logic_vector(31 downto 0);
    opc1   : in  std_logic_vector(2 downto 0);
    addr1  : out std_logic_vector(3 downto 0);
    r_wrb1 : out std_logic;
    out1   : out std_logic_vector(31 downto 0)
    );
end entity;


architecture rtl of alu1 is

begin
  
  process(opc1, clk)
    
    variable temp       : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
    variable addr1_temp : std_logic_vector(3 downto 0)  := "0001";
  begin
    if rising_edge(clk) then
      case opc1 is
        when "000"  => temp := opnd1 + opnd2;
        when "001"  => temp := opnd1 - opnd2;
        when "010"  => temp := opnd1 * opnd2;
--        when "011"  => temp := opnd1 / opnd2;
        when "100"  => temp := opnd1 and opnd2;
        when "101"  => temp := opnd1 or opnd2;
        when "110"  => temp := opnd1 nand opnd2;
        when "111"  => temp := opnd1 xor opnd2;
        when others => temp := "00000000000000000000000000000000";
      end case;

      addr1_temp := addr1_temp+2;

    else
      temp := temp;
    end if;

    addr1  <= addr1_temp;
    out1   <= temp;
    r_wrb1 <= '0';

  end process;
  
end rtl;
