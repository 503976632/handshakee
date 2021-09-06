module handshakee(
	input	clk,
	input	rst_n,

	input	valid_i, 
	input	data_i,  	
	input	ready_i,  

	output	ready_o, 
	output	valid_o, 
	output	data_o  	
);

	reg	valid_o_r;
	reg	ready_o_r;
	reg	data_r;

	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			valid_o_r <= 0;
		end 
		else if(valid_i) begin
			valid_o_r <= 1;
		end
		else if(~valid_i) begin
			valid_o_r <= 0;
		end
		else valid_o_r <= valid_o_r;
	end

	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			ready_o_r <= 0;
		end 
		else if(ready_i) begin
			ready_o_r <= 1;
		end
		else if(~ready_i) begin
			ready_o_r <= 0;
		end
		else ready_o_r <= ready_o_r;
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			data_r <= 0;
		end 
		else if(ready_o && valid_o) begin
			data_r <= data_i;
		end
		else data_r <= data_r;
	end

assign ready_o = ready_o_r;
assign valid_o = valid_o_r;
assign data_o  = data_r;

endmodule