module datapath(datapath_in, vsel, writenum, write, readnum, clk, loada, loadb, shift, asel, bsel, ALUop, loadc, loads, datapath_out, Z_out);
  input write, clk, loada, loadb, vsel, asel, bsel, loadc, loads;
  input [1:0] shift, ALUop;
  input [2:0] writenum, readnum;
  input [15:0] datapath_in;
  output [15:0] datapath_out;
  output Z_out;

  wire [15:0] out,data_in, data_out, A_out, in, sout, Ain, Bin;
  wire Z;

  
  writebackmultiplexer beg(vsel, datapath_in, datapath_out, data_in);
  regfile REGFILE(data_in, writenum, write,readnum, clk, data_out); //instantiate the register
  pipeline_reg A(data_out, clk, loada, A_out); // instantiate the loadA
  pipeline_reg B(data_out, clk, loadb, in); // instantiate the loadB
  shifter SHIFT(in,shift,sout); // instantiate shifter
  Multiplexer_A mux_A(asel,A_out,16'b0, Ain);
  Multiplexer_B mux_B(bsel, sout,{11'b0,datapath_in[4:0]}, Bin);
  ALU ALU(Ain,Bin,ALUop,out,Z); //instantiate the ALU
  pipeline_reg C(out, clk, loadc, datapath_out);
  status STATUS(Z, clk, loads, Z_out); // instantiate the STATUS module
  

endmodule
