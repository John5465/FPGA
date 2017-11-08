module Uart_Rx(
	clk,rst_n,
	rs232_rx,rx_data,rx_int,
	clk_bps,bps_start
);

input clk;            //50MHz
input rst_n;
input rs232_rx;       //Rs232接收数据
input clk_bps;        //clk_bps高电平为接收或者发送数据位的中间采样点
output bps_start;     //接收到数据后，波特率时钟启动信号置位
output[7:0] rx_data;  //接收数据寄存器，保存直至下一个数据来临
output rx_int;        //接收数据中断信号，接收数据过程中始终为高电平

//----------------------------------------------------------
reg rs232_rx0,rs232_rx1,rs232_rx2,rs232_rx3;      //接收数据寄存器，滤波用
wire neg_rs232_rx;                                //表示数据线接收到下降沿

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		rs232_rx0 <= 1'b0;
		rs232_rx1 <= 1'b0;
		rs232_rx2 <= 1'b0;
		rs232_rx3 <= 1'b0;
	end 
	else begin
		rs232_rx0 <= rs232_rx;
		rs232_rx1 <= rs232_rx0;
		rs232_rx2 <= rs232_rx1;
		rs232_rx3 <= rs232_rx2;
	end
end
//下面的下降沿检测可以滤掉<20ns-40ns的毛刺(包括高脉冲和低脉冲毛刺)，
//这里就是用资源换稳定（前提是我们对时间要求不是那么苛刻，因为输入信号打了好几拍） 
//（当然我们的有效低脉冲信号肯定是远远大于40ns的）
assign neg_rs232_rx = rs232_rx3 & rs232_rx2 & ~rs232_rx1 & ~rs232_rx0;	//接收到下降沿后neg_rs232_rx置高一个时钟周期
//---------------------------------------------------------------




endmodule