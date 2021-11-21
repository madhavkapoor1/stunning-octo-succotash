module writebackmultiplexer (vsel, datapath_in, datapath_out, data_in);  //9
  input vsel;
  input [15:0] datapath_in;
  input[15:0] datapath_out;
  output reg [15:0] data_in;


  always @(*) begin
    case(vsel)
      1'b1: data_in=datapath_in;
      1'b0: data_in=datapath_out; 
    endcase
  end
endmodule

module vDFF1(clk,D,Q);
  input clk;
  input  D;
  output Q;
  reg Q;

  always @(posedge clk)
    Q <= D;
endmodule

