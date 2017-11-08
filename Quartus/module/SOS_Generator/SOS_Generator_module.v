module SOS_Generator_module
(
		CLK,RST_N,
		Pin_Out
);

input CLK;
input RST_N;
output Pin_Out;

/**********************************************/

wire SOS_En_Sig;
	
	Control_module U1
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.SOS_En_Sig(SOS_En_Sig)
	);
	
wire Pin_Out_Wire;

	SOS_module	U2
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.SOS_En_Sig(SOS_En_Sig),
		.Pin_Out(Pin_Out_Wire)
	);

/******************************************/

assign Pin_Out = !Pin_Out_Wire;

/******************************************/

endmodule