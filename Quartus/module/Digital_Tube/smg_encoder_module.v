module smg_encoder_module
(
	CLK,RST_N,
	Ten_Data,One_Data,
	Ten_SMG_Data,One_SMG_Data
);

input CLK;
input RST_N;
input[4:1] Ten_Data, One_Data;
output[8:1] Ten_SMG_Data, One_SMG_Data;

/****************************************************/

	parameter seg0 = 8'hc0, seg1 = 8'hf9,
			    seg2 = 8'ha4, seg3 = 8'hb0,
			    seg4 = 8'h99, seg5 = 8'h92,
			    seg6 = 8'h82, seg7 = 8'hf8,
			    seg8 = 8'h80, seg9 = 8'h90,
			    sega = 8'h88, segb = 8'h83,
			    segc = 8'hc6, segd = 8'ha1,
			    sege = 8'h86, segf = 8'h8e;

/****************************************************/

reg[7:0] rTen_SMG_Data;

always@(posedge CLK or negedge RST_N)
	if(!RST_N)
		begin
			rTen_SMG_Data <= 8'hff;
		end
   else 
		case(Ten_Data)
		
			4'd0: rTen_SMG_Data <= seg0;	
			4'd1: rTen_SMG_Data <= seg1;	
			4'd2: rTen_SMG_Data <= seg2;	
			4'd3: rTen_SMG_Data <= seg3;
			4'd4: rTen_SMG_Data <= seg4;	
			4'd5: rTen_SMG_Data <= seg5;
			4'd6: rTen_SMG_Data <= seg6;	
			4'd7: rTen_SMG_Data <= seg7;
         4'd8: rTen_SMG_Data <= seg8;
			4'd9: rTen_SMG_Data <= seg9;
		endcase

/********************************************************/	

reg[7:0] rOne_SMG_Data;

always@(posedge CLK or negedge RST_N)
	if(!RST_N)
		begin
			rOne_SMG_Data <= 8'hff;
		end
   else 
		case(One_Data)
		
			4'd0: rOne_SMG_Data <= seg0;	
			4'd1: rOne_SMG_Data <= seg1;	
			4'd2: rOne_SMG_Data <= seg2;	
			4'd3: rOne_SMG_Data <= seg3;
			4'd4: rOne_SMG_Data <= seg4;	
			4'd5: rOne_SMG_Data <= seg5;
			4'd6: rOne_SMG_Data <= seg6;	
			4'd7: rOne_SMG_Data <= seg7;
         4'd8: rOne_SMG_Data <= seg8;
			4'd9: rOne_SMG_Data <= seg9;
		endcase

/*****************************************************************/

	assign Ten_SMG_Data = rTen_SMG_Data;
	assign One_SMG_Data = rOne_SMG_Data;

/*****************************************************************/


endmodule