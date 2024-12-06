
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4x1 is
    Port ( S0 : in STD_LOGIC;
           S1 : in STD_LOGIC;
           D0 : in STD_LOGIC;
           D1 : in STD_LOGIC;
           D2 : in STD_LOGIC;
           D3 : in STD_LOGIC;
           Y : out STD_LOGIC);
end mux4x1;

architecture Behavioral of mux4x1 is
begin
    process (S0, S1, D0, D1, D2, D3)
    begin
        case (S1 & S0) is
            when "00" => Y <= D0;
            when "01" => Y <= D1;
            when "10" => Y <= D2;
            when "11" => Y <= D3;
            when others => Y <= '0';
        end case;
    end process;
end Behavioral;