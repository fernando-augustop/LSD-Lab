library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;                     -- Reset
        LOAD : in STD_LOGIC;                    -- Load parallel data
        D : in STD_LOGIC_VECTOR(3 downto 0);    -- Parallel data input
        DIR : in STD_LOGIC;                     -- Shift direction (0=left, 1=right)
        L : in STD_LOGIC;                       -- Left input
        R : in STD_LOGIC;                       -- Right input
        Q : out STD_LOGIC_VECTOR(3 downto 0)    -- Output
    );
end shift_register;

architecture Behavioral of shift_register is
    signal current_state : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            -- Reset condition (highest priority)
            if RST = '1' then
                current_state <= "0000";
            
            -- Load parallel data
            elsif LOAD = '1' then
                current_state <= D;
            
            -- Shift operations when not loading
            elsif LOAD = '0' then
                -- Left shift
                if DIR = '0' then
                    if L = '0' then
                        current_state <= current_state(2 downto 0) & '0';
                    elsif L = '1' then
                        current_state <= current_state(2 downto 0) & '1';
                    end if;
                
                -- Right shift
                elsif DIR = '1' then
                    if R = '0' then
                        current_state <= '0' & current_state(3 downto 1);
                    elsif R = '1' then
                        current_state <= '1' & current_state(3 downto 1);
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Output assignment
    Q <= current_state;
end Behavioral;