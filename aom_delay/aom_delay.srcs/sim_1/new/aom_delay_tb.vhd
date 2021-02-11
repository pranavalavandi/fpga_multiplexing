library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity aom_delay_tb is
end;

architecture bench of aom_delay_tb is

  component aom_delay
    Port (
    		clk : in std_logic; 
    		reset : in std_logic;
    		delay_switch : in std_logic;
    		switch_out : out std_logic
    );
  end component;

  signal clk: std_logic;
  signal reset: std_logic;
  signal delay_switch: std_logic;
  signal switch_out: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: aom_delay port map ( clk          => clk,
                            reset        => reset,
                            delay_switch => delay_switch,
                            switch_out   => switch_out );

  stimulus: process
  begin
  
   -- Put initialisation code here
	reset <= '1';
    wait for 5 ns;
    reset <= '0';
    wait for 10 ns;
    delay_switch <= '0';

    -- Put test bench stimulus code here
	wait for clock_period * 10;
	delay_switch <= '1';
	wait for clock_period * 30;
	delay_switch <= '0';
	wait for clock_period * 10;
	delay_switch <= '1';
	wait for clock_period * 30;
	delay_switch <= '0';
	wait for clock_period * 10;
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