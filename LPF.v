/////////////////////
// Low pass filter //
/////////////////////

// Infinite impulse response first order low pass filter
// Averages over AVG clock cycles to make the filter more efficient at low frequencies
// Outputs [c1*I(t)+c2*I(t-1)], with c1+c2=1, and c2 determining the time constant of the low pass



`timescale 1ns / 1ps



module LPF #(

    parameter AXIS_TDATA_WIDTH = 32,    
    parameter ADC_DATA_WIDTH  = 14)(
    
    input                               clk_i,      // clock in
    input   [AXIS_TDATA_WIDTH-1:0]      sig_i,      // signal in
    output  [AXIS_TDATA_WIDTH-1:0]      data_o,     // data output
    input   [AXIS_TDATA_WIDTH-1:0]      a           // sets the time constant of the low pass
    );
    


localparam  [AXIS_TDATA_WIDTH-1:0]      one = 32'b01000000000000000000000000000000;     // first bit sets the sign, so it has to be zero
                                                                                        
localparam                              AVG = 16384;
localparam                              AVGl = 14;
reg         [AVGl-1:0]                  AVGc = 0;

reg         [AXIS_TDATA_WIDTH+AVGl-1:0] sum = 0;
reg         [AXIS_TDATA_WIDTH-1:0]      sig = 0;


reg         [AXIS_TDATA_WIDTH-1:0]      sig_reg = 0;
reg         [AXIS_TDATA_WIDTH-1:0]      data_reg = 0;
reg         [2*AXIS_TDATA_WIDTH-1:0]    mult = 0;

wire        [AXIS_TDATA_WIDTH-1:0]      c1;
wire        [AXIS_TDATA_WIDTH-1:0]      c2;

assign c1 = $signed(one) - $signed(a);
assign c2 = $signed(a);

always @(posedge clk_i) begin
    if (AVGc < AVG-1) begin
        sig = sig_i;
        sum = $signed(sum) + $signed(sig);
        AVGc = AVGc + 1;
    end else begin
        sig = sig_i;
        mult         = $signed(c1)*$signed(sum[AXIS_TDATA_WIDTH+AVGl-1:AVGl]) + $signed(c2)*$signed(data_reg);
        data_reg     = mult[2*AXIS_TDATA_WIDTH-1:AXIS_TDATA_WIDTH];
        AVGc         = 0;
        sum          = $signed(sig);
    end
end

assign data_o = data_reg;

    
endmodule
