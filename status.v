module status( Z, clk, loads, Z_out);//`10
  input loads,clk;
  input Z;
  output reg Z_out;

  reg mux_out;
  wire df_out;

  vDFF1 DQ(clk,mux_out,df_out);

always @(*) begin
  case(loads)
    1'b1:begin  mux_out = Z;
                Z_out=df_out;
    end
    1'b0:begin mux_out = df_out;
               Z_out=df_out;
    end
  endcase     
  end
endmodule

