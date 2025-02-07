library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_bcd_counter_100 is
end tb_bcd_counter_100;

architecture behavioral of tb_bcd_counter_100 is
    component bcd_counter_100
        Port (
            CLOCK      : in STD_LOGIC;
            RESET      : in STD_LOGIC;
            ENABLE     : in STD_LOGIC;
            D_UNIDADE  : in STD_LOGIC_VECTOR(3 downto 0);
            D_DEZENA   : in STD_LOGIC_VECTOR(3 downto 0);
            LOAD       : in STD_LOGIC;
            Q_UNIDADE  : out STD_LOGIC_VECTOR(3 downto 0);
            Q_DEZENA   : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Sinais de entrada
    signal CLOCK      : STD_LOGIC := '0';
    signal RESET      : STD_LOGIC := '1';
    signal ENABLE     : STD_LOGIC := '1';
    signal D_UNIDADE  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal D_DEZENA   : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal LOAD       : STD_LOGIC := '0';

    -- Sinais de saída
    signal Q_UNIDADE  : STD_LOGIC_VECTOR(3 downto 0);
    signal Q_DEZENA   : STD_LOGIC_VECTOR(3 downto 0);

    -- Período do clock
    constant CLOCK_PERIOD : time := 10 ns;

begin
    -- Instância do contador BCD módulo 100
    uut: bcd_counter_100
        port map (
            CLOCK      => CLOCK,
            RESET      => RESET,
            ENABLE     => ENABLE,
            D_UNIDADE  => D_UNIDADE,
            D_DEZENA   => D_DEZENA,
            LOAD       => LOAD,
            Q_UNIDADE  => Q_UNIDADE,
            Q_DEZENA   => Q_DEZENA
        );

    -- Geração do clock
    clock_process: process
    begin
        CLOCK <= '0';
        wait for CLOCK_PERIOD/2;
        CLOCK <= '1';
        wait for CLOCK_PERIOD/2;
    end process;

    -- Processo de estímulo
    stim_proc: process
    begin
        -- Reset inicial (2 ciclos de clock)
        RESET <= '1';
        ENABLE <= '1';
        wait for CLOCK_PERIOD * 2;

        -- Inicia a contagem
        RESET <= '0';
        ENABLE <= '0'; -- Ativa a contagem (ENABLE em nível baixo)
        wait for CLOCK_PERIOD * 100; -- Conta de 00 a 99

        -- Teste de LOAD (carrega o valor 42)
        D_UNIDADE <= "0010"; -- Unidade = 2
        D_DEZENA <= "0100";  -- Dezena = 4
        LOAD <= '1';
        wait for CLOCK_PERIOD;
        LOAD <= '0';
        wait for CLOCK_PERIOD * 10; -- Conta mais 10 ciclos

        -- Reset final
        RESET <= '1';
        wait for CLOCK_PERIOD;
        RESET <= '0';
        wait;
    end process;

    -- Monitoramento (exibe os valores no console)
    monitor_proc: process(CLOCK)
        variable dezena, unidade : integer;
    begin
        if rising_edge(CLOCK) then
            dezena := conv_integer(Q_DEZENA);
            unidade := conv_integer(Q_UNIDADE);
            report "Contagem: " & integer'image(dezena) & integer'image(unidade);
        end if;
    end process;

end behavioral;