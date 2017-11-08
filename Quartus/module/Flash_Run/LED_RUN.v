module LED_RUN
(
	CLK,RST_N,
	LED_OUT
);
input CLK;
input RST_N;
output[2:0] LED_OUT;

/*********************************************
	f=3.3Hz, T=1/3.3=300ms(100+100+100);
	Count=50*10e6*0.1=23'd5_000_000;();
********************************************/
parameter T100MS = 23'd5_000_000;
/******************Clock***********************/

reg[22:0] Count2;

always@(posedge CLK or negedge RST_N)
	if(!RST_N)
		Count2 <= 23'd0;
	else if(Count2 <= 23'd5_000_000)
		Count2 <= Count2 + 1'b1;
	else 
		Count2 <= 23'd0;
/********************jicishu**********************/

reg[1:0] Count_freq;
always@(posedge CLK or negedge RST_N)
	if(!RST_N)
		Count_freq <= 2'd0;
	else if(Count_freq == 2'b1) 
		Count_freq <= 2'd0;
	else 
		Count_freq <= Count_freq + 1'b1;

/********************************************/
reg[2:0] rLED_OUT;

always@(posedge CLK or negedge RST_N)
	if(!RST_N)
		rLED_OUT <= 3'b001;
	else if(Count_freq == 2'd1)
		begin 
		if(rLED_OUT <= 3'b000)
			rLED_OUT <= 3'b001;
		else
			rLED_OUT <= {rLED_OUT[1:0],1'b0};
		end
/************************************************/

assign LED_OUT = rLED_OUT;

/************************************************/

endmodule