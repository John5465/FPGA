
module learn1(a,b,out1,out2);

input			a;
input			b;
output		out1;
output		out2;

assign out1=a&b;
assign out2=a|b;
endmodule
