module LED_Module
(
	CLK, RST_N, 
	LED_OUT,
	DB,CS,
);

input CLK;
input RST_N;
output[3:0] LED_OUT;
output[6:0] DB;            //7段数码管，不包括小数点
output[5:0] CS;

/******************Instantiation****************/
/***********************************************/
wire LED0_OUT;

led0_module U1
(
	.CLK(CLK),
	.RST_N(RST_N),
	.LED_OUT(LED0_OUT)
);
/**********************************************/
wire LED1_OUT;

led1_module U2
(
	.CLK(CLK),
	.RST_N(RST_N),
	.LED_OUT(LED1_OUT)
);
/************************************************/
wire LED2_OUT;

led2_module U3
(
	.CLK(CLK),
	.RST_N(RST_N),
	.LED_OUT(LED2_OUT)
);
/************************************************/
wire LED3_OUT;

led3_module U4
(
	.CLK(CLK),
	.RST_N(RST_N),
	.LED_OUT(LED3_OUT)
);
/************************************************/ 
/*wire[6:0] SM_DBr;

 Digital_Tube U5(
	.clk(CLK),
	.rst_n(RST_N),
	.sm_db(SM_DBr),
	.cs(CS)
);

/************************************************/

/*assign DB = SM_DBr;*/
assign LED_OUT = {LED3_OUT, LED2_OUT, LED1_OUT, LED0_OUT};

/**************************************************/
endmodule