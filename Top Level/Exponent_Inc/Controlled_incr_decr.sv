module Controlled_incr_decr(
input select, 			//Select signals 1 for change, 0 for no change
input Cin,				//Cin is 1 for subtraction, 0 for addition
input [4:0] A,			
output [4:0] B
);


genvar j;
logic [4:0] Cout;

	
//Initial FA XOR with Select
FAbehav FA(
	.ai(A[0]), 			//input ai_sig
	.bi(Cin^select), 	//input bi_sig
	.cini(Cin), 			//input cini_sig
	.si(B[0]), 			//output si_sig
	.couti(Cout[0])			//output couti_sig
); 


//Generates Chained FAs 
	generate
		begin
		
			for(j=1; j<5; j=j+1)
				begin: 
				generatingBlock	
					FAbehav FA(
						.ai(A[j]), 				//input ai_sig
						.bi(Cin^1'b0), 		//input bi_sig {Cin XOR 0}
						.cini(Cout[j-1]), 	//input cini_sig
						.si(B[j]),	 			//output si_sig
						.couti(Cout[j])		//output couti_sig
					); 
				end
				
		end
	endgenerate

endmodule 
