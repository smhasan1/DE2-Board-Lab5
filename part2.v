module part2(KEY, SW, LEDG, LEDR);

	input [1:0]SW;
	input [0:0]KEY;
	output [0:0]LEDG;
	output [2:0]LEDR;
	
	reg [2:0] y_Q, Y_D;	
	wire z;	
	wire reset = SW[0];
	wire w = SW[1];
	wire clock = KEY[0];
	
	assign LEDR = y_Q;	
	assign z = (y_Q == H)|(y_Q == E);
	assign LEDG[0] = z;
	
	parameter A=3'b000, B=3'b001, C=3'b010, D=3'b011, E=3'b100, F=3'b101, G=3'b110, H=3'b111;
	
	always@(*)
	begin
		
		case(y_Q)
		
			A: if(w) Y_D = A;
				else Y_D = B;
			B: if(w) Y_D = F;
				else Y_D = C;
			C: if(w) Y_D = F;
				else Y_D = D;
			D: if(w) Y_D = F;
				else Y_D = E;
			E: if(w) Y_D = F;
				else Y_D = E;
			F: if(w) Y_D = G;
				else Y_D = B;	
			G: if(w) Y_D = A;
				else Y_D = H;
			H: if(w) Y_D = F;
				else Y_D = C;
		
			default: Y_D = 3'bxxx;
			
		endcase
	end
	
	always@(posedge clock)
	begin	
		if(reset == 0)
		begin
			y_Q <= A;
		end
		else
		begin
			y_Q <= Y_D;
		end	
	end
	
endmodule