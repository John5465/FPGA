module Digital_Tube
(
	CLK,RST_N,
	Number_Data,
	Row_Scan_Sig,Column_Scan_Sig
);

input CLK;
input RST_N;
input[7:0] Number_Data;
output[7:0] Row_Scan_Sig;
output[1:0] Column_Scan_Sig;

/*******************************************************************
//parameter Number_Data = 8'd67;

reg[24:0] cnt;               //计数器，最大可以计到2的25次方*20ns=640ms

always @(posedge CLK, negedge RST_N)
	if(!RST_N) cnt <= 25'd0;
	else cnt <= cnt + 1'b1;  
/******************************************

reg[7:0] Number_Data;

always @(posedge CLK, negedge RST_N)
	if(!RST_N) 
		Number_Data <= 8'd0;
else if(cnt == 24'hffffff) 
	Number_Data <= Number_Data + 1'b1;
	
assign rNumber_Data = Number_Data;
/*******************************************************************/

wire[3:0] Ten_Data;
wire[3:0] One_Data;

	number_mod_module U1
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.Number_Data(Number_Data),           //input from top
		.Ten_Data(Ten_Data),                 //output to U2
		.One_Data(One_Data)                  //output to U2
	);

/******************************************************************/	

wire[7:0] Ten_SMG_Data;
wire[7:0] One_SMG_Data;

	smg_encoder_module U2
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.Ten_Data(Ten_Data),                //input from U1
		.One_Data(One_Data),                //input from U1
		.Ten_SMG_Data(Ten_SMG_Data),        //output to U4
		.One_SMG_Data(One_SMG_Data)         //output to U4
	);
	
/*********************************************************************/

	column_scan_module U3
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.Column_Scan_Sig(Column_Scan_Sig)    //output to top
	);

/*********************************************************************/

	 row_scan_module U4
	(
	.CLK(CLK),
	.RST_N(RST_N),
	.Ten_SMG_Data(Ten_SMG_Data),           //input from U3
	.One_SMG_Data(One_SMG_Data),           //input from U3
	.Row_Scan_Sig(Row_Scan_Sig)            //output to top
	); 

/********************************************************************/

endmodule