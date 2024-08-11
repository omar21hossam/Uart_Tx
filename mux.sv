module Mux4x1(
    input wire                  SER_Data,
    input wire                  PAR_Bit,
    input wire   [1:0]          Mux_Sel,
    input wire                  CLK, RST,
    output reg                  TX_Out
);


//*--------------------------------------
//*          Internal Signals
//*--------------------------------------
reg mux_out;

//*--------------------------------------
//*          Sequantial Block
//*--------------------------------------

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        TX_Out <= 0;
    end else begin
        TX_Out <= mux_out;
    end
end

//*--------------------------------------
//*          Combinational Block
//*--------------------------------------

always @(*) begin
    case (Mux_Sel)
        2'b00: begin
            mux_out = 1'b0;
        end
        2'b01: begin
            mux_out = 1'b1;
        end
        2'b11: begin
            mux_out = PAR_Bit;
        end
        2'b10:begin
            mux_out = SER_Data;
        end

    endcase
end
endmodule