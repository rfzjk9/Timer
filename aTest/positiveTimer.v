module positiveTimer(
  input wire clk,
  input wire rst,
  input SW_pT,
  input button,
  input rstButton,
  output[23:0] timeBus
);

  reg [5:0] seconds_internal;
  reg [5:0] minutes_internal;
  reg [4:0] hours_internal;
  reg button_temp_p;

  always @(posedge button)
  begin if(SW_pT) begin
  if(button_temp_p)  button_temp_p = 0;  else button_temp_p = 1; end end
	
  always @(posedge clk or negedge rst) begin
     if (~rst) begin
      seconds_internal <= 0;
      minutes_internal <= 0;
      hours_internal <= 0; end 
	 else if(rstButton) begin
      seconds_internal <= 0;
      minutes_internal <= 0;
      hours_internal <= 0; 	 
	 end
	 else begin
		if(button_temp_p) begin
			if (seconds_internal == 6'b111011) begin
			  seconds_internal <= 6'b000000;
			  minutes_internal <= minutes_internal + 1;
			  
				if (minutes_internal == 6'b111011) begin
				  minutes_internal <= 6'b000000;
				  hours_internal <= hours_internal + 1;
				  
					if (hours_internal == 5'b10111) begin
						hours_internal <= 5'b00000;
					end else begin
						hours_internal <= hours_internal + 1;
						end
				end else begin
				  minutes_internal <= minutes_internal + 1;
				end
			
			end else begin
			  seconds_internal <= seconds_internal + 1;
			end end
    end
  end

  assign timeBus = {3'b000, hours_internal, 2'b00, minutes_internal, 2'b00, seconds_internal};

endmodule
