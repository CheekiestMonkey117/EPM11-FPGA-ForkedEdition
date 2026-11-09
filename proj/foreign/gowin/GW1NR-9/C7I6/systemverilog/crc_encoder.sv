`timescale 1ns/1ps

// Module for encoding a 16 bit value's 16 bit CRC.
//
// NOTE: CRC-16/CCITT-FALSE, MSB first. The non-zero
// INIT means an all zero word has a non-zero CRC, so
// a bus stuck low fails the check...

module crc_encoder #(
    parameter logic [15:0] POLYNOMIAL = 16'h1021,
    parameter logic [15:0] INIT       = 16'hFFFF
) (
    input   logic   [15:0]  data,
    output  logic   [15:0]  crc
);

    // ----------------------------------------------
    //  Implementation
    // ----------------------------------------------

    always_comb begin
        crc = INIT;

        for (int i_bit = 15; i_bit >= 0; i_bit = i_bit - 1) begin
            if ((crc[15] ^ data[i_bit]) == 1'b1) begin
                crc = {crc[14:0], 1'b0} ^ POLYNOMIAL;
            end else begin
                crc = {crc[14:0], 1'b0};
            end
        end
    end

endmodule
