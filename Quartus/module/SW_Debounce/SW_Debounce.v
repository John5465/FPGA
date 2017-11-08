`timescale 1ns / 1ps    
/*******************************************
*名   称：SW_Debounce()
*功   能：实现按键消抖，利用LED显示
*入口参数：无
*出口参数：无
*作   者:VanAllen
*******************************************/
module SW_Debounce(
				clk,rst_n,	
				sw1_n,sw2_n,sw3_n,
				led_d1,led_d2,led_d3,
				led_d4
				);
input  clk;                  //50MHz
input  rst_n;
input  sw1_n,sw2_n,sw3_n;
output led_d1,led_d2,led_d3,led_d4;
//***********ji cun sw value****************
reg[2:0] key_rst;
always @ (posedge clk or negedge rst_n)
	if (!rst_n) key_rst <= 3'b111;
	else key_rst<={sw3_n,sw2_n,sw1_n};
	
//******************************************
reg[2:0] key_rst_r;
always @(posedge clk or negedge rst_n)
	if (!rst_n) key_rst_r <= 3'b111;
	else key_rst_r <= key_rst;
	
//*****************************************
wire [2:0] key_an = key_rst_r & (~key_rst);
//*****************************************
reg[19:0] cnt;
always @(posedge clk or negedge rst_n)
	if(!rst_n) cnt<=20'd0;
	else if(key_an) cnt<=20'd0;
	else cnt <= cnt + 1'b1;

reg[2:0] low_sw;
always @(posedge clk or negedge rst_n)
	if(!rst_n) low_sw <= 3'b111;
	else if(cnt==20'hfffff)
		low_sw <= {sw3_n,sw2_n,sw1_n};
//*****************************************
reg[2:0]	low_sw_r;
always @(posedge clk or negedge rst_n)
	if(!rst_n) low_sw_r <= 3'b111;
	else low_sw_r <= low_sw;
//*****************************************
wire[2:0] led_ctr1;
assign led_ctr1=low_sw_r[2:0] & (~low_sw[2:0]);

reg d1;
reg d2;
reg d3;
	
always @(posedge clk or negedge rst_n)
		if(!rst_n) begin
			d1 <= 1'b0;
			d2 <= 1'b0;
			d3 <= 1'b0;
			end
			else begin
				if(led_ctr1[0]) d1 <= ~d1;
	         if(led_ctr1[1]) d2 <= ~d2;
	         if(led_ctr1[2]) d3 <= ~d3;
				end

assign led_d3 = d1 ? 1'b1 : 1'b0;
assign led_d2 = d2 ? 1'b1 : 1'b0;
assign led_d1 = d3 ? 1'b1 : 1'b0;


/******************************************
	flash_led T=100ms, light=50ms,Dark=50ms, 
	2*Count=50*10e6*0.1=5_000_000;
******************************************/

parameter T50MS = 22'd2_499_999;

/********************flash_led********************/
reg[21:0] Count1;
always@(posedge clk or negedge rst_n)
	if(!rst_n) 
		Count1 <= 22'd0;
	else if(Count1 == T50MS)
		Count1 <= 22'd0;
	else
		Count1 <= Count1 + 1'b1;
/*******************************************/

reg rled_d4;
always@(posedge clk or negedge rst_n)
	if(!rst_n) 
		rled_d4 <= 1'b0;
	else if (Count1 == T50MS)
		rled_d4 <= ~rled_d4;
/*********************************************/
assign led_d4 = rled_d4;


endmodule