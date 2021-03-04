----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2021 11:24:40
-- Design Name: 
-- Module Name: aom_delay - Behavioral
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



entity aom_delay is
  Port (
  		clk : in std_logic; 
  		reset : in std_logic;
  		delay_switch : in std_logic;
  		switch_out : out std_logic;
  		non_delay : out std_logic
  );
end aom_delay;
architecture Behavioral of aom_delay is

signal delay_counter : std_logic_vector (24 downto 0); 
signal signal_out : std_logic;	
signal out_delayed : std_logic;

begin


	delay: process (clk)
--	variable counter : integer range 0 to 1000000002 := 1;
--	variable max_counter : integer := 1000000000;
	variable counter : integer range 0 to 41111113 := 1;
	variable max_counter : integer := 41111111;
	begin
--		if reset = '1' then
--			delay_counter <=  (others => '0');
--			turn_off_counter <= (others => '0');
--			signal_out <= '1';

--		end if;
	
	
--		if delay_switch = '1' then
--			if counter < max_counter then
--				counter := counter + 1;
--				out_delayed <= '1';
--			else
--				signal_out <= out_delayed;
--			end if;
				
--		else
--			signal_out <= '0';
--		end if;
	
	
			
		if delay_switch = '1' then
			if counter < max_counter then
				counter := counter + 1;
			else
				signal_out <= '0';
			end if;
		elsif delay_switch <= '0' then
			signal_out <= '1';
			counter := 0;
		end if;




--if delay_switch = '1' then
--	if rising_edge (clk) then
--		if counter = 240000 then
--			switch_out <= '1';
--		elsif counter < 240000 then
--			switch_out <= '0';
--			counter := counter + 1;
--		end if;
--	end if;
--elsif  delay_switch = '0' then
--	switch_out <= delay_switch;
--	counter := 0;
--end if;

--		if rising_edge (clk) then
--			if delay_switch = '1' then
--				if delay_counter < 	"0000000111010100110000000" then
--					switch_out <= '0';
--				else 
--					switch_out <= '1';
--				end if;
--				delay_counter <= delay_counter + 1;
--			elsif delay_switch = '0' then
--				switch_out <= '0';
--				delay_counter <= "0000000000000000000000000";
--			end if;
--		end if;

--		if delay_switch = '1' then
--			if rising_edge (clk) then
----				if delay_counter < "0000000011111111111111111" then
--				if delay_counter < "0000000111010100110000000" then
----				if delay_counter < "0000000000000000000001000" then
----				if delay_counter  < "1011011100011011000000000" then -- 10 second
--					delay_counter <= delay_counter + 1;
--					switch_out <= '0';
--				else
----					delay_counter <= (others => '0');
--					switch_out <= '1';
--				end if;
--			end if;
--		elsif delay_switch = '0' then
--			switch_out <= '0';
--			delay_counter <= "0000000000000000000000000";

--		end if;
	
	end process delay;

	switch_out <= signal_out;
	non_delay <= not delay_switch;	

		

end Behavioral;
