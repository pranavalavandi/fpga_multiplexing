-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity led_blink_delay_tb is
end;

architecture bench of led_blink_delay_tb is

  component led_blink_delay
  	port (
  		clk: in std_logic;
  		reset : in std_logic;
  		led: out std_logic;
  		delay_switch : in std_logic
  	);
  end component;

  signal clk: std_logic;
  signal reset: std_logic;
  signal led: std_logic;
  signal delay_switch: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: led_blink_delay port map ( clk          => clk,
                                  reset        => reset,
                                  led          => led,
                                  delay_switch => delay_switch );

  stimulus: process
  begin
  
    -- Put initialisation code here

    reset <= '1';
    wait for 5 ns;
    reset <= '0';
    wait for 5 ns;
	delay_switch <= '0';
    -- Put test bench stimulus code here
    
    wait for clock_period * 10;
    
    delay_switch <= '1';
    
    wait for clock_period * 100;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;