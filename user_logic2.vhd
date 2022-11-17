library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
library UNISIM;
use UNISIM.VComponents.all;

entity user_logic2 is
 PORT (
    ck : IN STD_LOGIC;
    resetn : IN STD_LOGIC;
    i_tvalid : IN STD_LOGIC;
    theta : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    yx_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    o_tvalid : OUT STD_LOGIC;
    yx_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
end user_logic2;
