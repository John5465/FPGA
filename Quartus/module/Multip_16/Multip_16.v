/***********************************************
名   称：Multip_16()
功   能：实现两个16位二进制数的相乘
入口参数：start,ain,bin
出口参数：yout,done
************************************************/
module Multip_16(
	clk,rst_n,
	start,ain,bin,
	yout,done
);
input clk;
input rst_n;
input start;              //芯片使能信号，1有效
input[15:0] ain;
input[15:0] bin;
output[31:0] yout;
output done;             //芯片输出标志位，1表示运算完成

reg[15:0] areg;
reg[15:0] breg;
reg[31:0] yout_r;
reg done_r;              
reg[4:0] i;               //移位次数寄存器

/****************数据控制位********************/
always @(posedge clk, negedge rst_n)
	if(!rst_n) i <= 5'd0;
		else if (start && i < 5'd17) i <= i + 1'b1;
		else if (!start) i <= 5'd0;
		
/**************乘法运算完成标志位产生*************/
always @(posedge clk, negedge rst_n)
	if(!rst_n) done_r <= 1'b0;
		else if(i == 5'd16) done_r = 1'b1;
		else if(i == 5'd17) done_r = 1'b0;
assign done = done_r;

/**************专用寄存器进行移位累加运算***********/
always @(posedge clk, negedge rst_n)begin 
		if(!rst_n) begin
			areg <= 16'h0000;
			breg <= 16'h0000;
			yout_r <= 32'h00000000;
		end
		else if(start) begin          //启动运算
			if(i == 5'd0) begin        //锁存乘数，被乘数
				areg <= ain;
				breg <= bin;
			end
			else if (i > 5'd0 && i < 5'd16) begin
				if(areg[i-1]) yout_r = {1'b0,yout[30:15]+breg,yout_r[14:1]};	//累加并移位
				else yout_r <= yout_r>>1;	//移位不累加
			end 
		else if(i == 5'd16 && areg[15]) yout_r[31:16] <= yout_r[31:16]+breg;	//累加不移位
		end 
					
	end

assign yout = yout_r;

endmodule