module rightShifter (
    input  [10:0] in,      // 11-bit input
    input  [3:0] control,   // 4-bit shift amount
    output [10:0] out      // 11-bit output
);

    wire [10:0] stage0, stage1, stage2;
	 
//8-Bit Shift Right
    mux2x1 ins0_0 (.in0(in[10]),.in1(1'b0),  .sel(control[3]), .out(stage2[10]));
    mux2x1 ins0_1 (.in0(in[9]), .in1(1'b0),  .sel(control[3]), .out(stage2[9]));
    mux2x1 ins0_2 (.in0(in[8]), .in1(1'b0),  .sel(control[3]), .out(stage2[8]));
    mux2x1 ins0_3 (.in0(in[7]), .in1(1'b0),  .sel(control[3]), .out(stage2[7]));
    mux2x1 ins0_4 (.in0(in[6]), .in1(1'b0),  .sel(control[3]), .out(stage2[6]));
    mux2x1 ins0_5 (.in0(in[5]), .in1(1'b0),  .sel(control[3]), .out(stage2[5]));
    mux2x1 ins0_6 (.in0(in[4]), .in1(1'b0),  .sel(control[3]), .out(stage2[4]));
    mux2x1 ins0_7 (.in0(in[3]), .in1(1'b0),  .sel(control[3]), .out(stage2[3]));
    mux2x1 ins0_8 (.in0(in[2]), .in1(in[10]),.sel(control[3]), .out(stage2[2]));
    mux2x1 ins0_9 (.in0(in[1]), .in1(in[9]), .sel(control[3]), .out(stage2[1]));
	 mux2x1 ins0_10(.in0(in[0]), .in1(in[8]), .sel(control[3]), .out(stage2[0]));
	 
	 
//4-Bit Shift Right
    mux2x1 ins1_0 (.in0(stage2[10]),.in1(1'b0),  	  .sel(control[2]), .out(stage0[10]));
    mux2x1 ins1_1 (.in0(stage2[9]), .in1(1'b0),  	  .sel(control[2]), .out(stage0[9]));
    mux2x1 ins1_2 (.in0(stage2[8]), .in1(1'b0),  	  .sel(control[2]), .out(stage0[8]));
    mux2x1 ins1_3 (.in0(stage2[7]), .in1(1'b0), 	  .sel(control[2]), .out(stage0[7]));
    mux2x1 ins1_4 (.in0(stage2[6]), .in1(stage2[10]),.sel(control[2]), .out(stage0[6]));
    mux2x1 ins1_5 (.in0(stage2[5]), .in1(stage2[9]), .sel(control[2]), .out(stage0[5]));
    mux2x1 ins1_6 (.in0(stage2[4]), .in1(stage2[8]), .sel(control[2]), .out(stage0[4]));
    mux2x1 ins1_7 (.in0(stage2[3]), .in1(stage2[7]), .sel(control[2]), .out(stage0[3]));
    mux2x1 ins1_8 (.in0(stage2[2]), .in1(stage2[6]), .sel(control[2]), .out(stage0[2]));
    mux2x1 ins1_9 (.in0(stage2[1]), .in1(stage2[5]), .sel(control[2]), .out(stage0[1]));
	 mux2x1 ins1_10(.in0(stage2[0]), .in1(stage2[4]), .sel(control[2]), .out(stage0[0]));
    
	 
//2-Bit Shift Right
    mux2x1 ins2_0 (.in0(stage0[10]),.in1(1'b0),  	  .sel(control[1]), .out(stage1[10]));
    mux2x1 ins2_1 (.in0(stage0[9]), .in1(1'b0),  	  .sel(control[1]), .out(stage1[9]));
    mux2x1 ins2_2 (.in0(stage0[8]), .in1(stage0[10]),.sel(control[1]), .out(stage1[8]));
	 mux2x1 ins2_3 (.in0(stage0[7]), .in1(stage0[9]), .sel(control[1]), .out(stage1[7]));
    mux2x1 ins2_4 (.in0(stage0[6]), .in1(stage0[8]), .sel(control[1]), .out(stage1[6]));
    mux2x1 ins2_5 (.in0(stage0[5]), .in1(stage0[7]), .sel(control[1]), .out(stage1[5]));
    mux2x1 ins2_6 (.in0(stage0[4]), .in1(stage0[6]), .sel(control[1]), .out(stage1[4]));
    mux2x1 ins2_7 (.in0(stage0[3]), .in1(stage0[5]), .sel(control[1]), .out(stage1[3]));
    mux2x1 ins2_8 (.in0(stage0[2]), .in1(stage0[4]), .sel(control[1]), .out(stage1[2]));
    mux2x1 ins2_9 (.in0(stage0[1]), .in1(stage0[3]), .sel(control[1]), .out(stage1[1]));
	 mux2x1 ins2_10(.in0(stage0[0]), .in1(stage0[2]), .sel(control[1]), .out(stage1[0]));
	 
//1-Bit Shift Right
	 mux2x1 ins3_0 (.in0(stage1[10]),.in1(1'b0),  	  .sel(control[0]), .out(out[10]));
	 mux2x1 ins3_1 (.in0(stage1[9]), .in1(stage1[10]),.sel(control[0]), .out(out[9]));
	 mux2x1 ins3_2 (.in0(stage1[8]), .in1(stage1[9]), .sel(control[0]), .out(out[8]));
    mux2x1 ins3_3 (.in0(stage1[7]), .in1(stage1[8]), .sel(control[0]), .out(out[7]));
    mux2x1 ins3_4 (.in0(stage1[6]), .in1(stage1[7]), .sel(control[0]), .out(out[6]));
    mux2x1 ins3_5 (.in0(stage1[5]), .in1(stage1[6]), .sel(control[0]), .out(out[5]));
    mux2x1 ins3_6 (.in0(stage1[4]), .in1(stage1[5]), .sel(control[0]), .out(out[4]));
    mux2x1 ins3_7 (.in0(stage1[3]), .in1(stage1[4]), .sel(control[0]), .out(out[3]));
    mux2x1 ins3_8 (.in0(stage1[2]), .in1(stage1[3]), .sel(control[0]), .out(out[2]));
    mux2x1 ins3_9 (.in0(stage1[1]), .in1(stage1[2]), .sel(control[0]), .out(out[1]));
	 mux2x1 ins3_10(.in0(stage1[0]), .in1(stage1[1]), .sel(control[0]), .out(out[0]));

endmodule
