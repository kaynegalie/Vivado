library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
library UNISIM;
use UNISIM.VComponents.all;
----------------
-- x = q*y + r
----------------
entity user_logic is
PORT (
    ck: IN STD_LOGIC;
    in_tvalid : IN STD_LOGIC;
    x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    y : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    out_tvalid : OUT STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    r : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
end user_logic;
 
architecture Behavioral of user_logic is
COMPONENT div_gen_0
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_divisor_tvalid : IN STD_LOGIC;
    s_axis_divisor_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_dividend_tvalid : IN STD_LOGIC;
    s_axis_dividend_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
  );
END COMPONENT;
signal temp : std_logic_vector(63 downto 0);
begin
U : div_gen_0
  PORT MAP (
    aclk => ck,
    s_axis_divisor_tvalid => in_tvalid,
    s_axis_divisor_tdata => y,
    s_axis_dividend_tvalid => in_tvalid,
    s_axis_dividend_tdata => x,
    m_axis_dout_tvalid => out_tvalid,
    m_axis_dout_tdata => temp
  );
q <= temp(63 downto 32);
r <= temp(31 downto 0);
 
end Behavioral;
