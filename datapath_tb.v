module datapath_tb;
 // Using reg for inputs and wire for outputs
 reg sim_write, sim_clk, sim_loada, sim_loadb, sim_vsel, sim_asel, sim_bsel, sim_loadc, sim_loads;
 reg [1:0] sim_shift, sim_ALUop;
 reg [2:0] sim_readnum, sim_writenum;
 reg [15:0] sim_datapath_in;
 wire [15:0] sim_datapath_out;
 wire sim_Z_out;

 reg err;
	
 //declaring dut
 datapath DUT(
 .clk(sim_clk),
 .readnum(sim_readnum),
 .vsel(sim_vsel),
 .loada(sim_loada),
 .loadb(sim_loadb),
 .shift(sim_shift),
 .asel(sim_asel),
 .bsel(sim_bsel),
 .ALUop(sim_ALUop),
 .loadc(sim_loadc),
 .loads(sim_loads),
 .writenum(sim_writenum),
 .write(sim_write),
 .datapath_in(sim_datapath_in),
 .Z_out(sim_Z_out),
 .datapath_out(sim_datapath_out)
 );
 
 initial begin
   //CLK MODIFY
   sim_clk = 0;
   forever begin
     #50 sim_clk = !sim_clk;
   end
 end

 initial begin
 
 err = 1'b0;

 // Load 7 into R0
 sim_datapath_in = 16'b0000000000000111; //Decimal 7; 
 sim_vsel = 1'b1;
 sim_writenum = 3'b000;
 sim_write = 1'b1;
 #100

 // Load 2 into R1
 sim_datapath_in = 16'b000000000000010; //Decimal 2; 
 sim_writenum = 3'b001;
 #100
 
 // Read 7 from R0
 sim_readnum = 3'b000;
 sim_loadb = 1'b1;
 #50
 
 // Read 2 from R1
 sim_readnum = 3'b001;
 sim_loada = 1'b1;
 #50

 // Cycle 3
 sim_shift = 2'b01;
 sim_asel = 1'b0;
 sim_bsel = 1'b0;
 sim_ALUop = 2'b00;
 sim_loadc = 1'b1;
 #150

 if(sim_datapath_out != 16'b0000000000010000) begin
 $display("Error! Output is %b, expected is 0000000000010000", sim_datapath_out);
 err=1'b1;
 end

 if(err==1'b0) begin
 $display("No Error. Test Successful");
 end
 else begin
 $display(" Error!! Test Unsuccessful");
 end
 
 $stop;
 end

endmodule