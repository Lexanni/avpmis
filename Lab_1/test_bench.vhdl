VHDL Testbench
No reset code was detected. This may be because no architecture was supplied or because a supplied architecture does not contain code such as:

if Reset = '1' then
 . . . .
elsif rising_edge( Clock ) then
 . . . .
No clock code was detected. This may be because no architecture was supplied or because a supplied architecture does not contain code such as:

rising_edge( clock ) then
-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity look_ahead_carry_tb is
end;

architecture bench of look_ahead_carry_tb is

  component look_ahead_carry
  port (
    n_G0, n_G1, n_G2, n_G3 : in std_logic;
    n_P0, n_P1, n_P2, n_P3 : in std_logic;
    Cn 					 : in std_logic;
    Cn_x, Cn_y, Cn_z       : out std_logic;
    n_G, n_P               : out std_logic
  );
  end component;

  signal n_G0, n_G1, n_G2, n_G3: std_logic;
  signal n_P0, n_P1, n_P2, n_P3: std_logic;
  signal Cn: std_logic;
  signal Cn_x, Cn_y, Cn_z: std_logic;
  signal n_G, n_P: std_logic ;

begin

  uut: look_ahead_carry port map ( n_G0 => n_G0,
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

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    wait;
  end process;


end;
  
Configuration Declaration
-- Test bench configuration created online at:
--    www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

configuration cfg_look_ahead_carry_tb of look_ahead_carry_tb is
  for bench
    for uut: look_ahead_carry
      -- Default configuration
    end for;
  end for;
end cfg_look_ahead_carry_tb;

configuration cfg_look_ahead_carry_tb_lac_1 of look_ahead_carry_tb is
  for bench
    for uut: look_ahead_carry
      use entity work.look_ahead_carry(lac_1);
    end for;
  end for;
end cfg_look_ahead_carry_tb_lac_1;