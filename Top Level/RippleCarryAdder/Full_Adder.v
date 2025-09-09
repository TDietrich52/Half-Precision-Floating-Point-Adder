//Verilog behavioral model of a full adder
module Full_Adder (
	input Ai, Bi, Ciin,
	output reg Si, Ciout);
	always @ (Ai,Bi,Ciin)
		case ({Ai,Bi,Ciin})
					3'b000: begin Si = 0; Ciout = 0; end 
					3'b001: begin Si = 1; Ciout = 0; end 
					3'b010: begin Si = 1; Ciout = 0; end 
					3'b011: begin Si = 0; Ciout = 1; end 
					3'b100: begin Si = 1; Ciout = 0; end 
					3'b101: begin Si = 0; Ciout = 1; end 
					3'b110: begin Si = 0; Ciout = 1; end 
					3'b111: begin Si = 1; Ciout = 1; end 
	endcase
endmodule