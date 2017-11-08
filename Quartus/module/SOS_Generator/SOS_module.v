/**********************************************
Modele Name：SOS_module()
Module Function：SOS sig Generator
Input Parameters：SOS_En_Sig
Output Parameters：Pin_Out
Data：2016/9/13
Author: VanAllen Ye
**********************************************/

module SOS_module
(
	CLK,RST_N,
	Pin_Out,
	SOS_En_Sig
);

input CLK;
input RST_N;
input SOS_En_Sig;
output Pin_Out;


/********************************************/
	// 50M*0.001-1=4_999
parameter T1MS = 16'd4_999;
/********************************************/

reg[15:0] Count1;

always@(posedge CLK or negedge RST_N)
	if(!RST_N)
		Count1 <= 16'd0;
	else if(isCount && Count1 == T1MS)
		Count1 <= 16'd0;
	else if(isCount)
		Count1 <= Count1 + 1'b1;
	else if(!isCount)
		Count1 <= 16'd0;
		
/*********************************************/

reg[9:0] Count_MS;

always@(posedge CLK or negedge RST_N)
	if(!RST_N)
		Count_MS <= 10'd0;
	else if(isCount && Count1 == T1MS)
		Count_MS <= Count_MS + 1'b1;
	else if(!isCount)
		Count_MS <= 10'd0;

/********************************************/

reg isCount;
reg rPin_Out;
reg[4:0] i;

always@(posedge CLK or negedge RST_N)
	if(!RST_N)
		begin
			isCount <= 1'b0;
			rPin_Out <= 1'b0;
			i <= 5'd0;
		end
	else
		case(i)
			
			5'd0:
				if(SOS_En_Sig)
					i <= 5'd1;
					
			5'd1,5'd3,5'd5,              //short
			5'd13,5'd15,5'd17:
				if(Count_MS == 10'd100)
					begin
						isCount <= 1'b0;
						rPin_Out <= 1'b0;
						i <= i + 1'b1;
					end
				else
					begin
						isCount <= 1'b1;
						rPin_Out <= 1'b1;
					end
					
			5'd7,5'd9,5'd11:              //long
				if(Count_MS == 10'd300)
					begin
						isCount <= 1'b0;
						rPin_Out <= 1'b0;
						i <= i + 1'b1;
					end
				else
					begin
						isCount <= 1'b1;
						rPin_Out <= 1'b1;
					end
					
			5'd2,5'd4,5'd6,
			5'd8,5'd10,5'd12,
			5'd14,5'd16,5'd18:            //interval
				if(Count_MS == 10'd50)
					begin
						isCount <= 1'b0;
						i <= i + 1'b1;
					end
				else
					isCount <= 1'b1;
	
			5'd19:
				begin
					rPin_Out <= 1'b0;
					i <= 5'd0;
				end
				
		endcase

/*****************************************************/

assign Pin_Out = rPin_Out;

/*****************************************************/

endmodule