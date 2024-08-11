module UART_TX #(
    parameter data_width = 8

) (
    input wire [data_width-1:0] P_Data_TOP,
    input wire                  Data_Valid_TOP,
    input wire                  PAR_EN_TOP,
    input wire                  PAR_Type_TOP,
    input wire                  CLK, RST,
    output wire                 TX_OUT_TOP,
    output wire                 BUSY_TOP
);
//* Internal Wires

wire                            SER_Done_TOP;
wire                            SER_EN_TOP;
wire                            SER_Data_TOP;
wire                            PAR_Bit_TOP;
wire     [1:0]                  Mux_Sel_TOP;

Serializer U_serializer(
.P_Data(P_Data_TOP),
.SER_EN(SER_EN_TOP),
.CLK(CLK), 
.RST(RST),
.SER_Done(SER_Done_TOP),
.SER_Data(SER_Data_TOP)
);

FSM U_FSM(
.Data_Valid(Data_Valid_TOP),
.PAR_EN(PAR_EN_TOP),
.SER_Done(SER_Done_TOP),
.CLK(CLK),
.RST(RST),
.SER_EN(SER_EN_TOP),
.BUSY(BUSY_TOP),
.Mux_Sel(Mux_Sel_TOP)
);

PAR_CALC U_PAR_CALC (
.P_Data(P_Data_TOP),
.Data_Valid(Data_Valid_TOP),
.PAR_Type(PAR_Type_TOP),
.CLK(CLK),
.RST(RST),
.PAR_Bit(PAR_Bit_TOP)
);

Mux4x1 U_MUX(
.SER_Data(SER_Data_TOP),
.PAR_Bit(PAR_Bit_TOP),
.Mux_Sel(Mux_Sel_TOP),
.CLK(CLK),
.RST(RST),
.TX_Out(TX_OUT_TOP)
);

    
endmodule