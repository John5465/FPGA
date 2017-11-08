module MIX_LED
(
	CLK,RST_N,
	FLASH_LED,
	RUN_LED
);
input CLK;
input RST_N;
output FLASH_LED;
output[2:0] RUN_LED;

/*****************************************************/

	wire led_out1;
	LED_FLASH U1
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.LED_OUT(led_out1)
	);
	assign FLASH_LED = led_out1;
	
/*******************************************************/

	wire[2:0] led_out2;
	LED_RUN U2
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.LED_OUT(led_out2)
	);
	assign  RUN_LED = led_out2;

/*******************************************************/
endmodule