
//=======================================================
//  MODULE Definition
//=======================================================
module CC_DECODER #(parameter DATAWIDTH_DECODER_SELECTION=6, parameter DATAWIDTH_DECODER_OUT=8)(
	//////////// OUTPUTS //////////
	CC_DECODER_datadecoder_OutBUS,
	//////////// INPUTS //////////
	CC_DECODER_selection_InBUS
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output reg	[DATAWIDTH_DECODER_OUT-1:0] CC_DECODER_datadecoder_OutBUS;
input		[DATAWIDTH_DECODER_SELECTION-1:0] CC_DECODER_selection_InBUS;
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always@(*)
begin
	case (CC_DECODER_selection_InBUS)	
		6'b000000: CC_DECODER_datadecoder_OutBUS = 8'b11111110;
		6'b000001: CC_DECODER_datadecoder_OutBUS = 8'b11111101;
		6'b000010: CC_DECODER_datadecoder_OutBUS = 8'b11111011;
		6'b000011: CC_DECODER_datadecoder_OutBUS = 8'b11110111;
		6'b000100: CC_DECODER_datadecoder_OutBUS = 8'b11101111;
		6'b000101: CC_DECODER_datadecoder_OutBUS = 8'b11011111;
		6'b000110: CC_DECODER_datadecoder_OutBUS = 8'b10111111;//PC
		6'b000111: CC_DECODER_datadecoder_OutBUS = 8'b01111111;//IR
		default  : CC_DECODER_datadecoder_OutBUS = 8'b11111111;//IR
	endcase
end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule
