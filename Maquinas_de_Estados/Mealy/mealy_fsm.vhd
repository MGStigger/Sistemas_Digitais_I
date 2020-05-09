-----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
ENTITY mealy_fsm IS
	PORT ( 	clk, rst: IN std_logic;
			entrada: IN std_logic_vector(1 DOWNTO 0);
            saida: OUT std_logic
	);
END mealy_fsm;
-----------------------------------------------------------------------------------
ARCHITECTURE detector_abc OF mealy_fsm IS

	TYPE estado IS (zero, um, dois);
	SIGNAL estado_atual, proximo_estado: estado;

BEGIN
------------------------------ Registrador de estado ------------------------------
	PROCESS (rst, clk)
	BEGIN
		IF (rst='1') THEN
			estado_atual <= zero;
		ELSIF (clk'EVENT AND clk='1') THEN
			estado_atual <= proximo_estado;
		END IF;
	END PROCESS;
------------------------ Logica de proximo estado e saida -------------------------
	PROCESS (entrada, estado_atual)
	BEGIN
		CASE estado_atual IS
			WHEN zero =>
				CASE entrada IS
					WHEN "00" =>
						proximo_estado <= um;
						saida <= '0';
					WHEN OTHERS =>
						proximo_estado <= zero;
						saida <= '0';
				END CASE;
			WHEN um =>
				CASE entrada IS
					WHEN "00" =>
						proximo_estado <= um;
						saida <= '0';
					WHEN "01" =>
						proximo_estado <= dois;
						saida <= '0';
					WHEN OTHERS =>
						proximo_estado <= zero;
						saida <= '0';
				END CASE;
			WHEN dois =>
				CASE entrada IS
					WHEN "10" =>
						proximo_estado <= zero;
						saida <= '1';
					WHEN "00" =>
						proximo_estado <= um;
						saida <= '0';
					WHEN OTHERS =>
						proximo_estado <= zero;
						saida <= '0';
				END CASE;
		END CASE;
	END PROCESS;
END detector_abc;
-----------------------------------------------------------------------------------