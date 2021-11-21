module Multiplexer_A (asel, pipeline_out,A_inp,Ain);    //6-put cases
  input asel;
  input [15:0] pipeline_out;
  input [15:0] A_inp;
  output reg [15:0] Ain;
  
   //output = input when sel is 0; output = 0 when sel is 1
  always @(*) begin
    case(asel)
    1'b1:Ain=A_inp;
    1'b0:Ain=pipeline_out;
    endcase
  end
endmodule


//  //need to edit
module Multiplexer_B (bsel, sout, B_inp,Bin);
  input bsel;
  input [15:0] sout,B_inp;
  output reg [15:0] Bin;  

  always @(*) begin
    case(bsel)
    1'b0:Bin=sout; 
    1'b1:Bin=B_inp;//{11'b0,}
    endcase
  end
endmodule