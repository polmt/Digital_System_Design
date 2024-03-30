########################################################
# ZedBoard Pin Assignments
########################################################
# CLK - Zedboard 100MHz oscillator
set_property -dict { PACKAGE_PIN Y9 IOSTANDARD LVCMOS33 } [get_ports {CLK}]

########################################################
##ZedBoard Timing Constraints
########################################################
# define clock and period
create_clock -period 10 -name CLK -waveform {0.000 5.000} [get_ports {CLK}]
