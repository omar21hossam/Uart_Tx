module name #(
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

    
endmodule