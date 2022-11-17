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
 
 architecture Behavioral of user_logic2 is
COMPONENT cordic_0
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_cartesian_tvalid : IN STD_LOGIC;
    s_axis_cartesian_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_phase_tvalid : IN STD_LOGIC;
    s_axis_phase_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
begin
U : cordic_0
  PORT MAP (
    aclk => ck,
    s_axis_cartesian_tvalid => i_tvalid,
    s_axis_cartesian_tdata => yx_in,
    s_axis_phase_tvalid => i_tvalid,
    s_axis_phase_tdata => theta,
    m_axis_dout_tvalid => o_tvalid,
    m_axis_dout_tdata => yx_out
  );
 
end Behavioral;
