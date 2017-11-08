module led0_module
(
	CLK, RST_N, LED_OUT
);
input CLK;
input RST_N;
output LED_OUT;

/*****************************************************/
//XTAL=50MHz,  T=100Ms,   50*10^6*100*10^(-3)=5_000_000

parameter T100MS = 23'd5_000_000;
/********************Counting**************************/

reg[22:0] Count1;

always@(posedge CLK or negedge RST_N)
	if(!RST_N)
		Count1 <= 23'd0;
		else if(Count1 == T100MS)  
		Count1 <= 23'd0;
	else 
		Count1 <= Count1 + 1'b1;
		
/***************************************************/
reg rLED_OUT;

always@(posedge CLK or negedge RST_N)
	if(!RST_N) 
		rLED_OUT <= 1'b0;
	else if (Count1 >= 23'd0 && Count1 < 23'd1_250_000)
		rLED_OUT <= 1'b1;
	else
		rLED_OUT <= 1'b0;
/****************************************************/

assign LED_OUT = rLED_OUT;
endmodule