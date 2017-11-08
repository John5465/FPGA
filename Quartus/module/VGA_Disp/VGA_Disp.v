`timescale 1ns / 1ps

module VGA_Disp(
			clk,rst_n,
			hsync,vsync,
			vga_r,vga_g,vga_b
		);

input clk;		//50MHz
input rst_n;	//
output hsync;	//
output vsync;	//
output vga_r;
output vga_g;
output vga_b;

//--------------------------------------------------
reg[10:0] x_cnt;	//
reg[9:0] y_cnt;	//

always @ (posedge clk or negedge rst_n)
	if(!rst_n) x_cnt <= 11'd0;
	else if(x_cnt == 11'd1039) x_cnt <= 11'd0;
	else x_cnt <= x_cnt+1'b1;

always @ (posedge clk or negedge rst_n)
	if(!rst_n) y_cnt <= 10'd0;
	else if(y_cnt == 10'd665) y_cnt <= 10'd0;
	else if(x_cnt == 11'd1039) y_cnt <= y_cnt+1'b1;

//--------------------------------------------------
wire valid;	//

assign valid = (x_cnt >= 11'd187) && (x_cnt < 11'd987) 
					&& (y_cnt >= 10'd31) && (y_cnt < 10'd631); 

wire[9:0] xpos,ypos;	//
assign xpos = x_cnt-11'd187;
assign ypos = y_cnt-10'd31;

//--------------------------------------------------
reg hsync_r,vsync_r;	//ͬ
always @ (posedge clk or negedge rst_n)
	if(!rst_n) hsync_r <= 1'b1;
	else if(x_cnt == 11'd0) hsync_r <= 1'b0;	//
	else if(x_cnt == 11'd120) hsync_r <= 1'b1;
 
always @ (posedge clk or negedge rst_n)
	if(!rst_n) vsync_r <= 1'b1;
	else if(y_cnt == 10'd0) vsync_r <= 1'b0;	//
	else if(y_cnt == 10'd6) vsync_r <= 1'b1;

assign hsync = hsync_r;
assign vsync = vsync_r;

//--------------------------------------------------
	
wire a_dis,b_dis,c_dis,d_dis;	//
assign a_dis = ( (xpos>=200) && (xpos<=220) ) 
				&&	( (ypos>=140) && (ypos<=460) );
				
assign b_dis = ( (xpos>=580) && (xpos<=600) )
				&& ( (ypos>=140) && (ypos<=460) );

assign c_dis = ( (xpos>=220) && (xpos<=580) ) 
				&&	( (ypos>140)  && (ypos<=160) );
				
assign d_dis = ( (xpos>=220) && (xpos<=580) )
				&& ( (ypos>=440) && (ypos<=460) );


wire e_rdy;	//

assign e_rdy = ( (xpos>=385) && (xpos<=415) )
				&&	( (ypos>=285) && (ypos<=315) );

//-------------------------------------------------- 
	
assign vga_r = valid ? e_rdy : 1'b0;
assign vga_g = valid ?  (a_dis | b_dis | c_dis | d_dis) : 1'b0;
assign vga_b = valid ? ~(a_dis | b_dis | c_dis | d_dis) : 1'b0;	  

endmodule
