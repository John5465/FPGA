/**********************************************
Modele Name：Control_module()
Module Function：SOS_En_Sig Generator
Input Parameters：null
Output Parameters：SOS_En_Sig
Data：2016/9/13
Author: VanAllen Ye
**********************************************/

module Control_module
(
	CLK,RST_N,
	SOS_En_Sig
);

input CLK;
input RST_N;
output SOS_En_Sig;

/***********************************************/

parameter T3S = 28'd149_999_999;

/***********************************************/

reg isEn;
reg[27:0] Count1;

always@(posedge CLK or negedge RST_N)
	if(!RST_N)
		begin
			isEn <= 1'b0;
			Count1 <= 28'd0;
		end
	else if(Count1 == T3S)
		begin
			isEn <= 1'b1;
			Count1 <= 28'd0;
		end
	else
		begin
			isEn <= 1'b0;
			Count1 <= Count1 + 1'b1;
		end

/***************************************************/

assign SOS_En_Sig = isEn;

/***************************************************/

endmodule