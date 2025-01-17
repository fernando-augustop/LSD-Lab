library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jk_flipflop is
    Port ( 
        CLK : in STD_LOGIC;
        J : in STD_LOGIC;
        K : in STD_LOGIC;
        PR : in STD_LOGIC;  -- Preset
        CLR : in STD_LOGIC; -- Clear
        Q : out STD_LOGIC
    );
end jk_flipflop;

architecture Behavioral of jk_flipflop is
    signal current_state : STD_LOGIC := '0';
begin
    process(CLK, PR, CLR)
    begin
        -- Asynchronous Preset
        if (PR = '1') then
            current_state <= '1';
        -- Asynchronous Clear
        elsif (CLR = '1') then
            current_state <= '0';
        -- Synchronous operations
        elsif rising_edge(CLK) then
            case std_logic_vector'(J & K) is
                when "00" =>   -- Hold state
                    current_state <= current_state;
                when "01" =>   -- Reset
                    current_state <= '0';
                when "10" =>   -- Set
                    current_state <= '1';
                when "11" =>   -- Toggle
                    current_state <= not current_state;
                when others => -- No change
                    current_state <= current_state;
            end case;
        end if;
    end process;

    -- Output assignment
    Q <= current_state;
end Behavioral;