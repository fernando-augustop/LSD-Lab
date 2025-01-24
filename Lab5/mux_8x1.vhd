
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_8x1 is
    Port ( S : in STD_LOGIC_VECTOR (2 downto 0);
           D : in STD_LOGIC_VECTOR (7 downto 0);
           Y : out STD_LOGIC);
end mux_8x1;

architecture Behavioral of mux_8x1 is
begin
    process (S, D)
    begin
        case S is
            when "000" => Y <= D(0);
            when "001" => Y <= D(1);
            when "010" => Y <= D(2);
            when "011" => Y <= D(3);
            when "100" => Y <= D(4);
            when "101" => Y <= D(5);
            when "110" => Y <= D(6);
            when "111" => Y <= D(7);
            when others => Y <= '0';
        end case;
    end process;
end Behavioral;