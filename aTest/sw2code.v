//module sw2code(input[6:0] switch, output reg[4:0] SW, output reg[2:0] led_s,output reg clock_s, output reg repeat_s);
	always @(switch) begin
	if(switch[6:2]==5'b10000) begin SW<=5'b10000; led_s<=0; end
	else if(switch[6:2]==5'b01000) begin SW<=5'b01000; led_s<=1; end
	else if(switch[6:2]==5'b00100) begin SW<=5'b00100; led_s<=2; end
	else if(switch[6:2]==5'b00010) begin SW<=5'b00010; led_s<=3; end
	else if(switch[6:2]==5'b00001) begin SW<=5'b00001; led_s<=4; end
	else  begin SW<=5'b00000; led_s<=0; end

	if(switch[1]) clock_s <= 1; else clock_s <= 0;
	if(switch[0]) repeat_s <= 1; else repeat_s <= 0;
	end
endmodule
