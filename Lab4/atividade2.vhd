-- filepath: /C:/Users/ferna/Documents/GitHub/LSD-Lab/Lab4/atividade2.vhd
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

    signal dec_out : STD_LOGIC_VECTOR (15 downto 0);
    signal mux_in : STD_LOGIC_VECTOR (7 downto 0);
    signal or_out : STD_LOGIC;
    signal I_sig : STD_LOGIC_VECTOR(3 downto 0); -- Intermediate signal for I
    signal S_sig : STD_LOGIC_VECTOR(2 downto 0); -- Intermediate signal for S

begin

    -- Assign inputs to intermediate signals
    I_sig <= (A & B & C & D);
    S_sig <= (E & F & G);

    -- Inst�ncia do Decodificador 4x16
    DEC: entity work.decodificador_4x16 port map (
        I => I_sig,
        Y => dec_out
    );

    -- Inst�ncia da porta OR
    OR1: entity work.or_gate port map (
        A => dec_out(0),
        B => dec_out(8),
        C => dec_out(12),
        Y => or_out
    );

    -- Conex�o das entradas do Multiplexador
    mux_in(0) <= or_out;
    mux_in(1) <= dec_out(1);
    mux_in(2) <= dec_out(2);
    mux_in(3) <= dec_out(3);
    mux_in(4) <= dec_out(4);
    mux_in(5) <= dec_out(5);
    mux_in(6) <= dec_out(6);
    mux_in(7) <= dec_out(7);

    -- Inst�ncia do Multiplexador 8x1
    MUX: entity work.mux_8x1 port map (
        S => S_sig,
        D => mux_in,
        Y => Z
    );

end Estrutura;