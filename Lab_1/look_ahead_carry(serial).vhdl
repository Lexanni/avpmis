library IEEE;
use IEEE.std_logic_1164.all;

entity look_ahead_carry is
port (
  n_G0, n_G1, n_G2, n_G3 : in std_logic;
  n_P0, n_P1, n_P2, n_P3 : in std_logic;
  Cn 					 : in std_logic;
  
  Cn_x, Cn_y, Cn_z       : out std_logic;
  n_G, n_P               : out std_logic;
);
end look_ahead_carry

architecture lac_1 of look_ahead_carry is

	proc_n_G: 
	process (n_G3, n_G2, n_G1, n_P2, n_P1, n_P0)
	begin
		if (not n_G3) then
			n_G0 <= '0';
		elsif (not n_G2 and not n_P2) then
			n_G0 <= '0';
		elsif (not n_G1 and not n_P2 and not n_P1) then
			n_G0 <= '0';
		elsif (not n_P3 and not n_P2 and not n_P1 and not n_P0) then
			n_G0 <= '0';
		else
			n_G0 <= '1';			
	end process
	
	proc_n_P:
	process (n_P3, n_P2, n_P1, n_P0)
	begin
		if (not n_P3 and not n_P2 and not n_P1 and not n_P0) then
			n_P <= '0';
		else
			n_P <= '1';	
	end process
	
	proc_Cn_x:
	process (n_G0, n_P0, Cn)
	begin
		if (not n_G0) or (not n_P0 and Cn) then
			Cn_X <= '1';
		else
			Cn_X <= '0';
	end process
	
	proc_Cn_y:
	process (n_G1, n_G0, n_P1, n_P0, Cn)
	begin
		if (not n_G1) then
			Cn_y <= '1';
		elsif (not n_G0 and not n_P1) then
			Cn_y <= '1';
		elsif (not n_P1 and not n_P0 and Cn) then
			Cn_y <= '1';
		else
			Cn_y <= '0';
	end process
	
	proc_Cn_z:
	process (n_G2, n_G1, n_G0, n_P2, n_P1, n_P0, Cn)
	begin
		if (not n_G2) then
			Cn_z <= '1';
		elsif (not n_G1 and not n_P2) then
			Cn_3 <= '1';
		elsif (not n_G0 and not n_P2 and not n_P1) then
			Cn_3 <= '1';
		elsif (not n_P2 and not n_P1 and not n_P0 and Cn) then
			Cn_3 <= '1';
		else
			Cn_3 <= '0';
	end process
	
		
end lac_1