module jic(
clk,rst_n,
Data_in,
Data_out
);

input clk;
input rst_n;
input[3:0] Data_in;
output reg[3:0] Data_out;

always@(posedge clk, negedge rst_n)
	begin
	if(rst_n)
		Data_out <=0;
	else
		Data_out <= Data_in;
   end


endmodule