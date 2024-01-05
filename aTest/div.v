//rtl
module div(clk,rst_n,clk_1k,clk_1);
    input clk,rst_n;
    output clk_1k,clk_1;
    reg [15:0] counter1k;
	 reg [25:0] counter1;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        counter1k <= 0;
    else if(counter1k==49999)
        counter1k <= 0;
    else
        counter1k <= counter1k+1;
	 
	 
	if(~rst_n)
        counter1 <= 0;
    else if(counter1==49999999)
        counter1 <= 0;
    else
        counter1 <= counter1+1;
end
assign clk_1k = counter1k[15];
assign clk_1 = counter1[25];
endmodule