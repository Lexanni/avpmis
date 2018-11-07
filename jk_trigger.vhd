----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2018 14:50:00
-- Design Name: 
-- Module Name: jk_trigger - arch_1
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

entity jk_trigger is
  Port (
        C, R, S, J, K   : in std_logic;
        Q, nQ           : out std_logic
  );
end jk_trigger;

architecture arch_1 of jk_trigger is
    signal sig_Q, sig_nQ : std_logic;
    begin
    process(C, R, S)
    begin
        if(R = '0' and S = '0') then
            sig_Q  <= 'X';
            sig_nQ <= 'X';
        elsif (R = '0') then
            sig_Q  <= '0';
            sig_nQ <= '1';
        elsif (S = '0') then
            sig_Q  <= '1';
            sig_nQ <= '0';
        elsif (C'event and C = '1') then
            if (J = '1' and K = '1') then
                sig_Q  <= not sig_Q;
                sig_nQ <= not sig_nQ;
            elsif (J = '1') then
                sig_Q <= '1';
                sig_nQ <= '0';
            elsif (K = '1') then
                sig_Q <= '0';
                sig_nQ <= '1';
            end if;
        end if;
            
    end process;
    Q <= sig_Q;
    nQ <= sig_nQ;
end arch_1;