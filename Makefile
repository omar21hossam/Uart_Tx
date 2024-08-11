all: compile sim
compile:
	vlib work
	vlog -sv UART_top.sv FSM.sv mux.sv parity_calc.sv serializer.sv UART_TX_TB.sv
sim:
	vsim -logfile sim.log -c -do "run -all" work.UART_TX_TB