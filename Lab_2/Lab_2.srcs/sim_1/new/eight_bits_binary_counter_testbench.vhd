----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.10.2018 11:44:29
-- Design Name: 
-- Module Name: eight_bits_binary_counter_testbench - arch_1
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

entity eight_bits_binary_counter_testbench is
--  Port ( );
end eight_bits_binary_counter_testbench;

architecture arch_1 of eight_bits_binary_counter_testbench is
component eight_bits_binary_counter 
     Port (
          A, B, C, D, E, F, G, H          : in  std_logic;
          CCLR, CCKEN, CCK, CLOAD, RCK    : in  std_logic;
          RCO                             : out std_logic;
          vRS_out                         : out std_logic_vector (7 downto 0)
     );
end component;
    signal vec   : std_logic_vector (7 downto 0) := X"f1";
    signal CCLR  : std_logic := '1';
    signal CCKEN : std_logic := '1';
    signal CCK   : std_logic := '0';
    signal CLOAD : std_logic := '1';
    signal RCK   : std_logic := '0';
    signal RCO   : std_logic;
    signal vRS_out : std_logic_vector (7 downto 0);
begin
    ebbc: eight_bits_binary_counter 
    port map (
        A => vec(0),
        B => vec(1),
        C => vec(2),
        D => vec(3),
        E => vec(4),
        F => vec(5),
        G => vec(6),
        H => vec(7),
        CCLR => CCLR,
        CCKEN => CCKEN,
        CCK => CCK,
        CLOAD => CLOAD,
        RCK => RCK,
        RCO => RCO, 
        vRS_out => vRS_out
    );
    
    CCK <= not CCK after 2 ns;
    process
    begin
    wait for 5 ns;
        RCK <= '1';
    wait for 4 ns;
        RCK <= '0';
    wait for 4 ns;
        CLOAD <= '0';
    wait for 8 ns;
        CLOAD <= '1';
    wait for 8 ns;
        CCKEN <= '0';
    wait for 100 ns;
        vec <= X"CC";
        RCK <= '1';
    wait for 4 ns;
        RCK <= '0';
    wait for 4 ns;
        CLOAD <= '0';
    wait for 4 ns;
        CLOAD <= '1';
    wait for 16 ns;
        CCLR <= '0';
    wait for 4 ns;
        CCLR <= '1';
    wait;
    end process;
    
end arch_1;
