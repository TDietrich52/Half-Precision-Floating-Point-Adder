module leftShifter (
    input  [10:0] in,      // 11-bit input
    input  [1:0] control,   // 4-bit shift amount
    output [10:0] out      // 11-bit output
);

wire [10:0] stage1;
	 
//1-Bit Shift Left
	 mux2x1 ins3_0 (.in0(in[10]),.in1(in[9]), .sel(control[0]), .out(stage1[10]));
	 mux2x1 ins3_1 (.in0(in[9]), .in1(in[8]),. sel(control[0]), .out(stage1[9]));
	 mux2x1 ins3_2 (.in0(in[8]), .in1(in[7]), .sel(control[0]), .out(stage1[8]));
    mux2x1 ins3_3 (.in0(in[7]), .in1(in[6]), .sel(control[0]), .out(stage1[7]));
    mux2x1 ins3_4 (.in0(in[6]), .in1(in[5]), .sel(control[0]), .out(stage1[6]));
    mux2x1 ins3_5 (.in0(in[5]), .in1(in[4]), .sel(control[0]), .out(stage1[5]));
    mux2x1 ins3_6 (.in0(in[4]), .in1(in[3]), .sel(control[0]), .out(stage1[4]));
    mux2x1 ins3_7 (.in0(in[3]), .in1(in[2]), .sel(control[0]), .out(stage1[3]));
    mux2x1 ins3_8 (.in0(in[2]), .in1(in[1]), .sel(control[0]), .out(stage1[2]));
    mux2x1 ins3_9 (.in0(in[1]), .in1(in[0]), .sel(control[0]), .out(stage1[1]));
	 mux2x1 ins3_10(.in0(in[0]), .in1(1'b0),  .sel(control[0]), .out(stage1[0]));
	 
//2-Bit Shift Left
	 mux2x1 ins2_0 (.in0(stage1[10]),.in1(stage1[8]), .sel(control[1]), .out(out[10]));
	 mux2x1 ins2_1 (.in0(stage1[9]), .in1(stage1[7]),. sel(control[1]), .out(out[9]));
	 mux2x1 ins2_2 (.in0(stage1[8]), .in1(stage1[6]), .sel(control[1]), .out(out[8]));
    mux2x1 ins2_3 (.in0(stage1[7]), .in1(stage1[5]), .sel(control[1]), .out(out[7]));
    mux2x1 ins2_4 (.in0(stage1[6]), .in1(stage1[4]), .sel(control[1]), .out(out[6]));
    mux2x1 ins2_5 (.in0(stage1[5]), .in1(stage1[3]), .sel(control[1]), .out(out[5]));
    mux2x1 ins2_6 (.in0(stage1[4]), .in1(stage1[2]), .sel(control[1]), .out(out[4]));
    mux2x1 ins2_7 (.in0(stage1[3]), .in1(stage1[1]), .sel(control[1]), .out(out[3]));
    mux2x1 ins2_8 (.in0(stage1[2]), .in1(stage1[0]), .sel(control[1]), .out(out[2]));
    mux2x1 ins2_9 (.in0(stage1[1]), .in1(1'b0), 	  .sel(control[1]), .out(out[1]));
	 mux2x1 ins2_10(.in0(stage1[0]), .in1(1'b0),  	  .sel(control[1]), .out(out[0]));

endmodule