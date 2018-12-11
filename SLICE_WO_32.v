`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2018 02:18:05 PM
// Design Name: 
// Module Name: SLICE_WO_32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SLICE_WO_32 #(
    parameter win   = 64,
    parameter uout  = 31,
    parameter lout  = 0
    
    )(
    
    input                   clk_i,
    input   [win-1:0]       sig_i,
    output  [uout-lout:0]   sig_o
    );
        
    reg     [uout-lout:0]   sig;
    
    always @(posedge clk_i) begin
        if ({sig_i[win-1],|sig_i[win-3:uout]} == 2'b01) //positive overflow
            sig <= 32'h7FFFFFFF ;
        else if ({sig_i[win-1],&sig_i[win-2:uout]} == 2'b10) //negative overflow
            sig <= 32'h80000000 ;
        else
            sig <= sig_i[uout:lout] ;
    end
    
    assign sig_o = sig;
    
endmodule
