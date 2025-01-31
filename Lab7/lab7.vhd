library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vending_machine is
    Port (
        clk      : in  STD_LOGIC;
        A        : in  STD_LOGIC_VECTOR(1 downto 0);
        product  : out STD_LOGIC;
        change25 : out STD_LOGIC;
        change50 : out STD_LOGIC
    );
end vending_machine;

architecture Behavioral of vending_machine is
    type state_type is (
        S0, S25, S50, S75,
        RELEASE_P0, RELEASE_P25,
        CANCEL_C25, CANCEL_C50, CANCEL_C75
    );
    signal current_state, next_state : state_type := S0;
begin

    -- Processo para atualização do estado
    process(clk)
    begin
        if rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Processo combinacional para transições e saídas
    process(current_state, A)
    begin
        case current_state is
            -- Estado Inicial (0 centavos)
            when S0 =>
                product <= '0';
                change25 <= '0';
                change50 <= '0';
                case A is
                    when "01" => next_state <= S25;   -- Insere 25c
                    when "10" => next_state <= S50;   -- Insere 50c
                    when others => next_state <= S0;  -- Nada ou Cancelar sem moedas
                end case;

            -- Estado com 25 centavos
            when S25 =>
                product <= '0';
                change25 <= '0';
                change50 <= '0';
                case A is
                    when "01" => next_state <= S50;    -- Total 50c
                    when "10" => next_state <= S75;    -- Total 75c
                    when "11" => next_state <= CANCEL_C25; -- Cancelar (devolve 25c)
                    when others => next_state <= S25;  -- Mantém estado
                end case;

            -- Estado com 50 centavos
            when S50 =>
                product <= '0';
                change25 <= '0';
                change50 <= '0';
                case A is
                    when "01" => next_state <= S75;    -- Total 75c
                    when "10" => next_state <= RELEASE_P0; -- Total 100c (Libera produto)
                    when "11" => next_state <= CANCEL_C50; -- Cancelar (devolve 50c)
                    when others => next_state <= S50;  -- Mantém estado
                end case;

            -- Estado com 75 centavos
            when S75 =>
                product <= '0';
                change25 <= '0';
                change50 <= '0';
                case A is
                    when "01" => next_state <= RELEASE_P0;  -- Total 100c (Libera produto)
                    when "10" => next_state <= RELEASE_P25; -- Total 125c (Libera produto + 25c)
                    when "11" => next_state <= CANCEL_C75;  -- Cancelar (devolve 75c)
                    when others => next_state <= S75;  -- Mantém estado
                end case;

            -- Estados de Liberação do Produto
            when RELEASE_P0 =>    -- Total exato (100c)
                product <= '1';
                change25 <= '0';
                change50 <= '0';
                next_state <= S0; -- Retorna ao estado inicial

            when RELEASE_P25 =>   -- Total 125c (troco 25c)
                product <= '1';
                change25 <= '1';
                change50 <= '0';
                next_state <= S0;

            -- Estados de Cancelamento
            when CANCEL_C25 =>    -- Devolve 25c
                product <= '0';
                change25 <= '1';
                change50 <= '0';
                next_state <= S0;

            when CANCEL_C50 =>    -- Devolve 50c
                product <= '0';
                change25 <= '0';
                change50 <= '1';
                next_state <= S0;

            when CANCEL_C75 =>    -- Devolve 75c (25c + 50c)
                product <= '0';
                change25 <= '1';
                change50 <= '1';
                next_state <= S0;

            when others =>        -- Caso padrão
                next_state <= S0;
        end case;
    end process;

end Behavioral;