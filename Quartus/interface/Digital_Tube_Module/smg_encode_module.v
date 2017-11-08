module smg_encode_module
(
	CLK,RST_N,
	Number_Data,
	SMG_Data
);

input CLK;
input RST_N;
input[3:0] Number_Data;
output[7:0] SMG_Data;

/***************************************************/

	parameter seg0 = 8'hc0, seg1 = 8'hf9,
			    seg2 = 8'ha4, seg3 = 8'hb0,
			    seg4 = 8'h99, seg5 = 8'h92,
			    seg6 = 8'h82, seg7 = 8'hf8,
			    seg8 = 8'h80, seg9 = 8'h90,
			    sega = 8'h88, segb = 8'h83,
			    segc = 8'hc6, segd = 8'ha1,
			    sege = 8'h86, segf = 8'h8e;

/***************************************************/

reg[7:0] rSMG;

always@(posedge CLK or negedge RST_N)
	if(!RST_N)
		begin
			rSMG <= 8'hff;
		end
   else 
		case(Number_Data)
		
			4'd0: rSMG <= seg0;	
			4'd1: rSMG <= seg1;	
			4'd2: rSMG <= seg2;	
			4'd3: rSMG <= seg3;
			4'd4: rSMG <= seg4;	
			4'd5: rSMG <= seg5;
			4'd6: rSMG <= seg6;	
			4'd7: rSMG <= seg7;
         4'd8: rSMG <= seg8;
			4'd9: rSMG <= seg9;
		endcase
/***************************************************************/

assign SMG_Data = rSMG;

/***************************************************************/

endmodule