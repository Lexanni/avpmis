----------------------------------------------------------------------------------
-- Company: BSUIR
-- Engineer: Alexander Volchkov
-- 
-- Create Date: 27.09.2018 14:32:22
-- Design Name: 
-- Module Name: test_bench_serial - Behavioral
-- Project Name: Lab_3 (var 14)
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_textio.ALL;
use std.textio.ALL;

entity testbench_lab_1_etalon is
--  Port ( );
end testbench_lab_1_etalon;

architecture arch_1 of testbench_lab_1_etalon is
component look_ahead_carry_serial
  port (
    n_G0, n_G1, n_G2, n_G3 : in std_logic;
    n_P0, n_P1, n_P2, n_P3 : in std_logic;
    Cn 					   : in std_logic;
    Cn_x, Cn_y, Cn_z       : out std_logic;
    n_G, n_P               : out std_logic
  );
  end component;
  component look_ahead_carry
  port (
    n_G0, n_G1, n_G2, n_G3 : in std_logic;
    n_P0, n_P1, n_P2, n_P3 : in std_logic;
    Cn                      : in std_logic;
    
    Cn_x, Cn_y, Cn_z       : out std_logic;
    n_G, n_P               : out std_logic
  );
  end component;

  signal n_G0       : std_logic  := '0';
  signal n_G1       : std_logic  := '0';
  signal n_G2       : std_logic  := '0';
  signal n_G3       : std_logic  := '0';
  signal n_P0       : std_logic  := '0';
  signal n_P1       : std_logic  := '0';
  signal n_P2       : std_logic  := '0';
  signal n_P3       : std_logic  := '0';
  signal Cn         : std_logic  := '0';
  signal Cn_x       : std_logic  := '0'; 
  signal Cn_y       : std_logic  := '0'; 
  signal Cn_z       : std_logic  := '0'; 
  signal n_G        : std_logic  := '0'; 
  signal n_P        : std_logic  := '0';
  signal et_n_G0    : std_logic  := '0';
  signal et_n_G1    : std_logic  := '0';
  signal et_n_G2    : std_logic  := '0';
  signal et_n_G3    : std_logic  := '0';
  signal et_n_P0    : std_logic  := '0';
  signal et_n_P1    : std_logic  := '0';
  signal et_n_P2    : std_logic  := '0';
  signal et_n_P3    : std_logic  := '0';
  signal et_Cn      : std_logic  := '0';
  signal et_Cn_x    : std_logic  := '0'; 
  signal et_Cn_y    : std_logic  := '0'; 
  signal et_Cn_z    : std_logic  := '0'; 
  signal et_n_G     : std_logic  := '0'; 
  signal et_n_P     : std_logic  := '0';  
  
  signal etalon_out : std_logic_vector(4 downto 0) := "00000";
  signal cur_out    : std_logic_vector(4 downto 0) := "00000";
  
begin
  etalon: look_ahead_carry port map ( 
                                   n_G0 => et_n_G0,
                                   n_G1 => et_n_G1,
                                   n_G2 => et_n_G2,
                                   n_G3 => et_n_G3,
                                   n_P0 => et_n_P0,
                                   n_P1 => et_n_P1,
                                   n_P2 => et_n_P2,
                                   n_P3 => et_n_P3,
                                   Cn   => et_Cn,
                                   Cn_x => et_Cn_x,
                                   Cn_y => et_Cn_y,
                                   Cn_z => et_Cn_z,
                                   n_G  => et_n_G,
                                   n_P  => et_n_P );
  uut: look_ahead_carry_serial port map ( 
                                   n_G0 => n_G0,
                                   n_G1 => n_G1,
                                   n_G2 => n_G2,
                                   n_G3 => n_G3,
                                   n_P0 => n_P0,
                                   n_P1 => n_P1,
                                   n_P2 => n_P2,
                                   n_P3 => n_P3,
                                   Cn   => Cn,
                                   Cn_x => Cn_x,
                                   Cn_y => Cn_y,
                                   Cn_z => Cn_z,
                                   n_G  => n_G,
                                   n_P  => n_P );

   process
		file     test_file    : text;
		variable current_line : line;
		variable buf          : std_logic_vector(13 downto 0);
		variable i            : integer := 1;
		variable isSuccessed  : boolean := true;
		
   begin			
		file_open(test_file, "test_set.txt", READ_MODE);
		while not endfile(test_file) loop		
			readline(test_file, current_line);
			read(current_line, buf);
			wait for 1 ns;
            n_G0     <= buf(0);
            n_G1     <= buf(1);
            n_G2     <= buf(2);
            n_G3     <= buf(3);
            n_P0     <= buf(4);
            n_P1     <= buf(5);
            n_P2     <= buf(6);
            n_P3     <= buf(7);
            Cn       <= buf(8);
            
            et_n_G0     <= buf(0);
            et_n_G1     <= buf(1);
            et_n_G2     <= buf(2);
            et_n_G3     <= buf(3);
            et_n_P0     <= buf(4);
            et_n_P1     <= buf(5);
            et_n_P2     <= buf(6);
            et_n_P3     <= buf(7);
            et_Cn       <= buf(8);
            
			wait for 1 ns;
			
			cur_out(0) <= Cn_x;
			cur_out(1) <= Cn_y;
			cur_out(2) <= Cn_z;
			cur_out(3) <= n_G ;
			cur_out(4) <= n_P ;
			
			etalon_out(0) <= et_Cn_x;
            etalon_out(1) <= et_Cn_y;
            etalon_out(2) <= et_Cn_z;
            etalon_out(3) <= et_n_G ;
            etalon_out(4) <= et_n_P ;
			
			wait for 1 ns; 
			    
			if not (cur_out = etalon_out) then
				 report "Fail! Test fail at set " & integer'image(i);
				 isSuccessed := false;
			end if;
			i := i + 1;
		end loop;  
		
		file_close(test_file);
		
		if isSuccessed then
			report "Test completed successfully.";
		end if;
		
		wait;
   end process;

end arch_1;
