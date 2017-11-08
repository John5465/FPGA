module Key_Interface_Demo
(
	CLK,RST_N,
	Key_In,
	Led_Out
);

input CLK;
input RST_N;
input[3:0] Key_In;
output Led_Out;

/*************************************************/

wire[3:0] Key_Out;

	key_interface U1
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.Key_In(Key_In),
		.Key_Out(Key_Out)
	);

/*************************************************/

	optional_pwm_module U2
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.Option_Key(Key_Out),
		.Led_Out(Led_Out)
	);


endmodule