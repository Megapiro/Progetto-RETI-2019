----------------------------------------------------------------------------------
--
-- Prova Finale (Progetto di Reti Logiche)
-- Prof. Gianluca Palermo - Anno 2018/2019
--
-- Giorgio Piazza (Codice Persona 10529035 Matricola 867894)
-- Francesco Piro (Codice Persona 10534719 Matricola 870365)
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity project_reti_logiche is
    Port ( 
        i_clk     : in std_logic;
        i_start   : in std_logic;
        i_rst     : in std_logic;
        i_data    : in std_logic_vector(7 downto 0);
        o_address : out std_logic_vector(15 downto 0);
        o_done    : out std_logic;
        o_en      : out std_logic;
        o_we      : out std_logic;
        o_data    : out std_logic_vector(7 downto 0)
    );
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is
    type state_type is (IDLE, FETCH_CONST, WAIT_RAM, GET_CONST, FETCH_NEXT, 
                        GET_CENTROID, CALC_DIST, CHECK_DIST, WRITE_OUT, DONE);
    signal state_reg, state_next : state_type;
	
	signal o_done_next, o_en_next, o_we_next : std_logic := '0';
	signal o_data_next : std_logic_vector(7 downto 0) := "00000000";
	signal o_address_next : std_logic_vector(15 downto 0) := "0000000000000000";
	
	signal got_x_reg, got_y_reg, got_x_next, got_y_next : boolean := false;
	signal got_mask_reg, got_centr_x_reg, got_mask_next, got_centr_x_next : boolean := false;
	
    signal point_x_reg, point_y_reg, point_x_next, point_y_next : integer range 0 to 255 := 0;
	signal centroid_x_reg, centroid_y_reg, centroid_x_next, centroid_y_next : integer range 0 to 255 := 0;
	
    signal in_mask_reg, in_mask_next : std_logic_vector(7 downto 0) := "00000000";
	signal out_mask_reg, out_mask_next : std_logic_vector(7 downto 0) := "00000000";
	
    signal address_reg, address_next : std_logic_vector(15 downto 0) := "0000000000000001";
    signal centroid_bit_reg, centroid_bit_next : std_logic_vector(7 downto 0) := "00000001";    
    signal centroid_dist_reg, centroid_dist_next : integer range 0 to 510 := 0;
    signal min_dist_reg, min_dist_next : integer range 0 to 510 := 510;
begin
    process (i_clk, i_rst) 
    begin
        if (i_rst = '1') then
            got_x_reg <= false;
            got_y_reg <= false;
            got_mask_reg <= false;
            got_centr_x_reg <= false;
            
			point_x_reg <= 0; 
			point_y_reg <= 0; 
			centroid_x_reg <= 0;
			centroid_y_reg <= 0;
			
			in_mask_reg <= "00000000";
			out_mask_reg <= "00000000";
			
			address_reg <= "0000000000000001";
			centroid_bit_reg <= "00000001";
			
			min_dist_reg <= 510;
			centroid_dist_reg <= 0;
			
			state_reg <= IDLE;
        elsif (i_clk'event and i_clk='1') then
            o_done <= o_done_next;
            o_en <= o_en_next;
            o_we <= o_we_next;
            o_data <= o_data_next;
            o_address <= o_address_next;
            
            got_x_reg <= got_x_next;
            got_y_reg <= got_y_next;
            got_mask_reg <= got_mask_next;
            got_centr_x_reg <= got_centr_x_next;
            
			point_x_reg <= point_x_next; 
			point_y_reg <= point_y_next; 
			centroid_x_reg <= centroid_x_next;
			centroid_y_reg <= centroid_y_next;
			
			in_mask_reg <= in_mask_next;
			out_mask_reg <= out_mask_next;
			
			address_reg <= address_next;
			centroid_bit_reg <= centroid_bit_next;
			
			min_dist_reg <= min_dist_next;
			centroid_dist_reg <= centroid_dist_next;
			
            state_reg <= state_next;
        end if;
    end process;
    
    process(state_reg, i_data, i_start, point_x_reg, point_y_reg, centroid_x_reg, centroid_y_reg, 
		in_mask_reg, out_mask_reg, address_reg, centroid_bit_reg, min_dist_reg, centroid_dist_reg,
		got_x_reg, got_y_reg, got_mask_reg, got_centr_x_reg)
    begin
        o_done_next <= '0';
        o_en_next <= '0';
        o_we_next <= '0';
        o_data_next <= "00000000";
        o_address_next <= "0000000000000000";
        
        got_x_next <= got_x_reg;
        got_y_next <= got_y_reg;
        got_mask_next <= got_mask_reg;
        got_centr_x_next <= got_centr_x_reg;
        
        point_x_next <= point_x_reg; 
		point_y_next <= point_y_reg;
		centroid_x_next <= centroid_x_reg;
		centroid_y_next <= centroid_y_reg;
		
		in_mask_next <= in_mask_reg;
		out_mask_next <= out_mask_reg;
		
		address_next <= address_reg;
		centroid_bit_next <= centroid_bit_reg;
		
		min_dist_next <= min_dist_reg;
		centroid_dist_next <= centroid_dist_reg;
		
		state_next <= state_reg;
		
        case state_reg is
            when IDLE =>
                if (i_start = '1') then
                    state_next <= FETCH_CONST;
                end if;
                
            when FETCH_CONST =>
            	o_en_next <= '1';
				o_we_next <= '0';
				
                if (not got_x_reg) then
                    o_address_next <= "0000000000010001";
                elsif (not got_y_reg) then 
                    o_address_next <= "0000000000010010";
                else
                    o_address_next <= "0000000000000000";
                end if;
                
                state_next <= WAIT_RAM;
                
            when WAIT_RAM =>
                if (got_x_reg and got_y_reg and got_mask_reg) then
                    state_next <= GET_CENTROID;
                else 
                    state_next <= GET_CONST;
                end if;
                
            when GET_CONST =>
                if (not got_x_reg) then
                    point_x_next <= conv_integer(i_data);
                    got_x_next <= true;
                    
                    state_next <= FETCH_CONST;
                elsif (not got_y_reg) then 
                    point_y_next <= conv_integer(i_data);
                    got_y_next <= true;
                    
                    state_next <= FETCH_CONST;
                else
                    in_mask_next <= i_data;
                    got_mask_next <= true;
                    
                    state_next <= FETCH_NEXT;
                end if;
                
            when FETCH_NEXT =>
                if(in_mask_reg = "00000000") then
                    state_next <= WRITE_OUT;
                elsif ((in_mask_reg and "00000001") = "00000001") then
                    o_en_next <= '1';
                    o_we_next <= '0';
                    o_address_next <= address_reg;
                    
                    state_next <= WAIT_RAM;
                else
                    address_next <= address_reg + "0000000000000010";
                    centroid_bit_next <= std_logic_vector(shift_left(unsigned(centroid_bit_reg), 1));
                    
                    state_next <= FETCH_NEXT;
                end if;
                in_mask_next <= std_logic_vector(shift_right(unsigned(in_mask_reg), 1));
                
            when GET_CENTROID =>
                if (not got_centr_x_reg) then
                    centroid_x_next <= conv_integer(i_data);
                    got_centr_x_next <= true;
                    
                    o_en_next <= '1';
                    o_we_next <= '0';
                    o_address_next <= address_reg + "0000000000000001";
                
                    state_next <= WAIT_RAM;
                else 
                    centroid_y_next <= conv_integer(i_data);
                    got_centr_x_next <= false;
                    
                    state_next <= CALC_DIST;  
                end if;
                
            when CALC_DIST =>
                centroid_dist_next <= abs (point_x_reg - centroid_x_reg) + abs (point_y_reg - centroid_y_reg);
                
                state_next <= CHECK_DIST;
                
            when CHECK_DIST => 
                if (centroid_dist_reg < min_dist_reg) then
                    out_mask_next <= centroid_bit_reg;  
                    min_dist_next <= centroid_dist_reg;
                elsif (centroid_dist_reg = min_dist_reg) then
                    out_mask_next <= out_mask_reg + centroid_bit_reg;
                end if;
                
                address_next <= address_reg + "0000000000000010";
                centroid_bit_next <= std_logic_vector(shift_left(unsigned(centroid_bit_reg), 1));
                
                state_next <= FETCH_NEXT;
                
            when WRITE_OUT =>
                o_en_next <= '1';
                o_we_next <= '1';
                o_address_next <= "0000000000010011";
                o_data_next <= out_mask_reg;
                o_done_next <= '1';
                
                state_next <= DONE;
				
            when DONE =>
                if (i_start = '0') then
                    got_x_next <= false;
                    got_y_next <= false;
                    got_mask_next <= false;
                    got_centr_x_next <= false;
                
                    point_x_next <= 0; 
                    point_y_next <= 0; 
                    centroid_x_next <= 0;
                    centroid_y_next <= 0;
                    
                    in_mask_next <= "00000000";
                    out_mask_next <= "00000000";
                    
                    address_next <= "0000000000000001";
                    centroid_bit_next <= "00000001";
                    
                    min_dist_next <= 510;
                    centroid_dist_next <= 0;
					
                    state_next <= IDLE;
                end if;
        end case;
    end process;          
end Behavioral;
