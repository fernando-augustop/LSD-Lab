library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity maquina_de_vendas is
    Port (
        clk      : in  STD_LOGIC;
        A        : in  STD_LOGIC_VECTOR(1 downto 0);
        produto  : out STD_LOGIC;
        troco25 : out STD_LOGIC;
        troco50 : out STD_LOGIC
    );
end maquina_de_vendas;

architecture Behavioral of maquina_de_vendas is
    type state_type is (
        S0, S25, S50, S75,
        LIBERA_P0, LIBERA_P25,
        CANCELA_C25, CANCELA_C50, CANCELA_C75
    );
    signal estado_atual, proximo_estado : state_type := S0;
begin

    -- Processo para atualização do estado
    process(clk)
    begin
        if rising_edge(clk) then
            estado_atual <= proximo_estado;
        end if;
    end process;

    -- Processo combinacional para transições e saídas
    process(estado_atual, A)
    begin
        case estado_atual is
            -- Estado Inicial (0 centavos)
            when S0 =>
                produto <= '0';
                troco25 <= '0';
                troco50 <= '0';
                case A is
                    when "01" => proximo_estado <= S25;   -- Insere 25c
                    when "10" => proximo_estado <= S50;   -- Insere 50c
                    when others => proximo_estado <= S0;  -- Nada ou Cancelar sem moedas
                end case;

            -- Estado com 25 centavos
            when S25 =>
                produto <= '0';
                troco25 <= '0';
                troco50 <= '0';
                case A is
                    when "01" => proximo_estado <= S50;    -- Total 50c
                    when "10" => proximo_estado <= S75;    -- Total 75c
                    when "11" => proximo_estado <= CANCELA_C25; -- Cancelar (devolve 25c)
                    when others => proximo_estado <= S25;  -- Mantém estado
                end case;

            -- Estado com 50 centavos
            when S50 =>
                produto <= '0';
                troco25 <= '0';
                troco50 <= '0';
                case A is
                    when "01" => proximo_estado <= S75;    -- Total 75c
                    when "10" => proximo_estado <= LIBERA_P0; -- Total 100c (Libera produto)
                    when "11" => proximo_estado <= CANCELA_C50; -- Cancelar (devolve 50c)
                    when others => proximo_estado <= S50;  -- Mantém estado
                end case;

            -- Estado com 75 centavos
            when S75 =>
                produto <= '0';
                troco25 <= '0';
                troco50 <= '0';
                case A is
                    when "01" => proximo_estado <= LIBERA_P0;  -- Total 100c (Libera produto)
                    when "10" => proximo_estado <= LIBERA_P25; -- Total 125c (Libera produto + 25c)
                    when "11" => proximo_estado <= CANCELA_C75;  -- Cancelar (devolve 75c)
                    when others => proximo_estado <= S75;  -- Mantém estado
                end case;

            -- Estados de Liberação do Produto
            when LIBERA_P0 =>    -- Total exato (100c)
                produto <= '1';
                troco25 <= '0';
                troco50 <= '0';
                proximo_estado <= S0; -- Retorna ao estado inicial

            when LIBERA_P25 =>   -- Total 125c (troco 25c)
                produto <= '1';
                troco25 <= '1';
                troco50 <= '0';
                proximo_estado <= S0;

            -- Estados de Cancelamento
            when CANCELA_C25 =>    -- Devolve 25c
                produto <= '0';
                troco25 <= '1';
                troco50 <= '0';
                proximo_estado <= S0;

            when CANCELA_C50 =>    -- Devolve 50c
                produto <= '0';
                troco25 <= '0';
                troco50 <= '1';
                proximo_estado <= S0;

            when CANCELA_C75 =>    -- Devolve 75c (25c + 50c)
                produto <= '0';
                troco25 <= '1';
                troco50 <= '1';
                proximo_estado <= S0;

            when others =>        -- Caso padrão
                proximo_estado <= S0;
        end case;
    end process;

end Behavioral;