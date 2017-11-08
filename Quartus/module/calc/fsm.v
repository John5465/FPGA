module fsm(
clk,rst_n,A,
F,G
);

input clk,rst_n,A;
output F,G;
reg F,G;
reg[1:0] state;

parameter Idle=2'b00, Start=2'b01, Stop=2'b10, Clear=2'b11;

always@(posedge clk, negedge rst_n)
if(!rst_n)
begin
	state <= Idle;
	F <= 0;
	G <= 0;
end
else
	case (state)
	Idle: begin
				if(A)
					begin 
						state <= Start;
						G <=0;
					end
				else
					state <= Idle;
			end
	Start: begin
				if(!A)
					state <= Stop;
				else
					state <= Start;				
			 end
	Stop: begin
				if(A) 
					begin
						state <= Clear;
						F <= 1;
					end
				else
					state <= Stop;
			end
	Clear: begin
				if(!A)
					begin
						state <= Idle;
						F <= 0; G <= 1;
					end
				else
					state <= Clear;
			 end
	endcase

endmodule