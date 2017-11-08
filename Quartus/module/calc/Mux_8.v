module Mux_8(
clk,rst_n,
addr,
In1,In2,In3,In4,In5,In6,In7,In8,
Mout
);

input clk, rst_n;
input[2:0] addr;
input[width-1:0] In1,In2,In3,In4,In5,In6,In7,In8;
output reg[width-1:0] Mout;
parameter width = 8;

always@(addr or In1 or In2 or In3 or In4 or In5 or In6 or In7 or In8)
	begin
		if(!rst_n)
			case(addr)
			3'b000: Mout = In1;
			3'b001: Mout = In2;
			3'b010: Mout = In3;
			3'b011: Mout = In4;
			3'b100: Mout = In5;
			3'b101: Mout = In6;
			3'b110: Mout = In7;
			3'b111: Mout = In8;
			endcase
		else
			Mout = 0;
	end
	
endmodule