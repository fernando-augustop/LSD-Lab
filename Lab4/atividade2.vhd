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

-- Arquitetura do Decodificador 4x16
architecture Behavioral of decodificador_4x16 is
begin
    process (I)
    begin
        Y <= (others => '0');
        case I is
            when "0000" => Y(0) <= '1';
            when "0001" => Y(1) <= '1';
            when "0010" => Y(2) <= '1';
            when "0011" => Y(3) <= '1';
            when "0100" => Y(4) <= '1';
            when "0101" => Y(5) <= '1';
            when "0110" => Y(6) <= '1';
            when "0111" => Y(7) <= '1';
            when "1000" => Y(8) <= '1';
            when "1001" => Y(9) <= '1';
            when "1010" => Y(10) <= '1';
            when "1011" => Y(11) <= '1';
            when "1100" => Y(12) <= '1';
            when "1101" => Y(13) <= '1';
            when "1110" => Y(14) <= '1';
            when "1111" => Y(15) <= '1';
            when others => Y <= (others => '0');
        end case;
    end process;
end Behavioral;

-- Arquitetura do Multiplexador 8x1
architecture Behavioral of mux_8x1 is
begin
    process (S, D)
    begin
        case S is
            when "000" => Y <= D(0);
            when "001" => Y <= D(1);
            when "010" => Y <= D(2);
            when "011" => Y <= D(3);
            when "100" => Y <= D(4);
            when "101" => Y <= D(5);
            when "110" => Y <= D(6);
            when "111" => Y <= D(7);
            when others => Y <= '0';
        end case;
    end process;
end Behavioral;