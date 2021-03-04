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

	variable counter : integer range 0 to 41111113 := 1;
	variable max_counter : integer := 41111111;
	begin
	
			
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




	
	end process delay;

	switch_out <= signal_out;
	non_delay <= not delay_switch;	

		

end Behavioral;
