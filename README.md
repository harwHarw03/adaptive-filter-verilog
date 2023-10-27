# adaptive-filter-vedic-mcc-verilog

yosys -q -p "synth_ice40 -top data_path_tb -json datapath.json" sim/datapath_tb.v data_path.v 8bit_test.v gabung_coba.v vedic.v mcc.v memory.v pembaruan_bobot.v addsub.v error_check.v

use nextpnr --> JSON
use arachne-pnr --> bliff
