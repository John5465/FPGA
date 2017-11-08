module Digital_Tube_Demo
(
	CLK,RST_N,
	Row_Scan_Sig,Column_Scan_Sig
);
input CLK;
input RST_N;
output[7:0] Row_Scan_Sig;
output[1:0] Column_Scan_Sig;


parameter Number_Data = 8'd67;

/*
reg[24:0] cnt;               //计数器，最大可以计到2的25次方*20ns=640ms

always @(posedge CLK, negedge RST_N)
	if(!RST_N) cnt <= 25'd0;
	else cnt <= cnt + 1'b1;  
/******************************************/
/*
reg[7:0] Number_Data;

always @(posedge CLK, negedge RST_N)
	if(!RST_N) 
		Number_Data <= 8'd0;
else if(cnt == 24'hffffff) 
	Number_Data <= Number_Data + 1'b1;
*/
wire[7:0] rNumber_Data;
 
	Digital_Tube U1
  (
	.CLK(CLK),
	.RST_N(RST_N),
	.Number_Data(rNumber_Data),
	.Row_Scan_Sig(Row_Scan_Sig),
	.Column_Scan_Sig(Column_Scan_Sig)
  );

 	
assign rNumber_Data = Number_Data;	

endmodule