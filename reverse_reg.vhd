library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity reverse_reg is
generic(  N: natural := 3;
          M: natural := 4;
saddr_width: natural := 4);
port(     x : in  std_logic_vector(N-1 downto 0);
          z : out std_logic_vector(N-1 downto 0);
slv_reg_addr: in  std_logic_vector(saddr_width-1 downto 0);
  ck, wren, resetN : in std_logic);
end reverse_reg;
architecture Behavioral of reverse_reg is
constant addr_0 : 
std_logic_vector(saddr_width - 1 downto 0) := 
                                (others => '0');
constant addr_1 : 
std_logic_vector(saddr_width - 1 downto 0) := 
                      (2 => '1', others => '0');
constant addr_3 : 
std_logic_vector(saddr_width - 1 downto 0) := 
                      (3 => '1', 2 => '1', others => '0');
type v_array is array(natural range <>) of 
                 std_logic_vector(N-1 downto 0);
signal temp : v_array(M-1 downto 0);
begin
process(ck)
begin
if ck='1' and ck'event then
  if resetN = '0' then -- active-low reset
    for i in 0 to M-1 loop
      temp(i) <= (others => '0');
    end loop;
  else
    if wren = '1' and slv_reg_addr = addr_0 then
    temp <= x&temp(M-1 downto 1);
    elsif wren = '1' and slv_reg_addr = addr_1 then
    temp <= temp(0)&temp(M-1 downto 1);
    elsif wren = '1' and slv_reg_addr = addr_3 then
    for i in 0 to M-1 loop
    temp(i) <= temp(M-1 - i);
    end loop;
    end if;
  end if;
end if;
end process;
z <= temp(0);
end Behavioral;
