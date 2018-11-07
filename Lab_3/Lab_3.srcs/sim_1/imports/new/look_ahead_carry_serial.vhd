----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/29/2016 08:09:41 PM
-- Design Name: 
-- Module Name: look_ahead_carry_serial - Behavioral
-- Project Name: 
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

entity look_ahead_carry_serial is
port (
  n_G0, n_G1, n_G2, n_G3 : in std_logic;
  n_P0, n_P1, n_P2, n_P3 : in std_logic;
  Cn 					 : in std_logic;
  
  Cn_x, Cn_y, Cn_z       : out std_logic;
  n_G, n_P               : out std_logic
);
end look_ahead_carry_serial;

architecture Behavioral_serial of look_ahead_carry_serial is
begin
process (n_G0, n_G1, n_G2, n_G3, n_P0, n_P1, n_P2, n_P3, Cn)
begin
    if (n_G3 and n_P3) = '1' then
        n_G <= '1';
    elsif (n_G3 and n_G2 and n_P2) = '1' then
        n_G <= '1';
    elsif ((n_G3 and n_G2) and (n_G1 and n_P1)) = '1' then
        n_G <= '1';
    elsif ((n_G3 and n_G2) and (n_G1 and n_G0)) = '1' then
        n_G <= '1';
    else
        n_G <= '0';         
    end if; 

    if ((not n_P3 and not n_P2) and (not n_P1 and not n_P0)) = '1' then
        n_P <= '0';
    else
        n_P <= '1';  
    end if;  

    if ((not n_G0) or (not n_P0 and Cn)) = '1' then
        Cn_X <= '1';
    else
        Cn_X <= '0';
    end if;

    if (not n_G1) = '1' then
        Cn_y <= '1';
    elsif (not n_G0 and not n_P1) = '1' then
        Cn_y <= '1';
    elsif (not n_P1 and not n_P0 and Cn) = '1' then
        Cn_y <= '1';
    else
        Cn_y <= '0';
    end if;

    if (not n_G2) = '1' then
        Cn_z <= '1';
    elsif (not n_G1 and not n_P2) = '1' then
        Cn_z <= '1';
    elsif (not n_G0 and not n_P2 and not n_P1) = '1' then
        Cn_z <= '1';
    elsif (not n_P2 and not n_P1 and not n_P0 and Cn) = '1' then
        Cn_z <= '1';
    else
        Cn_z <= '0';
    end if;
end process;
end Behavioral_serial;
