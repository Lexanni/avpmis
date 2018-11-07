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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench_lab_1_from_file is
--  Port ( );
end testbench_lab_1_from_file;

architecture arch_1 of testbench_lab_1_from_file is
--file filedest : TEXT open WRITE_MODE is "test.txt";
--shared variable i : integer := 0;
--file test_file : text open READ_MODE is "test_set.txt";
component look_ahead_carry_serial
  port (
    n_G0, n_G1, n_G2, n_G3 : in std_logic;
    n_P0, n_P1, n_P2, n_P3 : in std_logic;
    Cn 					   : in std_logic;
    Cn_x, Cn_y, Cn_z       : out std_logic;
    n_G, n_P               : out std_logic
  );
  end component;

  signal n_G0    : std_logic                    := '0';
  signal n_G1    : std_logic                    := '0';
  signal n_G2    : std_logic                    := '0';
  signal n_G3    : std_logic                    := '0';
  signal n_P0    : std_logic                    := '0';
  signal n_P1    : std_logic                    := '0';
  signal n_P2    : std_logic                    := '0';
  signal n_P3    : std_logic                    := '0';
  signal Cn      : std_logic                    := '0';
  signal Cn_x    : std_logic                    := '0'; 
  signal Cn_y    : std_logic                    := '0'; 
  signal Cn_z    : std_logic                    := '0'; 
  signal n_G     : std_logic                    := '0'; 
  signal n_P     : std_logic                    := '0'; 
  signal ref_out : std_logic_vector(4 downto 0) := "00000";
  signal cur_out : std_logic_vector(4 downto 0) := "00000";
  
begin
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
		variable isFail   : boolean := false;
		
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
            
			wait for 1 ns;
			
			ref_out    <= buf(13 downto 9);
			cur_out(0) <= Cn_x;
			cur_out(1) <= Cn_y;
			cur_out(2) <= Cn_z;
			cur_out(3) <= n_G ;
			cur_out(4) <= n_P ;
			wait for 1 ns;     
			if not (cur_out = ref_out) then
				 report "Fail! Test fail at set " & integer'image(i);
				 isFail := true;
			end if;
			i := i + 1;
		end loop;  
		
		file_close(test_file);
		
		if not isFail then
			report "Test compleat succesfuly.";
		end if;
		
		wait;
   end process;

   --  n_G0 <= not n_G0 after 2            ns;
   --  n_G1 <= not n_G1 after 4            ns;
   --  n_G2 <= not n_G2 after 8            ns;
   --  n_G3 <= not n_G3 after 16           ns;
   --  n_P0 <= not n_P0 after 32           ns;
   --  n_P1 <= not n_P1 after 64           ns;
   --  n_P2 <= not n_P2 after 128          ns;
   --  n_P3 <= not n_P3 after 256          ns;
   --  Cn   <= not Cn   after 512          ns;
   
   --   process
   --        variable current_line : line;
   --        variable v            : std_logic_vector(13 downto 0);
   --        variable i            : integer := 0;
   --   begin
   --        if i = 0 then            
   --            wait for 1 ns;
   --        else 
   --            wait for 2 ns;
   --        end if;
               
   --        v(0)  :=  n_G0;
   --        v(1)  :=  n_G1;
   --        v(2)  :=  n_G2;
   --        v(3)  :=  n_G3;
   --        v(4)  :=  n_P0;
   --        v(5)  :=  n_P1;
   --        v(6)  :=  n_P2;
   --        v(7)  :=  n_P3;
   --        v(8)  :=  Cn  ;
   --        v(9 ) :=  Cn_x;
   --        v(10) :=  Cn_y;
   --        v(11) :=  Cn_z;
   --        v(12) :=  n_G ;
   --        v(13) :=  n_P ;
           
   --        if i < 513 then
   --          write(current_line, v, right, 14);
   --          writeline(filedest, current_line);
   --        end if;
   --        i := i + 1;
   --   end process;

end arch_1;
