module optional_pwm_module
(
    input CLK,
	 input RST_N,
	 input [3:0]Option_Key,
	 output Led_Out
);
	 
	 /*******************************/
	 
	 parameter SEGMENT = 8'd195; // 3.9us 50M*(3.9*e-6)=195
	 
	 /*******************************/
	 
	 reg [7:0]C1;
	 
	 always @ ( posedge CLK or negedge RST_N )
	     if( !RST_N )
		      C1 <= 8'd0;
		  else if( C1 == SEGMENT )
		      C1 <= 8'd0;
		  else 
		      C1 <= C1 + 1'b1; 
				
	 /*******************************/
	
	 reg [7:0]System_Seg;
	
    always @ ( posedge CLK or negedge RST_N )
	     if( !RST_N )
		      System_Seg <= 8'd0;
		  else if( System_Seg == 8'd255 )
		      System_Seg <= 8'd0;
		  else if( C1 == SEGMENT )
		      System_Seg <= System_Seg + 1'b1;
	
	 /*******************************/
	 
	 reg [7:0]Option_Seg;
	 
	 always @ ( posedge CLK or negedge RST_N )
	     if( !RST_N )
		  
		      Option_Seg <= 8'd0;
				
/*   	  else if( Option_Key[4] ) // Key up = Segment + 10
		  
      		if( Option_Seg < 8'd245) Option_Seg <= Option_Seg + 8'd10; 
				else Option_Seg <= 8'd255;
*/		  
		  else if( Option_Key[3] ) // key down = Segment - 10
		  
		      if( Option_Seg > 8'd10) Option_Seg <= Option_Seg - 8'd10; 
				else Option_Seg <= 8'd0;
				
		  else if( Option_Key[2] ) // key left = Segment + 1
		  
      		if( Option_Seg < 8'd255) Option_Seg <= Option_Seg + 8'd1; 
				else Option_Seg <= 8'd255;
				
		  else if( Option_Key[1] ) // key down = Segment - 1
		  
		      if( Option_Seg > 8'd0) Option_Seg <= Option_Seg - 8'd1; 
				else Option_Seg <= 8'd0;
				
		  else if( Option_Key[0] ) // key middle = Segment = half
		  
				Option_Seg <= 8'd127;
		   
    /******************************************/

    assign Led_Out = ( System_Seg < Option_Seg ) ? 1'b1 : 1'b0;
	 
	 /******************************************/
	 
endmodule