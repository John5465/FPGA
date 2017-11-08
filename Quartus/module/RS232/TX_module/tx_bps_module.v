module tx_bps_module
(
    CLK, RST_N,
	 Count_Sig, 
	 BPS_CLK
);

    input CLK;
	 input RST_N;
	 input Count_Sig;
	 output BPS_CLK;
	 
	 /***************************/
	 
	 reg [12:0]Count_BPS;
	 
	 always @ ( posedge CLK or negedge RST_N )
	    if( !RST_N )
		     Count_BPS <= 13'd0;
		 else if( Count_BPS == 13'd5207 )
		     Count_BPS <= 13'd0;
		 else if( Count_Sig )
		     Count_BPS <= Count_BPS + 1'b1;
		 else
		     Count_BPS <= 13'd0;
			  
	 /********************************/

    assign BPS_CLK = ( Count_BPS == 13'd2604 ) ? 1'b1 : 1'b0;

    /*********************************/

endmodule
