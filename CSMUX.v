//=======================================================
//  MODULE Definition
//=======================================================
module CSMUX #(parameter DATAWIDTH_CONTROL_ADDRESS_BUS=11, parameter DATAWIDTH_SCRATCHPAD_BUS=8, parameter DATAWIDTH_MICRO_INSTRUCTION_BUS=11, parameter DATAWIDTH_CONTROL_BRANCH_BUS=2)
(
	//////////// INPUTS //////////
	CLK,
	RESET,
	// CSAI In
	NEXT,
	// Registers Control In
	DECODE,
	// Jump Address In
	JUMP,
	// Branch Logic In
	CBL,
	//////////// OUTPUTS //////////
	OUT
);
//=======================================================
//  PARAMETER declarations
//=======================================================
	parameter decode = 11'b10000000000;
//=======================================================
//  PORT declarations
//=======================================================
	//////////// INPUTS //////////
	input 														  CLK;
	input 														  RESET;
	input 		[DATAWIDTH_CONTROL_ADDRESS_BUS-1:0]   NEXT;
	input 		[DATAWIDTH_SCRATCHPAD_BUS-1:0] 		  DECODE;
	input 		[DATAWIDTH_MICRO_INSTRUCTION_BUS-1:0] JUMP;
	input 		[DATAWIDTH_CONTROL_BRANCH_BUS-1:0] 	  CBL;
	//////////// OUTPUTS //////////
	output reg 	[10:0]										  OUT;
//=======================================================
//  REG/WIRE declarations
//=======================================================
//=======================================================
//  Structural coding
//=======================================================
//=======================================================
//  REG/WIRE declarations
//=======================================================
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always@(negedge CLK)
		begin
			case (CBL)
				2'b00: 	OUT = NEXT; // NEXT
				2'b01: 	OUT = JUMP; // JUMP
				2'b10:   // DECODE
					begin
						if(DECODE[7:3]==5'b00010)
							OUT = 11'd1088; // Branch
						else
							case(DECODE)
								8'b10010000: OUT = 11'd1600; // addcc
								8'b10001100: OUT = 11'd1584; // subcc
								8'b11000000: OUT = 11'd1792; // ld
								8'b11000100: OUT = 11'd1808; // st
							endcase
					end
				2'b11: 	OUT = 11'b00000000000; // NOTHING
				default: OUT = 11'b00000000000;
			endcase
		end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL
endmodule
