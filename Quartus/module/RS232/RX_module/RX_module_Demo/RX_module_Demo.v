module RX_module_Demo
(
    CLK, RSTn,
	 RX_Pin_In,
	 Number_Data
);

    input CLK;
	 input RSTn;
	 input RX_Pin_In;
    output [3:0]Number_Data;	
	 
	 /**********************************/
	 
	 wire RX_Done_Sig;
	 wire [7:0]RX_Data;
	 
	 Rx_module U1
	 (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .RX_Pin_In( RX_Pin_In ),   // input - from top
		  .RX_En_Sig( RX_En_Sig ),   // input - from U2
		  .RX_Done_Sig( RX_Done_Sig ),  // output - to U2
		  .RX_Data( RX_Data )           // output - to U2
	 );
	 
	 /***********************************/
	 
	 wire RX_En_Sig;
	 wire [7:0]Output_Data;
	 
	 control_module U2
	 (
	     .CLK( CLK ),
	     .RSTn( RSTn ),
		  .RX_Done_Sig( RX_Done_Sig ),  // input - from U1
		  .RX_Data( RX_Data ),          // input - from U1
		  .RX_En_Sig( RX_En_Sig ),      // output - to U1
		  .Number_Data( Output_Data )   // output - to top
	 );
	 
	 /***********************************/

	 assign Number_Data = Output_Data[3:0];
	 
endmodule
