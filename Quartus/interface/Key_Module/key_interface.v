module key_interface
(
	CLK,RST_N,
	Key_In,Key_Out
);

input CLK;
input RST_N;
input[3:0] Key_In;
output[3:0] Key_Out;

/*********************************************************/

	Debounce_module U1_Up
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.Pin_In(Key_In[3]),
		.Pin_Out(Key_Out[3])
	);
	
/*********************************************************/
		Debounce_module U2_Down
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.Pin_In(Key_In[2]),
		.Pin_Out(Key_Out[2])
	);
	
/*********************************************************/
		Debounce_module U3_Lift
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.Pin_In(Key_In[1]),
		.Pin_Out(Key_Out[1])
	);

/**********************************************************/
		Debounce_module U4_Right
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.Pin_In(Key_In[0]),
		.Pin_Out(Key_Out[0])
	);

/********************************************************/


endmodule