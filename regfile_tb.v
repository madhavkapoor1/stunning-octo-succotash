module regfile_tb ();

reg [15:0] sim_data_in;
reg [2:0] sim_writenum, sim_readnum;
reg sim_write, sim_clk;
reg err; //Self-ERROR-checking
wire [15:0] sim_data_out;

REGFILE DUT(
	.data_in(sim_data_in),
	.writenum(sim_writenum),
	.readnum(sim_readnum),
	.write(sim_write),
	.clk(sim_clk),
	.data_out(sim_data_out)
);


initial begin
  //CLK MODIFY
sim_readnum = 3'b001;
sim_data_in = 16'b0000_0000_0000_0000;
sim_writenum = 3'b000;
sim_write = 1;
err = 1'b0;

  sim_clk = 0;
  forever begin
    sim_clk = !sim_clk;
    #5; 
  end
end

initial begin


$display("Running test 1"); 

sim_data_in = 16'b0000_0000_0000_0010;
sim_writenum = 3'b001;
sim_write = 1;
#50;
sim_readnum = 3'b001;
#50;
if(sim_data_out !== 16'b0000_0000_0000_0010) begin
  $display("ERROR ** output is %b, expected %b", sim_data_out, 16'b0000_0000_000_0010);
  err = 1'b1;
end



$display("Running test 2"); 

sim_data_in = 16'b1000_1100_1111_1010;
sim_writenum = 3'b010;
sim_write = 1;
#50;
sim_readnum = 3'b010;
#50;
if(sim_data_out !== 16'b1000_1100_1111_1010) begin
  $display("ERROR! output is %b, expected %b", sim_data_out, 16'b1000_1100_1111_1010);
  err = 1'b1;
end



$display("Running test 3"); 

sim_data_in = 16'b1111_0000_1000_0000;
sim_writenum = 3'b011;
sim_write = 1;
#50;
sim_readnum = 3'b011;
#50;
if(sim_data_out !== 16'b1111_0000_1000_0000) begin
  $display("ERROR ** output is %b, expected %b", sim_data_out, 16'b1111_0000_1000_0000);
  err = 1'b1;
end


$display("Running test 4"); 

sim_data_in = 16'b0000_0010_0000_1111;
sim_writenum = 3'b100;
sim_write = 1;
#50;
sim_readnum = 3'b100;
#50;
if(sim_data_out !== 16'b0000_0010_0000_1111) begin
  $display("ERROR! output is %b, expected %b", sim_data_out, 16'b0000_0010_0000_1111);
  err = 1'b1;
end



$display("Running test 5"); 

sim_data_in = 16'b1010_1000_0000_0000;
sim_writenum = 3'b101;
sim_write = 1;
#50;
sim_readnum = 3'b101;
#50;
if(sim_data_out !== 16'b1010_1000_0000_0000) begin
  $display("ERROR! output is %b, expected %b", sim_data_out, 16'b1010_1000_0000_0000);
  err = 1'b1;
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