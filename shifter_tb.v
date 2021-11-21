module shifter_tb;
 // Using reg for inputs and wire for outputs
 reg [15:0] sim_in; 
 reg [1:0] sim_shift;
 wire [15:0] sim_sout;
 reg err;
 
 //declaring dut
 shifter DUT(
 .in(sim_in),
 .shift(sim_shift),
 .sout(sim_sout)
 );

 initial begin 
    
    // initial conditions for all zeros and error = 0
    err = 1'b0;

    sim_in = 16'b0000_0000_0000_0000;
    sim_shift = 2'b00;
    #100;
    
    //1st test 
    $display("Running test 1");

    sim_in = 16'b1111000011001111; 
    sim_shift = 2'b00; 
    #100 
 
    if(sim_sout!== 16'b1111000011001111) begin
    $display("Error! Output is %b, expected is 1111000011001111", sim_sout);
    err=1'b1;
    end

    //2nd test 
    $display("Running test 2");

    sim_in = 16'b1111000011001111; 
    sim_shift = 2'b01; 
    #100 
 
    if(sim_sout!== 16'b1110000110011110) begin
    $display("Error! Output is %b, expected is 1110000110011110", sim_sout);
    err=1'b1;
    end

    //3rd test 
    $display("Running test 3");

    sim_in = 16'b1111000011001111; 
    sim_shift = 2'b10; 
    #100 
 
    if(sim_sout!== 16'b0111100001100111) begin
    $display("Error! Output is %b, expected is 0111100001100111", sim_sout);
    err=1'b1;
    end

    //4th test 
    $display("Running test 4");

    sim_in = 16'b1111000011001111; 
    sim_shift = 2'b11; 
    #100 
 
    if(sim_sout!== 16'b1111100001100111) begin
    $display("Error! Output is %b, expected is 1111100001100111", sim_sout);
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