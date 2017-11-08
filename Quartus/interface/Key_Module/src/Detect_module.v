/**********************************************
Modele Name：Detect_module()
Module Function：检测按键是否按下
Input Parameters：Pin_In
Output Parameters：H2L_Sig, L2H_Sig
Data：2016/9/12
Author: VanAllen Ye
**********************************************/
module Detect_module(
	CLK,RST_N,
	Pin_In,
	H2L_Sig,L2H_Sig

);

input CLK;
input RST_N;
input Pin_In;
output H2L_Sig;
output L2H_Sig;

/************************************************/
//XTAL=50MHz, 50*10e6*0.0001-1=4_999;
parameter T100US = 11'd4_999;

/*******************Delay 100us******************/
reg [12:0]Count1;
	 reg isEn;
	 
	 always @ ( posedge CLK or negedge RST_N )
	     if( !RST_N )
		      begin
		          Count1 <= 13'd0;
		          isEn <= 1'b0;
				end
	     else if( Count1 == T100US )
				isEn <= 1'b1;
		  else
		      Count1 <= Count1 + 1'b1;
				
    /********************************************/
	 
	 reg H2L_F1;
	 reg H2L_F2;
	 reg L2H_F1;
	 reg L2H_F2;
	 
	 always @ ( posedge CLK or negedge RST_N )
	     if( !RST_N )
		      begin
				    H2L_F1 <= 1'b1;
					 H2L_F2 <= 1'b1;
					 L2H_F1 <= 1'b0;
					 L2H_F2 <= 1'b0;
			   end
		  else
		      begin
					 H2L_F1 <= Pin_In; 
					 H2L_F2 <= H2L_F1;
					 L2H_F1 <= Pin_In;
					 L2H_F2 <= L2H_F1;
				end
				
    /***********************************/
	 

	 assign H2L_Sig = isEn ? ( H2L_F2 & !H2L_F1 ) : 1'b0;
	 assign L2H_Sig = isEn ? ( !L2H_F2 & L2H_F1 ) : 1'b0;

	 
	 /***********************************/
	 
endmodule
