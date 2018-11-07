----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2018 14:46:27
-- Design Name: 
-- Module Name: eight_bits_binary_counter - arch_1
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

entity eight_bits_binary_counter is
  Port (
        A, B, C, D, E, F, G, H          : in  std_logic;
        CCLR, CCKEN, CCK, CLOAD, RCK    : in  std_logic;
        RCO                             : out std_logic;
        vRS_out                         : out std_logic_vector (7 downto 0)
   );
end eight_bits_binary_counter;

architecture arch_1 of eight_bits_binary_counter is
  component jk_trigger
  Port (
      C, R, S, J, K   : in std_logic;
      Q, nQ           : out std_logic
  );
end component;
  signal vD_Q   : std_logic_vector (7 downto 0);
  signal vD_nQ  : std_logic_vector (7 downto 0);
  signal vRS_Q  : std_logic_vector (7 downto 0);
  signal vRS_nQ : std_logic_vector (7 downto 0);
  signal vCR    : std_logic_vector (6 downto 0);
  signal vR_in  : std_logic_vector (7 downto 0);
  signal vS_in  : std_logic_vector (7 downto 0);
  signal SH_CLK : std_logic;
  signal VCC : std_logic := '1';
  signal GND : std_logic := '0';
begin

D0 : jk_trigger port map (RCK, VCC, VCC, A, not A, vD_Q(0), vD_nQ(0));
D1 : jk_trigger port map (RCK, VCC, VCC, B, not B, vD_Q(1), vD_nQ(1));
D2 : jk_trigger port map (RCK, VCC, VCC, C, not C, vD_Q(2), vD_nQ(2));
D3 : jk_trigger port map (RCK, VCC, VCC, D, not D, vD_Q(3), vD_nQ(3));
D4 : jk_trigger port map (RCK, VCC, VCC, E, not E, vD_Q(4), vD_nQ(4));
D5 : jk_trigger port map (RCK, VCC, VCC, F, not F, vD_Q(5), vD_nQ(5));
D6 : jk_trigger port map (RCK, VCC, VCC, G, not G, vD_Q(6), vD_nQ(6));
D7 : jk_trigger port map (RCK, VCC, VCC, H, not H, vD_Q(7), vD_nQ(7));


vR_in(0) <= (CCLR and not (not CLOAD and vD_nQ(0)));
vR_in(1) <= (CCLR and not (not CLOAD and vD_nQ(1)));
vR_in(2) <= (CCLR and not (not CLOAD and vD_nQ(2)));
vR_in(3) <= (CCLR and not (not CLOAD and vD_nQ(3)));
vR_in(4) <= (CCLR and not (not CLOAD and vD_nQ(4)));
vR_in(5) <= (CCLR and not (not CLOAD and vD_nQ(5)));
vR_in(6) <= (CCLR and not (not CLOAD and vD_nQ(6)));
vR_in(7) <= (CCLR and not (not CLOAD and vD_nQ(7)));

vS_in(0) <= not (not CLOAD and vD_Q(0));
vS_in(1) <= not (not CLOAD and vD_Q(1));
vS_in(2) <= not (not CLOAD and vD_Q(2));
vS_in(3) <= not (not CLOAD and vD_Q(3));
vS_in(4) <= not (not CLOAD and vD_Q(4));
vS_in(5) <= not (not CLOAD and vD_Q(5));
vS_in(6) <= not (not CLOAD and vD_Q(6));
vS_in(7) <= not (not CLOAD and vD_Q(7));

RS0 : jk_trigger port map (not SH_CLK   , vR_in(0) , vS_in(0), VCC, VCC, vRS_Q(0), vRS_nQ(0));
RS1 : jk_trigger port map (not vCR(0)   , vR_in(1) , vS_in(1), VCC, VCC, vRS_Q(1), vRS_nQ(1));
RS2 : jk_trigger port map (not vCR(1)   , vR_in(2) , vS_in(2), VCC, VCC, vRS_Q(2), vRS_nQ(2));
RS3 : jk_trigger port map (not vCR(2)   , vR_in(3) , vS_in(3), VCC, VCC, vRS_Q(3), vRS_nQ(3));
RS4 : jk_trigger port map (not vCR(3)   , vR_in(4) , vS_in(4), VCC, VCC, vRS_Q(4), vRS_nQ(4));
RS5 : jk_trigger port map (not vCR(4)   , vR_in(5) , vS_in(5), VCC, VCC, vRS_Q(5), vRS_nQ(5));
RS6 : jk_trigger port map (not vCR(5)   , vR_in(6) , vS_in(6), VCC, VCC, vRS_Q(6), vRS_nQ(6));
RS7 : jk_trigger port map (not vCR(6)   , vR_in(7) , vS_in(7), VCC, VCC, vRS_Q(7), vRS_nQ(7));

vCR(0) <=   (SH_CLK and vRS_Q(0));
vCR(1) <=   (SH_CLK and vRS_Q(0)) and  vRS_Q(1);
vCR(2) <=   (SH_CLK and vRS_Q(0)) and (vRS_Q(1) and vRS_Q(2));
vCR(3) <=   (SH_CLK and vRS_Q(0)) and (vRS_Q(1) and vRS_Q(2))  and   vRS_Q(3);
vCR(4) <=   (SH_CLK and vRS_Q(0)) and (vRS_Q(1) and vRS_Q(2))  and ( vRS_Q(3) and vRS_Q(4));
vCR(5) <=  ((SH_CLK and vRS_Q(0)) and (vRS_Q(1) and vRS_Q(2))) and ((vRS_Q(3) and vRS_Q(4)) and  vRS_Q(5));    
vCR(6) <=  ((SH_CLK and vRS_Q(0)) and (vRS_Q(1) and vRS_Q(2))) and ((vRS_Q(3) and vRS_Q(4)) and (vRS_Q(5) and vRS_Q(6)));
    
RCO <= not (((vRS_Q(0) and vRS_Q(1)) and (vRS_Q(2) and vRS_Q(3))) and ((vRS_Q(4) and vRS_Q(5)) and (vRS_Q(6) and vRS_Q(7))));    
SH_CLK <= not (CCK and not CCKEN);
vRS_out <= vRS_Q;

end arch_1;
