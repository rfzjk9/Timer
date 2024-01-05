`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:30:31 01/03/2024 
// Design Name: 
// Module Name:    bus2b 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module bus2b(bus,num,clk1000,wx,rst);
	input clk1000, rst;
	input[23:0] bus;
	output reg[3:0] num;
	output reg[7:0] wx;
	wire[7:0] hp,mp,sp;
	reg[2:0] Opt;
	b2bcd bcdh(bus[23:16],hp);
	b2bcd bcdm(bus[15:8],mp);
	b2bcd bcds(bus[7:0],sp);
	always @(posedge clk1000 or negedge rst) begin
	if (~rst) begin num = 10; Opt = 0; end
	else begin
		if(Opt>=7) Opt=0;
		else Opt = Opt + 1;
		case(Opt)
			3'd0:begin num=hp[7:4]; wx=8'b0111_1111; end
			3'd1:begin num=hp[3:0]; wx=8'b1011_1111; end
			3'd2:begin num=4'b1111; wx=8'b1101_1111; end
			3'd3:begin num=mp[7:4]; wx=8'b1110_1111; end
			3'd4:begin num=mp[3:0]; wx=8'b1111_0111; end
			3'd5:begin num=4'b1111; wx=8'b1111_1011; end
			3'd6:begin num=sp[7:4]; wx=8'b1111_1101; end
			3'd7:begin num=sp[3:0]; wx=8'b1111_1110; end
			endcase end end
endmodule
