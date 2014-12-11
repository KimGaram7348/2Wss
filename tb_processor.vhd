library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
use work.array_pkg.all;

entity tb_processor is
end tb_processor;

architecture behavior of tb_processor is

  component processor
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
      data_out_f : out std_logic_vector(31 downto 0)
      );
  end component;

  -- inputs
  signal clk     : std_logic                     := '0';
  signal opnd1   : std_logic_vector(31 downto 0) := (others => '0');
  signal opnd2   : std_logic_vector(31 downto 0) := (others => '0');
  signal opc1    : std_logic_vector(2 downto 0)  := (others => '0');
  signal opnd3   : std_logic_vector(31 downto 0) := (others => '0');
  signal opnd4   : std_logic_vector(31 downto 0) := (others => '0');
  signal opc2    : std_logic_vector(2 downto 0)  := (others => '0');
  signal abus    : unsigned(3 downto 0)          := (others => '0');
  signal r_wrb_f : std_logic                     := '0';

  -- outputs
  signal data_out_f : std_logic_vector(31 downto 0) := (others => '0');

  constant clk_period : time := 10 ns;
  
begin
  uut : processor port map(
    clk     => clk,
    opnd1   => opnd1,
    opnd2   => opnd2,
    opc1    => opc1,
    opnd3   => opnd3,
    opnd4   => opnd4,
    opc2    => opc2,
    abus    => abus,
    r_wrb_f => r_wrb_f
    );

  clk_process : process
  begin
    clk <= '0';
    wait for clk_period;
    clk <= '1';
    wait for clk_period;
  end process;

  stimulas_process : process
  begin

    wait for 30 ns;
    opnd1 <= "00000000101011101010100010101010";
    opnd2 <= "00000000101011101001100010101010";
    opc1  <= "001";
    opnd3 <= "00000000101011101010100011101010";
    opnd4 <= "00000000101011101010100010100010";
    opc2  <= "010";
    abus  <= "0001";

    wait for 30 ns;
    opnd1 <= "00000001101011101010100010101010";
    opnd2 <= "00000000110011101001100010101010";
    opc1  <= "011";
    opnd3 <= "00000100101011101010100011101010";
    opnd4 <= "00000010101011101010100010100010";
    opc2  <= "010";
    abus  <= "0003";

    wait for 30 ns;
    opnd1 <= "00000001101011101010100010101010";
    opnd2 <= "00000000001011101001100010101010";
    opc1  <= "100";
    opnd3 <= "00000010101011101010100011101010";
    opnd4 <= "00000001101011101010100010100010";
    opc2  <= "110";
    abus  <= "0004";

  end process;
  
end behavior;
