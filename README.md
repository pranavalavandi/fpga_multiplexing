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
-- signal signal_out : std_logic;	


delay: process (clk)
    variable counter : integer range 0 41111112 := 1;
	variable max_counter : integer := 41111111;

	begin
        if delay_switch = '1' then
            if counter < max_counter then
                counter := counter+1;
        	else
                signal_out <= '0';
        	end if;
        elsif delay_switch <= '0' then
            signal_out <= '1';
            counter := 0;
		end if;
	end process delay;
```



What this example does is, it waits for the `delay_switch` to be turned on. Open which it starts a counter. The period between each increment for the counter is given by the clock speed. On each clock cycle the process is executed, and consequently the counter is incremented.

Once the counter is finished, `signal_out` is set to 1. `signal_out` is the switch that controls the LED (in this example) and hence the LED turns on after the delay. Since `signal_out` is just a signal, it can be mapped to whichever output port is defined in the entity description of the relevant VHDL file. 



#### Template

The corresponding template for the above would be 

```vhdl
-- signal signal_out : std_logic;	


delay: process (clk)
    variable counter : integer range 0 <time_of_delay/clock_speed>+1 := 1;
	variable max_counter : integer := time_of_delay/clock_speed 

	begin
        if delay_switch = '1' then
            if counter < max_counter then
                counter := counter+1;
        	else
                signal_out <= '0';
        	end if;
        elsif delay_switch <= '0' then
            signal_out <= '1';
            counter := 0;
		end if;
	end process delay;
```



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



### Clock Synchronisation

Goal was to synchronise the zturn board with the master FPGA. However this FPGA does not have a dedicated clock input.

As such we tried to use a general IO pin as a dedicated clock input. As shown in the below three figures we can see that the clock signal breaks down as a increase the frequency, making it unfeasible to use.



![image-20210304111243424](C:\Users\pala8831\AppData\Roaming\Typora\typora-user-images\image-20210304111243424.png)![image-20210304111249621](C:\Users\pala8831\AppData\Roaming\Typora\typora-user-images\image-20210304111249621.png)



Here the yellow curve is the input clock signal, given from a signal generator, and the green curve is the the clock signal that the FPGA is 'experiencing'.