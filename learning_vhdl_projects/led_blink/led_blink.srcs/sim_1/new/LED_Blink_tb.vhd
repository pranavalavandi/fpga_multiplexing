library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity LED_Blink_tb is
end;

architecture bench of LED_Blink_tb is

  component LED_Blink
  	port (
  		CLK_50MHz: in std_logic;
  		LED: out std_logic;
  		reset : in std_logic
  	);
  end component;

  signal CLK_50MHz: std_logic;
  signal LED: std_logic;
  signal reset: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: LED_Blink port map ( CLK_50MHz => CLK_50MHz,
                            LED       => LED,
                            reset     => reset );

  stimulus: process
  begin
  
    -- Put initialisation code here

    reset <= '1';
    wait for 5 ns;
    reset <= '0';
    wait for 5 ns;

	wait for clock_period * 100;
    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK_50MHz <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;