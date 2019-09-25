-- come da esempio su specifica

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb is
end project_tb;

architecture projecttb of project_tb is
constant c_CLOCK_PERIOD		: time := 100 ns;
signal   tb_done		: std_logic;
signal   mem_address		: std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst	                : std_logic := '0';
signal   tb_start		: std_logic := '0';
signal   tb_clk		        : std_logic := '0';
signal   mem_o_data,mem_i_data	: std_logic_vector (7 downto 0);
signal   enable_wire  		: std_logic;
signal   mem_we		        : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal RAM: ram_type := (0 => std_logic_vector(to_unsigned( 185 , 8)),
                         1 => std_logic_vector(to_unsigned( 75 , 8)),
                         2 => std_logic_vector(to_unsigned( 32 , 8)),
                         3 => std_logic_vector(to_unsigned( 111 , 8)),
                         4 => std_logic_vector(to_unsigned( 213 , 8)),
                         5 => std_logic_vector(to_unsigned( 79 , 8)),
                         6 => std_logic_vector(to_unsigned( 33 , 8)),
                         7 => std_logic_vector(to_unsigned( 1 , 8)),
                         8 => std_logic_vector(to_unsigned( 33 , 8)),
                         9 => std_logic_vector(to_unsigned( 80 , 8)),
                         10 => std_logic_vector(to_unsigned( 35 , 8)),
                         11 => std_logic_vector(to_unsigned( 12 , 8)),
                         12 => std_logic_vector(to_unsigned( 254 , 8)),
                         13 => std_logic_vector(to_unsigned( 215 , 8)),
                         14 => std_logic_vector(to_unsigned( 78 , 8)),
                         15 => std_logic_vector(to_unsigned( 211 , 8)),
                         16 => std_logic_vector(to_unsigned( 121 , 8)),
                         17 => std_logic_vector(to_unsigned( 78 , 8)),
                         18 => std_logic_vector(to_unsigned( 33 , 8)),
			 others => (others =>'0'));

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
    if tb_clk'event and tb_clk = '1' then
        if enable_wire = '1' then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 2 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 2 ns;
            end if;
        end if;
    end if;
end process;


test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';

    -- Maschera di output = 00010001
    assert RAM(19) = std_logic_vector(to_unsigned( 17 , 8)) report "TEST FALLITO" severity failure;
 
    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;
end projecttb; 

--maschera di ingresso nulla: 00000000

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb_1 is
end project_tb_1;

architecture projecttb of project_tb_1 is
constant c_CLOCK_PERIOD		: time := 100 ns;
signal   tb_done		: std_logic;
signal   mem_address		: std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst	                : std_logic := '0';
signal   tb_start		: std_logic := '0';
signal   tb_clk		        : std_logic := '0';
signal   mem_o_data,mem_i_data	: std_logic_vector (7 downto 0);
signal   enable_wire  		: std_logic;
signal   mem_we		        : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal RAM: ram_type := (0 => std_logic_vector(to_unsigned( 0 , 8)),
                         1 => std_logic_vector(to_unsigned( 75 , 8)),
                         2 => std_logic_vector(to_unsigned( 32 , 8)),
                         3 => std_logic_vector(to_unsigned( 111 , 8)),
                         4 => std_logic_vector(to_unsigned( 213 , 8)),
                         5 => std_logic_vector(to_unsigned( 79 , 8)),
                         6 => std_logic_vector(to_unsigned( 33 , 8)),
                         7 => std_logic_vector(to_unsigned( 1 , 8)),
                         8 => std_logic_vector(to_unsigned( 33 , 8)),
                         9 => std_logic_vector(to_unsigned( 80 , 8)),
                         10 => std_logic_vector(to_unsigned( 35 , 8)),
                         11 => std_logic_vector(to_unsigned( 12 , 8)),
                         12 => std_logic_vector(to_unsigned( 254 , 8)),
                         13 => std_logic_vector(to_unsigned( 215 , 8)),
                         14 => std_logic_vector(to_unsigned( 78 , 8)),
                         15 => std_logic_vector(to_unsigned( 211 , 8)),
                         16 => std_logic_vector(to_unsigned( 121 , 8)),
                         17 => std_logic_vector(to_unsigned( 78 , 8)),
                         18 => std_logic_vector(to_unsigned( 33 , 8)),
			 others => (others =>'0'));

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
    if tb_clk'event and tb_clk = '1' then
        if enable_wire = '1' then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 2 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 2 ns;
            end if;
        end if;
    end if;
end process;


test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';

    assert RAM(19) = std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO" severity failure;
 
    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;
end projecttb;

--tutti i punti coincidenti  in un angolo (255-255), maschera che li considera tutti
 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb_2 is
end project_tb_2;

architecture projecttb of project_tb_2 is
constant c_CLOCK_PERIOD		: time := 100 ns;
signal   tb_done		: std_logic;
signal   mem_address		: std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst	                : std_logic := '0';
signal   tb_start		: std_logic := '0';
signal   tb_clk		        : std_logic := '0';
signal   mem_o_data,mem_i_data	: std_logic_vector (7 downto 0);
signal   enable_wire  		: std_logic;
signal   mem_we		        : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal RAM: ram_type := (0 => std_logic_vector(to_unsigned( 255 , 8)),
                         1 => std_logic_vector(to_unsigned( 255 , 8)),
                         2 => std_logic_vector(to_unsigned( 255 , 8)),
                         3 => std_logic_vector(to_unsigned( 255 , 8)),
                         4 => std_logic_vector(to_unsigned( 255 , 8)),
                         5 => std_logic_vector(to_unsigned( 255 , 8)),
                         6 => std_logic_vector(to_unsigned( 255 , 8)),
                         7 => std_logic_vector(to_unsigned( 255 , 8)),
                         8 => std_logic_vector(to_unsigned( 255 , 8)),
                         9 => std_logic_vector(to_unsigned( 255 , 8)),
                         10 => std_logic_vector(to_unsigned( 255 , 8)),
                         11 => std_logic_vector(to_unsigned( 255 , 8)),
                         12 => std_logic_vector(to_unsigned( 255 , 8)),
                         13 => std_logic_vector(to_unsigned( 255 , 8)),
                         14 => std_logic_vector(to_unsigned( 255 , 8)),
                         15 => std_logic_vector(to_unsigned( 255 , 8)),
                         16 => std_logic_vector(to_unsigned( 255 , 8)),
                         17 => std_logic_vector(to_unsigned( 255 , 8)),
                         18 => std_logic_vector(to_unsigned( 255 , 8)),
			 others => (others =>'0'));

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
    if tb_clk'event and tb_clk = '1' then
        if enable_wire = '1' then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 2 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 2 ns;
            end if;
        end if;
    end if;
end process;


test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';

    assert RAM(19) = std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO" severity failure;
 
    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;
end projecttb;

-- tutti i punti coincidenti nell'angolo in alto a destra, con distanza massima da quello considerato, quindi nell'origine

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb_3 is
end project_tb_3;

architecture projecttb of project_tb_3 is
constant c_CLOCK_PERIOD		: time := 100 ns;
signal   tb_done		: std_logic;
signal   mem_address		: std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst	                : std_logic := '0';
signal   tb_start		: std_logic := '0';
signal   tb_clk		        : std_logic := '0';
signal   mem_o_data,mem_i_data	: std_logic_vector (7 downto 0);
signal   enable_wire  		: std_logic;
signal   mem_we		        : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal RAM: ram_type := (0 => std_logic_vector(to_unsigned( 255 , 8)),
                         1 => std_logic_vector(to_unsigned( 255 , 8)),
                         2 => std_logic_vector(to_unsigned( 255 , 8)),
                         3 => std_logic_vector(to_unsigned( 255 , 8)),
                         4 => std_logic_vector(to_unsigned( 255 , 8)),
                         5 => std_logic_vector(to_unsigned( 255 , 8)),
                         6 => std_logic_vector(to_unsigned( 255 , 8)),
                         7 => std_logic_vector(to_unsigned( 255 , 8)),
                         8 => std_logic_vector(to_unsigned( 255 , 8)),
                         9 => std_logic_vector(to_unsigned( 255 , 8)),
                         10 => std_logic_vector(to_unsigned( 255 , 8)),
                         11 => std_logic_vector(to_unsigned( 255 , 8)),
                         12 => std_logic_vector(to_unsigned( 255 , 8)),
                         13 => std_logic_vector(to_unsigned( 255 , 8)),
                         14 => std_logic_vector(to_unsigned( 255 , 8)),
                         15 => std_logic_vector(to_unsigned( 255 , 8)),
                         16 => std_logic_vector(to_unsigned( 255 , 8)),
                         17 => std_logic_vector(to_unsigned( 0 , 8)),
                         18 => std_logic_vector(to_unsigned( 0 , 8)),
			 others => (others =>'0'));

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
    if tb_clk'event and tb_clk = '1' then
        if enable_wire = '1' then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 2 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 2 ns;
            end if;
        end if;
    end if;
end process;


test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';

    assert RAM(19) = std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO" severity failure;
 
    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;
end projecttb;

-- solo il primo punto considerato buono

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb_4 is
end project_tb_4;

architecture projecttb of project_tb_4 is
constant c_CLOCK_PERIOD		: time := 100 ns;
signal   tb_done		: std_logic;
signal   mem_address		: std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst	                : std_logic := '0';
signal   tb_start		: std_logic := '0';
signal   tb_clk		        : std_logic := '0';
signal   mem_o_data,mem_i_data	: std_logic_vector (7 downto 0);
signal   enable_wire  		: std_logic;
signal   mem_we		        : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal RAM: ram_type := (0 => std_logic_vector(to_unsigned( 1 , 8)),
                         1 => std_logic_vector(to_unsigned( 75 , 8)),
                         2 => std_logic_vector(to_unsigned( 32 , 8)),
                         3 => std_logic_vector(to_unsigned( 111 , 8)),
                         4 => std_logic_vector(to_unsigned( 213 , 8)),
                         5 => std_logic_vector(to_unsigned( 79 , 8)),
                         6 => std_logic_vector(to_unsigned( 33 , 8)),
                         7 => std_logic_vector(to_unsigned( 1 , 8)),
                         8 => std_logic_vector(to_unsigned( 33 , 8)),
                         9 => std_logic_vector(to_unsigned( 80 , 8)),
                         10 => std_logic_vector(to_unsigned( 35 , 8)),
                         11 => std_logic_vector(to_unsigned( 12 , 8)),
                         12 => std_logic_vector(to_unsigned( 254 , 8)),
                         13 => std_logic_vector(to_unsigned( 215 , 8)),
                         14 => std_logic_vector(to_unsigned( 78 , 8)),
                         15 => std_logic_vector(to_unsigned( 211 , 8)),
                         16 => std_logic_vector(to_unsigned( 121 , 8)),
                         17 => std_logic_vector(to_unsigned( 78 , 8)),
                         18 => std_logic_vector(to_unsigned( 33 , 8)),
			 others => (others =>'0'));

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
    if tb_clk'event and tb_clk = '1' then
        if enable_wire = '1' then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 2 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 2 ns;
            end if;
        end if;
    end if;
end process;


test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';

    assert RAM(19) = std_logic_vector(to_unsigned( 1 , 8)) report "TEST FALLITO" severity failure;
 
    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;
end projecttb;

--solo ultimo punto considerato buono

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb_5 is
end project_tb_5;

architecture projecttb of project_tb_5 is
constant c_CLOCK_PERIOD		: time := 100 ns;
signal   tb_done		: std_logic;
signal   mem_address		: std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst	                : std_logic := '0';
signal   tb_start		: std_logic := '0';
signal   tb_clk		        : std_logic := '0';
signal   mem_o_data,mem_i_data	: std_logic_vector (7 downto 0);
signal   enable_wire  		: std_logic;
signal   mem_we		        : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal RAM: ram_type := (0 => std_logic_vector(to_unsigned( 128 , 8)),
                         1 => std_logic_vector(to_unsigned( 75 , 8)),
                         2 => std_logic_vector(to_unsigned( 32 , 8)),
                         3 => std_logic_vector(to_unsigned( 111 , 8)),
                         4 => std_logic_vector(to_unsigned( 213 , 8)),
                         5 => std_logic_vector(to_unsigned( 79 , 8)),
                         6 => std_logic_vector(to_unsigned( 33 , 8)),
                         7 => std_logic_vector(to_unsigned( 1 , 8)),
                         8 => std_logic_vector(to_unsigned( 33 , 8)),
                         9 => std_logic_vector(to_unsigned( 80 , 8)),
                         10 => std_logic_vector(to_unsigned( 35 , 8)),
                         11 => std_logic_vector(to_unsigned( 12 , 8)),
                         12 => std_logic_vector(to_unsigned( 254 , 8)),
                         13 => std_logic_vector(to_unsigned( 215 , 8)),
                         14 => std_logic_vector(to_unsigned( 78 , 8)),
                         15 => std_logic_vector(to_unsigned( 211 , 8)),
                         16 => std_logic_vector(to_unsigned( 121 , 8)),
                         17 => std_logic_vector(to_unsigned( 78 , 8)),
                         18 => std_logic_vector(to_unsigned( 33 , 8)),
			 others => (others =>'0'));

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
    if tb_clk'event and tb_clk = '1' then
        if enable_wire = '1' then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 2 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 2 ns;
            end if;
        end if;
    end if;
end process;


test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';

    assert RAM(19) = std_logic_vector(to_unsigned( 128 , 8)) report "TEST FALLITO" severity failure;
 
    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;
end projecttb;

--primo e ultimo considerati con ultimo più vicino del primo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb_6 is
end project_tb_6;

architecture projecttb of project_tb_6 is
constant c_CLOCK_PERIOD		: time := 100 ns;
signal   tb_done		: std_logic;
signal   mem_address		: std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst	                : std_logic := '0';
signal   tb_start		: std_logic := '0';
signal   tb_clk		        : std_logic := '0';
signal   mem_o_data,mem_i_data	: std_logic_vector (7 downto 0);
signal   enable_wire  		: std_logic;
signal   mem_we		        : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal RAM: ram_type := (0 => std_logic_vector(to_unsigned( 129 , 8)),
                         1 => std_logic_vector(to_unsigned( 80 , 8)),
                         2 => std_logic_vector(to_unsigned( 35 , 8)),
                         3 => std_logic_vector(to_unsigned( 111 , 8)),
                         4 => std_logic_vector(to_unsigned( 213 , 8)),
                         5 => std_logic_vector(to_unsigned( 79 , 8)),
                         6 => std_logic_vector(to_unsigned( 33 , 8)),
                         7 => std_logic_vector(to_unsigned( 1 , 8)),
                         8 => std_logic_vector(to_unsigned( 33 , 8)),
                         9 => std_logic_vector(to_unsigned( 80 , 8)),
                         10 => std_logic_vector(to_unsigned( 35 , 8)),
                         11 => std_logic_vector(to_unsigned( 12 , 8)),
                         12 => std_logic_vector(to_unsigned( 254 , 8)),
                         13 => std_logic_vector(to_unsigned( 215 , 8)),
                         14 => std_logic_vector(to_unsigned( 78 , 8)),
                         15 => std_logic_vector(to_unsigned( 79 , 8)),
                         16 => std_logic_vector(to_unsigned( 34 , 8)),
                         17 => std_logic_vector(to_unsigned( 78 , 8)),
                         18 => std_logic_vector(to_unsigned( 33 , 8)),
			 others => (others =>'0'));

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
    if tb_clk'event and tb_clk = '1' then
        if enable_wire = '1' then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 2 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 2 ns;
            end if;
        end if;
    end if;
end process;


test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';

    assert RAM(19) = std_logic_vector(to_unsigned( 128 , 8)) report "TEST FALLITO" severity failure;
 
    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;
end projecttb;

--punti equidistanti a stella (punto in esame al centro (127,127)) e gli 8 centroidi a due a due negli angoli hanno quindi distanza massima
--in questo test aggiungiamo anche l'alternanza della mschera di ingresso che sceglie un punto si e quello successivo no: in_mask = 01010101

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb_7 is
end project_tb_7;

architecture projecttb of project_tb_7 is
constant c_CLOCK_PERIOD		: time := 100 ns;
signal   tb_done		: std_logic;
signal   mem_address		: std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst	                : std_logic := '0';
signal   tb_start		: std_logic := '0';
signal   tb_clk		        : std_logic := '0';
signal   mem_o_data,mem_i_data	: std_logic_vector (7 downto 0);
signal   enable_wire  		: std_logic;
signal   mem_we		        : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal RAM: ram_type := (0 => std_logic_vector(to_unsigned( 85 , 8)),
                         1 => std_logic_vector(to_unsigned( 0 , 8)),
                         2 => std_logic_vector(to_unsigned( 0 , 8)),
                         3 => std_logic_vector(to_unsigned( 255 , 8)),
                         4 => std_logic_vector(to_unsigned( 0 , 8)),
                         5 => std_logic_vector(to_unsigned( 255 , 8)),
                         6 => std_logic_vector(to_unsigned( 255 , 8)),
                         7 => std_logic_vector(to_unsigned( 0 , 8)),
                         8 => std_logic_vector(to_unsigned( 255 , 8)),
                         9 => std_logic_vector(to_unsigned( 0 , 8)),
                         10 => std_logic_vector(to_unsigned( 0 , 8)),
                         11 => std_logic_vector(to_unsigned( 255 , 8)),
                         12 => std_logic_vector(to_unsigned( 0 , 8)),
                         13 => std_logic_vector(to_unsigned( 255 , 8)),
                         14 => std_logic_vector(to_unsigned( 255 , 8)),
                         15 => std_logic_vector(to_unsigned( 0 , 8)),
                         16 => std_logic_vector(to_unsigned( 255 , 8)),
                         17 => std_logic_vector(to_unsigned( 127 , 8)),
                         18 => std_logic_vector(to_unsigned( 127 , 8)),
			 others => (others =>'0'));

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
    if tb_clk'event and tb_clk = '1' then
        if enable_wire = '1' then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 2 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 2 ns;
            end if;
        end if;
    end if;
end process;


test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';

    assert RAM(19) = std_logic_vector(to_unsigned( 17 , 8)) report "TEST FALLITO" severity failure;
 
    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;
end projecttb;

--punti a croce equidistanti da quello nel centro (127,127), situati sulle proiezioni di questo sui bordi della griglia
--in questo caso consideriamo solamente quelli determinati dall'altro caso di maschera in alternanza: in_mask = 10101010

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb_8 is
end project_tb_8;

architecture projecttb of project_tb_8 is
constant c_CLOCK_PERIOD		: time := 100 ns;
signal   tb_done		: std_logic;
signal   mem_address		: std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst	                : std_logic := '0';
signal   tb_start		: std_logic := '0';
signal   tb_clk		        : std_logic := '0';
signal   mem_o_data,mem_i_data	: std_logic_vector (7 downto 0);
signal   enable_wire  		: std_logic;
signal   mem_we		        : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal RAM: ram_type := (0 => std_logic_vector(to_unsigned( 170 , 8)),
                         1 => std_logic_vector(to_unsigned( 127 , 8)),
                         2 => std_logic_vector(to_unsigned( 0 , 8)),
                         3 => std_logic_vector(to_unsigned( 255 , 8)),
                         4 => std_logic_vector(to_unsigned( 127 , 8)),
                         5 => std_logic_vector(to_unsigned( 127 , 8)),
                         6 => std_logic_vector(to_unsigned( 255 , 8)),
                         7 => std_logic_vector(to_unsigned( 0 , 8)),
                         8 => std_logic_vector(to_unsigned( 127 , 8)),
                         9 => std_logic_vector(to_unsigned( 127 , 8)),
                         10 => std_logic_vector(to_unsigned( 0 , 8)),
                         11 => std_logic_vector(to_unsigned( 255 , 8)),
                         12 => std_logic_vector(to_unsigned( 127 , 8)),
                         13 => std_logic_vector(to_unsigned( 127 , 8)),
                         14 => std_logic_vector(to_unsigned( 255 , 8)),
                         15 => std_logic_vector(to_unsigned( 0 , 8)),
                         16 => std_logic_vector(to_unsigned( 127 , 8)),
                         17 => std_logic_vector(to_unsigned( 127 , 8)),
                         18 => std_logic_vector(to_unsigned( 127 , 8)),
			 others => (others =>'0'));

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
    if tb_clk'event and tb_clk = '1' then
        if enable_wire = '1' then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 2 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 2 ns;
            end if;
        end if;
    end if;
end process;


test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';

    assert RAM(19) = std_logic_vector(to_unsigned( 136 , 8)) report "TEST FALLITO" severity failure;
 
    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;
end projecttb;

--punto circondato a distanza minima, quindi 1, gli unici punti buoni sono allora solo quelli nelle direzioni singole: N,S,O,E

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb_9 is
end project_tb_9;

architecture projecttb of project_tb_9 is
constant c_CLOCK_PERIOD		: time := 100 ns;
signal   tb_done		: std_logic;
signal   mem_address		: std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst	                : std_logic := '0';
signal   tb_start		: std_logic := '0';
signal   tb_clk		        : std_logic := '0';
signal   mem_o_data,mem_i_data	: std_logic_vector (7 downto 0);
signal   enable_wire  		: std_logic;
signal   mem_we		        : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal RAM: ram_type := (0 => std_logic_vector(to_unsigned( 255 , 8)),
                         1 => std_logic_vector(to_unsigned( 126 , 8)),
                         2 => std_logic_vector(to_unsigned( 126 , 8)),
                         3 => std_logic_vector(to_unsigned( 127 , 8)),
                         4 => std_logic_vector(to_unsigned( 126 , 8)),
                         5 => std_logic_vector(to_unsigned( 128 , 8)),
                         6 => std_logic_vector(to_unsigned( 126 , 8)),
                         7 => std_logic_vector(to_unsigned( 128 , 8)),
                         8 => std_logic_vector(to_unsigned( 127 , 8)),
                         9 => std_logic_vector(to_unsigned( 128 , 8)),
                         10 => std_logic_vector(to_unsigned( 128 , 8)),
                         11 => std_logic_vector(to_unsigned( 127 , 8)),
                         12 => std_logic_vector(to_unsigned( 128 , 8)),
                         13 => std_logic_vector(to_unsigned( 126 , 8)),
                         14 => std_logic_vector(to_unsigned( 128 , 8)),
                         15 => std_logic_vector(to_unsigned( 126 , 8)),
                         16 => std_logic_vector(to_unsigned( 127 , 8)),
                         17 => std_logic_vector(to_unsigned( 127 , 8)),
                         18 => std_logic_vector(to_unsigned( 127 , 8)),
			 others => (others =>'0'));

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
    if tb_clk'event and tb_clk = '1' then
        if enable_wire = '1' then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 2 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 2 ns;
            end if;
        end if;
    end if;
end process;


test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';

    assert RAM(19) = std_logic_vector(to_unsigned( 170 , 8)) report "TEST FALLITO" severity failure;
 
    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;
end projecttb;

-- Triggero reset a caso durante la computazione

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb_10 is
end project_tb_10;

architecture projecttb of project_tb_10 is
constant c_CLOCK_PERIOD		: time := 100 ns;
signal   tb_done		: std_logic;
signal   mem_address		: std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst	                : std_logic := '0';
signal   tb_start		: std_logic := '0';
signal   tb_clk		        : std_logic := '0';
signal   mem_o_data,mem_i_data	: std_logic_vector (7 downto 0);
signal   enable_wire  		: std_logic;
signal   mem_we		        : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal RAM: ram_type := (0 => std_logic_vector(to_unsigned( 185 , 8)),
                         1 => std_logic_vector(to_unsigned( 75 , 8)),
                         2 => std_logic_vector(to_unsigned( 32 , 8)),
                         3 => std_logic_vector(to_unsigned( 111 , 8)),
                         4 => std_logic_vector(to_unsigned( 213 , 8)),
                         5 => std_logic_vector(to_unsigned( 79 , 8)),
                         6 => std_logic_vector(to_unsigned( 33 , 8)),
                         7 => std_logic_vector(to_unsigned( 1 , 8)),
                         8 => std_logic_vector(to_unsigned( 33 , 8)),
                         9 => std_logic_vector(to_unsigned( 80 , 8)),
                         10 => std_logic_vector(to_unsigned( 35 , 8)),
                         11 => std_logic_vector(to_unsigned( 12 , 8)),
                         12 => std_logic_vector(to_unsigned( 254 , 8)),
                         13 => std_logic_vector(to_unsigned( 215 , 8)),
                         14 => std_logic_vector(to_unsigned( 78 , 8)),
                         15 => std_logic_vector(to_unsigned( 211 , 8)),
                         16 => std_logic_vector(to_unsigned( 121 , 8)),
                         17 => std_logic_vector(to_unsigned( 78 , 8)),
                         18 => std_logic_vector(to_unsigned( 33 , 8)),
			 others => (others =>'0'));

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
    if tb_clk'event and tb_clk = '1' then
        if enable_wire = '1' then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 2 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 2 ns;
            end if;
        end if;
    end if;
end process;


test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
	wait for c_CLOCK_PERIOD; 
	wait for c_CLOCK_PERIOD;
	tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    tb_rst <= '0';
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';

    -- Maschera di output = 00010001
    assert RAM(19) = std_logic_vector(to_unsigned( 17 , 8)) report "TEST FALLITO" severity failure;
 
    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;
end projecttb; 

-- Due computazioni di fila con stessa RAM ma aspettando più tempo prima di ripartire 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb_11 is
end project_tb_11;

architecture projecttb of project_tb_11 is
constant c_CLOCK_PERIOD		: time := 100 ns;
signal   tb_done		: std_logic;
signal   mem_address		: std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst	                : std_logic := '0';
signal   tb_start		: std_logic := '0';
signal   tb_clk		        : std_logic := '0';
signal   mem_o_data,mem_i_data	: std_logic_vector (7 downto 0);
signal   enable_wire  		: std_logic;
signal   mem_we		        : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal RAM: ram_type := (0 => std_logic_vector(to_unsigned( 185 , 8)),
                         1 => std_logic_vector(to_unsigned( 75 , 8)),
                         2 => std_logic_vector(to_unsigned( 32 , 8)),
                         3 => std_logic_vector(to_unsigned( 111 , 8)),
                         4 => std_logic_vector(to_unsigned( 213 , 8)),
                         5 => std_logic_vector(to_unsigned( 79 , 8)),
                         6 => std_logic_vector(to_unsigned( 33 , 8)),
                         7 => std_logic_vector(to_unsigned( 1 , 8)),
                         8 => std_logic_vector(to_unsigned( 33 , 8)),
                         9 => std_logic_vector(to_unsigned( 80 , 8)),
                         10 => std_logic_vector(to_unsigned( 35 , 8)),
                         11 => std_logic_vector(to_unsigned( 12 , 8)),
                         12 => std_logic_vector(to_unsigned( 254 , 8)),
                         13 => std_logic_vector(to_unsigned( 215 , 8)),
                         14 => std_logic_vector(to_unsigned( 78 , 8)),
                         15 => std_logic_vector(to_unsigned( 211 , 8)),
                         16 => std_logic_vector(to_unsigned( 121 , 8)),
                         17 => std_logic_vector(to_unsigned( 78 , 8)),
                         18 => std_logic_vector(to_unsigned( 33 , 8)),
			 others => (others =>'0'));

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
    if tb_clk'event and tb_clk = '1' then
        if enable_wire = '1' then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 2 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 2 ns;
            end if;
        end if;
    end if;
end process;


test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    tb_start <= '1';
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';

    -- Maschera di output = 00010001
    assert RAM(19) = std_logic_vector(to_unsigned( 17 , 8)) report "TEST FALLITO" severity failure;
			
	wait for 111 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    tb_start <= '1';
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';		
	
	-- Maschera di output = 00000000
    assert RAM(19) = std_logic_vector(to_unsigned( 17 , 8)) report "TEST FALLITO" severity failure;
	assert false report "Simulation Ended! TEST PASSATO" severity failure;

end process test;
end projecttb; 