library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package array_pkg is
  constant N : integer := 15;
  constant M : integer := 31;

  subtype wordN is std_logic_vector (M downto 0);
  type strng is array (N downto 0) of wordN;

end array_pkg;
  
