PROJECTNAME=gabung_coba
VERILOGS="data_path.v 8bit_test.v gabung_coba.v vedic.v mcc.v memory.v pembaruan_bobot.v addsub.v error_check.v"
yosys -q -p "synth_ice40 -top $PROJECTNAME -json $PROJECTNAME.json" $VERILOGS || exit

# nextpnr-ice40 --force --json $PROJECTNAME.json --pcf $PROJECTNAME.pcf --asc $PROJECTNAME.asc --freq 12 --hx1k --package tq144 $1 || exit

# icetime -p $PROJECTNAME.pcf -P tq144 -r $PROJECTNAME.timings -d hx1k -t $PROJECTNAME.asc

# icepack $PROJECTNAME.asc $PROJECTNAME.bin || exit

# iceprog $PROJECTNAME.bin || exit

# echo DONE.