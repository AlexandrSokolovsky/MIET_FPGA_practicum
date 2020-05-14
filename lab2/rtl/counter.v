`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2020 15:14:33
// Design Name: 
// Module Name: counter
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

module counter
  (
  input        clk100_i,
  input        rstn_i,
  input  [9:0] sw_i,
  input  [2:0] key_i,
  output [9:0] ledr_o,
  output [6:0] hex0_o,
  output [6:0] hex1_o,
  output [6:0] hex2_o
  );

reg             b_event;
reg      [9:0]  p;
reg      [7:0]  counter;
integer         counter_int;
wire     [2:0]  button_down;

button_check bt0
  (
  .reset  ( key_i[1]       ),
  .btn_i  ( !key_i[0]      ),
  .ondn_o ( button_down[0] ),
  .clk_i  ( clk100_i       )
  );

//button_check bt1
 // (
 // .btn_i  ( !key_i[1]      ),
 // .ondn_o ( button_down[1] ),
 // .clk_i  ( clk100_i       )
 // );

button_check bt2
  (
  .reset  ( key_i[1]       ),
  .btn_i  ( !key_i[2]      ),
  .ondn_o ( button_down[2] ),
  .clk_i  ( clk100_i       )
  );

always @( posedge clk100_i or negedge key_i[1] ) begin
  if ( !key_i[1] ) begin
    p           <= 10'b0;
    counter     <= 8'd0;
    counter_int <= 'd0;
    b_event     <= 1'd0;
  end
  else begin
    if ( button_down[0] )
      b_event <= 1'd1;
    if ( b_event && button_down[2] ) begin
      counter <= counter + 1'b1;
      p       <= sw_i;
      b_event <= 1'd0;
    end
    if ( key_i[0] )
      b_event <= 1'd0;
    counter_int <= counter;
  end
end

//always @( * ) begin
//  if ( b_event ) begin
//    if ( button_down[2] ) begin
//      p       = sw_i;
//      b_event = 1'b0;
//      if ( counter == 8'd255 )
//        counter = 8'd0;
//      else
//        counter = counter + 1'b1;
//    end
//  end
//  counter_int = counter;
//end

assign ledr_o = p;

dec_hex dec0
  (
  .in  ( counter_int % 10 ),
  .out ( hex0_o           )
  );

dec_hex dec1
  (
  .in  ( ( counter_int % 100 ) / 10 ),
  .out ( hex1_o                     )
  );

dec_hex dec2
  (
  .in  ( counter_int / 100 ),
  .out ( hex2_o            )
  );

endmodule