module FSM #(
    parameter data_width = 8
) (
    input wire Data_Valid,
    input wire PAR_EN,
    input wire SER_Done,
    input wire CLK, RST,
    output reg SER_EN,
    output reg BUSY,
    output reg [1:0] Mux_Sel
);

reg [1:0]  current_state, next_state;
reg BUSY_C;

localparam  IDLE        = 3'b000,
            START       = 3'b001,
            DATA        = 3'b011,
            PARITY      = 3'b010,
            STOP        = 3'b110;

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        current_state <= IDLE;
    end else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        IDLE: begin
            if (Data_Valid) begin
                next_state = START;
            end else begin
                next_state = IDLE;
            end
            end
        
        START: begin
                next_state = DATA;
            end

        DATA: begin
            if (SER_Done) begin
                if (PAR_EN) begin
                    next_state = PARITY;
                end else begin
                    next_state = STOP;
                end
            end else begin
                next_state = DATA;
            end
        end

        PARITY: begin
                next_state = STOP;
        end

        STOP: begin
                next_state = IDLE;
        end


        default: begin
            next_state = IDLE;
        end
    endcase
end

always @(*) begin
    case (current_state)
        
        IDLE: begin
                SER_EN = 0;
                BUSY_C = 0;
                Mux_Sel = 2'b01;
            end
        
        START: begin
                SER_EN = 0;
                BUSY_C = 1;
                Mux_Sel = 2'b00;
        end

        DATA: begin
                SER_EN = 1;
                BUSY_C = 1;
                Mux_Sel = 2'b10;
        end

        PARITY: begin
                SER_EN = 0;
                BUSY_C = 1;
                Mux_Sel = 2'b11;
        end

        STOP: begin
                SER_EN = 0;
                BUSY_C = 1;
                Mux_Sel = 2'b01;
        end

        default: begin
                SER_EN = 0;
                BUSY_C = 0;
                Mux_Sel = 2'b01;
        end
    endcase
end

always_ff @(posedge CLK or negedge RST) begin
    if (!RST) begin
        BUSY <= 0;
    end else begin
        BUSY <= BUSY_C;
    end
end
    
endmodule