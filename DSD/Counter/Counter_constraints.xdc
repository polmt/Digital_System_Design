# ZedBoard Pin Assignments

############################
# INPUT                    #
############################

# CLK - Zedboard 100MHz oscillator
set_property -dict { PACKAGE_PIN Y9 IOSTANDARD LVCMOS33 } [get_ports {clk}]

############################
# On-board Slide Switches  #
############################
set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { reset }];
set_property -dict { PACKAGE_PIN F22   IOSTANDARD LVCMOS33 } [get_ports { direction }];

############################
# OUTPUT                   #
############################

############################
# On-board LEDS  #
############################

set_property -dict { PACKAGE_PIN T22   IOSTANDARD LVCMOS33 } [get_ports { led_result[0] }];
set_property -dict { PACKAGE_PIN T21   IOSTANDARD LVCMOS33 } [get_ports { led_result[1] }];
set_property -dict { PACKAGE_PIN U22   IOSTANDARD LVCMOS33 } [get_ports { led_result[2] }];
set_property -dict { PACKAGE_PIN U21   IOSTANDARD LVCMOS33 } [get_ports { led_result[3] }];
set_property -dict { PACKAGE_PIN V22   IOSTANDARD LVCMOS33 } [get_ports { led_result[4] }];
set_property -dict { PACKAGE_PIN W22   IOSTANDARD LVCMOS33 } [get_ports { led_result[5] }];
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { led_result[6] }];

############################
# PmodSSO		           #
############################
set_property -dict { PACKAGE_PIN Y11   IOSTANDARD LVCMOS33 } [get_ports { seven_segment[0] }];
set_property -dict { PACKAGE_PIN AA11  IOSTANDARD LVCMOS33 } [get_ports { seven_segment[1] }];
set_property -dict { PACKAGE_PIN Y10   IOSTANDARD LVCMOS33 } [get_ports { seven_segment[2] }];
set_property -dict { PACKAGE_PIN AA9   IOSTANDARD LVCMOS33 } [get_ports { seven_segment[3] }];
set_property -dict { PACKAGE_PIN W12   IOSTANDARD LVCMOS33 } [get_ports { seven_segment[4] }];
set_property -dict { PACKAGE_PIN W11   IOSTANDARD LVCMOS33 } [get_ports { seven_segment[5] }];
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { seven_segment[6] }];

set_property -dict { PACKAGE_PIN W8   IOSTANDARD LVCMOS33 } [get_ports { digit_selection_out }];


########################################################
##ZedBoard Timing Constraints
########################################################
# define clock and period
create_clock -period 10 -name CLK -waveform {0.000 5.000} [get_ports {clk}]
