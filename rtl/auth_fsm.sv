`timescale 1ns/1ps
module auth_fsm #(
    parameter int NONCE_W       = 32,
    parameter int RESP_W        = 16,
    parameter int HASH_W        = 64,
    parameter int WINDOW_CYCLES = 1024
)(
    input  logic               clk,
    input  logic               rst_n,
    input  logic               start,
    input  logic [NONCE_W-1:0] nonce,
    input  logic [RESP_W-1:0]  puf_resp,
    output logic               ro_en,
    output logic               sample,
    output logic [HASH_W-1:0]  response_hash,
    output logic               done,
    output logic               error
);
    typedef enum logic [2:0] {
        IDLE, RO_ON, SAMPLE_ST, MASK, HASH, DONE, ERR
    } state_t;

    state_t state;
    logic [15:0] timer;
    logic [RESP_W-1:0] masked, permuted;
    logic [HASH_W-1:0] hash_in, hash_out_i;
    logic [NONCE_W-1:0] last_nonce;
    logic nonce_seen;

    light_hash #(.IN_W(HASH_W), .OUT_W(HASH_W)) u_hash (
        .din(hash_in),
        .dout(hash_out_i)
    );

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            timer <= '0;
            ro_en <= 1'b0;
            sample <= 1'b0;
            done <= 1'b0;
            error <= 1'b0;
            response_hash <= '0;
            masked <= '0;
            permuted <= '0;
            hash_in <= '0;
            last_nonce <= '0;
            nonce_seen <= 1'b0;
        end else begin
            done <= 1'b0;
            sample <= 1'b0;

            case (state)
                IDLE: begin
                    ro_en <= 1'b0;
                    error <= 1'b0;
                    if (start) begin
                        if (nonce_seen && (nonce == last_nonce)) begin
                            error <= 1'b1;
                            state <= ERR;
                        end else begin
                            nonce_seen <= 1'b1;
                            last_nonce <= nonce;
                            timer <= '0;
                            state <= RO_ON;
                        end
                    end
                end

                RO_ON: begin
                    ro_en <= 1'b1;
                    if (timer == WINDOW_CYCLES-1) begin
                        timer <= '0;
                        state <= SAMPLE_ST;
                    end else begin
                        timer <= timer + 1'b1;
                    end
                end

                SAMPLE_ST: begin
                    ro_en <= 1'b0;
                    sample <= 1'b1;
                    state <= MASK;
                end

                MASK: begin
                    masked <= puf_resp ^ nonce[RESP_W-1:0];
                    permuted <= {masked[RESP_W/2-1:0], masked[RESP_W-1:RESP_W/2]};
                    hash_in <= {{(HASH_W-RESP_W-NONCE_W){1'b0}}, permuted, nonce};
                    state <= HASH;
                end

                HASH: begin
                    response_hash <= hash_out_i;
                    state <= DONE;
                end

                DONE: begin
                    done <= 1'b1;
                    if (!start) state <= IDLE;
                end

                ERR: begin
                    error <= 1'b1;
                    if (!start) state <= IDLE;
                end

                default: state <= ERR;
            endcase
        end
    end
endmodule
