
//=======================================================
//  MODULE Definition
//=======================================================
module CC_ALU #(parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_ALU_SELECTION=4)(
	//////////// OUTPUTS //////////
	CC_ALU_overflow_OutHigh,
	CC_ALU_carry_OutHigh,
	CC_ALU_negative_OutHigh,
	CC_ALU_zero_OutHigh,
	CC_ALU_data_OutBUS,
	SCC,
	//////////// INPUTS //////////
	CC_ALU_dataA_InBUS,
	CC_ALU_dataB_InBUS,
	CC_ALU_selection_InBUS
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output 			CC_ALU_overflow_OutHigh;
output 			CC_ALU_carry_OutHigh;
output 			CC_ALU_negative_OutHigh;
output 			CC_ALU_zero_OutHigh;
output reg		[DATAWIDTH_BUS-1:0] CC_ALU_data_OutBUS;
output reg		SCC;
initial 			SCC = 1'b0;

input			[DATAWIDTH_BUS-1:0] CC_ALU_dataA_InBUS;
input			[DATAWIDTH_BUS-1:0] CC_ALU_dataB_InBUS;
input			[DATAWIDTH_ALU_SELECTION-1:0] CC_ALU_selection_InBUS;
//=======================================================
//  REG/WIRE declarations
//=======================================================
wire caover,cout;
wire [DATAWIDTH_BUS-2:0] addition0; // Variable usada para la operación suma y para determinar las flags
wire addition1;		// Variable usada para la operación suma y para determinar las flags
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always@(*)
begin
	case (CC_ALU_selection_InBUS)	
		4'b0000:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS & CC_ALU_dataB_InBUS;  					 // 0.  ANDCC (A,B)
		4'b0001:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS | CC_ALU_dataB_InBUS;  					 // 1.  ORCC (A,B)
		4'b0010:  CC_ALU_data_OutBUS =!(CC_ALU_dataA_InBUS & CC_ALU_dataB_InBUS);					 // 2.  ORNCC (A,B)
		4'b0011:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS + CC_ALU_dataB_InBUS;  					 // 3.  ADCC (A,B)
		4'b0100:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS>>CC_ALU_dataB_InBUS;   					 // 4.  SRL (A,B)
		4'b0101:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS & CC_ALU_dataB_InBUS; 				    // 5.  AND (A,B)
		4'b0110:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS | CC_ALU_dataB_InBUS;  					 // 6.  OR (A,B)
		4'b0111:  CC_ALU_data_OutBUS = ~(CC_ALU_dataA_InBUS|CC_ALU_dataB_InBUS); 					 // 7.  ORN (A,B)
		4'b1000:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS + CC_ALU_dataB_InBUS;	 					 // 8.  ADD (A,B)
		4'b1001:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS<<2; 										    // 9.  LSHIFT2 (A)
		4'b1010:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS<<10; 										    // 10. LSHIFT10 (A)
		4'b1011:  CC_ALU_data_OutBUS = {19'b0,CC_ALU_dataA_InBUS[12:0]};					 			 // 11. SIMM13 (A)
		4'b1100:  CC_ALU_data_OutBUS = {{19{CC_ALU_dataA_InBUS[12]}}, CC_ALU_dataA_InBUS[12:0]};// 12. SEXT13
		4'b1101:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS + 32'd1; 										 // 13. INC (A)
		4'b1110:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS + 32'd4; 										 // 14. INCPC (A)
		4'b1111:  CC_ALU_data_OutBUS = {{5{CC_ALU_dataA_InBUS[31]}}, CC_ALU_dataA_InBUS[31:5]}; // 15. RSHIFT5 (A)
		default :  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS; 							 					 // channel 0 is selected
	endcase
end
//=======================================================
//  Outputs
//=======================================================
	always @ (*)
		begin
			if(CC_ALU_selection_InBUS==4'd0||CC_ALU_selection_InBUS==4'd1||CC_ALU_selection_InBUS==4'd2||CC_ALU_selection_InBUS==4'd3)
				SCC = 1;
			else
				SCC = 0;
		end

/*Flags*/
assign {caover,addition0[DATAWIDTH_BUS-2:0]} = CC_ALU_dataA_InBUS[DATAWIDTH_BUS-2:0] + CC_ALU_dataB_InBUS[DATAWIDTH_BUS-2:0]; 	// Determinación de carry del bit número 7
assign {cout,addition1} = CC_ALU_dataA_InBUS[DATAWIDTH_BUS-1] + CC_ALU_dataB_InBUS[DATAWIDTH_BUS-1] + caover;	// Determinación de la flag Carry y la suma de busA y busB
assign CC_ALU_zero_OutHigh=(CC_ALU_data_OutBUS==32'd0) ? 1'b1 : 1'b0;	// Determinación de la flag Zero
assign CC_ALU_carry_OutHigh = cout;
assign CC_ALU_overflow_OutHigh =  (caover ^ cout);		// Determinación de la flag Ov a partir de la flag Carry y el carry del bit 7
assign CC_ALU_negative_OutHigh = (CC_ALU_data_OutBUS[DATAWIDTH_BUS-1]);	

endmodule


