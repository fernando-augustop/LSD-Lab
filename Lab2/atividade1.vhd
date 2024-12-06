LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ATIVIDADE1_lab IS
    PORT (A, B, CIN: IN STD_LOGIC;
          S: OUT STD_LOGIC;
          COUT: OUT STD_LOGIC);
END ATIVIDADE1_lab;

ARCHITECTURE ATIVIDADE1_lab_ARCH OF ATIVIDADE1_lab IS
    SIGNAL AUX1: STD_LOGIC;
    SIGNAL AUX2: STD_LOGIC;
    SIGNAL AUX3: STD_LOGIC;
BEGIN
    AUX1 <= A AND B;
    AUX2 <= A AND CIN;
    AUX3 <= B AND CIN;

    COUT <= AUX1 OR AUX2 OR AUX3;
    S <= A XOR B XOR CIN;
END ATIVIDADE1_lab_ARCH;