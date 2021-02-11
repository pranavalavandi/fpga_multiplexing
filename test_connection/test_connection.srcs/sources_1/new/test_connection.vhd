----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.02.2021 16:52:52
-- Design Name: 
-- Module Name: test_connection - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_connection is
    Port ( clk : in STD_LOGIC;
    	   input_signal : in STD_LOGIC;
           led : out STD_LOGIC);
end test_connection;

architecture Behavioral of test_connection is
	signal counter : std_logic_vector (2 downto 0); 		-- counter to delay input
	signal switch_out : std_logic;
	
	
begin


	delay: process (clk)
	begin
	
		if input_signal = '1' then 
			if rising_edge (clk) then
	
				if counter < "10" then 
					counter <= counter + 1;
					switch_out <= '0';
				else
					switch_out <= not switch_out;
					counter <= (others => '0');
					
				end if;
			end if;
		end if;
	
	
	
	end process delay;
	
	led <= switch_out;

	

		

end Behavioral;
