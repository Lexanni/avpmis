----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2018 16:29:15
-- Design Name: 
-- Module Name: jk_trigger_testbench - arch_1
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

entity jk_trigger_testbench is
--  Port ( );
end jk_trigger_testbench;

architecture arch_1 of jk_trigger_testbench is
  component jk_trigger
  Port (
      C, R, S, J, K   : in std_logic;
      Q, nQ           : out std_logic
  );
  end component;
  
  signal C : std_logic := '0';
  signal R : std_logic := '1';
  signal S : std_logic := '1';
  signal J : std_logic := '0';
  signal K : std_logic := '0';
  signal Q : std_logic;
  signal nQ : std_logic;
  
  begin
  uut : jk_trigger port map (
      C => C,
      R => R,
      S => S,
      J => J,
      K => K,
      Q => Q,
      nQ => nQ  
  );
  
  C <= not C after 2  ns;
  
  process
  begin
        wait for 3 ns;
            J <= '1';
        wait for 4 ns;
            J <= '0';
            K <= '1';
        wait for 4 ns;
            J <= '1';
            K <= '1';
        wait for 12 ns;
            J <= '0';
            K <= '0';
    wait for 4 ns;
        R <= '0';
        wait for 3 ns;  
            J <= '1';   
        wait for 4 ns;  
            J <= '0';   
            K <= '1';   
        wait for 4 ns;  
            J <= '1';   
            K <= '1';   
        wait for 12 ns; 
            J <= '0';   
            K <= '0';
    wait for 3 ns;
         R <= '1';
         wait for 2 ns;  
             J <= '1';   
         wait for 4 ns;  
             J <= '0';   
             K <= '1';   
         wait for 4 ns;  
             J <= '1';   
             K <= '1';   
         wait for 16 ns; 
             J <= '0';   
             K <= '0';
     wait for 4 ns;
         S <= '0';
         wait for 4 ns;  
             J <= '1';   
         wait for 4 ns;  
             J <= '0';   
             K <= '1';   
         wait for 4 ns;  
             J <= '1';   
             K <= '1';   
         wait for 12 ns; 
             J <= '0';   
             K <= '0';
     wait for 4 ns;
          S <= '1';
     wait for 2 ns;
          R <= '0';
     wait for 2 ns;
          R <= '1';
          wait for 4 ns;  
              J <= '1';   
          wait for 4 ns;  
              J <= '0';   
              K <= '1';   
          wait for 4 ns;  
              J <= '1';   
              K <= '1';   
          wait for 12 ns; 
              J <= '0';   
              K <= '0';
     wait for 4 ns;
           S <= '0';
           R <= '0';
           wait for 3 ns;  
               J <= '1';   
           wait for 4 ns;  
               J <= '0';   
               K <= '1';   
           wait for 4 ns;  
               J <= '1';   
               K <= '1';   
           wait for 12 ns; 
               J <= '0';   
               K <= '0';
    wait;
  end process;
        
        
end arch_1;
        