//=======================================================
//  MODULE Definition
//=======================================================
module Scratchpad #(parameter DATAWIDTH_DATA=32, parameter DATAWIDTH_DECODER_SELECTION=6,  parameter DATAWIDTH_DECODER_SELECTED=8)
(
	input Clock,
	input Reset,
	input [DATAWIDTH_DECODER_SELECTION-1:0] Amux_Selector,
	input [DATAWIDTH_DECODER_SELECTION-1:0] Bmux_Selector,
	input [DATAWIDTH_DECODER_SELECTION-1:0] Cmux_Selector,
	input [DATAWIDTH_DATA-1:0] Cmux_BUS_DATA,
	
	output [DATAWIDTH_DATA-1:0] Amux_BUS_DATA,
	output [DATAWIDTH_DATA-1:0] Bmux_BUS_DATA,
	output [DATAWIDTH_DATA-1:0] IR_DATA_BUS
) ;

//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  REG/WIRE declarations
//=======================================================

wire [DATAWIDTH_DATA-1:0] Cmux_BUS_DATA_IN;

wire [DATAWIDTH_DECODER_SELECTED-1:0] C_DECODER_SELECTED_REG;
wire [DATAWIDTH_DECODER_SELECTED-1:0] A_DECODER_SELECTED_REG;
wire [DATAWIDTH_DECODER_SELECTED-1:0] B_DECODER_SELECTED_REG;

wire [DATAWIDTH_DATA-1:0] REG_R0;
wire [DATAWIDTH_DATA-1:0] REG_R1;
wire [DATAWIDTH_DATA-1:0] REG_R2;
wire [DATAWIDTH_DATA-1:0] REG_R3;
wire [DATAWIDTH_DATA-1:0] REG_R4;
wire [DATAWIDTH_DATA-1:0] REG_R5;
wire [DATAWIDTH_DATA-1:0] REG_PC;
wire [DATAWIDTH_DATA-1:0] REG_IR;

//=======================================================
//  Structural coding
//=======================================================

						//REGISTERS//
//FIXED REGISTER
SC_RegFIXED r0 
(
	.SC_RegFIXED_data_OutBUS(REG_R0),
	.SC_RegFIXED_CLOCK_50(Clock),
	.SC_RegFIXED_RESET_InHigh(Reset)
);

//GENERAL REGISTERS
SC_RegGENERAL r1
(
	//////////// OUTPUTS //////////
	.SC_RegGENERAL_data_OutBUS(REG_R1),
	//////////// INPUTS //////////
	.SC_RegGENERAL_CLOCK_50(Clock),
	.SC_RegGENERAL_RESET_InHigh(Reset),
	.SC_RegGENERAL_clear_InLow(1'b1), 
	.SC_RegGENERAL_load_InLow(C_DECODER_SELECTED_REG[1]), 
	.SC_RegGENERAL_data_InBUS(Cmux_BUS_DATA_IN)
);

SC_RegGENERAL r2
(
	//////////// OUTPUTS //////////
	.SC_RegGENERAL_data_OutBUS(REG_R2),
	//////////// INPUTS //////////
	.SC_RegGENERAL_CLOCK_50(Clock),
	.SC_RegGENERAL_RESET_InHigh(Reset),
	.SC_RegGENERAL_clear_InLow(1'b1), 
	.SC_RegGENERAL_load_InLow(C_DECODER_SELECTED_REG[2]), 
	.SC_RegGENERAL_data_InBUS(Cmux_BUS_DATA_IN)
);

SC_RegGENERAL r3
(
	//////////// OUTPUTS //////////
	.SC_RegGENERAL_data_OutBUS(REG_R3),
	//////////// INPUTS //////////
	.SC_RegGENERAL_CLOCK_50(Clock),
	.SC_RegGENERAL_RESET_InHigh(Reset),
	.SC_RegGENERAL_clear_InLow(1'b1), 
	.SC_RegGENERAL_load_InLow(C_DECODER_SELECTED_REG[3]), 
	.SC_RegGENERAL_data_InBUS(Cmux_BUS_DATA_IN)
);

SC_RegGENERAL r4
(
	//////////// OUTPUTS //////////
	.SC_RegGENERAL_data_OutBUS(REG_R4),
	//////////// INPUTS //////////
	.SC_RegGENERAL_CLOCK_50(Clock),
	.SC_RegGENERAL_RESET_InHigh(Reset),
	.SC_RegGENERAL_clear_InLow(1'b1), 
	.SC_RegGENERAL_load_InLow(C_DECODER_SELECTED_REG[4]), 
	.SC_RegGENERAL_data_InBUS(Cmux_BUS_DATA_IN)
);

SC_RegGENERAL r5
(
	//////////// OUTPUTS //////////
	.SC_RegGENERAL_data_OutBUS(REG_R4),
	//////////// INPUTS //////////
	.SC_RegGENERAL_CLOCK_50(Clock),
	.SC_RegGENERAL_RESET_InHigh(Reset),
	.SC_RegGENERAL_clear_InLow(1'b1), 
	.SC_RegGENERAL_load_InLow(C_DECODER_SELECTED_REG[5]), 
	.SC_RegGENERAL_data_InBUS(Cmux_BUS_DATA_IN)
);


//PC LINE REGISTER
SC_Reg_PC PC // Empieza en la linea 2048
(
	//////////// OUTPUTS //////////
	.SC_RegGENERAL_data_OutBUS(REG_PC),
	//////////// INPUTS //////////
	.SC_RegGENERAL_CLOCK_50(Clock),
	.SC_RegGENERAL_RESET_InHigh(Reset),
	.SC_RegGENERAL_clear_InLow(1'b1), 
	.SC_RegGENERAL_load_InLow(C_DECODER_SELECTED_REG[6]), 
	.SC_RegGENERAL_data_InBUS(Cmux_BUS_DATA_IN)
);

//INSTRUCTIONS REGISTER
SC_RegGENERAL IR
(
	//////////// OUTPUTS //////////
	.SC_RegGENERAL_data_OutBUS(IR_DATA_BUS),
	//////////// INPUTS //////////
	.SC_RegGENERAL_CLOCK_50(Clock),
	.SC_RegGENERAL_RESET_InHigh(Reset),
	.SC_RegGENERAL_clear_InLow(1'b1), 
	.SC_RegGENERAL_load_InLow(C_DECODER_SELECTED_REG[7]), 
	.SC_RegGENERAL_data_InBUS(Cmux_BUS_DATA_IN)
);
						//DECODERS//
//INPUT
CC_DECODER C_DEC
(
	//////////// OUTPUTS //////////
	.CC_DECODER_datadecoder_OutBUS(C_DECODER_SELECTED_REG),
	//////////// INPUTS //////////
	.CC_DECODER_selection_InBUS(Cmux_Selector)
);

//OUTPUT
CC_DECODER A_DEC
(
	//////////// OUTPUTS //////////
	.CC_DECODER_datadecoder_OutBUS(A_DECODER_SELECTED_REG),
	//////////// INPUTS //////////
	.CC_DECODER_selection_InBUS(Amux_Selector)
);

CC_DECODER B_DEC
(
	//////////// OUTPUTS //////////
	.CC_DECODER_datadecoder_OutBUS(B_DECODER_SELECTED_REG),
	//////////// INPUTS //////////
	.CC_DECODER_selection_InBUS(Bmux_Selector)
);

						//OUTPUT BUS A AND B MUX//
MUX_8 A_MUX
(
	//////////// OUTPUTS //////////
	.MUX_8_data_OutBUS(Amux_BUS_DATA),
	//////////// INPUTS //////////
	.MUX_8_data0_InBUS(REG_R0),
	.MUX_8_data1_InBUS(REG_R1),
	.MUX_8_data2_InBUS(REG_R2),	
	.MUX_8_data3_InBUS(REG_R3),	
	.MUX_8_data4_InBUS(REG_R4),	
	.MUX_8_data5_InBUS(REG_R5),	
	.MUX_8_data6_InBUS(REG_PC),	
	.MUX_8_data7_InBUS(32'b0),	
	.MUX_8_selection_InBUS(A_DECODER_SELECTED_REG)
);

MUX_8 B_MUX
(
	//////////// OUTPUTS //////////
	.MUX_8_data_OutBUS(Bmux_BUS_DATA),
	//////////// INPUTS //////////
	.MUX_8_data0_InBUS(REG_R0),
	.MUX_8_data1_InBUS(REG_R1),
	.MUX_8_data2_InBUS(REG_R2),	
	.MUX_8_data3_InBUS(REG_R3),	
	.MUX_8_data4_InBUS(REG_R4),	
	.MUX_8_data5_InBUS(REG_R5),	
	.MUX_8_data6_InBUS(REG_PC),	
	.MUX_8_data7_InBUS(32'b0),		
	.MUX_8_selection_InBUS(B_DECODER_SELECTED_REG)
);

endmodule
