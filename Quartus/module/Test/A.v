module A(a,b,c,y);  //三个数相加的模块
input a;
input b;
input c;
output[1:0] y;

assign y= a+b+c;
endmodule