module Digital_Tube_Interface_Demo
(
	CLK,RST_N,
	SMG_Data,
	Scan_Sig
);

input CLK;
input RST_N;
output[7:0] SMG_Data;
output[5:0] Scan_Sig;


parameter num = 23'd9;
/*************************************************************


reg[24:0] cnt;               //计数器，最大可以计到2的25次方*20ns=640ms

always @(posedge CLK, negedge RST_N)
	if(!RST_N) cnt <= 25'd0;
	else cnt <= cnt + 1'b1;  
/******************************************

reg[23:0] num;                //显示数值

always @(posedge CLK, negedge RST_N)
if(!RST_N) num <= 24'd0;
else if(cnt == 24'hffffff) num <= num + 1'b1;


/*************************************************************/

wire[23:0] Number_Sig;

 Digital_Tube_Interface U1
(
	.CLK(CLK),
	.RST_N(RST_N),
	.Number_Sig(Number_Sig),
	.SMG_Data(SMG_Data),
	.Scan_Sig(Scan_Sig)
);


assign  Number_Sig = num;
/*****************************************************************/
endmodule