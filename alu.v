module ALU(Ain,Bin,ALUop,out,Z);
input [15:0] Ain, Bin;
input [1:0] ALUop;
output reg [15:0] out;
output Z;
reg Z;

always @(*) begin
    case(ALUop) 
        2'b00:
        begin 
            out=Ain+Bin;
                if(out==16'b0000000000000000)
                  Z=1'b1;
 
                else
                  Z=1'b0;
        end

        2'b01:begin 
            out=Ain-Bin;
                if(out==16'b0000000000000000)begin
                  Z=1'b1;
                end
                else
                  Z=1'b0;
        end 
        2'b10: begin
        out=Ain & Bin;
                if(out==16'b0000000000000000)begin
                  Z=1'b1;
                end
                else
                  Z=1'b0;
        end
        2'b11: begin
        out=~Bin;
                if(out==16'b0000000000000000)begin
                  Z=1'b1;
                end
                else
                  Z=1'b0;
        end
        default:Z=1'b0;
    endcase
end 
endmodule