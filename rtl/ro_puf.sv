`timescale 1ns/1ps
module ro_puf #(
    parameter int N_RO    = 32,
    parameter int COUNT_W = 16,
    parameter int RESP_W  = N_RO/2
)(
    input  logic              clk,
    input  logic              rst_n,
    input  logic              ro_en,
    input  logic              sample,
    output logic [RESP_W-1:0] response
);
    logic [N_RO-1:0] ro_out;
    logic [COUNT_W-1:0] cnt [N_RO];
    logic [COUNT_W-1:0] cnt_latched [N_RO];

    generate
        for (genvar i = 0; i < N_RO; i++) begin : g_ro
            ring_oscillator u_ro (
                .en(ro_en),
                .ro_out(ro_out[i])
            );

            always_ff @(posedge ro_out[i] or negedge rst_n) begin
                if (!rst_n) cnt[i] <= '0;
                else if (ro_en) cnt[i] <= cnt[i] + 1'b1;
            end
        end
    endgenerate

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (int i = 0; i < N_RO; i++) cnt_latched[i] <= '0;
        end else if (sample) begin
            for (int i = 0; i < N_RO; i++) cnt_latched[i] <= cnt[i];
        end
    end

    always_comb begin
        for (int i = 0; i < RESP_W; i++) begin
            response[i] = (cnt_latched[i] > cnt_latched[i + RESP_W]) ? 1'b1 : 1'b0;
        end
    end
endmodule
