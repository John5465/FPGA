module TX_module_Demo
(
	CLK,RST_N,
	TX_Pin_Out
);

input CLK;
input RST_N;
output TX_Pin_Out;

/****************************************************/

wire[7:0] TX_Data;
wire TX_En_Sig;

	control_module U1
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.TX_Done_Sig(TX_Done_Sig),		// input from U2
		.TX_En_Sig(TX_En_Sig),			// output -to U2
		.TX_Data(TX_Data)					// output -to U2
	);

/***************************************************/

wire TX_Done_Sig;

	TX_module U2
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.TX_Data(TX_Data),				// input from U1
		.TX_En_Sig(TX_En_Sig),			// input from U1
		.TX_Done_Sig(TX_Done_Sig),		// output -to U1
		.TX_Pin_Out(TX_Pin_Out)			// output -to top
	);
	
	
/***************************************************/	

endmodule