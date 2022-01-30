module stimulus();
    //input
	logic clk;
    	logic we3;
	logic [4:0]  ra1, ra2, wa3;
	logic [31:0] wd3;
    //Output
	logic [31:0] rd1, rd2; 
    
	integer a; 
	integer b;

    
    // Instantiate DUT
    regfile dut(.clk(clk),.we3(we3),.ra1(ra1),.ra2(ra2),.wa3(wa3),.wd3(wd3),.rd1(rd1),.rd2(rd2));

    // Setup the clock to toggle every 1 time units 
    initial 
      begin  
        clk = 1'b1;
        forever #5 clk = ~clk;
      end

    initial
      begin
        // Gives output file name
        a = $fopen("test_regfile.out");
        // Tells when to finish simulation
        #500 $finish;         
      end

    always 
      begin
        b = a;
        #5 $fdisplay(b, "%b %b || %b", we3,ra1,ra2,wa3,wd3,rd1,rd2);
      end

    initial 
      begin 

        //Proving writes only take effect on rising edge of the clock and when write enable is at high.
        // when reading and writing the same register it updates on rising clock edge

        //Writing and reading register zero

        #0  we3 = 0;      //initially setting write enable to 0
        #0 	wd3 = 32'b011; 	// writing data so putting 3 as our data or 011
        #0 	wa3 = 5'b011; 	// putting to the address or register 3 
        #0 	ra1 = 5'b011; 	// reading register address 3 
        #0 	ra2 = 5'b0; 		// reading register address 0 to see if its set to zero like it should 
        #0 	rd1 = 32'b0; 	// reading the data.
        #0 	rd2 = 32'b0; 	// reading the data 
        #15 we3 = 1;  								// setting write enable to high
        #25 we3 = 0; 								// setting write enable to low

        //writing to register zero
        #10  we3 = 1;
        #0  wd3 = 32'b01; 
        #0 	wa3 = 5'b0;
        #0  ra2 = 5'b0;
        #0  rd2 = 5'b0;
        #5  we3 = 0;

        #10 we3 =1;
        #0 	wd3 = 32'b01; 	// writing data so putting 1 as our data or 01
        #0 	wa3 = 5'b01; 	// putting to the address or register 1 
        #0 	ra1 = 5'b01; 	// reading register address 1 
        #0 	ra2 = 5'b01; 		// reading register address 1 to see if its set to zero like it should 
        #0 	rd1 = 32'b0; 	// reading the data.
        #0 	rd2 = 32'b0; 	// reading the data 
        #15 we3 = 1;  								// setting write enable to high
        #25 we3 = 0; 								// setting write enable to low
         
        //writing data 
        #20 wd3 = 32'b0101;	//writing data to be put into the 1st register
        #20 wd3 = 32'b0111;	//setting write data to 7 so we can show it changes combinatorially
        #0 	we3 = 1; 									// set enable high
        #5 	wa3 = ra2; 		          //write address to address to 1 
        #10 we3 = 0; 								// set enable low 
        #15 ra1 = 1'b0; 	          //reading the address zero to see we get zero
        
      end

endmodule 
