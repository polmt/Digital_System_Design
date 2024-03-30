# Define the clock
create_clock -name clk -period 10 [get_ports clk]

# Set input and output delays
set_input_delay -clock clk 2 [get_ports {a[3] a[2] a[1] a[0]}]  # 2ns input delay
set_output_delay -clock clk 2 [get_ports {Result[3] Result[2] Result[1] Result[0]}]

# Set maximum delay (propagation delay)
set_max_delay 8 -from [get_ports {a[3] a[2] a[1] a[0]}] -to [get_ports {Result[3] Result[2] Result[1] Result[0]}]

# Set minimum delay (contamination delay)
set_min_delay 1 -from [get_ports {a[3] a[2] a[1] a[0]}] -to [get_ports {Result[3] Result[2] Result[1] Result[0]}]

# Set clock uncertainty (skew)
set_clock_uncertainty 0.5 [get_clocks clk]

# Define setup and hold checks
set_max_time_borrow 0.1

