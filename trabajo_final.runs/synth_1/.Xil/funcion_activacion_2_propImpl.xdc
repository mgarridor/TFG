set_property SRC_FILE_INFO {cfile:/home/matiaspc/Escritorio/universidad/tfg/trabajo/trabajo_final/Nexys4DDR_Master.xdc rfile:../../../Nexys4DDR_Master.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:7 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk]
set_property src_info {type:XDC file:1 line:268 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay -clock [get_clocks clk] -min -add_delay 2.000 [get_ports {A[*]}]
set_property src_info {type:XDC file:1 line:269 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay -clock [get_clocks clk] -max -add_delay 2.000 [get_ports {A[*]}]
set_property src_info {type:XDC file:1 line:270 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay -clock [get_clocks clk] -min -add_delay 2.000 [get_ports {B[*]}]
set_property src_info {type:XDC file:1 line:271 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay -clock [get_clocks clk] -max -add_delay 2.000 [get_ports {B[*]}]
set_property src_info {type:XDC file:1 line:272 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay -clock [get_clocks clk] -min -add_delay 2.000 [get_ports {control[*]}]
set_property src_info {type:XDC file:1 line:273 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay -clock [get_clocks clk] -max -add_delay 2.000 [get_ports {control[*]}]
set_property src_info {type:XDC file:1 line:274 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay -clock [get_clocks clk] -min -add_delay 2.000 [get_ports Ma]
set_property src_info {type:XDC file:1 line:275 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay -clock [get_clocks clk] -max -add_delay 2.000 [get_ports Ma]
set_property src_info {type:XDC file:1 line:276 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay -clock [get_clocks clk] -min -add_delay 2.000 [get_ports Mb]
set_property src_info {type:XDC file:1 line:277 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay -clock [get_clocks clk] -max -add_delay 2.000 [get_ports Mb]
set_property src_info {type:XDC file:1 line:280 export:INPUT save:INPUT read:READ} [current_design]
set_output_delay -clock [get_clocks clk] -min -add_delay 0.000 [get_ports {S[*]}]
set_property src_info {type:XDC file:1 line:281 export:INPUT save:INPUT read:READ} [current_design]
set_output_delay -clock [get_clocks clk] -max -add_delay 2.000 [get_ports {S[*]}]
