//=======================================================
//  MODULE Definition
//=======================================================
module MUX_8 #(parameter DATAWIDTH_MUX_SELECTION=3, parameter DATAWIDTH_BUS=32)(
	//////////// OUTPUTS //////////
	MUX_8_data_OutBUS,
	//////////// INPUTS //////////
	MUX_8_data0_InBUS,
	MUX_8_data1_InBUS,
	MUX_8_data2_InBUS,	
	MUX_8_data3_InBUS,	
	MUX_8_data4_InBUS,	
	MUX_8_data5_InBUS,	
	MUX_8_data6_InBUS,	
	MUX_8_data7_InBUS,	
	MUX_8_selection_InBUS
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output reg	[DATAWIDTH_BUS-1:0] MUX_8_data_OutBUS;
input			[DATAWIDTH_BUS-1:0] MUX_8_data0_InBUS;
input			[DATAWIDTH_BUS-1:0] MUX_8_data1_InBUS;
input			[DATAWIDTH_BUS-1:0] MUX_8_data2_InBUS;
input			[DATAWIDTH_BUS-1:0] MUX_8_data3_InBUS;	
input			[DATAWIDTH_BUS-1:0] MUX_8_data4_InBUS;
input			[DATAWIDTH_BUS-1:0] MUX_8_data5_InBUS;
input			[DATAWIDTH_BUS-1:0] MUX_8_data6_InBUS;
input			[DATAWIDTH_BUS-1:0] MUX_8_data7_InBUS;
input			[DATAWIDTH_MUX_SELECTION-1:0] MUX_8_selection_InBUS;
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always@(*)
begin
	case (MUX_8_selection_InBUS)	
	// Example to more outputs: WaitStart: begin sResetCounter = 0; sCuenteUP = 0; end
		8'b11111110: MUX_8_data_OutBUS = MUX_8_data0_InBUS;
		8'b11111101: MUX_8_data_OutBUS = MUX_8_data1_InBUS;
		8'b11111011: MUX_8_data_OutBUS = MUX_8_data2_InBUS;
		8'b11110111: MUX_8_data_OutBUS = MUX_8_data3_InBUS;
		8'b11101111: MUX_8_data_OutBUS = MUX_8_data4_InBUS;
		8'b11011111: MUX_8_data_OutBUS = MUX_8_data5_InBUS;
		8'b10111111: MUX_8_data_OutBUS = MUX_8_data6_InBUS;
		8'b01111111: MUX_8_data_OutBUS = MUX_8_data7_InBUS;
		default :  MUX_8_data_OutBUS = MUX_8_data6_InBUS; // channel 0 is selected 
	endcase
end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule

