module LED_FLASH
(
	CLK,RST_N,
	LED_OUT
);
input CLK;
input RST_N;
output LED_OUT;

/******************************************
	flash_led T=100ms, light=50ms,Dark=50ms, 
	2*Count=50*10e6*0.1=5_000_000;
******************************************/

parameter T50MS = 22'd2_499_999;

/******************************************/
reg[21:0] Count1;
always@(posedge CLK or negedge RST_N)
	if(!RST_N) 
		Count1 <= 22'd0;
	else if(Count1 == T50MS)
		Count1 <= 22'd0;
	else
		Count1 <= Count1 + 1'b1;
/*******************************************/

reg rLED_OUT;
always@(posedge CLK or negedge RST_N)
	if(!RST_N) 
		rLED_OUT <= 1'b0;
	else if (Count1 == T50MS)
		rLED_OUT <= ~rLED_OUT;
/*********************************************/
assign LED_OUT = rLED_OUT;

endmodule