library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_maquina is
end tb_maquina;

architecture Behavioral of tb_maquina is

    component maquina_de_vendas
        Port (
            clk     : in STD_LOGIC;
            A       : in STD_LOGIC_VECTOR(1 downto 0);
            produto : out STD_LOGIC;
            troco25 : out STD_LOGIC;
            troco50 : out STD_LOGIC
        );
    end component;

    signal clk      : STD_LOGIC := '0';
    signal A        : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal produto  : STD_LOGIC;
    signal troco25  : STD_LOGIC;
    signal troco50  : STD_LOGIC;

    constant clk_period : time := 20 ns;

begin

    uut: maquina_de_vendas port map (
        clk => clk,
        A => A,
        produto => produto,
        troco25 => troco25,
        troco50 => troco50
    );

    -- Processo para gerar o clock
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Processo de estímulo
    stim_proc: process
    begin
        -- Inicialização
        wait for clk_period*2;

        -- Teste 1: Pagamento exato (50c + 50c)
        A <= "10"; -- Insere 50c
        wait for clk_period;
        A <= "10"; -- Insere 50c (total 100c)
        wait for clk_period;
        assert produto = '1' and troco25 = '0' and troco50 = '0'
            report "Erro Teste 1: Produto deveria ser liberado sem troco" severity error;
        wait for clk_period; -- Retorna a S0

        -- Teste 2: Pagamento a mais (50c + 50c + 25c)
        A <= "10"; -- 50c
        wait for clk_period;
        A <= "10"; -- 50c (total 100c)
        wait for clk_period;
        A <= "01"; -- 25c (total 125c)
        wait for clk_period;
        assert produto = '1' and troco25 = '1' and troco50 = '0'
            report "Erro Teste 2: Produto com troco de 25c" severity error;
        wait for clk_period; -- Retorna a S0

        -- Teste 3: Cancelamento em S25
        A <= "01"; -- 25c
        wait for clk_period;
        A <= "11"; -- Cancela
        wait for clk_period;
        assert troco25 = '1' and produto = '0'
            report "Erro Teste 3: Deveria devolver 25c" severity error;
        wait for clk_period; -- Retorna a S0

        -- Teste 4: Cancelamento em S50
        A <= "10"; -- 50c
        wait for clk_period;
        A <= "11"; -- Cancela
        wait for clk_period;
        assert troco50 = '1' and produto = '0'
            report "Erro Teste 4: Deveria devolver 50c" severity error;
        wait for clk_period; -- Retorna a S0

        -- Teste 5: Cancelamento em S75
        A <= "01"; -- 25c
        wait for clk_period;
        A <= "10"; -- 50c (total 75c)
        wait for clk_period;
        A <= "11"; -- Cancela
        wait for clk_period;
        assert troco25 = '1' and troco50 = '1' and produto = '0'
            report "Erro Teste 5: Deveria devolver 75c (25+50)" severity error;
        wait for clk_period; -- Retorna a S0

        -- Teste 6: Nenhuma ação (mantém estado)
        A <= "01"; -- 25c
        wait for clk_period;
        A <= "00"; -- Nada
        wait for clk_period;
        A <= "01"; -- 25c (total 50c)
        wait for clk_period;
        assert produto = '0' and troco25 = '0' and troco50 = '0'
            report "Erro Teste 6: Deveria estar em S50" severity error;

        -- Finaliza simulação
        wait;
    end process;

end Behavioral;