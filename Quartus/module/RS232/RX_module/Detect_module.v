/**********************************************
Module Name：Detect_module()
Module Function：Detect start bit,
Input Parameters：RX_Pin_In
Output Parameters：H2L_Sig
Data：2016/9/13
Author: VanAllen Ye
**********************************************/

module Detect_module
(
    CLK, RSTn,
	 RX_Pin_In,
	 H2L_Sig
);
    input CLK;
	 input RSTn;
	 input RX_Pin_In;
	 output H2L_Sig;
	 
	 /******************************/
	 
	 reg H2L_F1;
	 reg H2L_F2;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      begin
				    H2L_F1 <= 1'b1;
					 H2L_F2 <= 1'b1;
				end
		  else
		      begin
				    H2L_F1 <= RX_Pin_In;
					 H2L_F2 <= H2L_F1;
				end
				
	/***************************************/
	
	assign H2L_Sig = H2L_F2 & !H2L_F1;
	
	/***************************************/
	
endmodule