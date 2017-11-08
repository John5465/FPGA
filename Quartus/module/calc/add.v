module add(
x,y,
sum,
z
);

input[3:0] x;
input[3:0] y;
output[4:0] sum;
output      z;

assign {z,sum} = x+y;

endmodule