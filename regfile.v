module regfile(data_in,writenum,write,readnum,clk,data_out);
input [15:0] data_in;
input [2:0] writenum, readnum;
input write, clk;
output [15:0] data_out;

wire[15:0] R0,R1,R2,R3,R4,R5,R6,R7;

wire [7:0] read_decoder_out;
wire [7:0] write_decoder_out;
wire [7:0] and_gate;


//crating output for every decoder ouput
assign and_gate[0]=write_decoder_out[0] & write;
assign and_gate[1]=write_decoder_out[1] & write;
assign and_gate[2]=write_decoder_out[2] & write;
assign and_gate[3]=write_decoder_out[3] & write;
assign and_gate[4]=write_decoder_out[4] & write;
assign and_gate[5]=write_decoder_out[5] & write;
assign and_gate[6]=write_decoder_out[6] & write;
assign and_gate[7]=write_decoder_out[7] & write;

//creating an instat for the decoders to get read/write outputs
decoder dec1(writenum,write_decoder_out);
decoder dec2(readnum,read_decoder_out);

LoadEnableCircuit r0(clk,data_in,and_gate[0],R0);
LoadEnableCircuit r1(clk,data_in,and_gate[1],R1);
LoadEnableCircuit r2(clk,data_in,and_gate[2],R2);
LoadEnableCircuit r3(clk,data_in,and_gate[3],R3);
LoadEnableCircuit r4(clk,data_in,and_gate[4],R4);
LoadEnableCircuit r5(clk,data_in,and_gate[5],R5);
LoadEnableCircuit r6(clk,data_in,and_gate[6],R6);
LoadEnableCircuit r7(clk,data_in,and_gate[7],R7);

MUX16to8 mu(R0,R1,R2,R3,R4,R5,R6,R7,read_decoder_out,data_out);

endmodule

module LoadEnableCircuit(clk,in_data,and_output,LEC_out);
input clk,and_output;
input [15:0] in_data;
output reg [15:0] LEC_out;

reg [15:0] mux_out;
wire [15:0] df_out;


always @(*) begin
  case(and_output)
    1'b1:begin  mux_out = in_data;
                LEC_out=df_out;
    end
    1'b0:begin mux_out = df_out;
               LEC_out=df_out;
    end
  endcase
end

vDFF16 dq(clk,mux_out,df_out);

endmodule


module vDFF16(clk,D,Q);
  input clk;
  input [15:0] D;
  output [15:0] Q;
  reg [15:0] Q;

  always @(posedge clk)
    Q <= D;
endmodule


module decoder(in,out);
input [2:0] in;
output [7:0] out;
wire [7:0] out= 1 << in;
endmodule




module MUX16to8 (AG0,AG1,AG2,AG3,AG4,AG5,AG6,AG7,num_sel,out_data);
input[15:0] AG0,AG1,AG2,AG3,AG4,AG5,AG6,AG7;
input [7:0] num_sel;
output [15:0] out_data;
reg [15:0] out_data;

always @(*)
begin
case(num_sel)
    8'b00000001:out_data=AG0;
    8'b00000010:out_data=AG1;
    8'b00000100:out_data=AG2;
    8'b00001000:out_data=AG3;
    8'b00010000:out_data=AG4;
    8'b00100000:out_data=AG5;
    8'b01000000:out_data=AG6;
    8'b10000000:out_data=AG7;
	 default:out_data=16'bx;
endcase
end
endmodule


