module Five_Bit_Expo(
	input [4:0] A,B,
	output [4:0] LEDS,
	output Cout
);


logic [4:0] Result, BinResult;

//assign LEDS = (Cout == 1'b0) ? Result : BinResult;
assign LEDS = (Cout == 1'b0) ? BinResult : Result;



RC_Sub RC_Sub_inst
(
	.A(A) ,	// input [7:0] A_sig
	.B(B) ,	// input [7:0] B_sig
	.S(Result) ,	// output [7:0] S_sig
	.Cout(Cout) 	// output  Cout_sig
);


conv_two conv_two_inst //2's Comp -> Signed
(
	.A(Result) ,	// input [N-1:0] A_sig
	.B(BinResult) 	// output [N-1:0] B_sig
);


endmodule 