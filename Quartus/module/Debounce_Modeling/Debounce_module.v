module Debounce_module(
	CLK,RST_N,
	Pin_In,
	Pin_Out
);

input CLK;
input RST_N;
input Pin_In;
output Pin_Out;

/********************************************/

wire H2L_Sig;
wire L2H_Sig;

		Detect_module U1
		(
			.CLK(CLK),
			.RST_N(RST_N),
			.Pin_In(Pin_In),     // input by top
			.H2L_Sig(H2L_Sig),   // output to U2
			.L2H_Sig(L2H_Sig)    // Output to U2
		);
		
/*********************************************/

Delay_module U2
		(
			.CLK(CLK),
			.RST_N(RST_N),
			.H2L_Sig(H2L_Sig),   // input from U1
			.L2H_Sig(L2H_Sig),    // input from U1
			.Pin_Out(Pin_Out)     // output to top
		);		

/**********************************************/

endmodule