module Mult (
    input wire [31:0] A,
    input wire [31:0] B,
    input wire clock,
    input wire reset,
    input wire mult_start,


    output reg [31:0] HI,
    output reg [31:0] LO,
    output reg mult_end
);

    integer counter = 32;
    reg [64:0] add, sub, product;
    reg [31:0] comp;


    always @(posedge clock) begin
        
        if(reset == 1'b1) begin
            HI = 32'b0;
            LO = 32'b0;
            counter = 32;
            mult_end = 1'b0;
            product = 65'd0;
            comp = 32'd0;
            sub = 65'd0;
            add = 65'd0; 
        end else begin

            if (mult_start == 1'b1) begin
                
                add = {B, 33'b0};
                comp = ~B + 1'b1;
                sub = {comp, 33'b0};
                product = {32'd0, A, 1'd0};
                mult_end = 1'b0;
                counter = 32;

            end else begin

                case(product[1:0])

                    2'b01: begin
                        product = product + add;
                    end

                    2'b10: begin
                        product = product + sub;
                    end

                endcase

                product = product >> 1;

                if(counter > 0) begin
                    counter = counter - 1;
                end


                if (counter == 0) begin
                    HI = product[64:33];
                    LO = product[32:1];
                    mult_end = 1'b1;
                    product = 65'd0;
                    comp = 32'd0;
                    sub = 65'd0;
                    add = 65'd0;

                    counter = -1; 
                end
            end
        end
    end    
endmodule