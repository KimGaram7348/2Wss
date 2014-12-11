
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_bit.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.math_real.all;
use work.array_pkg1.all;

entity processor is
  port(
    clk        : in  std_logic;
    opnd1      : in  std_logic_vector(31 downto 0);
    opnd2      : in  std_logic_vector(31 downto 0);
    opc1       : in  std_logic_vector(2 downto 0);
    opnd3      : in  std_logic_vector(31 downto 0);
    opnd4      : in  std_logic_vector(31 downto 0);
    opc2       : in  std_logic_vector(2 downto 0);
    abus       : in  unsigned(3 downto 0);
    r_wrb_f    : in  std_logic;
    memory     : inout strng;	 
    data_out_f : out std_logic_vector(31 downto 0)
    );
end entity;
--------------------------------------------------------------------------------------

architecture rtl of processor is

-----------------------------
  component alu1
    port(
      clk    : in  std_logic;
      opnd1  : in  std_logic_vector(31 downto 0);
      opnd2  : in  std_logic_vector(31 downto 0);
      opc1   : in  std_logic_vector(2 downto 0);
      addr1  : out std_logic_vector(3 downto 0);
      r_wrb1 : out std_logic;
      out1   : out std_logic_vector(31 downto 0)
      );
  end component;
----------------------------

  component alu2
    port(
      clk    : in  std_logic;
      opnd3  : in  std_logic_vector(31 downto 0);
      opnd4  : in  std_logic_vector(31 downto 0);
      opc2   : in  std_logic_vector(2 downto 0);
      addr2  : out std_logic_vector(3 downto 0);
      r_wrb2 : out std_logic;
      out2   : out std_logic_vector(31 downto 0)
      );
  end component;
----------------------------

  component mem
    port(
      abus       : in    unsigned(3 downto 0);
      memory     : inout strng;
      addr1      : in    unsigned(3 downto 0);
      addr2      : in    unsigned(3 downto 0);
      R_WRB1     : in    std_logic;
      R_WRB2     : in    std_logic;
      data_in1   : in    std_logic_vector(31 downto 0);
      data_in2   : in    std_logic_vector(31 downto 0);
      --data_out1 : out   std_logic_vector(31 downto 0);  -- Read not required
      --data_out2 : out   std_logic_vector(31 downto 0);  -- for ALU
      r_wrb_f    : in    std_logic;
      data_out_f : out   std_logic_vector(31 downto 0)  -- for General Read only
      );
  end component;
---------------------------
  
  signal tmp_out1, tmp_out2     : std_logic_vector(31 downto 0);
  signal tmp_addr1, tmp_addr2   : std_logic_vector(3 downto 0);
  signal tmp_r_wrb1, tmp_r_wrb2 : std_logic;
  signal tmp_memory             : strng;

begin

    dev_alu1 : alu1 port map(
      clk    => clk,
      opnd1  => opnd1,
      opnd2  => opnd2,
      opc1   => opc1,
      addr1  => tmp_addr1,
      r_wrb1 => tmp_r_wrb1,
      out1   => tmp_out1
      );

    dev_alu2 : alu2 port map(
      clk    => clk,
      opnd3  => opnd3,
      opnd4  => opnd4,
      opc2   => opc2,
      addr2  => tmp_addr2,
      r_wrb2 => tmp_r_wrb2,
      out2   => tmp_out2
      );

    dev_mem : mem port map(
      tmp_memory => memory,
      abus       => abus,
      r_wrb_f    => r_wrb_f,
      data_out_f => data_out_f,
      tmp_out1   => data_in1,
      tmp_out2   => data_in2,
      tmp_addr1  => addr1,
      tmp_addr2  => addr2,
      tmp_r_wrb1 => r_wrb1,
      tmp_r_wrb2 => r_wrb2
      );

end rtl;


