module PAR_CALC #(
    parameter data_width = 8
) (
    input wire [data_width-1:0] P_Data,
    input wire                  Data_Valid,
    input wire                  PAR_Type,
    input wire                  CLK, RST,
    output reg                  PAR_Bit        
);

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        PAR_Bit <= 0;
    end else if (Data_Valid) begin
        case (PAR_Type)
        1'b0:
            PAR_Bit <= ^P_Data;
        1'b1:
            PAR_Bit <= ~(^P_Data);
        endcase
    end
    else begin
        PAR_Bit <= 0;
    end
end

endmodule