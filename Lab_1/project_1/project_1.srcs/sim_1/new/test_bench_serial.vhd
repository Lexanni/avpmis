----------------------------------------------------------------------------------
-- Company: BSUIR
-- Engineer: Alexander Volchkov
-- 
-- Create Date: 27.09.2018 14:32:22
-- Design Name: 
-- Module Name: test_bench_serial - Behavioral
-- Project Name: Lab_1 (var 14)
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_bench_serial is
--  Port ( );
end test_bench_serial;

architecture Behavioral of test_bench_serial is
component look_ahead_carry_serial
  port (
    n_G0, n_G1, n_G2, n_G3 : in std_logic;
    n_P0, n_P1, n_P2, n_P3 : in std_logic;
    Cn 					   : in std_logic;
    Cn_x, Cn_y, Cn_z       : out std_logic;
    n_G, n_P               : out std_logic
  );
  end component;

  signal n_G0 : std_logic := '0';
  signal n_G1 : std_logic := '0';
  signal n_G2 : std_logic := '0';
  signal n_G3 : std_logic := '0';
  signal n_P0 : std_logic := '0';
  signal n_P1 : std_logic := '0';
  signal n_P2 : std_logic := '0';
  signal n_P3 : std_logic := '0';
  signal Cn   : std_logic := '0';
  signal Cn_x : std_logic := '0'; 
  signal Cn_y : std_logic := '0'; 
  signal Cn_z : std_logic := '0'; 
  signal n_G  : std_logic := '0'; 
  signal n_P  : std_logic := '0'; 

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

  n_G0 <= not n_G0 after 1 ns;
  n_G1 <= not n_G1 after 2 ns;
  n_G2 <= not n_G2 after 4 ns;
  n_G3 <= not n_G3 after 8 ns;
  n_P0 <= not n_P0 after 16 ns;
  n_P1 <= not n_P1 after 32 ns;
  n_P2 <= not n_P2 after 64 ns;
  n_P3 <= not n_P3 after 128 ns;
  Cn   <= not Cn   after 256 ns;


end Behavioral;

