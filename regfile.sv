module regfile(input  logic        clk, 
               input  logic        we3, 		
               input  logic [4:0]  ra1, ra2, wa3, 	
               input  logic [31:0] wd3,			
               output logic [31:0] rd1, rd2);		//Output read ports

  logic [31:0]     rf[31:0];

  // three ported register file
  // read two ports combinationally
  // write third port on rising edge of clock
  // register 0 hardwired to 0

	always @ (posedge clk) 				//Always on the rising edge
		if(we3 & wa3)					//If write eneable is high
			rf[wa3] <= wd3;			//Assigning wa3 to wd3 

	/*assign rf[ra1] = rd1
	assign rf[ra2] = rd2 */

	assign rd1 = (ra1 == 0) ?  0 : rf[ra1];		//rd1 = rf[ra1] if ra = 0 is true if not then it is 0 
	assign rd2 = (ra2 == 0) ?  0 : rf[ra2];

endmodule // regfile
