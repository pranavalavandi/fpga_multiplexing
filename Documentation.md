# FPGA board multiplexer documentation



### Board Information

Board used: MYIR z-turn board

Board name: MYS-7Z020-C-S(766)

Processor: ZYNQXC7Z020

 Link: 	http://www.myirtech.com/list.asp?id=502



Board was used in conjunction with the proprietary zturn I/O cape. 

Link: http://www.myirtech.com/list.asp?id=532





### Documentation

A CD was provided with the relevant documentation, this has been placed in a folder in the same directory labelled `\documentation`. 



The documentation on the board isn't the best. One website prescribes the basic pins that control the LED and switches, given here: https://sinetek.io/2018/07/17/myir-z-turn-fpga-board-pin-assignments/. Incase any basic functions need to be checked these pin assignments work just fine.





### Delay Signal

This is the process template to delay the sending of an output signal once an input signal is received. This will be used to delay the turning on of the feedback loop that stabilizes the AOM. Of course this can be used anywhere. 



First here is an example to indicate what's going on.

```vhdl
delay: process (clk, delay_switch)
	begin
	
		if delay_switch = '1' then
			if rising_edge (clk) then
				if delay_counter  < "1011011100011011000000000" then
					delay_counter <= delay_counter + 1;
				else
					delay_counter <= (others => '0');
					switch_out <= '1';
				end if;
			end if;
		end if;
	
	end process delay;
```



What this example does is, it waits for the `delay_switch` to be turned on. Open which it starts a counter. The period between each increment for the counter is given by the clock speed. Once the counter is finished, `switch_out` is set to 1. `switch_out` is the switch that controls the LED (in this example) and hence the LED turns on after the delay



#### Template

The corresponding template for the above would be 

```vhdl
delay: process (clk, input_signal)
	begin
	
		if delay_switch = '1' then
			if rising_edge (clk) then
				if delay_counter  < "Time_delay/clock_speed in binary" then
					delay_counter <= delay_counter + 1;
				else
					delay_counter <= (others => '0');
					signal_to_AOM <= '1';
				end if;
			end if;
		end if;
	
	end process delay;
```



Change `input_signal` and `signal_to_AOM` and the code will work fine.





### Connecting to the MYIR IO Cape

To find which IO pin on the IO cape corresponds to which pin coordinate in Vivado the following needs to happen.



The 40 main IO pins correspond to block J3. This can be found on `sheet 2 of 3` in the IO cape schematic. 

1. Let's say we are after pin 40. This corresponds to `IO_B35_LP20`. We need to find the corresponding pin name in the zturn board schematic (not the IO cape schematic)
2. On `sheet 3 of 16` we have the pin names identical to those given to the pins on the IO cape. 
3. Looking at Bank 35 we see that `IO_B35_LP20` is connected to pin `K14`. 
4. This is the pin that should be provided to Vivado when either using the IO pin-planning GUI, or manually writing the `constraints.xdc` file. 



This can be done for all 40 pins. 









### Working Code



The working code is in the project `aom_delay` in the `fpga_multiplexing` folder. 