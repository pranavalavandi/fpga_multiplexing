	----------------------------------------------------------------------------------
-- Company: TKJ Electronics
-- Engineer: Thomas Jespersen
-- 
-- Create Date:    18:31:45 02/04/2012 
-- Design Name:    LED Blink Tutorial
-- Module Name:    LED_Blink - Behavioral 
-- Project Name: 
-- Target Devices:  Spartan 3E - Basys2 Board
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 1.00 - Tutorial done
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_blink_delay is
	port (
		clk: in std_logic;
		reset : in std_logic;
		led: out std_logic;
		delay_switch : in std_logic
	);
end led_blink_delay;

architecture Behavioral of led_blink_delay is
	-- led blinking signals
	signal counter: std_logic_vector(23 downto 0); 	-- counter for LED
	signal clk_out: std_logic;						-- = 1 when the counter reaches specified number- turns LED on then
	
	signal delay_counter : std_logic_vector (24 downto 0); 		-- counter to delay input
	signal switch_out : std_logic;								-- = 1 when the delay_counter reaches specified number. 
	
begin

	prescaler: process(clk)
	begin
		
		if reset = '1' then
			counter <= "000000000000000000000000";
			clk_out <= '0';
		elsif rising_edge(clk) then
--			switch_out <= '1'; 								-- REMOVE THIS LINE!!!!!!!!!!!
--			if counter <= "000000000000000000000100" then
			if counter < "101101110001101100000000" then
				counter <= counter + 1;
			elsif switch_out = '1' then
				clk_out <= not clk_out;
				counter <= (others => '0');
			end if;
		end if;
	end process prescaler;
	
	led <= clk_out;
	
	delay: process (clk, delay_switch)
	begin
	
		if delay_switch = '1' then
			if rising_edge (clk) then
--				if delay_counter <= "000000000000000000000100" then
				if delay_counter  < "1011011100011011000000000" then
					delay_counter <= delay_counter + 1;
				else
					delay_counter <= (others => '0');
					switch_out <= '1';
				end if;
			end if;
		end if;
	
	end process delay;


end Behavioral;

