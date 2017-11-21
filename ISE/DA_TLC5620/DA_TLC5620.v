`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 		NSSC
// Engineer: 		VanAllenYe
// 
// Create Date:    15:17:07 10/18/2017 
// Design Name:    
// Module Name:    DA_TLC5620 
// Project Name:   
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DA_TLC5620(
	sys_clk,
	sys_rst_n,

	
	DA_IO_CLK,
	DA_LOAD,
	DA_LDAC,
	DA_OUT_DATA,
	LED,
	da_clk,
	analog_data
    );

input sys_clk;
input sys_rst_n;


output DA_IO_CLK;
output DA_LOAD;
output DA_LDAC;
output DA_OUT_DATA;
output LED;

output da_clk;
output analog_data;

//reg difine
reg[5:0] div_cnt;
reg 	 da_clk;
reg[4:0] ctrl_cnt;
reg[3:0] delay_cnt;
reg[7:0] analog_data;

reg DA_IO_CLK;
reg DA_LOAD;
reg DA_LDAC;
reg[10:0] DA_OUT_DATA;
reg[7:0] LED;
//wire define

//********************************************************************************
//**                                Main Program
//**
//********************************************************************************

// counter used for div osc clk to da ctrl clk    50M/64=0.78MHz

always @(posedge sys_clk or negedge sys_rst_n)
	begin
		if(!sys_rst_n)
			div_cnt <= 1'b0;
		else
			div_cnt <= div_cnt + 1'b1;
	end

// generate da_clk

always @(posedge sys_clk or negedge sys_rst_n)
	begin
		if(!sys_rst_n)
			da_clk <= 1'b0;
		else if(div_cnt <= 6'd31)
			da_clk <= 1'b1;
		else
			da_clk <= 1'b0;
	end
//*********************************************************************************
	
// da_ctrl signal generate; ctrl_cnt 0-32 for da ctrl

always @(posedge da_clk or negedge sys_rst_n)
	begin
		if(!sys_rst_n)
			ctrl_cnt <= 1'b0;
		else
			ctrl_cnt <= ctrl_cnt + 1'b1;
	end

always @(posedge da_clk or negedge sys_rst_n)
	begin
		if(!sys_rst_n)
			DA_IO_CLK <= 1'b0;
		else if(ctrl_cnt == 5'd6 || ctrl_cnt == 5'd8 || ctrl_cnt == 5'd10 || ctrl_cnt == 5'd12 || 
				ctrl_cnt == 5'd14 || ctrl_cnt == 5'd16 || ctrl_cnt == 5'd18 || ctrl_cnt == 5'd20 ||
				ctrl_cnt == 5'd22 || ctrl_cnt == 5'd24 || ctrl_cnt == 5'd26)
			DA_IO_CLK <= 1'b1;
		else
			DA_IO_CLK <= 1'b0;
	end

always @(posedge da_clk or negedge sys_rst_n)
	begin
		if(!sys_rst_n)
			DA_LOAD <= 1'b1;
		else if(ctrl_cnt == 5'd28)			// da load
			DA_LOAD <= 1'b0;
		else
			DA_LOAD <= 1'b1;
	end

always @(posedge da_clk or negedge sys_rst_n)
	begin
		if(!sys_rst_n)
			DA_LDAC <= 1'b1;
		else if(ctrl_cnt == 5'd30)
			DA_LDAC <= 1'b0;
		else
			DA_LDAC <= 1'b1;
	end

//*******************************************************************************************

always @(posedge da_clk or negedge sys_rst_n)
	begin
		if(!sys_rst_n)
			DA_OUT_DATA <= 1'b0;
		else if(ctrl_cnt == 5'd6 || ctrl_cnt == 5'd7)				// DA load A1
			DA_OUT_DATA[10] <= 1'b0;     
		else if(ctrl_cnt == 5'd8 || ctrl_cnt == 5'd9)				// DA load A0
			DA_OUT_DATA[9] <= 1'b0; 
		else if(ctrl_cnt == 5'd10 || ctrl_cnt == 5'd11)				// DA load RNG
			DA_OUT_DATA[8] <= 1'b0;  
		else if(ctrl_cnt == 5'd12 || ctrl_cnt == 5'd13)             // DA load analog_data BIT[7]
			DA_OUT_DATA[7] <= analog_data[7];
		else if(ctrl_cnt == 5'd14 || ctrl_cnt == 5'd15)             // DA load analog_data BIT[6]
			DA_OUT_DATA[6] <= analog_data[6];
		else if(ctrl_cnt == 5'd16 || ctrl_cnt == 5'd17)             // DA load analog_data BIT[5]
			DA_OUT_DATA[5] <= analog_data[5];
		else if(ctrl_cnt == 5'd18 || ctrl_cnt == 5'd19)             // DA load analog_data BIT[4]
			DA_OUT_DATA[4] <= analog_data[4];
		else if(ctrl_cnt == 5'd20 || ctrl_cnt == 5'd21)             // DA load analog_data BIT[3]
			DA_OUT_DATA[3] <= analog_data[3];
		else if(ctrl_cnt == 5'd22 || ctrl_cnt == 5'd23)             // DA load analog_data BIT[2]
			DA_OUT_DATA[2] <= analog_data[2];
		else if(ctrl_cnt == 5'd24 || ctrl_cnt == 5'd25)             // DA load analog_data BIT[1]
			DA_OUT_DATA[1] <= analog_data[1];
		else if(ctrl_cnt == 5'd26 || ctrl_cnt == 5'd27)             // DA load analog_data BIT[0]
			DA_OUT_DATA[0] <= analog_data[0];
		else
			DA_OUT_DATA <= 1'b0;
	end

//********************************************************************************************************

always @(posedge da_clk or negedge sys_rst_n)
	begin
		if(!sys_rst_n)
			delay_cnt <= 1'b0;
		else
			delay_cnt <= delay_cnt + 1'b1;
	end

always @(posedge da_clk or negedge sys_rst_n)
	begin
		if(!sys_rst_n)
			analog_data <= 1'b0;
		else if(delay_cnt == 4'd15)
			analog_data <= analog_data + 1'b1;
	end

// display da data to LED

always @(posedge da_clk or negedge sys_rst_n)
	begin
		if(!sys_rst_n)
			LED <= 1'b0;
		else
			LED <= analog_data;
	end


endmodule
