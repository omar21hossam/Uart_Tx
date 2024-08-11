module Serializer #(
    parameter data_width = 8
) (
    input wire [data_width-1:0] P_Data,
    input wire                  SER_EN,
    input wire                  CLK, RST,
    output reg                  SER_Done,
    output reg                  SER_Data
);

reg [2:0] i;

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        SER_Data <= 1'b0;
        SER_Done <= 1'b0;
        i <= 0;
    end 
    else if (SER_EN) begin
        if (i < data_width -1) begin
            SER_Data <= P_Data[i];
            i = i + 1;
        end
        
    end
    else begin
        SER_Data <= 1'b0;
        SER_Done <= 1'b0;
        i <= 0;
    end

end
    
endmodule