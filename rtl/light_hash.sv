`timescale 1ns/1ps
module light_hash #(
    parameter int IN_W  = 64,
    parameter int OUT_W = 64
)(
    input  logic [IN_W-1:0]  din,
    output logic [OUT_W-1:0] dout
);
    logic [OUT_W-1:0] t;

    always_comb begin
        t = '0;
        for (int i = 0; i < OUT_W; i++) begin
            t[i] = din[i % IN_W] ^ din[(i + 7) % IN_W] ^ din[(i + 13) % IN_W];
        end
        dout = t ^ 64'h9E37_79B9_7F4A_7C15;
    end
endmodule
