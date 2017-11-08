module control_module
(
	CLK,RST_N,
	TX_Done_Sig,
	TX_En_Sig,TX_Data
);

input CLK;
input RST_N;
input TX_Done_Sig;
output TX_En_Sig;
output[7:0] TX_Data;

/****************************************/

parameter T1S = 26'd49_999_999;

/****************************************/

reg[25:0] Count_Sec;

always@(posedge CLK or negedge RST_N)
	if(!RST_N)
		Count_Sec <= 26'd0;
	else if(Count_Sec == T1S)
		Count_Sec <= 26'd0;
	else
		Count_Sec <= Count_Sec + 1'b1;

/****************************************/

reg isEn;
reg[7:0] rData;

always@(posedge CLK or negedge RST_N)
	if(!RST_N)
		begin
			isEn <= 1'b0;
			rData <= 8'h31;
		end
	else if(TX_Done_Sig)
		begin
			rData <= 8'h31;
			isEn <= 1'b0;
		end
	else if(Count_Sec == T1S)
		isEn <= 1'b1;
		
/*********************************************/

assign TX_En_Sig = isEn;
assign TX_Data = rData;

/**********************************************/

endmodule