module negetiveTimer(
  input wire clk,
  input wire rst,
  input SW,
  input button2,
  input rstButton2,
  input [5:0] button_i,
  output[23:0] timeBus,
  output neg_alarm_s
);

  reg [5:0] seconds_internal;
  reg [5:0] minutes_internal;
  reg [4:0] hours_internal;
  reg button_temp_n;

  
  always @(posedge button2)
  begin if(SW) begin
  if(button_temp_n) button_temp_n = 0;  else button_temp_n = 1; end end
	
  always @(posedge clk or negedge rst) begin
     if (~rst) begin
      seconds_internal <= 0;
      minutes_internal <= 0;
      hours_internal <= 0; end 
	 else if(rstButton2) begin
      seconds_internal <= 0;
      minutes_internal <= 0;
      hours_internal <= 0; 	 
	 end
	 else begin
		if(button_temp_n) begin
			if (seconds_internal == 6'b000000) begin
			  seconds_internal <= 6'b111011;
			  minutes_internal <= minutes_internal - 1;
			  
				if (minutes_internal == 6'b000000) begin
				  minutes_internal <= 6'b111011;
				  hours_internal <= hours_internal - 1;
				  
					if (hours_internal == 5'b00000) begin
						hours_internal <= 5'b00000;
						minutes_internal <= 6'b000000;
						seconds_internal <= 6'b000000;
					end else begin
						hours_internal <= hours_internal - 1;
						end
				end else begin
				  minutes_internal <= minutes_internal - 1;
				end
			
			end else begin
			  seconds_internal <= seconds_internal - 1;
			end end
		else begin
			case(button_i)
				6'b100000: begin if(hours_internal<23) hours_internal <= hours_internal + 1; else hours_internal <= 0; end
				6'b010000: begin if(hours_internal>0) hours_internal <= hours_internal - 1; else hours_internal <= 23; end
				6'b001000: begin if(minutes_internal<59) minutes_internal <= minutes_internal + 1; else minutes_internal <= 0; end
				6'b000100: begin if(minutes_internal>0) minutes_internal <= minutes_internal - 1; else minutes_internal <= 59; end
				6'b000010: begin if(seconds_internal<59) seconds_internal <= seconds_internal + 1; else seconds_internal <= 0; end
				6'b000001: begin if(seconds_internal>0) seconds_internal <= seconds_internal - 1; else seconds_internal <= 59; end
				endcase end
    end
  end

  assign timeBus = {3'b000, hours_internal, 2'b00, minutes_internal, 2'b00, seconds_internal};
  assign neg_alarm_s = (button_temp_n && seconds_internal == 6'b000000 && minutes_internal == 6'b000000 && hours_internal == 5'b00000)?1:0;
  

endmodule
