module LCD_Board_Test_LCD
	 (input                clk          , // 50MHz Clock
	  input                lcd_reset    , // LCD Reset
	  input    [0:11] 	  LCD_Board_PB , // LCD Board Push Buttons
     input    [0:4] 		  LCD_Board_SW , // LCD Board Switches
	  
	  
	  input [3:0] row_sig,
	  input [1:0]target_line,		//swapping lines
	  input target_sign,				//SWITCH minus/plus
	  output [3:0] col_sig,
	  output [3:0] value_sig,  
	  
	  
	  inout    [7:0]       lcd_data     , // LCD Data Bus
     output   [0:7] 		  LCD_Board_LED, // LCD Board LEDs
	  output               lcd_rs       , // LCD Register Select
	  output               lcd_rw       , // LCD Read Write Select
	  output               lcd_e          // LCD Execute
	  );  
	   
	 
	 //KEYPAD -> DISPLAY
	 reg [15:0] Areg, Breg, Creg;
	 logic [19:0] out_sig;
	  
	//SIGN DISPLAY
	 wire [1:0] sign_sig;
	 assign sign_sig = (target_sign) ? 2'b01 : 2'b10;
	 
	//SIGNALS TO LOAD WHAT LINE
	 wire LoadA, LoadB, LoadC;
	 assign LoadA = LCD_Board_PB[0];
	 assign LoadB = LCD_Board_PB[6]; //was 1
	 assign LoadC = LCD_Board_PB[11]; //was 2
	 
	 
	// WIRES FOR CONNECTIONS
	 logic [9:0] MA, MB;
	 logic [4:0] EA, EB, shift_sig, bigEx, smolEx, finEX, currEx;
	 logic coutEX, coutRip, SA, SB;
	 logic [10:0] smallMantis, largeMantis, shiftedMan,addedMantis,finMan, finManSUB, finManADD;
	 
	
	Keypad_Input Keypad_Input_inst 
(
	.clk(clk) ,				// input  clk_sig
	.reset(lcd_reset) ,	// input  reset_sig
	.row(row_sig) ,		// input [3:0] row_sig
	.col(col_sig) ,		// output [3:0] col_sig
	.out(out_sig) ,		// output [DIGITS*4-1:0] out_sig
	.value(value_sig) ,	// output [3:0] value_sig
	.trig(trig_sig) 		// output  trig_sig
);

	always_ff @ (posedge LoadA, posedge LoadB, posedge LoadC, negedge lcd_reset) begin 
	
		if (lcd_reset == 0) begin
			Areg <= 0; 
			Breg <= 0;
			Creg <= 0;
		end
		
		else if (LoadA == 1) begin Areg <= out_sig; end
		else if (LoadB == 1) begin Breg <= out_sig; end
		else if (LoadC == 1) begin Creg[15] <= SB; Creg[14:10] <=finEX; Creg[9:0] <= finMan; end
		
	end
	
	
	//Assign Bit input to Mantissa/Expo/Sign
	assign SA = Areg[15];
	assign EA = Areg[14:10];
	assign MA = Areg[9:0];
	
	assign SB = Breg[15];
	assign EB = Breg[14:10];
	assign MB = Breg[9:0];

	 
	 
	 
	 
	 Five_Bit_Expo Exponent_Subtractor
(
	.A(EA) ,	// input [4:0] A_sig
	.B(EB) ,	// input [4:0] B_sig
	.LEDS(shift_sig) ,	// output [4:0] LEDS_sig
	.Cout(coutEX) 	// output  Cout_sig
);
	 
	 
	 //assign output = (sel) ? val_if_true : val_if_false;
	 
	 //Mantissa Shifter MUX -> Want Smaller Exponent's Mantissa
	 assign smallMantis[9:0] = (coutEX) ? MB : MA;
	 assign smallMantis[10] = 1'b1;
	 
	 //Mantissa Adder MUX -> Want Larger Exponent's Mantissa
	 assign largeMantis[9:0] = (coutEX) ? MA : MB;
	 assign largeMantis[10] = 1'b1;
	 
	 //Exponent INC MUX -> Want Larger Exponent
	 assign bigEx = (coutEX) ? EA : EB;
	 assign smolEx = (~coutEX) ? EA : EB;
	 assign currEx = (SB) ? smolEx : bigEx;
	 
	 
	 rightShifter Mantissa_Right_Shifter
(
	.in(smallMantis) ,	// input [10:0] in_sig
	.control(shift_sig[3:0]) ,	// input [3:0] control_sig
	.out(shiftedMan) 	// output [10:0] out_sig
);

	wire subFlag;
	assign subFlag = (SB) ? 1'b1 : 1'b0;

	Ripple_Carry	RippleCarry_Adder(
    .A(largeMantis),			//input [10:0] A_sig
	 .B(shiftedMan),			//input [10:0] B_sig
	 .sum_add(subFlag),	//input sum_add_sig				CHANGED: 1'b-> subFlag
    .S(addedMantis),				// output [10:0] S_sig    
    .Cout(coutRip)			//output Cout_sig
	 );


	Controlled_incr_decr Controlled_Exponent_Incrementor
(
	.select(coutRip) ,	// input  select_sig
	.Cin(SB) ,	// input  Cin_sig		//From 0 -> worked for adding, 1 work for sub
	.A(currEx) ,	// input [4:0] A_sig
	.B(finEX) 	// output [4:0] B_sig
);

//ADD MANTISSA HANDELING
wire [3:0] normalizingADD;
wire [1:0] normalizingSUB;
assign normalizingADD[3:1] =3'b000; 
assign normalizingADD[0] = coutRip;

		 rightShifter Mantissa_Normalizer_Shifter
(
	.in(addedMantis) ,	// input [10:0] in_sig
	.control(normalizingADD) ,	// input [3:0] control_sig
	.out(finManADD) 	// output [10:0] out_sig
);

//SUB MANTISSA HANDELING
assign normalizingSUB = (coutRip) ? 2'b10 : 2'b01;

		 leftShifter Mantissa_Normalizer_LShifter
(
	.in(addedMantis) ,	// input [10:0] in_sig
	.control(normalizingSUB) ,	// input [1:0] control_sig
	.out(finManSUB) 	// output [10:0] out_sig
);


assign finMan = (SB) ? finManSUB : finManADD;


	


	LCD #(
		 .WIDTH(64),
		 .DIGITS(16),
		 .FLOAT(0),
		 .MODE(1),
		 .LINES(4),
		 .CHARS(20),
		 .LINE_STARTS({7'h00, 7'h40, 7'h14, 7'h54})
		 )(
		 .clk(clk),
		 .lcd_data(lcd_data),
		 .lcd_rs(lcd_rs),
		 .lcd_rw(lcd_rw),
		 .lcd_e(lcd_e),
		 .lcd_reset(!lcd_reset),
		 .A(Areg),
		 .B(Breg),
		 .C(Creg),
		 .Operation(2'b01) // PLUS = 2'b01 MIN= 2'b10
	);



endmodule