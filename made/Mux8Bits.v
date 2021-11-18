module Mux8Bits (
    input wire [2:0] selector,
    input  wire [31:0] data_0,
    input  wire [31:0] data_1,
    input  wire [31:0] data_2,
    input  wire [31:0] data_3,
    input  wire [31:0] data_4,
    input  wire [31:0] data_5,
    input  wire [31:0] data_6,
    input  wire [31:0] data_7,
    output wire [31:0] data_output
);

    parameter IS_DATA_0 = 3'b000;
    parameter IS_DATA_1 = 3'b001;
    parameter IS_DATA_2 = 3'b010;
    parameter IS_DATA_3 = 3'b011;
    parameter IS_DATA_4 = 3'b100;
    parameter IS_DATA_5 = 3'b101;
    parameter IS_DATA_6 = 3'b110;
    parameter IS_DATA_7 = 3'b111;

    reg [31:0] data;
 
    always @(*) begin
        case(selector)
            IS_DATA_0:
                data = data_0;
            IS_DATA_1:
                data = data_1;
            IS_DATA_2:
                data = data_2;
            IS_DATA_3:
                data = data_3;
            IS_DATA_4:
                data = data_4;
            IS_DATA_5:
                data = data_5;
            IS_DATA_6:
                data = data_6;
            IS_DATA_7: 
                data = data_7;
        endcase
    end

endmodule