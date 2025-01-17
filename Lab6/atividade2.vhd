library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;                     -- Reset
        LOAD : in STD_LOGIC;                    -- Carregar dados paralelos
        D : in STD_LOGIC_VECTOR(3 downto 0);    -- Entrada de dados paralelos
        DIR : in STD_LOGIC;                     -- Direção do deslocamento (0=esquerda, 1=direita)
        L : in STD_LOGIC;                       -- Entrada esquerda
        R : in STD_LOGIC;                       -- Entrada direita
        Q : out STD_LOGIC_VECTOR(3 downto 0)    -- Saída
    );
end shift_register;

architecture Behavioral of shift_register is
    signal current_state : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            -- Condição de reset (prioridade mais alta)
            if RST = '1' then
                current_state <= "0000";
            
            -- Carregar dados paralelos
            elsif LOAD = '1' then
                current_state <= D;
            
            -- Operações de deslocamento quando não estiver carregando
            elsif LOAD = '0' then
                -- Deslocamento para a esquerda
                if DIR = '0' then
                    if L = '0' then
                        current_state <= current_state(2 downto 0) & '0';
                    elsif L = '1' then
                        current_state <= current_state(2 downto 0) & '1';
                    end if;
                
                -- Right shift
                elsif DIR = '1' then
                    if R = '0' then
                        current_state <= '0' & current_state(3 downto 1);
                    elsif R = '1' then
                        current_state <= '1' & current_state(3 downto 1);
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Output assignment
    Q <= current_state;
end Behavioral;