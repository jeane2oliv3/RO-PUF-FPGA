`timescale 1ns/1ps
module top (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic [31:0] nonce,
    output logic [63:0] response_hash,
    output logic        done,
    output logic        error
);
    logic ro_en, sample;
    logic [15:0] puf_resp;

    ro_puf #(
        .N_RO(32),
        .COUNT_W(16),
        .RESP_W(16)
    ) u_puf (
        .clk(clk),
        .rst_n(rst_n),
        .ro_en(ro_en),
        .sample(sample),
        .response(puf_resp)
    );

    auth_fsm #(
        .NONCE_W(32),
        .RESP_W(16),
        .HASH_W(64),
        .WINDOW_CYCLES(1024)
    ) u_fsm (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .nonce(nonce),
        .puf_resp(puf_resp),
        .ro_en(ro_en),
        .sample(sample),
        .response_hash(response_hash),
        .done(done),
        .error(error)
    );
endmodule
