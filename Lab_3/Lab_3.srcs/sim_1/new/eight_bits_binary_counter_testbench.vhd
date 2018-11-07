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
use IEEE.NUMERIC_STD.ALL;

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
    signal in_word   : std_logic_vector (7 downto 0) := X"ff";
    signal CCLR      : std_logic := '0';
    signal CCKEN     : std_logic := '0';
    signal CCK       : std_logic := '0';
    signal CLOAD     : std_logic := '1';
    signal RCK       : std_logic := '0';
    signal RCO       : std_logic;
    signal vRS_out   : std_logic_vector (7 downto 0);
    signal tmp_word  : std_logic_vector (7 downto 0);
begin
    ebbc: eight_bits_binary_counter 
    port map (
        A => in_word(0),
        B => in_word(1),
        C => in_word(2),
        D => in_word(3),
        E => in_word(4),
        F => in_word(5),
        G => in_word(6),
        H => in_word(7),
        CCLR => CCLR,
        CCKEN => CCKEN,
        CCK => CCK,
        CLOAD => CLOAD,
        RCK => RCK,
        RCO => RCO, 
        vRS_out => vRS_out
    );
    
    process
        variable i : integer range 0 to 255;
        variable j : integer;
        variable v : std_logic_vector (2 downto 0);
    begin
    in_word <= X"ff";
    wait for 5 ns;
    i := 255;
    while (i >= 0) loop
       CCLR <= '0';
       wait for 1 ns;
           if (not (vRS_out = x"00" and RCO = '1')) then 
              report "Clear fail when CCLR down at iteration " & integer'image(i);
              exit;
           end if;
       CCLR <= '1';
       in_word <= std_logic_vector(to_unsigned(i, in_word'length));
       wait for 1 ns;
           if (not (vRS_out = x"00" and RCO = '1')) then 
              report "Clear don't save when CCLR up at iteration " & integer'image(i);
              exit;
           end if;
       RCK <= '1';
       wait for 1 ns;
           if (not (vRS_out = x"00" and RCO = '1')) then 
              report "Register vRS_out change value when RCK up at iteration " & integer'image(i);
              exit;
           end if;
       CLOAD <= '0';
       wait for 1 ns;
           if (not (vRS_out = in_word and ((in_word = x"ff" and RCO = '0') or (not (in_word = x"ff") and RCO = '1')))) then 
              report "Loading into register vRS_out fail when CLOAD down at iteration " & integer'image(i);
              exit;
           end if;
       tmp_word <= in_word;
       in_word  <= not std_logic_vector(to_unsigned(i, in_word'length));
       wait for 1 ns;
           if (not (vRS_out = tmp_word and ((tmp_word = x"ff" and RCO = '0') or (not (tmp_word = x"ff") and RCO = '1')))) then 
              report "Fail! Register vRs_out change state when in_word changes at iteration " & integer'image(i);
              exit;
           end if;
       RCK <= '0';
       wait for 1 ns;
           if (not (vRS_out = tmp_word and ((tmp_word = x"ff" and RCO = '0') or (not (tmp_word = x"ff") and RCO = '1')))) then 
              report "Fail! Register vRs_out change state when RCK down at iteration " & integer'image(i);
              exit;
           end if;
       RCK <= '1';
       wait for 1 ns;
           if (not (vRS_out = in_word and ((in_word = x"ff" and RCO = '0') or (not (in_word = x"ff") and RCO = '1')))) then
              report "Fail loading in_word into register vRs_out at iteration " & integer'image(i);   
              report "Probably loading into vRS_out is not asynchronous."; 
              exit;
           end if;
       CCK <= '1';
       wait for 1 ns;
           if (not (vRS_out = in_word and ((in_word = x"ff" and RCO = '0') or (not (in_word = x"ff") and RCO = '1')))) then 
              report "Fail! Register vRS_out or RCO change state when CCK up at CLOAD low at iteration " & integer'image(i);
              exit;                         
           end if;
       CCK <= '0';
       wait for 1 ns;
           if (not (vRS_out = in_word and ((in_word = x"ff" and RCO = '0') or (not (in_word = x"ff") and RCO = '1')))) then
              report "Fail! Register vRS_out or RCO change state when CCK down at CLOAD low at iteration " & integer'image(i);
              exit;
           end if;
       CCKEN <= '1';
       wait for 1 ns;
           if (not (vRS_out = in_word and ((in_word = x"ff" and RCO = '0') or (not (in_word = x"ff") and RCO = '1')))) then
              report "Fail! Register vRS_out or RCO change state when CCKEN up at CLOAD low and CCK low at iteration " & integer'image(i);
              exit;
           end if;
       CCK <= '1';
       wait for 1 ns;
           if (not (vRS_out = in_word and ((in_word = x"ff" and RCO = '0') or (not (in_word = x"ff") and RCO = '1')))) then                                                                                              
              report "Fail! Register vRS_out or RCO change state when CCK up at CLOAD low and CCKEN heigh at iteration " & integer'image(i);                                                                                                 
              exit;
           end if;
       CCK <= '0';
       wait for 1 ns;
           if (not (vRS_out = in_word and ((in_word = x"ff" and RCO = '0') or (not (in_word = x"ff") and RCO = '1')))) then
              report "Fail! Register vRS_out or RCO change state when CCK down at CLOAD low and CCKEN heigh at iteration " & integer'image(i);
              exit;
           end if;
       CCKEN <= '0';
       wait for 1 ns;
           if (not (vRS_out = in_word and ((in_word = x"ff" and RCO = '0') or (not (in_word = x"ff") and RCO = '1')))) then
              report "Fail! Register vRS_out or RCO change state when CCKEN down at CLOAD low and CCK low at iteration " & integer'image(i);                                                                                                
              exit;
           end if;
       CCK <= '1';
       wait for 1 ns;
       CCKEN <= '1';
       wait for 1 ns;
            if (not (vRS_out = in_word and ((in_word = x"ff" and RCO = '0') or (not (in_word = x"ff") and RCO = '1')))) then 
               report "Fail! Register vRS_out or RCO change state when CCKEN up at CLOAD low and CCK high at iteration " & integer'image(i); 
               exit;
            end if;                                                                                                                                                                                                                 
       CCKEN <= '0';
       wait for 1 ns;
            if (not (vRS_out = in_word and ((in_word = x"ff" and RCO = '0') or (not (in_word = x"ff") and RCO = '1')))) then                 
               report "Fail! Register vRS_out or RCO change state when CCKEN down at CLOAD low and CCK high at iteration " & integer'image(i);
               exit;
            end if;
       CLOAD <= '1';
       wait for 1 ns;
            if (not (vRS_out = in_word and ((in_word = x"ff" and RCO = '0') or (not (in_word = x"ff") and RCO = '1')))) then               
               report "Fail! Register vRS_out or RCO change state when CLOAD up at iteration " & integer'image(i);
               exit;
            end if;
       CCK <= '0';
       wait for 1 ns;
            if (not (vRS_out = in_word and ((in_word = x"ff" and RCO = '0') or (not (in_word = x"ff") and RCO = '1')))) then 
               report "Fail! Register vRS_out or RCO change state when CCK down at iteration " & integer'image(i);             
               exit;
            end if;
       CCK <= '1';
       tmp_word <= std_logic_vector(to_unsigned(255 - i + 1, tmp_word'length));
       wait for 1 ns;
            if (not (vRS_out = tmp_word and ((tmp_word = x"ff" and RCO = '0') or (not (tmp_word = x"ff") and RCO = '1')))) then                                                                                           
               report "Fail! Register vRS_out or RCO incorrect change state when first time CCK up at iteration " & integer'image(i);              
               exit;
            end if;
       CCK <= '0';
       wait for 1 ns;
            if (not (vRS_out = tmp_word and ((tmp_word = x"ff" and RCO = '0') or (not (tmp_word = x"ff") and RCO = '1')))) then                                                                                           
               report "Fail! Register vRS_out or RCO change state when second time CCK down at iteration " & integer'image(i);              
               exit;
            end if;
       CCK <= '1';
       tmp_word <= std_logic_vector(to_unsigned(255 - i + 2, tmp_word'length));
       wait for 1 ns;
            if (not (vRS_out = tmp_word and ((tmp_word = x"ff" and RCO = '0') or (not (tmp_word = x"ff") and RCO = '1')))) then                                                                                                
               report "Fail! Register vRS_out or RCO incorrect change state when second time CCK up at iteration " & integer'image(i);     
               exit;
            end if;
       CCKEN <= '1';
       wait for 1 ns;
             if (not (vRS_out = tmp_word and ((tmp_word = x"ff" and RCO = '0') or (not (tmp_word = x"ff") and RCO = '1')))) then                                                                                                                                                                                                                                    
                report "Fail! Register vRS_out or RCO change state when CCKEN up at iteration " & integer'image(i);                                                                                                 
                exit;
             end if;
       tmp_word <= std_logic_vector(to_unsigned(255 - i + 3, tmp_word'length));
       CCKEN <= '0';
       wait for 1 ns;
             if (not (vRS_out = tmp_word and ((tmp_word = x"ff" and RCO = '0') or (not (tmp_word = x"ff") and RCO = '1')))) then                                                                                                                                                                                                                                    
                report "Fail! Register vRS_out or RCO incorrect change state when CCKEN down at CCK high at iteration " & integer'image(i);                                                                                                 
                exit;
             end if;
       j := 0;
       while (j < 8) loop
           v := std_logic_vector(to_unsigned(j, v'length));
           RCK   <= v(0);
           CCK   <= v(1);
           CCKEN <= v(2);
           CCLR  <= '1';
           wait for 1 ns;
           CLOAD <= '0';
           wait for 1 ns;
           CLOAD <= '1';
           wait for 1 ns;
           CCLR <= '0';
           wait for 1 ns;
           if (not (vRS_out = x"00" and RCO = '1')) then 
              report "Clear fail in internal loop at iteration external at " & integer'image(i);
              report "RCK = " & std_logic'image(RCK);
              report "CCK = " & std_logic'image(CCK);
              report "CCKEN = " & std_logic'image(CCKEN);
              exit;
           end if;
           j := j + 1;
       end loop;
       
       CCLR  <= '0';
       CCKEN <= '0';
       CCK   <= '0';
       CLOAD <= '1';
       RCK   <= '0';
       
       i := i - 1;                                                                                                                   
    end loop;
       
    wait;
    end process;
    
end arch_1;
