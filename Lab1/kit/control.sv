module control
(
	input clk,
	input reset,
	
	// Button input
	input i_enter,
	
	// Datapath
	output logic o_inc_actual,
	input i_over,
	input i_under,
	input i_equal,
	
	// LED Control: Setting this to 1 will copy the current
	// values of over/under/equal to the 3 LEDs. Setting this to 0
	// will cause the LEDs to hold their current values.
	output logic o_update_leds
);

// Declare two objects, 'state' and 'nextstate'
// that are of enum type.
enum int unsigned
{
	S_Random,
	S_Greater,
	S_Smaller,
	S_Equal
	// TODO: declare states here // done
} state, nextstate;

// Clocked always block for making state registers
always_ff @ (posedge clk or posedge reset) begin
	if (reset) state <= S_Random // TODO: choose initial reset state // done
	else state <= nextstate;
end

// always_comb replaces always @* and gives compile-time errors instead of warnings
// if you accidentally infer a latch
always_comb begin
	// Set default values for signals here, to avoid having to explicitly
	// set a value for every possible control path through this always block
	nextstate = state;
	o_inc_actual = 1'b0;
	o_update_leds = 1'b0;
	
	case (state)
		S_Random: begin
			if (reset) nextstate = S_Random;
			else if (i_enter) begin
				if (o_inc_actual == i_over) nextstate = S_Greater;
				else if (o_inc_actual == i_under) nextstate = S_Smaller;
				else if (o_inc_actual == i_equal) nextstate = S_Equal;
				o_update_leds = 1'b1;
				o_update_leds = 1'b0;
			end
		end

		S_Greater: begin
			if (reset) nextstate = S_Random;
			else if (i_enter) begin
				if (o_inc_actual == i_over) nextstate = S_Greater;
				else if (o_inc_actual == i_under) nextstate = S_Smaller;
				else if (o_inc_actual == i_equal) nextstate = S_Equal;
				o_update_leds = 1'b1;
				o_update_leds = 1'b0;
			end
		end

		S_Smaller: begin
			if (reset) nextstate = S_Random;
			else if (i_enter) begin
				if (o_inc_actual == i_over) nextstate = S_Greater;
				else if (o_inc_actual == i_under) nextstate = S_Smaller;
				else if (o_inc_actual == i_equal) nextstate = S_Equal;
				o_update_leds = 1'b1;
				o_update_leds = 1'b0;
			end
		end

		S_Equal: begin
			if (reset) nextstate = S_Random;
		end
		// TODO: complete this // done
	endcase
end

endmodule
