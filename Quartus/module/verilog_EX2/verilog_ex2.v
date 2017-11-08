`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:
// Design Name:    
// Module Name:    
// Project Name:
// Target Device:  
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 欢迎加入EDN的FPGA/CPLD助学小组一起讨论：http://group.ednchina.com/1375/
////////////////////////////////////////////////////////////////////////////////
module verilog_ex2(
            clk,rst_n,
            clk_div
        );

input clk;      //50MHz
input rst_n;    //低电平复位信号

output clk_div; //2分频信号

//---------------------------------------------------
reg cnt;    //分频计数器

always @ (posedge clk or negedge rst_n) //异步复位
    if(!rst_n) cnt <= 1'b0;
    else cnt <= ~cnt;   //寄存器cnt 20ms循环计数

assign clk_div = cnt;

endmodule