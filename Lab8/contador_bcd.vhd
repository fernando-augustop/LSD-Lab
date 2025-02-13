library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_bcd is
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           RCI : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (3 downto 0);
           LOAD : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0);
           RCO : out STD_LOGIC);
end contador_bcd;

architecture moore of contador_bcd is
    type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9);
    signal estado_atual : state_type := s0;
begin

    -- Processo de transição de estados
    process (CLOCK)
    begin
        if rising_edge(CLOCK) then
            if RESET = '1' then
                estado_atual <= s0;
            else
                if LOAD = '1' then
                    -- Carrega o input D (assumindo BCD válido)
                    case D is
                        when "0000" => estado_atual <= s0;
                        when "0001" => estado_atual <= s1;
                        when "0010" => estado_atual <= s2;
                        when "0011" => estado_atual <= s3;
                        when "0100" => estado_atual <= s4;
                        when "0101" => estado_atual <= s5;
                        when "0110" => estado_atual <= s6;
                        when "0111" => estado_atual <= s7;
                        when "1000" => estado_atual <= s8;
                        when "1001" => estado_atual <= s9;
                        when others => estado_atual <= s0; -- D inválido
                    end case;
                else
                    if (ENABLE = '0' and RCI = '0') then
                        -- Incrementa o estado atual
                        case estado_atual is
                            when s0 => estado_atual <= s1;
                            when s1 => estado_atual <= s2;
                            when s2 => estado_atual <= s3;
                            when s3 => estado_atual <= s4;
                            when s4 => estado_atual <= s5;
                            when s5 => estado_atual <= s6;
                            when s6 => estado_atual <= s7;
                            when s7 => estado_atual <= s8;
                            when s8 => estado_atual <= s9;
                            when s9 => estado_atual <= s0;
                        end case;
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Saídas
    with estado_atual select
        Q <= "0000" when s0,
             "0001" when s1,
             "0010" when s2,
             "0011" when s3,
             "0100" when s4,
             "0101" when s5,
             "0110" when s6,
             "0111" when s7,
             "1000" when s8,
             "1001" when s9;

    RCO <= '0' when estado_atual = s9 else '1';

end moore;