library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity register is
    port(
        clk : in std_logic;
        p1_in : in std_logic;
        p2_in : in std_logic;
        p3_in : in std_logic;
		  reset_in : in std_logic;
		  startstop_in : in std_logic;
        p1_out : out std_logic;
        p2_out : out std_logic;
        p3_out : out std_logic;
		  reset_out : out std_logic;
		  startstop_out : out std_logic;
        )
end register;
architecture Behav of Register is
	signal ison : std_logic:='0';
	signal ss : std_logic;
    begin
        process(clk)
        begin
            if rising_edge(clk) then
					p1_out <= p1_in;
					p2_out <= p2_in;
					p3_out <= p3_in;
            end if;
        end process;
		 

    debounceReset : entity work.DebounceUnit(Behavioral)
        generic map(
            kHzClkFreq         => 50000,
            mSecMinInWidth     => 100,
            inPolarity         => '0',
            outPolarity        => '1')
        port map(
            refClk        => clk,
            dirtyIn       => reset_in,
            pulsedOut     => reset_in);

    debounceStartStop : entity work.DebounceUnit(Behavioral)
        generic map(
            kHzClkFreq         => 50000,
            mSecMinInWidth     => 100,
            inPolarity         => '0',
            outPolarity        => '1')
        port map(
            refClk    => clk,
            dirtyIn   => startstop_in,
            pulsedOut => startstop_out);
    end Behav;