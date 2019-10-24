//=======================================================
//  MODULE Definition
//=======================================================
module PSR #(parameter DATAWIDTH_BUS=32)
(
	//////////// INPUTS //////////
	// General In	
	CLK,
	// Flags In
	Flags,
	// Conditions In
	SCC,
	//////////// OUTPUTS //////////
	// Flags Out
	Out
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	input					CLK;
	input					SCC;
	input			[3:0] Flags;//Negative, Zero, Overflow, Carry
	output reg	[3:0] Out;
	initial				Out = 4'b0;
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
	always@(*)
		begin
			if(SCC)
				Out = Flags;
		end


endmodule
