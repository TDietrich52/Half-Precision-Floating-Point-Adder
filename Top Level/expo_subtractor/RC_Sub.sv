//Ripple Addition & Subtraction
// If C=1 Subtraction, C=0 Addition 

module RC_Sub #(parameter N = 5)(
    input [N-1:0] A, B,  
    output [N-1:0] S,    
    output Cout
);


logic sub;
assign sub = 1'b1;
wire [N:0] C;
assign C[0] = sub; 

	 	 
// Instantiate full adders for each stage of the ripple carry 
Full_Adder s0 (.Ai(A[0]), .Bi(B[0] ^ sub), .Ciin(C[0]), .Si(S[0]), .Ciout(C[1]));
Full_Adder s1 (.Ai(A[1]), .Bi(B[1] ^ sub), .Ciin(C[1]), .Si(S[1]), .Ciout(C[2]));
Full_Adder s2 (.Ai(A[2]), .Bi(B[2] ^ sub), .Ciin(C[2]), .Si(S[2]), .Ciout(C[3]));
Full_Adder s3 (.Ai(A[3]), .Bi(B[3] ^ sub), .Ciin(C[3]), .Si(S[3]), .Ciout(C[4]));
Full_Adder s4 (.Ai(A[4]), .Bi(B[4] ^ sub), .Ciin(C[4]), .Si(S[4]), .Ciout(C[5]));


assign Cout = C[N];
endmodule 
