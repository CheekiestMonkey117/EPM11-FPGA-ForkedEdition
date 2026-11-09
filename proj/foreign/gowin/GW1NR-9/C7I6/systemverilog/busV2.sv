// bus version 2



module bus_v2 (
    input M_clk,
    input S_clk,
    input S_VALID,
    inout logic MS_IO,
    inout [15:0] DataBus,
);

// Variables:
wire S_clk_enabled;
wire M_REQ;
wire M_sync_en;

// ---------------------------
// HANDSHAKE
// ---------------------------

S_clk_enabled = S_clk & M_sync_en;
dff_synchroniser Mclk_sync(.clk(S_clk_enabled), .async(M_clk), .sync(M_REQ));

always_ff @(posedge M_REQ) begin

    if (MS_IO_wr_en) begin // if slave is enabled to write to the ms_io wire
        MS_IO = M_REQ & S_VALID;
    end

    // And another case that sets MS_IO = z; so that when we don't use the MS_IO to send we just recieve from master.

end


always_ff @(M_clk && wr_en) begin

    case (count)
        0 : R1 = DataBus;
        1 : R0 = DataBus;
        2 : R2 = R1, R1 = Databus;
        3 : R0 = DataBus;
    endcase



endmodule






