library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_counter_100 is
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
end bcd_counter_100;

architecture structural of bcd_counter_100 is
    component contador_bcd
        Port (
            CLOCK  : in STD_LOGIC;
            RESET  : in STD_LOGIC;
            ENABLE : in STD_LOGIC;
            RCI    : in STD_LOGIC;
            D      : in STD_LOGIC_VECTOR(3 downto 0);
            LOAD   : in STD_LOGIC;
            Q      : out STD_LOGIC_VECTOR(3 downto 0);
            RCO    : out STD_LOGIC
        );
    end component;

    signal rco_unidade : STD_LOGIC; -- Sinal de carry-out da unidade
    signal rci_dezena  : STD_LOGIC; -- Sinal de carry-in para a dezena

begin
    -- Conexão do carry: RCO da unidade (0 em estado 9) -> RCI da dezena
    rci_dezena <= rco_unidade;

    -- Contador das UNIDADES (0-9)
    counter_unidade: contador_bcd
        port map (
            CLOCK  => CLOCK,
            RESET  => RESET,
            ENABLE => ENABLE,
            RCI    => '0',          -- Sempre permite contagem quando ENABLE=0
            D      => D_UNIDADE,
            LOAD   => LOAD,
            Q      => Q_UNIDADE,
            RCO    => rco_unidade   -- 0 quando em 9
        );

    -- Contador das DEZENAS (0-9)
    counter_dezena: contador_bcd
        port map (
            CLOCK  => CLOCK,
            RESET  => RESET,
            ENABLE => ENABLE,
            RCI    => rci_dezena,   -- Só conta quando unidade está em 9 (RCO_unidade=0)
            D      => D_DEZENA,
            LOAD   => LOAD,
            Q      => Q_DEZENA,
            RCO    => open          -- Não utilizado
        );

end structural;