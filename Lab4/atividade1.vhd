library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity entradas_e_saidas is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           X : out STD_LOGIC;
           Y : out STD_LOGIC);
end entradas_e_saidas;

architecture Comportamento of entradas_e_saidas is

    component mux4x1
        Port ( S0 : in STD_LOGIC;
               S1 : in STD_LOGIC;
               D0 : in STD_LOGIC;
               D1 : in STD_LOGIC;
               D2 : in STD_LOGIC;
               D3 : in STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    component not_gate
        Port ( A : in STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    signal A_not : STD_LOGIC;
    signal mux1_out, mux2_out : STD_LOGIC;

begin

    -- Instância da porta inversora
    U1: not_gate port map (A => A, Y => A_not);

    -- Instância do primeiro multiplexador para saída X
    MUX1: mux4x1 port map (
        S0 => B,
        S1 => C,
        D0 => '0',
        D1 => A_not,
        D2 => A,
        D3 => '1',
        Y => mux1_out
    );

    -- Instância do segundo multiplexador para saída Y
    MUX2: mux4x1 port map (
        S0 => B,
        S1 => C,
        D0 => A_not,
        D1 => A_not,
        D2 => '0',
        D3 => A,
        Y => mux2_out
    );

    -- Atribuição das saídas
    X <= mux1_out;
    Y <= mux2_out;

end Comportamento;