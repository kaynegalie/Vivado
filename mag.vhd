library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL, IEEE.STD_LOGIC_signed.ALL;
entity user_logic is
    Port (a, b : in  signed(15 downto 0);
        ck, ce : in  std_logic;
             z : out signed(31 downto 0)
    );
end user_logic;
architecture Behavioral of user_logic is
signal temp : signed(31 downto 0);
begin
process(ck, ce)
begin
 if ck='1' and ck'event and ce='1' then
    temp <= a*a + b*b;
 end if;
end process;
z <= temp;
end Behavioral;
