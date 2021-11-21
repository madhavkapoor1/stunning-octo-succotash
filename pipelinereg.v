module pipeline_reg(in_data, clk, load, pipeline_out);  //3,4,5

input clk,load;
input [15:0] in_data;
output [15:0] pipeline_out;
reg [15:0] pipeline_out;

reg [15:0] MUX_out;
wire [15:0] DF_out;

vDFF16  DQ(clk,MUX_out,DF_out);

always @(*) begin
  case(load)
    1'b1:begin  MUX_out = in_data;
                pipeline_out=DF_out;
    end
    1'b0:begin MUX_out = DF_out;
             pipeline_out=DF_out;
    end
  endcase
end
endmodule

