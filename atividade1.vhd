LIBRARY IEEE

USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ATIVIDADE1 IS
    PORT(
        S: IN STD_LOGIC_VECTOR (0 TO 2);
        D: IN STD_LOGIC_VECTOR (0 TO 7);
        Y: OUT STD_LOGIC);  


END ATIVIDADE1;

ARCHITECTURE ATIVIDADE1_ARCHITECTURE OF ATIVIDADE1 IS
BEGIN
   Y <= D(0) WHEN (S(0) = '0' AND S(1) = '0' AND S(2) = '0') ELSE
        D(1) WHEN (S(0) = '0' AND S(1) = '0' AND S(2) = '1') ELSE
        D(2) WHEN (S(0) = '0' AND S(1) = '1' AND S(2) = '0') ELSE
        D(3) WHEN (S(0) = '0' AND S(1) = '1' AND S(2) = '1') ELSE
        D(4) WHEN (S(1) = '0' AND S(1) = '0' AND S(2) = '0') ELSE
        D(5) WHEN (S(1) = '0' AND S(1) = '0' AND S(2) = '1') ELSE
        D(6) WHEN (S(0) = '1' AND S(1) = '1' AND S(2) = '0') ELSE
        D(7) WHEN (S(0) = '1' AND S(1) = '1' AND S(2) = '1') ELSE
        '0';
END ATIVIDADE1_ARCHITECTURE;    

