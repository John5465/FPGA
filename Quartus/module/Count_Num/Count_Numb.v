/******************************************
名   称：Cunt_Numb()
功   能：实现键盘控制流水灯，key1控制开关，key2顺时针亮，key3逆时针亮
入口参数：无
出口参数：无
日   期：2016/4/22
********************************************/
module Count_Numb(
	clk,rst_n,
   sw1_n,sw2_n,sw3_n,
	led 
);
input clk;        	 				//时钟信号，50MHz
input rst_n;     		  			  //复位信号，低电平有效
input  sw1_n,sw2_n,sw3_n;
output[3:0] led;                //LED控制，1-亮

reg led_dir = 1'b1;      // 1'b1==left, 1'b0==right
reg led_on = 1'b0;       // 1'b1==on,   1'b0==off

/*************************************/
reg[23:0] cnt24;

always @(posedge clk,negedge rst_n)
	if(!rst_n) cnt24 <= 24'd0;
	else cnt24 <= cnt24 + 1'b1;

/************************************/
reg[3:0] led_r;

always @(posedge clk,negedge rst_n)
	if(!rst_n) led_r <= 4'b0001;
	else if(cnt24 == 24'hffffff && led_on) 
		begin
			if(led_dir)
			led_r <= {led_r[0],led_r[3:1]};	          //left
			else  led_r <= {led_r[2:0],led_r[3]};	    //right
		end
/************************************/

assign led = led_r;



//***********ji cun sw value 按键消抖*********
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
		low_sw <= {sw3_n,sw2_n,sw3_n};
//*****************************************
reg[2:0]	low_sw_r;
always @(posedge clk or negedge rst_n)
	if(!rst_n) low_sw_r <= 3'b111;
	else low_sw_r <= low_sw;
//*****************************************
//当寄存器low_sw由1变为0时，led_ctr1的值变为高，并维持一个时钟周期
wire[2:0] led_ctr1;
assign led_ctr1=low_sw_r[2:0] & (~low_sw[2:0]);
	
always @(posedge clk or negedge rst_n)
		if(!rst_n) begin
			led_on = 1'b0;
			led_dir = 1'b0;
			end
			else begin
				if(led_ctr1[0]) led_on <= ~led_on;
	         if(led_ctr1[1]) led_dir<= 1'b0;
	         if(led_ctr1[2]) led_dir<= 1'b1;
				end


endmodule
	
