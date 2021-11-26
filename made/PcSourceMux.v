module PcSourceMux (
    input wire [2:0] selector, 
    input wire [31:0] data_0,
    input wire [31:0] data_1,
    input wire [31:0] data_2,
    input wire [31:0] data_3,
    input wire [31:0] data_4,

    output reg [31:0] data_output
);

    parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100; 

    always @(*) begin

        case (selector)

            s0: begin
                data_output <= data_0;
            end 

            s1: begin
                data_output <= data_1; 
            end

            s2: begin
                data_output <= data_2;
            end

            s3: begin
                data_output <= data_3;
            end

            s4: begin
                data_output <= data_4;
            end
        endcase 
    end
    
endmodule