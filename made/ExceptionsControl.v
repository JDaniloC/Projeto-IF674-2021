module ExceptionsControl (
    input wire [1:0] exceptions_control,
    output reg [31:0] exceptions_out
);

    parameter s0 = 0, s1 = 1, s2 = 2;

        always @(*) begin
            case (exceptions_control)
                s0:
                    exceptions_control <= 32'd253;
                s1:
                    exceptions_control <= 32'd254;
                s2:
                    exceptions_control <= 32'd255;
            endcase
        end
endmodule