library IEEE;
use IEEE.STD_LOGIC_1164.ALL, ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VComponents.all;
entity user_logic is
 port (
          run,reset,ck : in  std_logic;
bus2mem_en, bus2mem_we : in  std_logic;
  bus2mem_addr, a0, a1 : in  std_logic_vector(6 downto 0);
    bus2mem_data_in, n : in  std_logic_vector(31 downto 0);
      mem2bus_data_out : out std_logic_vector(31 downto 0);
                  done : out std_logic);
end user_logic;
architecture Behavioral of user_logic is
COMPONENT blk_mem_gen_0
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
COMPONENT bus_ip_mem_bridge
generic (A: natural := 10);
port(
ip2mem_data_in,bus2mem_data_in : in  std_logic_vector(31 downto 0);
     ip2mem_addr,bus2mem_addr  : in  std_logic_vector(A-1 downto 0);
          bus2mem_we,ip2mem_we : in  std_logic_vector(0  downto 0);
                    bus2mem_en : in  std_logic;
                         addra : out std_logic_vector(A-1 downto 0);
                          dina : out std_logic_vector(31 downto 0);
                           wea : out std_logic_vector(0 downto 0);
                          busy : out std_logic
);
END COMPONENT;
-- bram signals 
signal wea, we : STD_LOGIC_VECTOR(0 DOWNTO 0);-- wea is bram port
signal addra   : STD_LOGIC_VECTOR(6 DOWNTO 0);-- we is ip signal 
signal dina    : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal douta   : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal temp_we   : STD_LOGIC_VECTOR(0 DOWNTO 0);
-- IP registers
signal mem_addr: std_logic_vector(6 downto 0);
signal mem_data_in,mem_data_out,temp1: std_logic_vector(31 downto 0);
signal busy,done_FF: std_logic;
type state is (idle,fetch,fetch2,fetch3, swap1,swap2,chill);
--simulation needs fetch3, implementation Hardware no fetch3  
signal n_s: state;
signal temp_a0, temp_a1: std_logic_vector(6 downto 0);
begin
temp_we(0) <= bus2mem_we; -- bus2mem_we to std_logic_vector
-- bridge multiplexes inputs (data, address and controls)
-- from bus or ip to bram
-- bram data out goes to ip and mem2bus_data_out ports,
-- bridge doesn't handle bram douta
-- Bus has priority over ip at which busy flag is high.
U1: bus_ip_mem_bridge
generic map(7)
port map(
bus2mem_addr => bus2mem_addr,
bus2mem_data_in => bus2mem_data_in,
ip2mem_addr => mem_addr, 
ip2mem_data_in => mem_data_in,
bus2mem_we => temp_we,
ip2mem_we => we,
bus2mem_en => bus2mem_en,
addra => addra,  -- outputs to mem
dina => dina,
wea => wea,
busy => busy);  -- output to user hardware
-- memory
mem : blk_mem_gen_0
  PORT MAP (
    clka => ck,
    wea => wea,    -- inputs come
    addra => addra,-- from bridge
    dina => dina,
    douta => douta
  );
-- memory data out register
process(ck)
begin
if ck='1' and ck'event then
  if reset = '1' then 
    mem_data_out <= (others => '0'); 
  else
    mem_data_out <= douta;
  end if; 
end if;
end process;
-- wire to output ports
mem2bus_data_out <= mem_data_out; done <= done_FF;
-- swap hardware
process(ck)
variable count : integer;
begin   
if ck='1' and ck'event then    
  if reset='1' then n_s <= idle;
  else           --                State Diagram
  case n_s is    --            run   
    when chill =>--reset~>(idle)-->(fetches)->(swap1)->(swap2)->(chill)
       null;
    when idle =>
     we <= "0"; done_FF <= '0';
     temp1 <= (others => '0'); count := 0;
     mem_addr <= (others => '0'); mem_data_in <= (others => '0');
     temp_a0 <= a0; temp_a1 <= a1;
     
     if run='1' and busy='0' then n_s <= fetch;
     --else  count <= (others => '0'); 
     end if;
     
    when fetch =>
     -- inititate loading address 0
     mem_addr <= temp_a0;
     we <= "0"; -- enable read next state
     n_s <= fetch2;
     
    when fetch2 => -- address updated
     mem_addr <= temp_a1;
     we <= "0"; -- read
     n_s <= fetch3;
     
    when fetch3 => -- douta not valid latency 1
     we <= "1"; -- write when leaving next state
     n_s <= swap1;
     
    -- swap write to Addr 1
    when swap1 =>  -- dout valid addr a0
     mem_data_in <= douta;
     we <= "1"; -- write when leaving in next state
     n_s <= swap2;
     
    when swap2 =>--Store: assign address,write to memory
     mem_addr <= temp_a0;
     mem_data_in <= douta; -- addr a1 valid
     we <= "1"; -- assert write
     temp_a0 <= temp_a0 + 1; temp_a1 <= temp_a1 + 1; 
     count := count + 1;
     if count < n then n_s <= swap1;
     else 
       done_FF <= '1';
       n_s <= chill; -- chill state is uptop
     end if;
   end case;
   end if;
end if;
end process;
end Behavioral;
