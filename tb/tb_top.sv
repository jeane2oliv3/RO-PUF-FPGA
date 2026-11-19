`timescale 1ns/1ps
module tb_top;
    logic clk = 1'b0;
    logic rst_n = 1'b0;
    logic start = 1'b0;
    logic [31:0] nonce = 32'h1234_5678;
    logic [63:0] response_hash;
    logic done, error;

    top dut (.*);

    always #5 clk = ~clk;

    task automatic do_auth(input logic [31:0] n);
        nonce = n;
        @(posedge clk);
        start = 1'b1;
        @(posedge clk);
        start = 1'b0;
        wait (done || error);
        @(posedge clk);
    endtask

    initial begin
        repeat (5) @(posedge clk);
        rst_n = 1'b1;

        do_auth(32'h1234_5678);
        $display("TESTE 1: HASH=%h ERROR=%b", response_hash, error);

        do_auth(32'h1234_5678);
        $display("TESTE 2 (nonce repetido): HASH=%h ERROR=%b", response_hash, error);

        #100;
        $finish;
    end
endmodule
