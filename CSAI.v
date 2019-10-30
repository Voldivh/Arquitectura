//=======================================================
//  MODULE Definition
//=======================================================
module CSAI #(parameter DATAWIDTH_BUS=11)
(
	//////////// INPUTS //////////
	CLK, 
	RESET,
	ACK,
	CS,
	//////////// OUTPUTS //////////
	OUT
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	input		CLK;
	input		RESET;
	input		ACK;
	input		[10:0] CS;
	output		[10:0] OUT;
//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [DATAWIDTH_BUS-1:0] Counter_Register;
reg [DATAWIDTH_BUS-1:0] Counter_Signal;
//=======================================================
//  Structural coding
//=======================================================
// INPUT LOGIC: COMBINATIONAL
always @(CS)
begin
	if(ACK==0)
		Counter_Signal = CS + 1;
	else
		Counter_Signal = CS;
end	
// INPUT LOGIC: SEQUENTIAL
always@(posedge CLK, posedge RESET)
begin 
	if(RESET == 1)
		Counter_Register <= 0;
	else
		Counter_Register <= Counter_Signal;
end

//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL
assign OUT = Counter_Register;
endmodule
