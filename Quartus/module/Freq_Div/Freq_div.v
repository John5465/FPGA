module Freq_div(clk,rst_n,beep);

input clk;  //时钟信号，50MHz
input rst_n;    //复位信号，低电平有效
output beep;  //蜂鸣器，0--响，1--不响

reg[21:0] cnt;

always @(posedge clk or negedge rst_n)
	 if(!rst_n) cnt <= 22'd0;
    else cnt <= cnt+1'b1;

assign beep = cnt[21];

endmodule
