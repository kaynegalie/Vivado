-------------------------------------------------
-- N-bit data M-stage shift register (right shift)
-- when slv_reg_wren (write enable) access to
-- slv_reg0 (addr is 0) shifts x (S_AXI_WDATA) into register
-- slv_reg1 (addr is 4) circular shifts resister
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sh_reg is
generic(  N: natural := 3;
          M: natural := 4;
saddr_width: natural := 4);
port(     x : in  std_logic_vector(N-1 downto 0);
          z : out std_logic_vector(N-1 downto 0);
slv_reg_addr: in  std_logic_vector(saddr_width-1 downto 0);
  ck, wren, resetN : in std_logic);
end sh_reg;

architecture Behavioral of sh_reg is
constant addr_0 : 
std_logic_vector(saddr_width - 1 downto 0) := 
                                (others => '0');
constant addr_1 : 
std_logic_vector(saddr_width - 1 downto 0) := 
                      (2 => '1', others => '0');
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
    end if;
  end if;
end if;
end process;
z <= temp(0);
end Behavioral;

	signal byte_index	: integer;
	signal aw_en	: std_logic;
component sh_reg
generic(  N: natural := 3;
          M: natural := 4;
saddr_width: natural := 4);
port(     x : in  std_logic_vector(N-1 downto 0);
          z : out std_logic_vector(N-1 downto 0);
slv_reg_addr: in  std_logic_vector(saddr_width-1 downto 0);
  ck, wren, resetN : in std_logic);
end component;
begin
U: sh_reg generic map
   (N => C_S_AXI_DATA_WIDTH,
    M => reg_depth)
port map
   (x => S_AXI_WDATA, slv_reg_addr => S_AXI_AWADDR,
    ck => S_AXI_ACLK,resetN => S_AXI_ARESETN, 
    wren => slv_reg_wren, z => slv_reg2);
    
process (S_AXI_ACLK)
	variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0); 
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      slv_reg0 <= (others => '0');
	      slv_reg1 <= (others => '0');
--	      slv_reg2 <= (others => '0');
slv_reg3 <= (others => '0');

when b"10" => null;
--	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
--	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
--	                -- Respective byte enables are asserted as per write strobes                   
--	                -- slave registor 2
--	                slv_reg2(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
--	              end if;
--	            end loop;
when b"11" =>
	
	          when others =>
	            slv_reg0 <= slv_reg0;
	            slv_reg1 <= slv_reg1;
--	            slv_reg2 <= slv_reg2;
	            slv_reg3 <= slv_reg3;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sh_reg_ip_v1_0_S_AXI is
	generic (
		-- Users to add parameters here
		reg_depth : natural := 4;
		
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sh_reg_ip_v1_0 is
	generic (
		-- Users to add parameters here
		reg_depth : natural := 4;
		
architecture arch_imp of sh_reg_ip_v1_0 is

	-- component declaration
	component sh_reg_ip_v1_0_S_AXI is
		generic (
		reg_depth : natural := 4;
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		S_AXI_ACLK	: in std_logic;
		
begin

-- Instantiation of Axi Bus Interface S_AXI
sh_reg_ip_v1_0_S_AXI_inst : sh_reg_ip_v1_0_S_AXI
	generic map (
	    reg_depth => reg_depth,
		C_S_AXI_DATA_WIDTH	=> C_S_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S_AXI_ADDR_WIDTH
	)
	port map (
		S_AXI_ACLK	=> s_axi_aclk,
		
-----------------------------
-- Block ram 
-----------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity user_logic is
PORT (
    ck : IN STD_LOGIC;
    we : IN STD_LOGIC;
    addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
end user_logic;

architecture Behavioral of user_logic is
COMPONENT blk_mem_gen_0
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
signal wren:  STD_LOGIC_VECTOR(0 DOWNTO 0);
begin
wren(0) <= we;
me : blk_mem_gen_0
  PORT MAP (
    clka => ck,
    wea => wren,
    addra => addr,
    dina => din,
    douta => dout
  );

end Behavioral;

	signal byte_index	: integer;
	signal aw_en	: std_logic;
	
constant addr_4 :
std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0) := 
(2 => '1', others => '0');
component  user_logic
PORT (
    ck : IN STD_LOGIC;
    we : IN STD_LOGIC;
    addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
end component;
signal we : std_logic;
begin

U: user_logic port map(
ck => S_AXI_ACLK,
we => we,
addr => slv_reg0(9 downto 0),
din => S_AXI_WDATA,
dout => slv_reg2);
-- BRAM write enable sync to slv_reg0 write
process(S_AXI_ACLK)
begin
if S_AXI_ACLK='1' and S_AXI_ACLK'event then
  if slv_reg_wren = '1' and axi_awaddr = addr_4 then
    we <= '1'; else we <='0';
  end if;
end if;
end process;

-------------------------------------------
-- Module Name:    bus_ip_mem_bridge - Behavioral 
-- Additional Comments: A bridge between bus or user ip to block ram memory
-- input signals are data and addresses from bus an ip to be muxed to mem
-- bus2mem_we,ip2mem_we are write enable from bus and mem
-- bus2mem_en is from bus controls the access to mem
-- output signals are to mem
-- busy signal is to ip indicating that bus is accessing memory
-------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity bus_ip_mem_bridge is
generic (A: natural := 10);
port(ip2mem_data_in,bus2mem_data_in : in  std_logic_vector(31 downto 0);
          ip2mem_addr,bus2mem_addr  : in  std_logic_vector(A-1 downto 0);
               bus2mem_we,ip2mem_we : in  std_logic_vector(0  downto 0);
                         bus2mem_en : in  std_logic;
	                          addra : out std_logic_vector(A-1 downto 0);
			                   dina : out std_logic_vector(31 downto 0);
					            wea : out std_logic_vector(0 downto 0);
			   			       busy : out std_logic);
end bus_ip_mem_bridge;

architecture Behavioral of bus_ip_mem_bridge is
begin
process(bus2mem_addr,bus2mem_data_in,
ip2mem_addr,ip2mem_data_in,bus2mem_we,ip2mem_we,
bus2mem_en)
begin
if bus2mem_en = '1' then 
    wea <= bus2mem_we;
    addra <= bus2mem_addr;
    dina <= bus2mem_data_in;
	 busy <= '1';
else
    wea <= ip2mem_we;
    addra <= ip2mem_addr;
    dina <= ip2mem_data_in;
	 busy <= '0';
end if;
end process;
end Behavioral;

--------------------------------------------------
-- accumulates 10 unsigned from bram starting
-- from address 0 and writes the sum to address 10
--------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
use UNISIM.VComponents.all;


entity user_logic is
generic (A : natural := 10);
port (
         run,reset,ck : in  std_logic;
bus2mem_en,bus2mem_we : in  std_logic;
         bus2mem_addr : in  std_logic_vector(A-1 downto 0);
      bus2mem_data_in : in  std_logic_vector(31 downto 0);
     mem2bus_data_out : out std_logic_vector(31 downto 0);
                 done : out std_logic);
end user_logic;

architecture Behavioral of user_logic is

COMPONENT blk_mem_gen_0
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
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
signal wea, we : STD_LOGIC_VECTOR(0 DOWNTO 0);  -- wea is bram port
signal addra   : STD_LOGIC_VECTOR(A-1 DOWNTO 0);-- we is ip signal 
signal dina    : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal douta   : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal temp_we   : STD_LOGIC_VECTOR(0 DOWNTO 0);
-- accumulator registers
signal mem_addr, count : std_logic_vector(A-1 downto 0);
signal mem_data_in,mem_data_out,temp1 : std_logic_vector(31 downto 0);
signal busy,done_FF: std_logic;
type state is (idle,fetch,fetch2,fetch3, add,store,chill);
--simulation needs fetch3, implementation Hardware no fetch3  
signal n_s: state;

begin
temp_we(0) <= bus2mem_we; -- bus2mem_we to std_logic_vector

-- bridge multiplexes inputs (data, address and controls)
-- from bus or ip to bram
-- bram data out goes to ip and mem2bus_data_out ports,
-- bridge doesn't handle bram douta
-- Bus has priority over ip at which busy flag is high.
U1: bus_ip_mem_bridge
generic map(A)
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
  if reset = '1' then mem_data_out <= (others => '0'); else
    mem_data_out <= douta;
end if; end if;
end process;
-- wire to output ports
mem2bus_data_out <= mem_data_out; done <= done_FF;

-- accumulator
process(ck)
variable num_add : integer;
begin                          --   State Diagram
if ck='1' and ck'event then    --      _______
  if reset='1' then n_s <= idle;else--|       |
  case n_s is     --            run   v       |
    when chill =>--reset~>(idle)-->(fetch)->(add)->(store)->(chill)
	   null;
    when idle =>
     we <= "0"; done_FF <= '0';
     temp1 <= (others => '0'); num_add := 0;
     mem_addr <= (others => '0'); mem_data_in <= (others => '0');

     if run='1' and busy='0' then n_s <= fetch;
     else  count <= (others => '0'); end if;
     
     
    when fetch =>
     -- inititate loading address 0
     mem_addr <= count; count <= count + 1;
     we <= "0"; -- enable read next state
     n_s <= fetch2;
    when fetch2 => -- address updated
	 mem_addr <= count; count <= count + 1;
     we <= "0"; -- read
     n_s <= fetch3;
     
    when fetch3 => -- douta not valid latency 1
	 mem_addr <= count; count <= count + 1;
     we <= "0"; -- read
     n_s <= add;
     
    when fetch2 => -- address updated
	 mem_addr <= count; count <= count + 1;
     we <= "0"; -- read
     n_s <= add;
     
--   when fetch3 => -- douta not valid latency 1
--	 mem_addr <= count; count <= count + 1;
--     we <= "0"; -- read
--     n_s <= add;
     
    -- accumulate state
    -- addr++ (pipelining dout)
    when add =>  -- dout valid
     we <= "0"; -- read
	 mem_addr <= count; count <= count + 1;
     temp1 <= temp1 + douta; num_add := num_add + 1;
     if num_add < 10 then n_s <= add;
     else n_s <= store;
     end if;
     
    when store =>--Store: assign address,write to memory
     mem_addr <= "0000001010"; -- addr = 10
     mem_data_in <= temp1;
     we <= "1"; -- write enable in next state
     done_FF <= '1';
     n_s <= chill; -- chill state is uptop
   end case;
   end if;
end if;
end process;
end Behavioral;

-----------------------------------------------------------
-- Project Name: multiply and accumulate fixed-point data
-----------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity user_logic is
  PORT (
  CK : IN STD_LOGIC;
  CE : IN STD_LOGIC;
  SCLR : IN STD_LOGIC;
  X_A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
  X_B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
  Z   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
end user_logic;

architecture Behavioral of user_logic is
COMPONENT xbip_multadd_0
  PORT (
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    SCLR : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    C : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    SUBTRACT : IN STD_LOGIC;
    P : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    PCOUT : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
END COMPONENT;
signal temp, W : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal subtract_low : std_logic;
begin
subtract_low <= '0';
Z <= temp;
U: xbip_multadd_0
  PORT MAP (
    CLK => CK,
    CE => CE,
    SCLR => SCLR,
    A => X_A,
    B => X_B,
    C => temp,
    SUBTRACT => SUBTRACT_LOW,
    P => W,
    PCOUT => open
  );
 -- temp register for latency 1
  process(ck, ce)
      begin
      if ck='1' and ck'event then
         if sclr = '1' then
         temp <= (others=> '0'); else
         temp <= W;
         end if;
      end if;
      end process;
end Behavioral;


-----------------
-- floating-point
-----------------
------------------------------------------
-- Multiply and accumulate
-- AXIS stream Float Multiply and add IP
-- and temp register
-- Flags to SW rdy and req (ready and request)
------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity user_logic is
port (a, b : in  std_logic_vector(31 downto 0);
         z : out std_logic_vector(31 downto 0);
        req: in  std_logic;
        rdy: out std_logic;
   ck, reset: in  std_logic
 );
end user_logic;

architecture Behavioral of user_logic is
COMPONENT floating_point_0
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_c_tvalid : IN STD_LOGIC;
    s_axis_c_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
signal in_tvalid, f_ma_tvalid : std_logic;
signal f_ma_data, temp : std_logic_vector(31 downto 0);
begin
me : floating_point_0
  PORT MAP (
    aclk => ck,
    s_axis_a_tvalid => in_tvalid,
    s_axis_a_tdata => a,
    s_axis_b_tvalid => in_tvalid,
    s_axis_b_tdata => b,
    s_axis_c_tvalid => in_tvalid,
    s_axis_c_tdata => temp,
    m_axis_result_tvalid => f_ma_tvalid,
    m_axis_result_tdata => f_ma_data
  );
process(ck)
type states is (
wait_on_req,
wait_on_req_low,
wait_on_f_ma_tvalid, 
wait_on_f_ma_tvalid_low);
variable n_s : states;
begin
if ck='1' and ck'event then
if reset = '1' then
   temp <= (others => '0');
   in_tvalid <= '0';
   rdy <= '1';
   n_s := wait_on_req;
else
 case n_s is
 -- ready for operands
 when wait_on_req =>
 -- req high lower rdy
 if req = '1' then
    in_tvalid <= '0';
    rdy <= '0';
    n_s := wait_on_req_low;
 else 
    in_tvalid <= '0';
    rdy <= '1';
 end if;
 
 when wait_on_req_low =>
 -- req low start float mult add
 if req = '0' then
    in_tvalid <= '1';
    rdy <= '0';
    n_s := wait_on_f_ma_tvalid;
 else 
    in_tvalid <= '0';
    rdy <= '0';
 end if;
 
 when wait_on_f_ma_tvalid =>
 in_tvalid <= '0';
 rdy <= '0';
 if f_ma_tvalid = '1' then
    n_s := wait_on_f_ma_tvalid_low;
 end if;
 
 when wait_on_f_ma_tvalid_low =>
 -- f_ma_tvalid tracks in_tvalid 
 if f_ma_tvalid = '0' then
 temp <= f_ma_data;
 in_tvalid <= '0';
 rdy <= '1';
 n_s := wait_on_req;
 else
 in_tvalid <= '0';
 rdy <= '0';
 end if;
 end case;
 
 end if;
 end if;
 end process;

z <= temp;
end Behavioral;

------------------------------------------
-- Cordic translate cartesian to polar
------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity user_logic is
  Port (ck, resetn, i_valid : in std_logic;
  carte_xy : in std_logic_vector(31 downto 0);
  o_valid: out std_logic;
  polar_z : out std_logic_vector(31 downto 0)
 );
end user_logic;

architecture Behavioral of user_logic is
COMPONENT cordic_0
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_cartesian_tvalid : IN STD_LOGIC;
    s_axis_cartesian_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
begin
name : cordic_0
  PORT MAP (
    aclk => ck,
    aresetn => resetn,
    s_axis_cartesian_tvalid => i_valid,
    s_axis_cartesian_tdata => carte_xy,
    m_axis_dout_tvalid => o_valid,
    m_axis_dout_tdata => polar_z
  );

end Behavioral;

---------------------
-- Project Name: Bubble sort array AXI Lite
---------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity instance is
generic(n: natural := 3;  -- n-bit unsigned 
        k: natural := 5); -- k numbers to sort
port (d_in : in  std_logic_vector(n-1 downto 0);
      d_out: out std_logic_vector(n-1 downto 0);
		reset,go,bus2ip_w_ack,bus2ip_r_ack,ck : in std_logic;
		new_data, done : out std_logic); -- new data flag to bus
end instance;

architecture struc of instance is
signal scan_en, run_en, reset_array : std_logic;
type device_operating_state is (idle, wait_on_go_low, download, reset_device,
run, wait_done_ack,wait_on_done_ack_low, upload, chill);
signal device_state: device_operating_state;
type download_handshake_state is (ready_for_new_data,consume,wait_for_w_ack_low);
signal download_sync_state: download_handshake_state;
type upload_handshake_state is (new_data_is_ready,put_new_data,wait_for_r_ack_low);
signal upload_sync_state: upload_handshake_state;
subtype my_integer is integer range 0 to k; -- k numbers to sort
signal count : my_integer;
component bubble_array
generic(n: natural := 2;  -- n-bit unsigned 
        k: natural := 4); -- k numbers to sort
port (d_in : in  std_logic_vector(n-1 downto 0);
      d_out: out std_logic_vector(n-1 downto 0);
		scan_en,run_en,reset,ck: in std_logic);
end component;
begin
U2: bubble_array generic map(n,k) port map(d_in,d_out,scan_en,run_en,reset_array,ck);

-- State machine synchronizes download, run and upload with processor
-- To use the device
-- 1. reset<='1'; 2. reset<='0'; 3. go<='1'; 4. go<='0';
-- for (i=0,i<k,i++){
-- 5. while(!new_data); 6. write data[i];}
-- 7. while(!done); (wait on done)
-- 8. go <= '1'; 9. go <= '0'
-- for (i=0,i<k,i++){
-- 10. while(!new_data); 11. read data[i];}
Process(ck)                                     
begin
if ck='1' and ck'event then
if reset = '1' then device_state <= idle; else
case device_state is 
 when idle => download_sync_state <= ready_for_new_data;
   upload_sync_state <= new_data_is_ready;  count <= 0;
   new_data<='0';scan_en<='0';run_en<='0';reset_array<='1';done<='0';
   if go = '1' then device_state <= wait_on_go_low; end if;
 when wait_on_go_low =>
   new_data<='0';scan_en<='0';run_en<='0';reset_array<='0';done<='0';
   if go = '0' then device_state <= download; end if; 
 when download =>
   Case download_sync_state is
      When ready_for_new_data =>
        new_data<='1';scan_en<='0';run_en<='0';reset_array<='0';done<='0';
        if bus2ip_w_ack = '1' then
         download_sync_state <= consume;
        end if;
      when consume => -- consume data, lower new data flag and count++
        new_data<='0';scan_en<='1';run_en<='0';reset_array<='0';done<='0';
		  download_sync_state <= wait_for_w_ack_low; count <= count+1;
		when wait_for_w_ack_low =>
        new_data<='0';scan_en <='0';run_en<='0';reset_array<='0';done<='0';
		  if bus2ip_w_ack = '0'then
		  		  download_sync_state <= ready_for_new_data;
		  end if;
		  if  count = k then  
		        device_state <= reset_device;
		  end if;
      end case; -- sync_state
 when reset_device =>
   new_data<='0';scan_en<='0';run_en<='1';reset_array<='1';done<='0';
	device_state <= run; count<=0;
 when run =>
   new_data<='0';scan_en<='0';run_en<='1';reset_array<='0';
   if count < k then count <= count+1; done <= '0'; else
   device_state <= wait_done_ack; count <= 0; done <= '1';
	end if;
 when wait_done_ack => -- go is done ack
    new_data<='0';scan_en<='0';run_en<='0';reset_array<='0';
    if go = '1' then
      device_state <= wait_on_done_ack_low; done <= '0'; else done <= '1';
    end if;
 when wait_on_done_ack_low => -- go is done ack
   new_data<='0';scan_en<='0';run_en<='1';reset_array<='1';done<='0';
   if go = '0' then
      device_state <= upload;
   end if;
 when upload =>
   case upload_sync_state is
      When new_data_is_ready =>
		new_data<='1'; scan_en<='0';run_en<='0';reset_array<='0';done<='0';
        if bus2ip_r_ack = '1' then
          upload_sync_state <= put_new_data; count <= count+1;
        end if;
      when put_new_data =>
        new_data<='0';scan_en <='1';run_en<='0';reset_array<='0';done<='0';
		  upload_sync_state <= wait_for_r_ack_low;
		when wait_for_r_ack_low =>
        new_data <= '0'; scan_en <='0';run_en<='0';reset_array <= '0';done <= '0';
		  if bus2ip_r_ack = '0' then
          upload_sync_state <= new_data_is_ready;
		  end if;
		  if count = k then  
		     device_state <= chill;
		  end if;
   end case; -- sync_state
 when chill => done <= '1';
 new_data <= '0'; scan_en <='0';run_en<='0';reset_array <= '0';
 end case; -- device state
end if; -- reset fence
end if; -- clock fence
end process;
end struc;

component instance 
    generic(n: natural := 3;  -- n-bit unsigned 
            k: natural := 5); -- k numbers to sort
    port (d_in : in  std_logic_vector(n-1 downto 0);
          d_out: out std_logic_vector(n-1 downto 0);
            reset,go,bus2ip_w_ack,bus2ip_r_ack,ck : in std_logic;
            new_data, done : out std_logic); -- new data flag to bus
end component;

begin

U: instance generic map (n => n, k => k)
   port map (ck => S_AXI_ACLK, d_in => slv_reg0,
   d_out => slv_reg2,
   reset => slv_reg1(0), go => slv_reg1(1),
   bus2ip_w_ack => slv_reg1(2), bus2ip_r_ack => slv_reg1(3),
   new_data => slv_reg3(0), done => slv_reg3(1));

entity sort_ip_v1_0_S0_AXI is
	generic (
		-- Users to add parameters here
        n: natural := 3;  -- n-bit unsigned 
        k: natural := 5; -- k numbers to sort

entity sort_ip_v1_0 is
	generic (
		-- Users to add parameters here
        n: natural := 32;  -- n-bit unsigned 
        k: natural := 5; -- k numbers to sort
        


-----------------------------
-- Module Name: sp101 
-- Comments: Stack Processor fetch-exe constant load store add
-----------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity user_logic is
generic (A : natural := 10);
port (
run,reset,bus2mem_en,bus2mem_we,ck : in  std_logic;
                      bus2mem_addr : in  std_logic_vector(A-1 downto 0);
                   bus2mem_data_in : in  std_logic_vector(31 downto 0);
                   sp2bus_data_out : out std_logic_vector(31 downto 0);
                              done : out std_logic);
end user_logic;

architecture Behavioral of user_logic is

-- bram signals
-- wea is bram port we is processor signal 
signal wea, we : STD_LOGIC_VECTOR(0 DOWNTO 0);  
signal addra   : STD_LOGIC_VECTOR(A-1 DOWNTO 0);  
signal dina    : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal douta   : STD_LOGIC_VECTOR(31 DOWNTO 0);
--cast bus2mem_we:in std_logic to wea:std_logic_vector
signal temp_we   : STD_LOGIC_VECTOR(0 DOWNTO 0);

-------------------------
-- processor registers
-------------------------

-- pointers
signal sp,pc,mem_addr : std_logic_vector(A-1 downto 0);

-- data registers
signal mem_data_in,mem_data_out,ir : std_logic_vector(31 downto 0);
signal temp1,temp2 : std_logic_vector(31 downto 0);

-- flags
signal busy, done_FF: std_logic;

------------------
-- machine state
------------------
type state is (idle,fetch,fetch2,fetch3, fetch4,fetch5,exe,chill);--implementation comment out fetch3,
signal n_s: state;

-----------------------------------
-- Instruction Definitions
-- Rightmost hex is the step in an instruction
-- higher hex is the code for an instruction,
-- e.g., the steps in SC (constant) instruction 0x01,.., 0x05
-- the steps in sl (load from memory) 0x11 to 0x19
-----------------------------------

constant HALT : std_logic_vector(31 downto 0) := (x"000000FF");

constant SC   : std_logic_vector(31 downto 0) := (x"00000001");
constant SC2  : std_logic_vector(31 downto 0) := (x"00000002");
-- implementation comment out sc3
--constant SC3  : std_logic_vector(31 downto 0) := (x"00000003");
constant SC4  : std_logic_vector(31 downto 0) := (x"00000004");
constant SC5  : std_logic_vector(31 downto 0) := (x"00000005");

 constant sl   : std_logic_vector(31 downto 0) := (x"00000011");
 constant sl2  : std_logic_vector(31 downto 0) := (x"00000012");
-- implementation comment out sl3
-- constant sl3  : std_logic_vector(31 downto 0) := (x"00000013");
 constant sl4  : std_logic_vector(31 downto 0) := (x"00000014");
 constant sl5  : std_logic_vector(31 downto 0) := (x"00000015");
 constant sl6  : std_logic_vector(31 downto 0) := (x"00000016");
-- implementation comment out sl7
-- constant sl7  : std_logic_vector(31 downto 0) := (x"00000017");
 constant sl8  : std_logic_vector(31 downto 0) := (x"00000018");
 constant sl9  : std_logic_vector(31 downto 0) := (x"00000019");
 
 constant ss   : std_logic_vector(31 downto 0) := (x"00000021");
 constant ss2  : std_logic_vector(31 downto 0) := (x"00000022");
-- implementation comment out ss3
 constant ss3  : std_logic_vector(31 downto 0) := (x"00000023");
 constant ss4  : std_logic_vector(31 downto 0) := (x"00000024");
 constant ss5  : std_logic_vector(31 downto 0) := (x"00000025");
 constant ss6  : std_logic_vector(31 downto 0) := (x"00000026");

 constant sadd : std_logic_vector(31 downto 0) := (x"00000031");
 constant sadd2: std_logic_vector(31 downto 0) := (x"00000032");
 -- implementation comment out sadd3
 constant sadd3: std_logic_vector(31 downto 0) := (x"00000033");
 constant sadd4: std_logic_vector(31 downto 0) := (x"00000034");
 constant sadd5: std_logic_vector(31 downto 0) := (x"00000035");
 constant sadd6: std_logic_vector(31 downto 0) := (x"00000036");

------------------
-- components 
------------------
COMPONENT blk_mem_gen_0
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
-- MEM bridge multiplexes BUS or processor signals to bram.
-- It also flags busy signal.
component  bus_ip_mem_bridge
generic(A: natural := 10); -- A-bit Address
port(
ip2mem_data_in,bus2mem_data_in : in  std_logic_vector(31 downto 0);
     ip2mem_addr,bus2mem_addr  : in  std_logic_vector(A-1 downto 0);
          bus2mem_we,ip2mem_we : in  std_logic_vector(0  downto 0);
                    bus2mem_en : in  std_logic;
	                     addra : out std_logic_vector(A-1 downto 0);
			              dina : out std_logic_vector(31 downto 0);
                           wea : out std_logic_vector(0 downto 0);
                          busy : out std_logic);
end component;

begin

---------------------------
-- components instantiation
---------------------------

temp_we(0) <= bus2mem_we; -- wire bus2mem_we to an std_logic_vector

-- MEM bridge multiplexes BUS or processor signals to bram.
bridge: bus_ip_mem_bridge -- It also flags busy signal to processor.
generic map(A)
port map(bus2mem_addr => bus2mem_addr, 
      bus2mem_data_in => bus2mem_data_in,
          ip2mem_addr => mem_addr, 
       ip2mem_data_in => mem_data_in,
           bus2mem_we => temp_we,
            ip2mem_we => we,
           bus2mem_en => bus2mem_en,
                addra => addra, 
                 dina => dina, 
                  wea => wea,
                 busy => busy);

-- main memory
mm : blk_mem_gen_0 PORT MAP (clka => ck,
                         wea => wea,
                       addra => addra,
                        dina => dina,
                       douta => douta);

-- memory data out register
process(ck)
begin
if ck='1' and ck'event then
  if reset = '1' then mem_data_out <= (others => '0'); 
  else mem_data_out <= douta;
  end if;
end if;
end process;

 -- wire to output ports sp2bus_data_out
sp2bus_data_out <= mem_data_out; done <= done_FF;

-------------------
-- Stack Processor
-------------------

process(ck)

begin
if ck='1' and ck'event then
  if reset='1' then n_s <= idle; else
                 --           Machine State Diagram
  case n_s is    --              run               halt
    when chill =>--reset~~>(idle)-->(fetch)-->(exe)-->(chill)
	   null; --                    |        |
             --                    |        v
             --                     <----(case ir)
    when idle =>
	   pc <= (others => '0');
	   sp <= (7 => '1', others => '0'); -- stack base 128
           ir <= (others => '0');
        temp1 <= (others => '0'); temp2 <= (others => '0');
     mem_addr <= (others => '0'); 
  mem_data_in <= (others => '0');
           we <= "0"; done_FF <= '0';

          -- poll on run and not busy 
	  if run='1' and busy='0' then n_s <= fetch; end if;

     when fetch => -- "init" means to initiate an action
	  mem_addr <= pc; pc <= pc+1;--init load pc to mem_addr 
		we <= "0"; -- enable read next state
		n_s <= fetch2;
        when fetch2 => -- mem_addr valid, pc advanced
		we <= "0";    -- read
--               n_s <= fetch3; -- one additional latency when simulate
               n_s <= fetch4; -- HW ip skip fetch3
                                               -----
                                               ----- mem_addr
--      when fetch3 => -- mem read latency=1     |   register
--             we <= "0"; -- read             --------
--            n_s <= fetch4;--               |  BRAM  |
        when fetch4 => -- douta valid       --------
               we <= "0"; -- read               | dout
              n_s <= fetch5; --               ----- 
        when fetch5 => -- mem_data_out valid  ----- mem_data_out
               we <= "0"; -- read               |   register
	       ir <= mem_data_out;-- init ir load 
              n_s <= exe;

     when exe =>   -- ir loaded
        case ir is -- Machine Instructions

	 when halt => -- signal done output and go to chill
          done_FF <= '1'; n_s <= chill;

         -- Stack Constant, init load constant pointed to by pc
	 when sc => 
         mem_addr <= pc;  --pc points at constant 
               pc <= pc+1;--advance to next instruction
               we <= "0"; --enable read next state
               ir <= sc2;
           when sc2 => -- mem_addr valid
		 we <= "0"; -- read
		 ir <= sc3; -- one additional latency when simulate
              -- ir <= sc4; -- HW ip skip sc3
           when sc3 => -- douta not valid latency 1
		 we <= "0"; -- read
		 ir <= sc4;
           when sc4 => -- douta valid
                 we <= "0"; -- read
                 ir <= sc5;  			
           when sc5 => -- mem_data_out valid
           mem_addr <= sp; sp <= sp+1;
        mem_data_in <= mem_data_out;
                 we <= "1"; -- write enable next state
                n_s <= fetch;

        --Load data from memory:pop address,read and stack data
	when sl => 
          mem_addr <= sp-1; sp <= sp-1;--init pop data address
                we <= "0"; -- enable read next state
		ir <= sl2;
          when sl2 => -- mem_addr updated
		we <= "0"; -- read
--		ir <= sl3; -- one additional latency when simulate
              ir <= sl4; -- HW ip skip sl3 
--          when sl3 => -- douta not valid latency 1
--                we <= "0"; -- read
--                ir <= sl4;			
          when sl4 => -- douta valid
		we <= "0"; -- read
		ir <= sl5; 	
          when sl5 => -- mem_data_out valid
	  mem_addr <= mem_data_out(A-1 downto 0);--data Address
		we <= "0"; -- read
                ir <= sl6;
          when sl6 => -- mem_addr updated
		we <= "0"; -- read
--		ir <= sl7; -- one additional latency when simulate
              ir <= sl8; -- HW ip skip sl7
--          when sl7 => -- douta not valid latency 1
--                we <= "0"; -- read
--                ir <= sl8;        			
          when sl8 => -- douta valid
		we <= "0"; -- read
		ir <= sl9; 	 	
          when sl9 => -- mem_data_out valid
          mem_addr <= sp; sp <= sp+1;
       mem_data_in <= mem_data_out;--data read
		we <= "1"; -- write enable in next state
               n_s <= fetch;

       --Store data to memory:pop data,address,write to memory
       when ss =>
          mem_addr <= sp-1; sp <= sp-1;--init1 pop data
		we <= "0"; -- read
                ir <= ss2;
          when ss2 =>  -- mem_addr updated1
          mem_addr <= sp-1; sp <= sp-1;--init2 pop address
                we <= "0"; -- read
                ir <= ss3; -- one additional latency when simulate
             -- ir <= ss4; -- HW ip skip ss3
          when ss3 =>      --douta1 not valid latency 1,
                we <= "0"; -- mem_addr updated2
                ir <= ss4;			
          when ss4 =>      -- douta valid1, 
                we <= "0"; --douta2 not valid latency 1
                ir <= ss5; 	 	
          when ss5 =>  --douta valid2, mem_data_out valid1
                we <= "0"; -- read
             temp1 <= mem_data_out;--temp <= data
                ir <= ss6;
          when ss6 =>  -- mem_data_out valid2
          mem_addr <= mem_data_out(A-1 downto 0);--init write
       mem_data_in <= temp1; --data in temp1
                we <= "1"; -- write enable in next state
               n_s <= fetch;
	       
       -- Add - pop operands add and push
       when sadd =>
          mem_addr <= sp-1;sp <= sp-1;--init1 pop operand1
                we <= "0"; -- read
                ir <= sadd2;
          when sadd2 => -- mem_addr updated1
	  mem_addr <= sp-1; sp <= sp-1;--init2 pop operand2
		we <= "0"; -- read
		ir <= sadd3; -- one additional latency when simulate
             -- ir <= sadd4; -- HW ip skip sadd3 
          when sadd3 =>--douta1 not valid latency 1,mem_addr updated2
              we <= "0"; -- read
              ir <= sadd4;
          when sadd4 =>  -- douta valid1, douta2 not valid latency 1,
              we <= "0"; -- read
              ir <= sadd5; 	 	
          when sadd5 =>  -- douta valid2, mem_data_out valid1
              we <= "0"; -- read
           temp1 <= mem_data_out;--temp1 <= operand1
              ir <= sadd6;
          when sadd6 => -- mem_data_out valid2
        mem_addr <= sp; sp <= sp+1; -- init push
     mem_data_in <= temp1+mem_data_out;--operand1+operand2
              we <= "1";  -- write enable in next state
             n_s <= fetch;  
							
       when others =>null;
      end case; -- instructions
     end case;  -- fetch-execute
  end if;       -- reset fence
end if;         -- clock fence
end process;
end Behavioral;

--------------------------------------------------------------------
-- Module Name: spiter
-- Comments: Stack Processor iterative process capable
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity user_logic is
generic (A : natural := 10);
port (
run,reset,bus2mem_en,bus2mem_we,ck : in  std_logic;
                      bus2mem_addr : in  std_logic_vector(A-1 downto 0);
                   bus2mem_data_in : in  std_logic_vector(31 downto 0);
                   sp2bus_data_out : out std_logic_vector(31 downto 0);
                              done : out std_logic);
end user_logic;

architecture Behavioral of user_logic is

-- bram signals
-- wea is bram port we is processor signal 
signal wea, we : STD_LOGIC_VECTOR(0 DOWNTO 0);  
signal addra   : STD_LOGIC_VECTOR(A-1 DOWNTO 0);  
signal dina    : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal douta   : STD_LOGIC_VECTOR(31 DOWNTO 0);
--cast bus2mem_we to std_logic_vector
signal temp_we   : STD_LOGIC_VECTOR(0 DOWNTO 0);

-------------------------
-- processor registers
-------------------------

-- pointers
signal sp,pc,mem_addr : std_logic_vector(A-1 downto 0);

-- data registers
signal mem_data_in,mem_data_out,ir : std_logic_vector(31 downto 0);
signal temp1,temp2 : std_logic_vector(31 downto 0);

-- flags
signal busy, done_FF: std_logic;
signal less_than_flag, grtr_than_flag, eq_flag: std_logic;
------------------
-- machine state
------------------
type state is (idle,fetch,fetch2,fetch4,fetch5,exe,chill);--fetch3,
signal n_s: state;

-----------------------------------
-- Instruction Definitions
-- Leftmost hex is the step in an instruction
-- higher hex is the code for an instruction,
-- e.g., the steps in SC (constant) instruction 0x01,.., 0x05
-- the steps in sl (load from memory) 0x11 to 0x19
-- When shoter Latency BRAM states are eliminated
-----------------------------------

constant HALT : std_logic_vector(31 downto 0) := (x"000000FF");

constant SC   : std_logic_vector(31 downto 0) := (x"00000001");
constant SC2  : std_logic_vector(31 downto 0) := (x"00000002");
--constant SC3  : std_logic_vector(31 downto 0) := (x"00000003");
constant SC4  : std_logic_vector(31 downto 0) := (x"00000004");
constant SC5  : std_logic_vector(31 downto 0) := (x"00000005");

 constant sl   : std_logic_vector(31 downto 0) := (x"00000011");
 constant sl2  : std_logic_vector(31 downto 0) := (x"00000012");
-- constant sl3  : std_logic_vector(31 downto 0) := (x"00000013");
 constant sl4  : std_logic_vector(31 downto 0) := (x"00000014");
 constant sl5  : std_logic_vector(31 downto 0) := (x"00000015");
 constant sl6  : std_logic_vector(31 downto 0) := (x"00000016");
-- constant sl7  : std_logic_vector(31 downto 0) := (x"00000017");
 constant sl8  : std_logic_vector(31 downto 0) := (x"00000018");
 constant sl9  : std_logic_vector(31 downto 0) := (x"00000019");
 
 constant ss   : std_logic_vector(31 downto 0) := (x"00000021");
 constant ss2  : std_logic_vector(31 downto 0) := (x"00000022");
-- constant ss3  : std_logic_vector(31 downto 0) := (x"00000023");
 constant ss4  : std_logic_vector(31 downto 0) := (x"00000024");
 constant ss5  : std_logic_vector(31 downto 0) := (x"00000025");
 constant ss6  : std_logic_vector(31 downto 0) := (x"00000026");

 constant sadd : std_logic_vector(31 downto 0) := (x"00000031");
 constant sadd2: std_logic_vector(31 downto 0) := (x"00000032");
-- constant sadd3: std_logic_vector(31 downto 0) := (x"00000033");
 constant sadd4: std_logic_vector(31 downto 0) := (x"00000034");
 constant sadd5: std_logic_vector(31 downto 0) := (x"00000035");
 constant sadd6: std_logic_vector(31 downto 0) := (x"00000036");
 
 constant ssub : std_logic_vector(31 downto 0) := (x"00000041");
 constant ssub2: std_logic_vector(31 downto 0) := (x"00000042");
-- constant ssub3: std_logic_vector(31 downto 0) := (x"00000043");
 constant ssub4: std_logic_vector(31 downto 0) := (x"00000044");
 constant ssub5: std_logic_vector(31 downto 0) := (x"00000045");
 constant ssub6: std_logic_vector(31 downto 0) := (x"00000046"); 

 constant sjlt : std_logic_vector(31 downto 0) := (x"00000051");
 constant sjlt2: std_logic_vector(31 downto 0) := (x"00000052");
-- constant sjlt3: std_logic_vector(31 downto 0) := (x"00000053");
 constant sjlt4: std_logic_vector(31 downto 0) := (x"00000054");
 constant sjlt5: std_logic_vector(31 downto 0) := (x"00000055"); 
 
 constant sjgt : std_logic_vector(31 downto 0) := (x"00000061");
 constant sjgt2: std_logic_vector(31 downto 0) := (x"00000062");
-- constant sjgt3: std_logic_vector(31 downto 0) := (x"00000063");
 constant sjgt4: std_logic_vector(31 downto 0) := (x"00000064");
 constant sjgt5: std_logic_vector(31 downto 0) := (x"00000065"); 
 
 constant sjeq : std_logic_vector(31 downto 0) := (x"00000071");
 constant sjeq2: std_logic_vector(31 downto 0) := (x"00000072");
-- constant sjeq3: std_logic_vector(31 downto 0) := (x"00000073");
 constant sjeq4: std_logic_vector(31 downto 0) := (x"00000074");
 constant sjeq5: std_logic_vector(31 downto 0) := (x"00000075");
 
 constant sjmp : std_logic_vector(31 downto 0) := (x"000000E1");
 constant sjmp2: std_logic_vector(31 downto 0) := (x"000000E2");
-- constant sjmp3: std_logic_vector(31 downto 0) := (x"000000E3");
 constant sjmp4: std_logic_vector(31 downto 0) := (x"000000E4");
 constant sjmp5: std_logic_vector(31 downto 0) := (x"000000E5");

 constant scmp : std_logic_vector(31 downto 0) := (x"000000F1");
 constant scmp2: std_logic_vector(31 downto 0) := (x"000000F2");
-- constant scmp3: std_logic_vector(31 downto 0) := (x"000000F3");
 constant scmp4: std_logic_vector(31 downto 0) := (x"000000F4");
 constant scmp5: std_logic_vector(31 downto 0) := (x"000000F5");
 constant scmp6: std_logic_vector(31 downto 0) := (x"000000F6");

 constant smul : std_logic_vector(31 downto 0) := (x"00000101");
 constant smul2: std_logic_vector(31 downto 0) := (x"00000102");
-- constant smul3: std_logic_vector(31 downto 0) := (x"00000103");
 constant smul4: std_logic_vector(31 downto 0) := (x"00000104");
 constant smul5: std_logic_vector(31 downto 0) := (x"00000105");
 constant smul6: std_logic_vector(31 downto 0) := (x"00000106");
 
------------------
-- components 
------------------
COMPONENT blk_mem_gen_0
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
-- MEM bridge multiplexes BUS or processor signals to bram.
-- It also flags busy signal.
component  bus_ip_mem_bridge
generic(A: natural := 10); -- A-bit Address
port(
ip2mem_data_in,bus2mem_data_in : in  std_logic_vector(31 downto 0);
     ip2mem_addr,bus2mem_addr  : in  std_logic_vector(A-1 downto 0);
          bus2mem_we,ip2mem_we : in  std_logic_vector(0  downto 0);
                    bus2mem_en : in  std_logic;
	                     addra : out std_logic_vector(A-1 downto 0);
			              dina : out std_logic_vector(31 downto 0);
                           wea : out std_logic_vector(0 downto 0);
                          busy : out std_logic);
end component;

begin

---------------------------
-- components instantiation
---------------------------

temp_we(0) <= bus2mem_we; -- wire bus2mem_we to an std_logic_vector

-- MEM bridge multiplexes BUS or processor signals to bram.
bridge: bus_ip_mem_bridge -- It also flags busy signal to processor.
generic map(A)
port map(bus2mem_addr => bus2mem_addr, 
      bus2mem_data_in => bus2mem_data_in,
          ip2mem_addr => mem_addr, 
       ip2mem_data_in => mem_data_in,
           bus2mem_we => temp_we,
            ip2mem_we => we,
           bus2mem_en => bus2mem_en,
                addra => addra, 
                 dina => dina, 
                  wea => wea,
                 busy => busy);

-- main memory
mm : blk_mem_gen_0 PORT MAP (clka => ck,
                         wea => wea,
                       addra => addra,
                        dina => dina,
                       douta => douta);

-- memory data out register always get new douta
process(ck)
begin
if ck='1' and ck'event then
  if reset = '1' then mem_data_out <= (others => '0'); 
  else mem_data_out <= douta;
  end if;
end if;
end process;

 -- wire to output ports sp2bus_data_out
sp2bus_data_out <= mem_data_out; done <= done_FF;

-------------------
-- Stack Processor
-------------------

process(ck)
-- temp signal for multiply instruction
variable temp_mult:std_logic_vector(63 downto 0);
begin
if ck='1' and ck'event then
  if reset='1' then n_s <= idle; else
                 --           Machine State Diagram
  case n_s is    --              run               halt
    when chill =>--reset~~>(idle)-->(fetch)-->(exe)-->(chill)
	   null;     --                    |        |
                 --                    |        v
                 --                     <----(case ir)
    when idle =>
	   pc <= (others => '0');
	   sp <= (7 => '1', others => '0'); -- stack base 128
           ir <= (others => '0');
        temp1 <= (others => '0'); temp2 <= (others => '0');
     mem_addr <= (others => '0'); 
  mem_data_in <= (others => '0');
           we <= "0"; done_FF <= '0';

      -- poll on run and not busy 
	  if run='1' and busy='0' then n_s <= fetch; end if;

    when fetch => -- "init" means to initiate an action
	 mem_addr <= pc; pc <= pc+1;--init load pc to mem_addr 
           we <= "0"; -- enable read next state
		  n_s <= fetch2;
      when fetch2 => -- mem_addr valid, pc advanced
		      we <= "0";     -- read         -----
             n_s <= fetch4;                  ----- mem_addr
--    when fetch3 => -- mem read latency=1     |   register
--            we <= "0"; -- read            --------
--            n_s <= fetch4;--             |  BRAM  |
      when fetch4 => -- douta valid         --------
              we <= "0"; -- read               | dout
             n_s <= fetch5; --               ----- 
      when fetch5 => -- mem_data_out valid   ----- mem_data_out
              we <= "0"; -- read               |   register
	          ir <= mem_data_out;-- init ir load 
             n_s <= exe;

     when exe =>   -- ir loaded
       case ir is -- Machine Instructions

	   when halt => -- signal done output and go to chill
          done_FF <= '1'; n_s <= chill;

       -- Stack Constant, init load constant pointed to by pc
	   when sc => 
        mem_addr <= pc;  --pc points at constant 
              pc <= pc+1;--advance to next instruction
              we <= "0"; --enable read next state
              ir <= sc2;
         when sc2 => -- mem_addr valid
		      we <= "0"; -- read
		      ir <= sc4;
--       when sc3 => -- douta not valid latency 1
--		      we <= "0"; -- read
--		      ir <= sc4;
         when sc4 => -- douta valid
              we <= "0"; -- read
              ir <= sc5;  			
         when sc5 => -- mem_data_out valid
        mem_addr <= sp; sp <= sp+1;
     mem_data_in <= mem_data_out;
              we <= "1"; -- write enable next state
             n_s <= fetch;

        --Load data from memory:pop address,read and stack data
	   when sl => 
        mem_addr <= sp-1; sp <= sp-1;--init pop data address
              we <= "0"; -- enable read next state
              ir <= sl2;
         when sl2 => -- mem_addr updated
		      we <= "0"; -- read
		      ir <= sl4;
--       when sl3 => -- douta not valid latency 1
--            we <= "0"; -- read
--            ir <= sl4; 		
         when sl4 => -- douta valid
		      we <= "0"; -- read
		      ir <= sl5; 	
         when sl5 => -- mem_data_out valid
	    mem_addr <= mem_data_out(A-1 downto 0);--data Address
		      we <= "0"; -- read
              ir <= sl6;
         when sl6 => -- mem_addr updated
		      we <= "0"; -- read
		      ir <= sl8; 
--       when sl7 => -- douta not valid latency 1
--            we <= "0"; -- read
--            ir <= sl8;        			
         when sl8 => -- douta valid
		      we <= "0"; -- read
              ir <= sl9; 	 	
         when sl9 => -- mem_data_out valid
        mem_addr <= sp; sp <= sp+1;
     mem_data_in <= mem_data_out;--data read
              we <= "1"; -- write enable in next state
             n_s <= fetch;

       --Store data to memory:pop data,address,write to memory
       when ss =>
        mem_addr <= sp-1; sp <= sp-1;--init1 pop data
	          we <= "0"; -- read
              ir <= ss2;
         when ss2 =>  -- mem_addr updated1
        mem_addr <= sp-1; sp <= sp-1;--init2 pop address
              we <= "0"; -- read
              ir <= ss4;
--       when ss3 =>      --douta1 not valid latency 1,
--            we <= "0"; -- mem_addr updated2
--            ir <= ss4;			
         when ss4 =>      -- douta valid1, 
              we <= "0"; --douta2 not valid latency 1
              ir <= ss5; 	 	
         when ss5 =>  --douta valid2, mem_data_out valid1
              we <= "0"; -- read
           temp1 <= mem_data_out;--temp <= data
              ir <= ss6;
         when ss6 =>  -- mem_data_out valid2
        mem_addr <= mem_data_out(A-1 downto 0);--init write
     mem_data_in <= temp1; --data in temp1
              we <= "1"; -- write enable in next state
             n_s <= fetch;
       
       -- Add - pop operands add and push
       when sadd =>
          mem_addr <= sp-1;sp <= sp-1;--init1 pop operand1
                we <= "0"; -- read
                ir <= sadd2;
         when sadd2 => -- mem_addr updated1
	      mem_addr <= sp-1; sp <= sp-1;--init2 pop operand2
		        we <= "0"; -- read
		        ir <= sadd4;
--       when sadd3 =>--douta1 not valid latency 1,mem_addr updated2
--              we <= "0"; -- read
--              ir <= sadd4;
         when sadd4 =>  -- douta valid1, douta2 not valid
                we <= "0"; -- read
                ir <= sadd5; 	 	
         when sadd5 =>  -- douta valid2, mem_data_out valid1
                we <= "0"; -- read
             temp1 <= mem_data_out;--temp1 <= operand1
                ir <= sadd6;
         when sadd6 => -- mem_data_out valid2
          mem_addr <= sp; sp <= sp+1; -- init push
        mem_data_in <= temp1+mem_data_out;--operand1+operand2
                we <= "1";  -- write enable in next state
               n_s <= fetch;

       -- Substract - pop operands, subtract and push, and set flags
	   when ssub => 
         mem_addr <= sp-1; sp <= sp-1;--init pop operand1
               we <= "0"; -- read
               ir <= ssub2;
         when ssub2 => -- mem_addr updated1
          mem_addr <= sp-1; sp <= sp-1;--init pop operand2
                we <= "0"; -- read
                ir <= ssub4;
--       when ssub3 => -- douta1 not valid latency 1, mem_addr updated2
--              we <= "0"; -- read
--              ir <= ssub4;            
         when ssub4 => -- douta1 valid1, douta2 not valid
                we <= "0"; -- mem_addr updated2
                ir <= ssub5;          
         when ssub5 =>  -- douta valid2, mem_data_out valid1
                we <= "0"; -- read
             temp1 <= mem_data_out;--temp1 <= operand1
                ir <= ssub6;
         when ssub6 => -- mem_data_out valid2
          mem_addr <= sp; sp <= sp+1; -- init push
       mem_data_in <= temp1-mem_data_out;--operand1-operand2
                we <= "1";  -- write enable in next state
  if mem_data_out<temp1 then less_than_flag<='1';else less_than_flag<='0';end if;
  if mem_data_out>temp1 then grtr_than_flag<='1';else grtr_than_flag<='0';end if;
  if mem_data_out=temp1 then        eq_flag<='1';else        eq_flag<='0';end if;
               n_s <= fetch;

       -- Multiply - pop operands multiply and push
	   when smul =>
			 mem_addr <= sp-1; sp <= sp-1;--init1 pop operand1
			 we <= "0"; -- read
			 ir <= smul2;
         when smul2 => -- mem_addr updated1
		  mem_addr <= sp-1; sp <= sp-1;--init2 pop operand2
	            we <= "0"; -- read
	            ir <= smul4;
--       when smul3 => -- douta1 not valid latency 1, mem_addr updated2
--              we <= "0"; -- read
--              ir <= smul4;			
         when smul4 =>  -- douta valid1, douta2 not valid
	            we <= "0"; -- read
	            ir <= smul5; 	 	
		 when smul5 =>  -- douta valid2, mem_data_out valid1
		        we <= "0"; -- read
			 temp1 <= mem_data_out;--temp1 <= operand1
			    ir <= smul6;
		 when smul6 => -- mem_data_out valid2
          mem_addr <= sp; sp <= sp+1; -- init push
         temp_mult := temp1*mem_data_out;
	   mem_data_in <= temp_mult(31 downto 0);--operand1*operand2
			 temp2 <= temp_mult(63 downto 32);--High 32bits assigned for sanity check
                we <= "1";  -- write enable in next state
               n_s <= fetch;
               
       -- Compare - pop operands, subtract and set flags 
       when scmp =>
          mem_addr <= sp-1; sp <= sp-1;--init pop operand1
                we <= "0"; -- read
                ir <= scmp2;
         when scmp2 => -- mem_addr updated1
          mem_addr <= sp-1; sp <= sp-1;--init pop operand2
                we <= "0"; -- read
                ir <= scmp4;
--       when scmp3 => -- douta1 not valid latency 1, mem_addr updated2
--              we <= "0"; -- read
--              ir <= scmp4;        
         when scmp4 =>  -- douta valid1, douta2 not valid
                we <= "0"; -- read
                ir <= scmp5;          
         when scmp5 =>  --  douta valid2, mem_data_out valid1
                we <= "0"; -- read
             temp1 <= mem_data_out;--temp1 <= operand1
              ir <= scmp6;
         when scmp6 => -- mem_data_out valid2
  if mem_data_out<temp1 then less_than_flag<='1';else less_than_flag<='0';end if;
  if mem_data_out>temp1 then grtr_than_flag<='1';else grtr_than_flag<='0';end if;
  if mem_data_out=temp1 then        eq_flag<='1';else        eq_flag<='0';end if;
              n_s <= fetch;

       -- Jump - pop address, pc <= address
	   when sjmp => 
	      mem_addr <= sp-1; sp <= sp-1;-- init pop jump-to address
	            we <= "0"; -- read
                ir <= sjmp2;
         when sjmp2 => -- mem_addr updated
		        we <= "0"; -- read
		        ir <= sjmp4;
--       when sjmp3 => -- douta not valid latency 1
--              we <= "0"; -- read
--              ir <= sjmp4;			
         when sjmp4 =>  -- douta valid
		        we <= "0"; -- read
		        ir <= sjmp5; 	 	
		 when sjmp5 =>  -- mem_data_out valid
		        we <= "0"; -- read
			    pc <= mem_data_out(A-1 downto 0);
		       n_s <= fetch;

    -- Jump Less Than -pop address,pc<=address on less_than_flag
	   when sjlt => 
	     mem_addr <= sp-1; sp <= sp-1;-- init pop jump-to address
			    we <= "0"; -- read
			    ir <= sjlt2;
         when sjlt2 => -- mem_addr updated
		        we <= "0"; -- read
		        ir <= sjlt4;
--         when sjlt3 => -- douta not valid latency 1
--            we <= "0"; -- read
--            ir <= sjlt4;
         when sjlt4 =>  -- douta valid
		        we <= "0"; -- read
		        ir <= sjlt5; 	 	
		 when sjlt5 =>  -- mem_data_out valid
		        we <= "0"; -- read
   if less_than_flag='1' then pc<=mem_data_out(A-1 downto 0);end if;
			   n_s <= fetch;
			   
    -- Jump greater Than -pop address,pc<=address on grtr_than_flag
       when sjgt =>
          mem_addr <= sp-1; sp <= sp-1;-- init pop jump-to address
                we <= "0"; -- read
                ir <= sjgt2;
         when sjgt2 => -- mem_addr updated
                we <= "0"; -- read
                ir <= sjgt4;
--       when sjgt3 => -- douta not valid latency 1
--              we <= "0"; -- read
--              ir <= sjgt4;
         when sjgt4 =>  -- douta valid
                we <= "0"; -- read
                ir <= sjgt5;          
         when sjgt5 =>  -- mem_data_out valid
                we <= "0"; -- read
   if grtr_than_flag='1' then pc<=mem_data_out(A-1 downto 0);end if;
               n_s <= fetch;
               
    -- Jump Equal - pop address, pc <= address on eq_flag
	   when sjeq => 
                     mem_addr <= sp-1; sp <= sp-1;-- init pop jump-to address
                     we <= "0"; -- read
                     ir <= sjeq2;
         when sjeq2 => -- mem_addr updated
                we <= "0"; -- read
                ir <= sjeq4;
--       when sjeq3 => -- douta not valid latency 1
--              we <= "0"; -- read
--              ir <= sjeq4;
         when sjeq4 =>  -- douta valid
                we <= "0"; -- read
                ir <= sjeq5;          
         when sjeq5 =>  -- mem_data_out valid
                we <= "0"; -- read
          if eq_flag='1' then pc<=mem_data_out(A-1 downto 0);end if;
               n_s <= fetch;

       when others =>null;
      end case; -- instructions
     end case;  -- fetch-execute
  end if;       -- reset fence
end if;         -- clock fence
end process;
end Behavioral;

--------------------------------------------------------------------
-- Company: Drexel ECE
-- Engineer: Prawat
-- Module Name: splite (sp lite)
-- Comments: Stack Processor iterative and recursive process capable
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity user_logic is
generic (A : natural := 10);
port (
run,reset,bus2mem_en,bus2mem_we,ck : in  std_logic;
                      bus2mem_addr : in  std_logic_vector(A-1 downto 0);
                   bus2mem_data_in : in  std_logic_vector(31 downto 0);
                   sp2bus_data_out : out std_logic_vector(31 downto 0);
                              done : out std_logic);
end user_logic;

architecture Behavioral of user_logic is

-- bram signals
-- wea is bram port we is processor signal 
signal wea, we : STD_LOGIC_VECTOR(0 DOWNTO 0);  
signal addra   : STD_LOGIC_VECTOR(A-1 DOWNTO 0);  
signal dina    : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal douta   : STD_LOGIC_VECTOR(31 DOWNTO 0);
--cast bus2mem_we to std_logic_vector
signal temp_we   : STD_LOGIC_VECTOR(0 DOWNTO 0);

-------------------------
-- processor registers
-------------------------

-- pointers
signal sp,pc,mem_addr,b : std_logic_vector(A-1 downto 0);

-- data registers
signal mem_data_in,mem_data_out,ir : std_logic_vector(31 downto 0);
signal temp1,temp2 : std_logic_vector(31 downto 0);

-- flags
signal busy, done_FF: std_logic;
signal less_than_flag, grtr_than_flag, eq_flag: std_logic;
------------------
-- machine state
------------------
type state is (idle,fetch,fetch2,fetch4,fetch5,exe,chill);--fetch3,
signal n_s: state;

-----------------------------------
-- Instruction Definitions
-- Leftmost hex is the step in an instruction
-- higher hex is the code for an instruction,
-- e.g., the steps in SC (constant) instruction 0x01,.., 0x05
-- the steps in sl (load from memory) 0x11 to 0x19
-- When shoter Latency BRAM states are eliminated
-----------------------------------

constant HALT : std_logic_vector(31 downto 0) := (x"000000FF");

constant SC   : std_logic_vector(31 downto 0) := (x"00000001");
constant SC2  : std_logic_vector(31 downto 0) := (x"00000002");
--constant SC3  : std_logic_vector(31 downto 0) := (x"00000003");
constant SC4  : std_logic_vector(31 downto 0) := (x"00000004");
constant SC5  : std_logic_vector(31 downto 0) := (x"00000005");

 constant sl   : std_logic_vector(31 downto 0) := (x"00000011");
 constant sl2  : std_logic_vector(31 downto 0) := (x"00000012");
-- constant sl3  : std_logic_vector(31 downto 0) := (x"00000013");
 constant sl4  : std_logic_vector(31 downto 0) := (x"00000014");
 constant sl5  : std_logic_vector(31 downto 0) := (x"00000015");
 constant sl6  : std_logic_vector(31 downto 0) := (x"00000016");
-- constant sl7  : std_logic_vector(31 downto 0) := (x"00000017");
 constant sl8  : std_logic_vector(31 downto 0) := (x"00000018");
 constant sl9  : std_logic_vector(31 downto 0) := (x"00000019");
 
 constant ss   : std_logic_vector(31 downto 0) := (x"00000021");
 constant ss2  : std_logic_vector(31 downto 0) := (x"00000022");
-- constant ss3  : std_logic_vector(31 downto 0) := (x"00000023");
 constant ss4  : std_logic_vector(31 downto 0) := (x"00000024");
 constant ss5  : std_logic_vector(31 downto 0) := (x"00000025");
 constant ss6  : std_logic_vector(31 downto 0) := (x"00000026");

 constant sadd : std_logic_vector(31 downto 0) := (x"00000031");
 constant sadd2: std_logic_vector(31 downto 0) := (x"00000032");
-- constant sadd3: std_logic_vector(31 downto 0) := (x"00000033");
 constant sadd4: std_logic_vector(31 downto 0) := (x"00000034");
 constant sadd5: std_logic_vector(31 downto 0) := (x"00000035");
 constant sadd6: std_logic_vector(31 downto 0) := (x"00000036");
 
 constant ssub : std_logic_vector(31 downto 0) := (x"00000041");
 constant ssub2: std_logic_vector(31 downto 0) := (x"00000042");
-- constant ssub3: std_logic_vector(31 downto 0) := (x"00000043");
 constant ssub4: std_logic_vector(31 downto 0) := (x"00000044");
 constant ssub5: std_logic_vector(31 downto 0) := (x"00000045");
 constant ssub6: std_logic_vector(31 downto 0) := (x"00000046"); 

 constant sjlt : std_logic_vector(31 downto 0) := (x"00000051");
 constant sjlt2: std_logic_vector(31 downto 0) := (x"00000052");
-- constant sjlt3: std_logic_vector(31 downto 0) := (x"00000053");
 constant sjlt4: std_logic_vector(31 downto 0) := (x"00000054");
 constant sjlt5: std_logic_vector(31 downto 0) := (x"00000055"); 
 
 constant sjgt : std_logic_vector(31 downto 0) := (x"00000061");
 constant sjgt2: std_logic_vector(31 downto 0) := (x"00000062");
-- constant sjgt3: std_logic_vector(31 downto 0) := (x"00000063");
 constant sjgt4: std_logic_vector(31 downto 0) := (x"00000064");
 constant sjgt5: std_logic_vector(31 downto 0) := (x"00000065"); 
 
 constant sjeq : std_logic_vector(31 downto 0) := (x"00000071");
 constant sjeq2: std_logic_vector(31 downto 0) := (x"00000072");
-- constant sjeq3: std_logic_vector(31 downto 0) := (x"00000073");
 constant sjeq4: std_logic_vector(31 downto 0) := (x"00000074");
 constant sjeq5: std_logic_vector(31 downto 0) := (x"00000075");
 
 constant sjmp : std_logic_vector(31 downto 0) := (x"000000E1");
 constant sjmp2: std_logic_vector(31 downto 0) := (x"000000E2");
-- constant sjmp3: std_logic_vector(31 downto 0) := (x"000000E3");
 constant sjmp4: std_logic_vector(31 downto 0) := (x"000000E4");
 constant sjmp5: std_logic_vector(31 downto 0) := (x"000000E5");

 constant scmp : std_logic_vector(31 downto 0) := (x"000000F1");
 constant scmp2: std_logic_vector(31 downto 0) := (x"000000F2");
-- constant scmp3: std_logic_vector(31 downto 0) := (x"000000F3");
 constant scmp4: std_logic_vector(31 downto 0) := (x"000000F4");
 constant scmp5: std_logic_vector(31 downto 0) := (x"000000F5");
 constant scmp6: std_logic_vector(31 downto 0) := (x"000000F6");

 constant smul : std_logic_vector(31 downto 0) := (x"00000101");
 constant smul2: std_logic_vector(31 downto 0) := (x"00000102");
-- constant smul3: std_logic_vector(31 downto 0) := (x"00000103");
 constant smul4: std_logic_vector(31 downto 0) := (x"00000104");
 constant smul5: std_logic_vector(31 downto 0) := (x"00000105");
 constant smul6: std_logic_vector(31 downto 0) := (x"00000106");
 
 constant scall : std_logic_vector(31 downto 0) := (x"00000081");
 constant scall2: std_logic_vector(31 downto 0) := (x"00000082");
-- constant scall3: std_logic_vector(31 downto 0) := (x"00000083");
 constant scall4: std_logic_vector(31 downto 0) := (x"00000084");
 constant scall5: std_logic_vector(31 downto 0) := (x"00000085");
 constant scall6: std_logic_vector(31 downto 0) := (x"00000086");
 constant scall7: std_logic_vector(31 downto 0) := (x"00000087");
 constant scall8: std_logic_vector(31 downto 0) := (x"00000088");
 constant scall9: std_logic_vector(31 downto 0) := (x"00000089");
 constant scall10: std_logic_vector(31 downto 0) := (x"0000008A");
 
 constant srtn : std_logic_vector(31 downto 0) := (x"00000091");
 constant srtn2: std_logic_vector(31 downto 0) := (x"00000092");
 constant srtn3: std_logic_vector(31 downto 0) := (x"00000093");
 constant srtn4: std_logic_vector(31 downto 0) := (x"00000094");
 constant srtn5: std_logic_vector(31 downto 0) := (x"00000095");
 constant srtn6: std_logic_vector(31 downto 0) := (x"00000096");
 constant srtn7: std_logic_vector(31 downto 0) := (x"00000097");
 constant srtn8: std_logic_vector(31 downto 0) := (x"00000098");
 constant srtn9: std_logic_vector(31 downto 0) := (x"00000099");

 constant salloc   : std_logic_vector(31 downto 0) := (x"000000A1");
 constant sdealloc : std_logic_vector(31 downto 0) := (x"000000B1");

 constant slaa : std_logic_vector(31 downto 0) := (x"000000C1");
 constant slaa2: std_logic_vector(31 downto 0) := (x"000000C2");
-- constant slaa3: std_logic_vector(31 downto 0) := (x"000000C3");
 constant slaa4: std_logic_vector(31 downto 0) := (x"000000C4");
 constant slaa5: std_logic_vector(31 downto 0) := (x"000000C5");
 constant slaa6: std_logic_vector(31 downto 0) := (x"000000C6");
 
 constant slla : std_logic_vector(31 downto 0) := (x"000000D1");
 constant slla2: std_logic_vector(31 downto 0) := (x"000000D2");
-- constant slla3: std_logic_vector(31 downto 0) := (x"000000D3");
 constant slla4: std_logic_vector(31 downto 0) := (x"000000D4");
 constant slla5: std_logic_vector(31 downto 0) := (x"000000D5");

------------------
-- components 
------------------
COMPONENT blk_mem_gen_0
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
-- MEM bridge multiplexes BUS or processor signals to bram.
-- It also flags busy signal.
component  bus_ip_mem_bridge
generic(A: natural := 10); -- A-bit Address
port(
ip2mem_data_in,bus2mem_data_in : in  std_logic_vector(31 downto 0);
     ip2mem_addr,bus2mem_addr  : in  std_logic_vector(A-1 downto 0);
          bus2mem_we,ip2mem_we : in  std_logic_vector(0  downto 0);
                    bus2mem_en : in  std_logic;
	                     addra : out std_logic_vector(A-1 downto 0);
			              dina : out std_logic_vector(31 downto 0);
                           wea : out std_logic_vector(0 downto 0);
                          busy : out std_logic);
end component;

begin

---------------------------
-- components instantiation
---------------------------

temp_we(0) <= bus2mem_we; -- wire bus2mem_we to an std_logic_vector

-- MEM bridge multiplexes BUS or processor signals to bram.
bridge: bus_ip_mem_bridge -- It also flags busy signal to processor.
generic map(A)
port map(bus2mem_addr => bus2mem_addr, 
      bus2mem_data_in => bus2mem_data_in,
          ip2mem_addr => mem_addr, 
       ip2mem_data_in => mem_data_in,
           bus2mem_we => temp_we,
            ip2mem_we => we,
           bus2mem_en => bus2mem_en,
                addra => addra, 
                 dina => dina, 
                  wea => wea,
                 busy => busy);

-- main memory
mm : blk_mem_gen_0 PORT MAP (clka => ck,
                         wea => wea,
                       addra => addra,
                        dina => dina,
                       douta => douta);

-- memory data out register always get new douta
process(ck)
begin
if ck='1' and ck'event then
  if reset = '1' then mem_data_out <= (others => '0'); 
  else mem_data_out <= douta;
  end if;
end if;
end process;

 -- wire to output ports sp2bus_data_out
sp2bus_data_out <= mem_data_out; done <= done_FF;

-------------------
-- Stack Processor
-------------------

process(ck)
-- temp signal for multiply instruction
variable temp_mult:std_logic_vector(63 downto 0);
begin
if ck='1' and ck'event then
  if reset='1' then n_s <= idle; else
                 --           Machine State Diagram
  case n_s is    --              run               halt
    when chill =>--reset~~>(idle)-->(fetch)-->(exe)-->(chill)
	   null;     --                    |        |
                 --                    |        v
                 --                     <----(case ir)
    when idle =>
	   pc <= (others => '0');
	   sp <= (7 => '1', others => '0'); -- stack base 128
	   b  <= (7 => '1', others => '0'); -- frame base 128
           ir <= (others => '0');
        temp1 <= (others => '0'); temp2 <= (others => '0');
     mem_addr <= (others => '0'); 
  mem_data_in <= (others => '0');
-- reset condition flags 
less_than_flag<='0';grtr_than_flag<='0';eq_flag<='0';
           we <= "0"; done_FF <= '0';

      -- poll on run and not busy 
	  if run='1' and busy='0' then n_s <= fetch; end if;

    when fetch => -- "init" means to initiate an action
	 mem_addr <= pc; pc <= pc+1;--init load pc to mem_addr 
           we <= "0"; -- enable read next state
		  n_s <= fetch2;
      when fetch2 => -- mem_addr valid, pc advanced
		      we <= "0";     -- read         -----
             n_s <= fetch4;                  ----- mem_addr
--    when fetch3 => -- mem read latency=1     |   register
--            we <= "0"; -- read            --------
--            n_s <= fetch4;--             |  BRAM  |
      when fetch4 => -- douta valid         --------
              we <= "0"; -- read               | dout
             n_s <= fetch5; --               ----- 
      when fetch5 => -- mem_data_out valid   ----- mem_data_out
              we <= "0"; -- read               |   register
	          ir <= mem_data_out;-- init ir load 
             n_s <= exe;

     when exe =>   -- ir loaded
       case ir is -- Machine Instructions

	   when halt => -- signal done output and go to chill
          done_FF <= '1'; n_s <= chill;

       -- Stack Constant, init load constant pointed to by pc
	   when sc => 
        mem_addr <= pc;  --pc points at constant 
              pc <= pc+1;--advance to next instruction
              we <= "0"; --enable read next state
              ir <= sc2;
         when sc2 => -- mem_addr valid
		      we <= "0"; -- read
		      ir <= sc4;
--       when sc3 => -- douta not valid latency 1
--		      we <= "0"; -- read
--		      ir <= sc4;
         when sc4 => -- douta valid
              we <= "0"; -- read
              ir <= sc5;  			
         when sc5 => -- mem_data_out valid
        mem_addr <= sp; sp <= sp+1;
     mem_data_in <= mem_data_out;
              we <= "1"; -- write enable next state
             n_s <= fetch;

        --Load data from memory:pop address,read and stack data
	   when sl => 
        mem_addr <= sp-1; sp <= sp-1;--init pop data address
              we <= "0"; -- enable read next state
              ir <= sl2;
         when sl2 => -- mem_addr updated
		      we <= "0"; -- read
		      ir <= sl4;
--       when sl3 => -- douta not valid latency 1
--            we <= "0"; -- read
--            ir <= sl4; 		
         when sl4 => -- douta valid
		      we <= "0"; -- read
		      ir <= sl5; 	
         when sl5 => -- mem_data_out valid
	    mem_addr <= mem_data_out(A-1 downto 0);--data Address
		      we <= "0"; -- read
              ir <= sl6;
         when sl6 => -- mem_addr updated
		      we <= "0"; -- read
		      ir <= sl8; 
--       when sl7 => -- douta not valid latency 1
--            we <= "0"; -- read
--            ir <= sl8;        			
         when sl8 => -- douta valid
		      we <= "0"; -- read
              ir <= sl9; 	 	
         when sl9 => -- mem_data_out valid
        mem_addr <= sp; sp <= sp+1;
     mem_data_in <= mem_data_out;--data read
              we <= "1"; -- write enable in next state
             n_s <= fetch;

       --Store data to memory:pop data,address,write to memory
       when ss =>
        mem_addr <= sp-1; sp <= sp-1;--init1 pop data
	          we <= "0"; -- read
              ir <= ss2;
         when ss2 =>  -- mem_addr updated1
        mem_addr <= sp-1; sp <= sp-1;--init2 pop address
              we <= "0"; -- read
              ir <= ss4;
--       when ss3 =>      --douta1 not valid latency 1,
--            we <= "0"; -- mem_addr updated2
--            ir <= ss4;			
         when ss4 =>      -- douta valid1, 
              we <= "0"; --douta2 not valid latency 1
              ir <= ss5; 	 	
         when ss5 =>  --douta valid2, mem_data_out valid1
              we <= "0"; -- read
           temp1 <= mem_data_out;--temp <= data
              ir <= ss6;
         when ss6 =>  -- mem_data_out valid2
        mem_addr <= mem_data_out(A-1 downto 0);--init write
     mem_data_in <= temp1; --data in temp1
              we <= "1"; -- write enable in next state
             n_s <= fetch;
       
       -- Add - pop operands add and push
       when sadd =>
          mem_addr <= sp-1;sp <= sp-1;--init1 pop operand1
                we <= "0"; -- read
                ir <= sadd2;
         when sadd2 => -- mem_addr updated1
	      mem_addr <= sp-1; sp <= sp-1;--init2 pop operand2
		        we <= "0"; -- read
		        ir <= sadd4;
--       when sadd3 =>--douta1 not valid latency 1,mem_addr updated2
--              we <= "0"; -- read
--              ir <= sadd4;
         when sadd4 =>  -- douta valid1, douta2 not valid
                we <= "0"; -- read
                ir <= sadd5; 	 	
         when sadd5 =>  -- douta valid2, mem_data_out valid1
                we <= "0"; -- read
             temp1 <= mem_data_out;--temp1 <= operand1
                ir <= sadd6;
         when sadd6 => -- mem_data_out valid2
          mem_addr <= sp; sp <= sp+1; -- init push
        mem_data_in <= temp1+mem_data_out;--operand1+operand2
                we <= "1";  -- write enable in next state
               n_s <= fetch;

       -- Substract - pop operands, subtract and push, and set flags
	   when ssub => 
         mem_addr <= sp-1; sp <= sp-1;--init pop operand1
               we <= "0"; -- read
               ir <= ssub2;
         when ssub2 => -- mem_addr updated1
          mem_addr <= sp-1; sp <= sp-1;--init pop operand2
                we <= "0"; -- read
                ir <= ssub4;
--       when ssub3 => -- douta1 not valid latency 1, mem_addr updated2
--              we <= "0"; -- read
--              ir <= ssub4;            
         when ssub4 => -- douta1 valid1, douta2 not valid
                we <= "0"; -- mem_addr updated2
                ir <= ssub5;          
         when ssub5 =>  -- douta valid2, mem_data_out valid1
                we <= "0"; -- read
             temp1 <= mem_data_out;--temp1 <= operand1
                ir <= ssub6;
         when ssub6 => -- mem_data_out valid2
          mem_addr <= sp; sp <= sp+1; -- init push
       mem_data_in <= temp1-mem_data_out;--operand1-operand2
                we <= "1";  -- write enable in next state
  if mem_data_out<temp1 then less_than_flag<='1';else less_than_flag<='0';end if;
  if mem_data_out>temp1 then grtr_than_flag<='1';else grtr_than_flag<='0';end if;
  if mem_data_out=temp1 then        eq_flag<='1';else        eq_flag<='0';end if;
               n_s <= fetch;

       -- Multiply - pop operands multiply and push
	   when smul =>
			 mem_addr <= sp-1; sp <= sp-1;--init1 pop operand1
			 we <= "0"; -- read
			 ir <= smul2;
         when smul2 => -- mem_addr updated1
		  mem_addr <= sp-1; sp <= sp-1;--init2 pop operand2
	            we <= "0"; -- read
	            ir <= smul4;
--       when smul3 => -- douta1 not valid latency 1, mem_addr updated2
--              we <= "0"; -- read
--              ir <= smul4;			
         when smul4 =>  -- douta valid1, douta2 not valid
	            we <= "0"; -- read
	            ir <= smul5; 	 	
		 when smul5 =>  -- douta valid2, mem_data_out valid1
		        we <= "0"; -- read
			 temp1 <= mem_data_out;--temp1 <= operand1
			    ir <= smul6;
		 when smul6 => -- mem_data_out valid2
          mem_addr <= sp; sp <= sp+1; -- init push
         temp_mult := temp1*mem_data_out;
	   mem_data_in <= temp_mult(31 downto 0);--operand1*operand2
			 temp2 <= temp_mult(63 downto 32);--High 32bits assigned for sanity check
                we <= "1";  -- write enable in next state
               n_s <= fetch;
               
       -- Compare - pop operands, subtract and set flags 
       when scmp =>
          mem_addr <= sp-1; sp <= sp-1;--init pop operand1
                we <= "0"; -- read
                ir <= scmp2;
         when scmp2 => -- mem_addr updated1
          mem_addr <= sp-1; sp <= sp-1;--init pop operand2
                we <= "0"; -- read
                ir <= scmp4;
--       when scmp3 => -- douta1 not valid latency 1, mem_addr updated2
--              we <= "0"; -- read
--              ir <= scmp4;        
         when scmp4 =>  -- douta valid1, douta2 not valid
                we <= "0"; -- read
                ir <= scmp5;          
         when scmp5 =>  --  douta valid2, mem_data_out valid1
                we <= "0"; -- read
             temp1 <= mem_data_out;--temp1 <= operand1
              ir <= scmp6;
         when scmp6 => -- mem_data_out valid2
  if mem_data_out<temp1 then less_than_flag<='1';else less_than_flag<='0';end if;
  if mem_data_out>temp1 then grtr_than_flag<='1';else grtr_than_flag<='0';end if;
  if mem_data_out=temp1 then        eq_flag<='1';else        eq_flag<='0';end if;
              n_s <= fetch;

       -- Jump - pop address, pc <= address
	   when sjmp => 
	      mem_addr <= sp-1; sp <= sp-1;-- init pop jump-to address
	            we <= "0"; -- read
                ir <= sjmp2;
         when sjmp2 => -- mem_addr updated
		        we <= "0"; -- read
		        ir <= sjmp4;
--       when sjmp3 => -- douta not valid latency 1
--              we <= "0"; -- read
--              ir <= sjmp4;			
         when sjmp4 =>  -- douta valid
		        we <= "0"; -- read
		        ir <= sjmp5; 	 	
		 when sjmp5 =>  -- mem_data_out valid
		        we <= "0"; -- read
			    pc <= mem_data_out(A-1 downto 0);
		       n_s <= fetch;

    -- Jump Less Than -pop address,pc<=address on less_than_flag
	   when sjlt => 
	     mem_addr <= sp-1; sp <= sp-1;-- init pop jump-to address
			    we <= "0"; -- read
			    ir <= sjlt2;
         when sjlt2 => -- mem_addr updated
		        we <= "0"; -- read
		        ir <= sjlt4;
--         when sjlt3 => -- douta not valid latency 1
--            we <= "0"; -- read
--            ir <= sjlt4;
         when sjlt4 =>  -- douta valid
		        we <= "0"; -- read
		        ir <= sjlt5; 	 	
		 when sjlt5 =>  -- mem_data_out valid
		        we <= "0"; -- read
   if less_than_flag='1' then pc<=mem_data_out(A-1 downto 0);end if;
			   n_s <= fetch;
			   
    -- Jump greater Than -pop address,pc<=address on grtr_than_flag
       when sjgt =>
          mem_addr <= sp-1; sp <= sp-1;-- init pop jump-to address
                we <= "0"; -- read
                ir <= sjgt2;
         when sjgt2 => -- mem_addr updated
                we <= "0"; -- read
                ir <= sjgt4;
--       when sjgt3 => -- douta not valid latency 1
--              we <= "0"; -- read
--              ir <= sjgt4;
         when sjgt4 =>  -- douta valid
                we <= "0"; -- read
                ir <= sjgt5;          
         when sjgt5 =>  -- mem_data_out valid
                we <= "0"; -- read
   if grtr_than_flag='1' then pc<=mem_data_out(A-1 downto 0);end if;
               n_s <= fetch;
               
    -- Jump Equal - pop address, pc <= address on eq_flag
	   when sjeq => 
          mem_addr <= sp-1; sp <= sp-1;-- init pop jump-to address
                we <= "0"; -- read
                ir <= sjeq2;
         when sjeq2 => -- mem_addr updated
                we <= "0"; -- read
                ir <= sjeq4;
--       when sjeq3 => -- douta not valid latency 1
--              we <= "0"; -- read
--              ir <= sjeq4;
         when sjeq4 =>  -- douta valid
                we <= "0"; -- read
                ir <= sjeq5;          
         when sjeq5 =>  -- mem_data_out valid
                we <= "0"; -- read
          if eq_flag='1' then pc<=mem_data_out(A-1 downto 0);end if;
               n_s <= fetch;
               
 --  stack frame before executing scall instruction
 --   |  agr0  | <- oldSP before subroutine call involing
 --   |  agr1  |    pushing args, #args and subroutine address
 --   | agrN-1 |
 --   |  #args |
 --   |sub addr| 
 --   |  ***   | <- sp

 --  stack frame after executing scall instruction
 --   |  agr0  | <- oldSP before subroutine call involing
 --   |  agr1  |    pushing args, #args and subroutine address
 --   | agrN-1 |
 --   |  oldPC |
 --   |  oldSP | oldSP <= currentSP-N-1
 --   |  old B |
 --   |  Flags |
 --   |  blank | <- B
 --   | TopOfS | <- SP(local variable 0)

    -- Subroutine call, build stack frame
    -- before scall instruction - arguments, 
    -- # of Args and subroutine address on the stack 
	when scall => 
	    mem_addr <= sp-1; sp <= sp-1;-- init1 pop jump-to address
                  we <= "0"; -- read
                  ir <= scall2;
      when scall2 => --init2 pop # of args, mem_addr updated1
        mem_addr <= sp-1; sp <= sp-1;
              we <= "0"; -- read
		          ir <= scall4;
--    when scall3 => -- douta1 not valid latency 1, mem_addr updated2
--            we <= "0"; -- read
--            ir <= scall4;    
      when scall4 =>  -- douta valid1, mem_addr updated2
		      we <= "0"; -- read
		      ir <= scall5; 	 	
      when scall5 =>  -- douta valid2, mem_data_out valid1
           temp1 <= mem_data_out;--subroutine address
              we <= "0"; -- read
              ir <= scall6;
      when scall6 =>  -- mem_data_out valid2
           temp2 <= mem_data_out;--#args
        mem_addr <= sp; sp <= sp+1; -- init push
     mem_data_in <= "0000000000000000000000"&pc; --save pc to be on stack frame
              we <= "1";  -- write enable in next state
              ir <= scall7;
      when scall7 =>
        mem_addr <= sp; sp <= sp+1; -- init push, old sp (where arg0 is) to be on stack frame
     mem_data_in <= "0000000000000000000000"&sp-temp2-1;--displacement is #args+1
              we <= "1";  -- write enable in next state
              ir <= scall8;
      when scall8 =>-- save Base pointer
        mem_addr <= sp; sp <= sp+1;
     mem_data_in <= "0000000000000000000000"&B;
              we <= "1"; -- enable write in next state
             ir  <= scall9;
      when scall9 =>-- save flags
        mem_addr <= sp; sp <= sp+1; -- sp will point at 
     mem_data_in <= (0=>less_than_flag,1=>grtr_than_flag,2=>eq_flag,others=>'0');
              we <= "1"; -- enable write in next state
              ir <= scall10;
      when scall10 =>
                B<=sp; sp<=sp+1;--new B points at blank and SP after blank, 
              pc <= temp1(A-1 downto 0); -- jump subroutine (address in temp1)			
              we <= "0"; -- disable write in next state
             n_s <= fetch;
			
 --  stack frame at return instruction
 --   |  agr0  | <- oldSP before calling subroutine
 --   |  agr1  |   
 --   | agrN-1 |
 --   |  oldPC |
 --   |  oldSP | oldSP<=SP-N-1
 --   |  old B |
 --   |  Flags |
 --   |  blank | <- B
 --   | result |
 --   |  ***   |<- SP

     -- Return from subroutine call, deallocate stack frame
     when srtn => 
        mem_addr <= sp-1; sp <= sp-1;-- init1 pop result
              we <= "0"; -- read
              ir <= srtn2;
       when srtn2 => -- init2 pop flags, mem_addr updated1
        mem_addr <= sp-2; sp <= sp-2; 
              we <= "0"; -- read
              ir <= srtn4;
              
--     when srtn3 =>  -- init3 pop oldB, mem_addr updated2,douta not valid1(latency)
--      mem_addr <= sp-1; sp<=sp-1;
--            we <= "0"; -- read
--            ir <= srtn5;
         
     when srtn4 => -- init3 pop oldB, mem_addr updated2,douta valid1(result)
       mem_addr <= sp-1; sp <= sp-1;
             we <= "0"; -- read
             ir <= srtn5;

       when srtn5 => --init4 pop oldSP,mem_addr updated3(B),doutvalid2(flags),mem_data_out valid1(result)
        mem_addr <= sp-1; sp <= sp-1;
           temp1 <= mem_data_out;-- result in temp1            
              we <= "0"; -- read
              ir <= srtn6;
             
       when srtn6 => --init5 pop oldPC,mem_addr updated4(sp),doutavalid3(B),mem_data_out valid2(flags)
        mem_addr <= sp-1; sp<=sp-1;
              we <= "0"; -- read
         eq_flag <= mem_data_out(2); -- flags restored
  grtr_than_flag <= mem_data_out(1);
  less_than_flag <= mem_data_out(0);
              ir <= srtn7;      
    
       when srtn7 => -- mem_addr updated5(pc), douta valid4(sp), mem_data_out valid3(B)
             we <= "0"; -- read
               B <= mem_data_out(A-1 downto 0); -- B restored
              ir <= srtn8;
              
       when srtn8 =>  -- douta valid5(PC), mem_data_out valid4(SP)
              sp <= mem_data_out(A-1 downto 0); -- sp restored
              we <= "0"; -- read
              ir <= srtn9;
              
       when srtn9 =>  -- mem_data_out valid5(pc)
        mem_addr <= sp; sp <= sp+1;
     mem_data_in <= temp1;--return result on stack
              we <= "1"; -- write enable in next state
              pc <= mem_data_out(A-1 downto 0); -- PC restored
             n_s <= fetch;		

     -- Allocate space on stack
     when salloc =>
		     we <= "0"; -- read
             sp <= sp+1;
            n_s <= fetch;

      -- Deallocate space on stack
     when sdealloc =>
               we <= "0"; -- read
               sp <= sp-1;
              n_s <= fetch;

      -- Load Argument Address - pop displacement, push Arg address = oldSP+displ
     when slaa =>
        mem_addr <= sp-1; sp <= sp-1; -- init1 pop displacement 
              we <= "0"; -- read
              ir <= slaa2;
       when slaa2 => -- mem_addr1 updated
        mem_addr <= B-3; --init2 pop old SP pointed to by B-3
              we <= "0"; -- read
              ir <= slaa4;
--     when slaa3 => -- douta1 not valid latency 1, mem_addr2 updated
--            we <= "0"; -- read
--            ir <= slaa4;
       when slaa4 => -- douta1 valid, mem_addr2 updated 
	       we <= "0"; -- read            
               ir <= slaa5; 	
        when slaa5 =>  --  douta2 valid, mem_data_out1 valid
               we <= "0"; -- read
            temp1 <= mem_data_out; --temp1 gets displacement
              ir  <= slaa6;	
        when slaa6 =>    -- mem_data_out2 valid
         mem_addr <= sp; sp <= sp+1;
      mem_data_in <= mem_data_out+temp1;--32-bit_extended_oldSP+displ
               we <= "1"; -- enable write next state
              n_s <= fetch;

      -- Load Local Address: pop displacement, push local address = B+displ
      when slla => 
         mem_addr <= sp-1; sp <= sp-1; -- init1 pop displacement 
               we <= "0"; -- read
               ir <= slla2;
        when slla2 => -- mem_addr updated
               we <= "0"; -- read
               ir <= slla4;
--      when slla3 => -- douta1 not valid latency 1
--             we <= "0"; -- read
--             ir <= slla4;			
        when slla4 => -- douta valid
	       we <= "0"; -- read
               ir <= slla5; 	
        when slla5 =>  -- mem_data_out valid
         mem_addr <= sp; sp <= sp+1;--local_variable_0 starts at B+1
      mem_data_in <= "0000000000000000000000"&B + 1 + mem_data_out;
               we <= "1";--enable write next state
              n_s <= fetch;			

       when others =>null;
      end case; -- instructions
     end case;  -- fetch-execute
  end if;       -- reset fence
end if;         -- clock fence
end process;
end Behavioral;

-------------
-- 8.7.1 Problem
-------------
-------------------------------------------
-- Fibonacci sequence generator
-------------------------------------------
library ieee;
use ieee.std_logic_1164.all,
ieee.std_logic_unsigned.all;

entity user_logic is
  generic (n : natural := 16);
  port(ck, reset, go: in std_logic;
  x: in std_logic_vector(n-1 downto 0);
  z: out std_logic_vector(n-1 downto 0);
  done : out std_logic
  );
end user_logic;

architecture beh of user_logic is
type my_state is (idle, run, chill);
signal n_s : my_state;
signal count : integer;
signal temp1, temp2 : 
       std_logic_vector(n-1 downto 0);
begin
  
  process(ck)
    begin
      if ck='1' and ck'event then
        if reset='1' then
          temp1 <= (others => '0');-- fib(0)
          temp2 <= (0 =>'1',others => '0'); --fib(1)
          count <= 0;
          done <= '0';
          n_s <= idle;
        else
        case n_s is
        when idle =>
        done <= '0';
        if go = '1' then
          n_s <= run;
        end if;
        when run =>
        if count < conv_integer(x) then
          temp1 <= temp1 + temp2;
          temp2 <= temp1;
          count <= count + 1;
          done <= '0';
        else
          n_s <= chill;
          done <= '1';
        end if;
        when chill => done <= '1';
        end case;
        end if;
      end if;
end process;

z <= temp1;

end beh;


---------------------
-- 8.7.2 Problem Fixed-point accumulator IP catalog
---------------------
----------------------------------------------------------------------------------
-- accumulator IP Catalog
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


library UNISIM;
use UNISIM.VComponents.all;

entity user_logic is
 PORT (
   B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
   CLK : IN STD_LOGIC;
   SCLR : IN STD_LOGIC;
   Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
 );
end user_logic;

architecture Behavioral of user_logic is
COMPONENT c_accum_0
  PORT (
    B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    CLK : IN STD_LOGIC;
    SCLR : IN STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
begin
me : c_accum_0
  PORT MAP (
    B => B,
    CLK => CLK,
    SCLR => SCLR,
    Q => Q
  );

end Behavioral;

---------------------
-- 8.7.4 Problem Floating-point MA IP catalog
---------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity user_logic is
  Port (
    ck, resetn : IN STD_LOGIC;
    i_valid : IN STD_LOGIC;
    a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    c : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    o_valid : OUT STD_LOGIC;
    z : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
   );
end user_logic;

architecture struc of user_logic is
COMPONENT floating_point_0
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_c_tvalid : IN STD_LOGIC;
    s_axis_c_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
begin
U : floating_point_0
  PORT MAP (
    aclk => ck,
    aresetn => resetn,
    s_axis_a_tvalid => i_valid,
    s_axis_a_tdata => a,
    s_axis_b_tvalid => i_valid,
    s_axis_b_tdata => b,
    s_axis_c_tvalid => i_valid,
    s_axis_c_tdata => c,
    m_axis_result_tvalid => o_valid,
    m_axis_result_tdata => z
  );
end struc;

component user_logic
  Port (
    ck, resetn : IN STD_LOGIC;
    i_valid : IN STD_LOGIC;
    a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    c : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    o_valid : OUT STD_LOGIC;
    z : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
   );
end component;
begin
U: user_logic port map(ck => S_AXI_ACLK,
resetn => slv_reg0(0), i_valid => slv_reg0(1),
a => slv_reg1, b => slv_reg2, c => slv_reg3,
o_valid => slv_reg4(0), z => slv_reg5);


---------------------
-- 8.7.5 Problem CORDIC
-- CORDIC rotate and multiply K
-- inputs: x + iy, k exp(ia)
-- -1 <= x, y, k <= 1, -pi <= a <= pi
-- output: p + iq
-- inputs x, y and K: 1QN
--                 a: 2QN
-- output    p and q: 1QN
-- Configure IP as 10-bit inputs and outputs
-- 1Q8 x, y, K, p, q and 2Q7 phase a
-- y&x => s_axis_cartesian_tdata : 
--        IN STD_LOGIC_VECTOR(31 DOWNTO 0);
-- Compensation Scaling is enable
-- round positive
-- QN converter
-- https://www.venea.net/web/q_format_conversion
-- translation calculator 
-- http://keisan.casio.com/exec/system/1223526375
-----------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

entity user_logic is
    port (
        ck, resetn: in std_logic;
        x, y, a, k:  in std_logic_vector(15 downto 0);
        i_valid : in std_logic;
        o_valid : out std_logic;
        p, q : out std_logic_vector(15 downto 0)
    );
end user_logic;

architecture struc of user_logic is

COMPONENT cordic_0
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_phase_tvalid : IN STD_LOGIC;
    s_axis_phase_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    s_axis_cartesian_tvalid : IN STD_LOGIC;
    s_axis_cartesian_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
    -- Signals
    signal cartesian_tdata : std_logic_vector(31 downto 0);
    signal pp : std_logic_vector(31 downto 0);
    signal qq : std_logic_vector(31 downto 0);
    signal dout_tdata : std_logic_vector(31 downto 0);
begin
    cartesian_tdata <= y&x;

U : cordic_0
      PORT MAP (
        aclk => ck,
        aresetn => resetn,
        s_axis_phase_tvalid => i_valid,
        s_axis_phase_tdata => a,
        s_axis_cartesian_tvalid => i_valid,
        s_axis_cartesian_tdata => cartesian_tdata,
        m_axis_dout_tvalid => o_valid,
        m_axis_dout_tdata => dout_tdata    
      );
-- dout_data and k have 8 bits fraction
-- pp and qq has 16 bits fraction
-- 31..24  23..16.15..8  7..0
    pp <= signed(dout_tdata(15 downto 0)) * signed(k);
    qq <= signed(dout_tdata(31 downto 16)) * signed(k);
-- output p and q are 1Q8
-- 8 bits fraction and 8 bits integral
    p <= pp(23 downto 8);
    q <= qq(23 downto 8);

end struc;

---------------------
-- 8.7.6 Problem CORDIC Givens Rotation
---------------------
----------------------------------------------
-- Company: Drexel ECE
-- Engineer: Prawat
-- Givens Rotation
-- 1Q8 and 2Q7 radian
-- inputs: [x y]^T
-- range -1 <= x,y <= 1 
-- inputs x, y : 1QN
-- translate IP
-- inputs yx_data with x, y 1Q8 
-- y is yx_data(31 downto 16)
-- x is yx_data(15 downto 0)
-- yx_data y&x
-- output pq: 
-- pq(31 downto 16) theta 2Q7
-- pq(15 downto 0) r 1Q8
-- sine sine cosine IP
-- input: theta
-- output: cs
-- cs(31 downto 16) sine 1Q8
-- cs(15 downto 0) cosine 1Q8
-- translate IP Compensation Scaling checked
-- QN converter
-- https://www.venea.net/web/q_format_conversion
-- Test data
-- 1/sqrt(2), 1/sqrt(2), 1 triangle
-- 1/2, 1/2, 1/sqrt(2) triangle
-- 0.707 @1Q8 = 0b5, sqrt(2)/2
-- 0.5   @1Q8 = 080, 1/2 
-- outputs 1 and 1/sqrt(2)
-- sqrt(3)/2, 1/2, 1 triangle
-- 0.866 @1Q8 = 0dd, sqrt(3)/2
--------------------------------------------
--         ______           ______
--        |trans-|  theta  |cosine|
--[x y]-->|late  |-------->| sine |--> [c s]
--        |______|--> r    |______|
--
-- Givens rotation for QR decomposition
-- theta = arctan(y/x)
--     c = cos(theta) = x/r
--     s = sin(theta) = y/r
--           
-- [ c    s ] [x]   [r]
-- [        ] [ ] = [ ]
-- [-s    c ] [y]   [0]
--
-- r = sqrt(x^2 + y^2)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity user_logic is
port(ck, resetn : in  std_logic;
      x,y : in  std_logic_vector(15 downto 0);
  i_valid : in  std_logic;
  o_valid : out std_logic;
    r,c,s : out std_logic_vector(15 downto 0)
 );
end user_logic;

architecture Behavioral of user_logic is
signal theta_valid : std_logic;
signal theta : std_logic_vector(15 downto 0);
signal yx_data : std_logic_vector(31 downto 0);
signal pq, cs : std_logic_vector(31 downto 0);
------------------
-- translate IP: retangular to polar
------------------
COMPONENT cordic_0
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_cartesian_tvalid : IN STD_LOGIC;
    s_axis_cartesian_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
-----------------
-- sine cosine IP
-----------------
COMPONENT cordic_1
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_phase_tvalid : IN STD_LOGIC;
    s_axis_phase_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
begin
  yx_data <= y&x;
  U0 : cordic_0
  PORT MAP (
    aclk => ck,
    aresetn => resetn,
    s_axis_cartesian_tvalid => i_valid,
    s_axis_cartesian_tdata => yx_data,
    m_axis_dout_tvalid => theta_valid,
    m_axis_dout_tdata => pq
  );
  r <= pq(15 downto 0);
  theta <= pq(31 downto 16);

  U1 : cordic_1
  PORT MAP (
    aclk => ck,
    aresetn => resetn,
    s_axis_phase_tvalid => theta_valid,
    s_axis_phase_tdata => theta,
    m_axis_dout_tvalid => o_valid,
    m_axis_dout_tdata => cs
  );
  s <= cs(31 downto 16);
  c <= cs(15 downto 0);
end Behavioral;

