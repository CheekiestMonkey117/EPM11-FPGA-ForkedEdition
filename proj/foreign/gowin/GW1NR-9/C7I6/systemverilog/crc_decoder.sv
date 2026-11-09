`timescale 1ns/1ps

// Module for decoding a 16 bit value's 16 bit CRC.

module crc_decoder (
    input   logic   [15:0]  data,
    input   logic   [15:0]  crc,
    output  logic           correct
);

    // ----------------------------------------------
    //  Internal signals
    // ----------------------------------------------

    logic   [15:0]  i_expected_crc;


    // ----------------------------------------------
    //  Implementation
    // ----------------------------------------------

    crc_encoder crc_encoder_inst (
        .data   (data),
        .crc    (i_expected_crc)
    );

    assign correct = (crc == i_expected_crc);

endmodule
