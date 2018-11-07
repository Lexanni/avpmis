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

	signal a0, a1 			: std_logic;
	signal b0, b1, b2 		: std_logic;
	signal c0, c1, c2, c3 	: std_logic;
	signal d0, d1, d2, d3 	: std_logic;
	
	begin
		
		a0 <= n_G0 and n_P0;
		a1 <= n_G0 and (not Cn);
		
		b0 <= n_G1 and n_P1;
		b1 <= n_G0 and n_G1 and n_P0;
		b2 <= n_G0 and n_G1 and (not Cn);
		
		c0 <= n_G2 and n_P2;
		c1 <= n_G1 and n_G2 and n_P1;
		c2 <= n_G0 and n_G1 and n_G2 and n_P0;
		c3 <= n_G0 and n_G1 and n_G2 and (not Cn);
		
		d0 <= n_G3 and n_P3;
		d1 <= n_G3 and n_G2 and n_P2;
		d2 <= n_G1 and n_G2 and n_G3 and n_P1;
		d3 <= n_G0 and n_G1 and n_G2 and n_G3;
		
		Cn_x <= a0 nor a1;
		Cn_y <= not ((b0 or b1) or b2);
		Cn_z <= not ((c0 or c1) or (c2 or c3));
		
		n_G <= (d0 or d1) or (d2 or d3);
		n_P <= n_P0 or n_P1 or n_P2 or n_P3;
		
end lac_1