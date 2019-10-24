//=======================================================
//  MODULE Definition
//=======================================================
module MUX_2 #(parameter DATAWIDTH_MUX_SELECTION=1, parameter DATAWIDTH_BUS=32)(
	//////////// OUTPUTS //////////
	CC_MUX_data_OutBUS,
	//////////// INPUTS //////////
	CC_MUX_data0_InBUS,
	CC_MUX_data1_InBUS,	
	CC_MUX_selection_InBUS
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output reg	[DATAWIDTH_BUS-1:0] CC_MUX_data_OutBUS;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data0_InBUS;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data1_InBUS;
input			[DATAWIDTH_MUX_SELECTION-1:0] CC_MUX_selection_InBUS;
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always@(*)
begin
	case (CC_MUX_selection_InBUS)	
	// Example to more outputs: WaitStart: begin sResetCounter = 0; sCuenteUP = 0; end
		1'b0: CC_MUX_data_OutBUS = CC_MUX_data0_InBUS;
		1'b1: CC_MUX_data_OutBUS = CC_MUX_data1_InBUS;
		default :   CC_MUX_data_OutBUS = CC_MUX_data0_InBUS; // channel 0 is selected 
	endcase
end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule

