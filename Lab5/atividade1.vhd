library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           S : out STD_LOGIC;
           Cout : out STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is
begin
    process(A, B, Cin)
    begin
        S <= A XOR B XOR Cin;
        Cout <= (A AND B) OR (B AND Cin) OR (A AND Cin);
    end process;
end Behavioral;

-- Definição do somador de 4 bits
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_4bit is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (4 downto 0));
end adder_4bit;

architecture Structural of adder_4bit is
    signal C : STD_LOGIC_VECTOR (4 downto 0);
    signal Sum : STD_LOGIC_VECTOR (3 downto 0);

    component full_adder
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               Cin : in STD_LOGIC;
               S : out STD_LOGIC;
               Cout : out STD_LOGIC);
    end component;

begin
    -- Conexões dos somadores completos
    FA0: full_adder Port map (A(0), B(0), '0', Sum(0), C(1));
    FA1: full_adder Port map (A(1), B(1), C(1), Sum(1), C(2));
    FA2: full_adder Port map (A(2), B(2), C(2), Sum(2), C(3));
    FA3: full_adder Port map (A(3), B(3), C(3), Sum(3), C(4));

    -- Saída final
    S(3 downto 0) <= Sum;
    S(4) <= C(4);
end Structural;