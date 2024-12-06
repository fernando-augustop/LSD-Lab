library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade Principal
entity funcao_logica is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           D : in STD_LOGIC;
           E : in STD_LOGIC;
           F : in STD_LOGIC;
           G : in STD_LOGIC;
           Z : out STD_LOGIC);
end funcao_logica;

architecture Estrutura of funcao_logica is

    -- Componente Decodificador 4x16
    component decodificador_4x16
        Port ( I : in STD_LOGIC_VECTOR (3 downto 0);
               Y : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

    -- Componente Multiplexador 8x1
    component mux_8x1
        Port ( S : in STD_LOGIC_VECTOR (2 downto 0);
               D : in STD_LOGIC_VECTOR (7 downto 0);
               Y : out STD_LOGIC);
    end component;

    signal dec_out : STD_LOGIC_VECTOR (15 downto 0);
    signal mux_in : STD_LOGIC_VECTOR (7 downto 0);

begin

    -- Instância do Decodificador 4x16
    DEC: decodificador_4x16 port map (
        I => (A & B & C & D),
        Y => dec_out
    );

    -- Conexão das entradas do Multiplexador
    mux_in(0) <= dec_out(0) or dec_out(8) or dec_out(12);
    mux_in(1) <= dec_out(1);
    mux_in(2) <= dec_out(2);
    mux_in(3) <= dec_out(3);
    mux_in(4) <= dec_out(4);
    mux_in(5) <= dec_out(5);
    mux_in(6) <= dec_out(6);
    mux_in(7) <= dec_out(7);

    -- Instância do Multiplexador 8x1
    MUX: mux_8x1 port map (
        S => (E & F & G),
        D => mux_in,
        Y => Z
    );

end Estrutura;