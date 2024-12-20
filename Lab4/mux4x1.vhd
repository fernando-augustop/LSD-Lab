library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux4x1 is
    Port ( S : in STD_LOGIC_VECTOR (1 downto 0); -- Change S0 and S1 to a vector
           D0 : in STD_LOGIC;
           D1 : in STD_LOGIC;
           D2 : in STD_LOGIC;
           D3 : in STD_LOGIC;
           Y : out STD_LOGIC);
end mux4x1;

architecture Behavioral of mux4x1 is
begin
    process (S, D0, D1, D2, D3)
    begin
        case to_integer(unsigned(S)) is -- Use the vector S
            when 0 => Y <= D0;
            when 1 => Y <= D1;
            when 2 => Y <= D2;
            when 3 => Y <= D3;
            when others => Y <= '0';
        end case;
    end process;
end Behavioral;