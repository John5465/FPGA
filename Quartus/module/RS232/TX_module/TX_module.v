module TX_module
(
	CLK,RST_N,
	TX_En_Sig,TX_Data,
	TX_Done_Sig,TX_Pin_Out
);

input CLK;
input RST_N;
input TX_En_Sig;
input[7:0] TX_Data;
output TX_Done_Sig;
output TX_Pin_Out;

/******************************************************/

wire BPS_CLK;

	tx_bps_module U1
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.Count_Sig(TX_En_Sig),            // input from U2
		.BPS_CLK(BPS_CLK)                 // output -to U2
	);

/******************************************************/

	tx_control_module U2
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.TX_En_Sig(TX_En_Sig),              // input from top
		.TX_Data(TX_Data),                  // input from top
		.BPS_CLK(BPS_CLK),	               // input from U1
		.TX_Done_Sig(TX_Done_Sig),				// output -to top
		.TX_Pin_Out(TX_Pin_Out)             // output -to top
	);

/******************************************************/

endmodule