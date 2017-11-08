module top(a1,a2,a3,b,z); //顶层模块 

input  a1,a2,a3;
input [1:0] b;
output [3:0] z;

wire[1:0] temp1;

//例化
A m1(.a(a1),
         .b(a2),
         .c(a3),
         .y(temp1)
       );

B m2(.a(temp1),
         .b(b),
         .y(z)
         );

endmodule