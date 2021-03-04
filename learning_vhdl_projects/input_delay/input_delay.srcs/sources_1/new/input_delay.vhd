----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2021 11:14:35
-- Design Name: 
-- Module Name: input_delay - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity input_delay is
    Port ( a : in STD_LOGIC;
           clk : in STD_LOGIC; 
           b : in STD_LOGIC;
           c : out STD_LOGIC);
end input_delay;

architecture Behavioral of input_delay is

constant c_CNT_100HZ : natural := 125000;

signal toggle : STD_LOGIC := '0'; 
signal r_CNT_100HZ : natural range 0 to c_CNT_100HZ;

begin

process (clk)
begin
    if rising_edge(clk) then
      if r_CNT_100HZ = c_CNT_100HZ-1 then  -- -1, since counter starts at 0
        toggle <= not toggle;
        r_CNT_100HZ    <= 0;
      else
        r_CNT_100HZ <= r_CNT_100HZ + 1;
      end if;
    end if;
end process;


c <= toggle when (a = '1' or b = '1');

end Behavioral;
