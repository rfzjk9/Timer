module alarm_s(time1,time2,sign);
	input[23:0] time1,time2;
	output reg sign;
	always @(*)
	if(time1[23:8]==time2[23:8])
		sign = 1;
	else sign = 0;
endmodule
