module show_s(opt,time0,time1,time2,time3,time4,time_o);
	input[2:0] opt;
	input[23:0] time0,time1,time2,time3,time4;
	output reg[23:0] time_o;
	always @(*)
	case(opt)
		3'b000:time_o<=time0;
		3'b001:time_o<=time1;
		3'b010:time_o<=time2;
		3'b011:time_o<=time3;
		3'b100:time_o<=time4;
		default:time_o<=time4;
		endcase
endmodule
