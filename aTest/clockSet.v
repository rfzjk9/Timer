module clockSet(
  input wire rst,
  input SW_cS,
  input clk,
  input [5:0] button,
  output[23:0] timeBus
);

  reg [5:0] seconds_internal;
  reg [5:0] minutes_internal;
  reg [4:0] hours_internal;


  always @(posedge clk or negedge rst) begin
     if (~rst) begin
      seconds_internal <= 0;
      minutes_internal <= 0;
      hours_internal <= 0;
    end else begin
		if(SW_cS) begin
			case(button)
				6'b100000: begin if(hours_internal<23) hours_internal <= hours_internal + 1; else hours_internal <= 0; end
				6'b010000: begin if(hours_internal>0) hours_internal <= hours_internal - 1; else hours_internal <= 23; end
				6'b001000: begin if(minutes_internal<59) minutes_internal <= minutes_internal + 1; else minutes_internal <= 0; end
				6'b000100: begin if(minutes_internal>0) minutes_internal <= minutes_internal - 1; else minutes_internal <= 59; end

				endcase end
    end
  end
  assign timeBus = {3'b000, hours_internal, 2'b00, minutes_internal, 8'b00000000};

endmodule
