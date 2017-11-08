module Uart_Commu_top(
	clk,rst_n,
	rs232_rx,rs232_tx
);
input clk;
input rst_n;
input rs232_rx;
input rs232_tx;



//-------------------------------------------------

Uart_Rx  Uart_Rx(
	.clk(clk),
	.rst_n(rst_n),
	.rs232_rx(rs232_rx),
	.rx_data(rx_data),
	.rx_int(rx_int),
	.clk_bps(clk_bps),
	.bps_start(bps_start)
);

endmodule