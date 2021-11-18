module Mult (
    input wire [31:0] A,
    input wire [31:0] B,
    input wire clock,
    input wire reset,
    input wire mult_in,


    output reg [31:0] hi,
    output reg [31:0] lo,
    output reg mult_out
);

    integer counter = 32;
    reg [64:0] add, sub, product;
    reg [31:0] comp;


    always @(posedge clock) begin
        
        if(reset == 1'b1) begin
            hi = 32'b0;
            lo = 32'b0;
            mult_out = 1'b0;
        end

        if(mult_in == 1'b1) begin
            add = {A, 33'b0};
            comp = (~A + 1'b1);
            sub = {comp, 33'b0};
            product = {32'b0, B, 1'b0};
            counter = 32;
            mult_out = 1'b0;
        end


        case(product[1:0])

        2'b01: begin
            product = product + add;
        end

        2'b10: begin
            product = product - sub;
        end

        endcase

        product = product >> 1;

        if(product[63] == 1'b1) begin
            product[64] = 1'b1;
        end

        if(counter > 0) begin
            counter = counter - 1;
        end


        if(counter == 0) begin
            hi = product[64:33];
            lo = product[32:1];
            mult_out = 1'b1;
            counter = -1;
        end

        if(counter == -1 ) begin
            product = 65'd0;
            comp = 32'd0;
            sub = 65'd0;
            add = 65'd0; 
        end

    end    
endmodule