library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (4 downto 0);
           Sel : in STD_LOGIC_VECTOR (1 downto 0);
           D : in STD_LOGIC_VECTOR (7 downto 0);
           Y : out STD_LOGIC);
end top_level;

architecture Structural of top_level is
    component mux4x1
        Port ( S : in STD_LOGIC_VECTOR (1 downto 0);
               D0 : in STD_LOGIC;
               D1 : in STD_LOGIC;
               D2 : in STD_LOGIC;
               D3 : in STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    component mux_8x1
        Port ( S : in STD_LOGIC_VECTOR (2 downto 0);
               D : in STD_LOGIC_VECTOR (7 downto 0);
               Y : out STD_LOGIC);
    end component;

    component adder_4bit
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               S : out STD_LOGIC_VECTOR (4 downto 0));
    end component;

    signal mux4x1_out : STD_LOGIC;
    signal mux_8x1_out : STD_LOGIC;
    signal Sel_extended : STD_LOGIC_VECTOR (2 downto 0);

begin
    -- Extend Sel to 3 bits
    Sel_extended <= Sel & '0';

    -- Instância do mux4x1
    MUX4X1_INST: mux4x1 Port map (S => Sel, D0 => A(0), D1 => A(1), D2 => A(2), D3 => A(3), Y => mux4x1_out);

    -- Instância do mux_8x1
    MUX8X1_INST: mux_8x1 Port map (S => Sel_extended, D => D, Y => mux_8x1_out);

    -- Instância do adder_4bit
    ADDER4BIT_INST: adder_4bit Port map (A => A, B => B, S => S);

    -- Conexões adicionais
    Y <= mux4x1_out or mux_8x1_out;

end Structural;

