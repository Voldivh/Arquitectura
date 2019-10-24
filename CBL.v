//=======================================================
//  MODULE Definition
//=======================================================
module CBL #(parameter DATAWIDTH_BUS=32)
(
	//////////// INPUTS //////////
	CLK,
	PSR_In,
	COND_In,
	IR_In,
	//////////// OUTPUTS //////////
	Control_Branch_2_CS_MUX
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	input					CLK;
	input					IR_In;
	input			[3:0] PSR_In;
	input			[2:0] COND_In;
	output reg	[1:0] Control_Branch_2_CS_MUX;
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
	always @ (*)
		begin
			case (COND_In)
				3'b000: 	Control_Branch_2_CS_MUX = 2'b00; // Next Address.
				3'b010:
					begin
						if(COND_In==3'b010 && PSR_In[2]==1'b1)//Zero
							Control_Branch_2_CS_MUX = 2'b01;
						else
							Control_Branch_2_CS_MUX = 2'b00;
					end
				3'b101: // Jump Addr if IR[13] = 1
					begin
						if(IR_In == 1)
							Control_Branch_2_CS_MUX = 2'b01;
						else
							Control_Branch_2_CS_MUX = 2'b00;
					end
				3'b110: 	Control_Branch_2_CS_MUX = 2'b01; // Jump Address.
				3'b111: 	Control_Branch_2_CS_MUX = 2'b10; // Decode.
				default: Control_Branch_2_CS_MUX = 2'b11;
			endcase
		end

//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule
