`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2018 12:39:24 PM
// Design Name: 
// Module Name: split_data
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


module split_data #(

    parameter AXIS_TDATA_WIDTH = 32)(

    input   [AXIS_TDATA_WIDTH-1:0]      S_AXIS_tdata,
    input                               S_AXIS_tvalid,
    
    output  [AXIS_TDATA_WIDTH/2-1:0]    M_AXIS_OUT1_tdata,
    output                              M_AXIS_OUT1_tvalid,
    
    output  [AXIS_TDATA_WIDTH/2-1:0]    M_AXIS_OUT2_tdata,
    output                              M_AXIS_OUT2_tvalid
    );
    
    assign M_AXIS_OUT1_tdata = S_AXIS_tdata[AXIS_TDATA_WIDTH/2-1:0];
    assign M_AXIS_OUT2_tdata = S_AXIS_tdata[AXIS_TDATA_WIDTH-1:AXIS_TDATA_WIDTH/2];
    assign M_AXIS_OUT1_tvalid = S_AXIS_tvalid;
    assign M_AXIS_OUT2_tvalid = S_AXIS_tvalid;
    
endmodule
