module part1(KEY, SW, LEDG, LEDR);

	input [1:0]SW;
	input [0:0]KEY;
	output [0:0]LEDG;
	output [7:0]LEDR;
	

	wire z;
	reg [7:0]Y; //8-bits
	wire [7:0]y;	
	wire reset = SW[0];
	wire w = SW[1];
	wire clock = KEY[0];

	parameter A=8'b00000001, B=8'b00000010, C=8'b00000100, D=8'b00001000, E=8'b00010000, F=8'b00100000, G=8'b01000000, H=8'b10000000; 

	D_ff U0(Y[0], clock, y[0]);
	D_ff U1(Y[1], clock, y[1]);
	D_ff U2(Y[2], clock, y[2]);
	D_ff U3(Y[3], clock, y[3]);
	D_ff U4(Y[4], clock, y[4]);
	D_ff U5(Y[5], clock, y[5]);
	D_ff U6(Y[6], clock, y[6]);
	D_ff U7(Y[7], clock, y[7]);
	
	assign LEDR = y;	
	assign z = (y == H)|(y == E);
	assign LEDG[0] = z;
	
	always@(y, w)
	begin
	
		if(reset)
		begin
			Y = A;
		end
		else
		begin
			Y[0] = y[0]&w | y[6]&w;
			Y[1] = y[0]&~w | y[5]&~w;
			Y[2] = y[1]&~w | y[7]&~w;
			Y[3] = y[2]&~w;
			Y[4] = y[3]&~w | y[4]&~w;
			Y[5] = y[1]&w | y[2]&w | y[3]&w | y[4]&w | y[7]&w;
			Y[6] = y[5]&w;
			Y[7] = y[6]&~w;
		end
	end
	
	

endmodule

module D_ff(D, clk, Q);

	input D, clk;
	output Q;
	
	reg Q;
	
	always@(posedge clk)
		Q <= D;

endmodule