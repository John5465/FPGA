`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:47:35 10/18/2017
// Design Name:   DA_TLC5620
// Module Name:   D:/workspace1/NewDocument/ISE/DA_TLC5620/DA_TCL5620_tb.v
// Project Name:  DA_TLC5620
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DA_TLC5620
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DA_TCL5620_tb;

	// Inputs
	reg sys_clk;
	reg sys_rst_n;
	
	reg[7:0] analog_data;

	// Outputs
	wire DA_IO_CLK;
	wire DA_LOAD;
	wire DA_LDAC;
	wire DA_OUT_DATA;
	wire [7:0] LED;
	reg da_clk;

	// Instantiate the Unit Under Test (UUT)
	DA_TLC5620 uut (
		.sys_clk(sys_clk), 
		.sys_rst_n(sys_rst_n), 
		.DA_IO_CLK(DA_IO_CLK), 
		.DA_LOAD(DA_LOAD), 
		.DA_LDAC(DA_LDAC), 
		.DA_OUT_DATA(DA_OUT_DATA), 
		.LED(LED),
		.da_clk(da_clk)
	);

	initial begin
		// Initialize Inputs
		sys_clk = 0;
		sys_rst_n = 0;

		// Wait 100 ns for global reset to finish
		#10;
		analog_data[7:0] <= 8'b11010011;
		sys_rst_n = 1;
        
		// Add stimulus here

	end
	
	always #1 sys_clk <= ~sys_clk;
      
endmodule

