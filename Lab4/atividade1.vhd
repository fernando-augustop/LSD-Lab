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

    signal A_not : STD_LOGIC;
    signal mux1_out, mux2_out : STD_LOGIC;
    signal S_sig : STD_LOGIC_VECTOR(1 downto 0); -- Intermediate signal for combined select lines

begin

    -- Instância da porta inversora
    U1: entity work.not_gate port map (A => A, Y => A_not);

    -- Assign inputs to intermediate signal
    S_sig <= (B & C);

    -- Instância do primeiro multiplexador para saída X
    MUX1: entity work.mux4x1 port map (
        S => S_sig, -- Use the intermediate signal
        D0 => '0',
        D1 => A_not,
        D2 => A,
        D3 => A,
        Y => mux1_out
    );


    -- Instância do segundo multiplexador para saída Y
    MUX2: entity work.mux4x1 port map (
        S => S_sig, -- Use the intermediate signal
        D0 => A_not,
        D1 => '0',
        D2 => A_not,
        D3 => A,
        Y => mux2_out
    );

    -- Atribuição das saídas
    X <= mux1_out;
    Y <= mux2_out;

end Comportamento;