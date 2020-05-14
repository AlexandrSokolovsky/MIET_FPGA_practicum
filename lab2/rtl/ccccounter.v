`timescale 1ns / 1ps

module ccccounter(
  input        clk100_i,
  input        rst_i,
  input        bt_down,
  output [6:0] hex1_o,
  output [6:0] hex0_o);

reg  [7:0] counter;

always @( posedge clk100_i or negedge rst_i ) begin
  if( !rst_i ) begin //��� ����������� ����� � ������
    counter <= 8'd0;
  end
  else
    if( bt_down ) begin //��� ����������� counter
      counter <= counter +1;
    end
end

endmodule