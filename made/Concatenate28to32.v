module Concatenate28to32(
    input   wire   [31:0]   PC,
    input   wire   [27:0]   Shift_left_out,
    output  wire   [31:0]   Concatenated_32
);

    assign Concatenated_32 = {PC[31:28], Shift_left_out};

endmodule