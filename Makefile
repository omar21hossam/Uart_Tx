all: compile sim
compile:
	vlib work
	vlog -sv alu.sv Arith_unit.sv cmp_unit.sv Decoder_unit.sv Logic_unit.sv shift_unit.sv alu_top_tb.sv
sim:
	vsim -logfile sim.log -c -do "run -all" work.ALU_TOP_TB