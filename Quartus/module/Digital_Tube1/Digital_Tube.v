/**********************************************
名   称：Digital_Tube()
功   能：数码管显示
入口参数：sm_cs1_n, sm_cs2_n, sm_db
出口参数：无
data：2016/4/23
**********************************************/
module Digital_Tube(
	clk,rst_n,
	//sm_cs1_n, sm_cs2_n, 
	sm_db,
	cs
);

input clk;            
input rst_n;
//output sm_cs1_n, sm_cs2_n;    //chip select
output[6:0] sm_db;            //7段数码管，不包括小数点
output[5:0] cs;
/********************************************/

reg[24:0] cnt;               //计数器，最大可以计到2的25次方*20ns=640ms

always @(posedge clk, negedge rst_n)
	if(!rst_n) cnt <= 25'd0;
	else cnt <= cnt + 1'b1;  
/******************************************/

reg[3:0] num;                //显示数值

always @(posedge clk, negedge rst_n)
if(!rst_n) num <= 4'd0;
else if(cnt == 24'hffffff) num <= num + 1'b1;
/******************************************/
/* 共阴极;不带小数点
    0， 1， 2， 3， 4， 5， 6， 7，
  3fh,06h,5bh,4fh,66h,6dh,7dh,07h
	 8,  9,  a,  b,  c,  d,  e,  f, 灭
  7fh, 6fh,77h,7ch,39h,5eh,79h,71h,00h
*/
/* 共阳极;不带小数点
    0， 1， 2， 3， 4， 5， 6， 7，
  c0h,f9h,a4h,b0h,99h,92h,82h,f8h
	 8,  9,  a,  b,  c,  d,  e,  f, 灭
  80h, 90h,88h,83h,c6h,a1h,86h,8eh,ffh
*/
parameter  seg0 = 7'hc0,
			  seg1 = 7'hf9,
			  seg2 = 7'ha4,
			  seg3 = 7'hb0,
			  seg4 = 7'h99,
			  seg5 = 7'h92,
			  seg6 = 7'h82,
			  seg7 = 7'hf8,
			  seg8 = 7'h80,
			  seg9 = 7'h90,
			  sega = 7'h88,
			  segb = 7'h83,
			  segc = 7'hc6,
			  segd = 7'ha1,
			  sege = 7'h86,
			  segf = 7'h8e;
/*****************译码**************************/			  
reg[6:0] sm_dbr;     //7段数码管，不包括小数点
always @(num)
		case(num)
           4'h0 : sm_dbr <= seg0;
			  4'h1 : sm_dbr <= seg1;
			  4'h2 : sm_dbr <= seg2;
			  4'h3 : sm_dbr <= seg3;
			  4'h4 : sm_dbr <= seg4;
			  4'h5 : sm_dbr <= seg5;
			  4'h6 : sm_dbr <= seg6;
			  4'h7 : sm_dbr <= seg7;
			  4'h8 : sm_dbr <= seg8;
			  4'h9 : sm_dbr <= seg9;
			  4'ha : sm_dbr <= sega;
			  4'hb : sm_dbr <= segb;
			  4'hc : sm_dbr <= segc;
			  4'hd : sm_dbr <= segd;
			  4'he : sm_dbr <= sege;
			  4'hf : sm_dbr <= segf;
			  default: ;
		endcase
assign sm_db = sm_dbr;
// assign sm_cs1_n = 1'b0;
// assign sm_cs2_n = 1'b0;
assign cs = 6'b0;

endmodule