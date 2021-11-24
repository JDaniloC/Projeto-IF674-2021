module ss_control(
    input   wire    [1:0]   ss_control,
    input   wire    [31:0]  data,
    input   wire    [31:0]  b_out,
    output  reg    [31:0]  ss_out
);

always @ (*)
    begin
        if (ss_control == 2'b01) begin 
            ss_out = b_out;
        end
        else if (ss_control == 2'b10) begin 
            ss_out = {data[31:16], b_out[15:0]};
        end
        else if (ss_control == 2'b11) begin
            ss_out = {data[31:8], b_out[7:0]};
        end
    end

endmodule