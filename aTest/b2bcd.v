module b2bcd(
	input	[7:0]	bin_in,
	output	[7:0]	bcd_out
    );
reg [3:0] ones;
reg [3:0] tens;
integer i;
 
always @(*) begin
	ones=4'd0;
	tens=4'd0;
	for(i=7;i>=0;i=i-1) begin
		if (ones >= 4'd5) ones = ones+4'd3;
		if (tens >= 4'd5) tens = tens+4'd3;
		tens={tens[2:0],ones[3]};
		ones={ones[2:0],bin_in[i]};
	end
end	
assign bcd_out={tens, ones};
endmodule
