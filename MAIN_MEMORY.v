//=======================================================
//  MODULE Definition
//=======================================================
module MAIN_MEMORY #(parameter DATAWIDTH_BUS=32)
(
	//////////// OUTPUTS //////////
	DATA_OUT,
	//////////// INPUTS //////////
	CLK,
	DATA_IN,
	ADDRESS,
	ACK,
	RD,
	WR
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	input									  CLK;
	input									  RD;
	input									  WR;
	input			[DATAWIDTH_BUS-1:0] DATA_IN;
	input			[DATAWIDTH_BUS-1:0] ADDRESS;
	output reg	[DATAWIDTH_BUS-1:0] DATA_OUT;
	output reg							  ACK;
	initial 								  ACK = 1'b0;

//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always@(RD,ADDRESS)
		begin
			if(RD == 1)
				begin
					case (ADDRESS)
						32'd2048 : DATA_OUT = 32'h8880200a; // ADDCC R4 = R0 + 10
						32'd2052 : DATA_OUT = 32'h86802000; // ADDCC R3 = R0 + 0
						32'd2056	: DATA_OUT = 32'h88813fff; // ADDCC R4 = R4 - 1
						32'd2060	: DATA_OUT = 32'h82802001; // ADDCC R1 = R0 + 1
						32'd2064	: DATA_OUT = 32'h84806000; // ADDCC R2 = R1 + 0
						32'd2068	: DATA_OUT = 32'h8680a000; // ADDCC R3 = R2 + 0
						32'd2072	: DATA_OUT = 32'h88813fff; // ADDCC R4 = R4 - 1

						32'd2076	: DATA_OUT = 32'h86804002; // ADDCC R3 = R2 + R1
						32'd2080	: DATA_OUT = 32'h8280a000; // ADDCC R1 = R2 + 0
						32'd2084	: DATA_OUT = 32'h8480e000; // ADDCC R2 = R3 + 0
						32'd2088	: DATA_OUT = 32'h88813fff; // ADDCC R4 = R4 - 1	
						
						32'd2092	: DATA_OUT = 32'h02800008; // be 8
						32'd2096	: DATA_OUT = 32'h10bfffec; // ba -20
						
						32'd2100	: DATA_OUT = 32'h8881200a; // R4 = R4 + 10
						32'd2104	: DATA_OUT = 32'h8680a000; // ADDCC R3 = R2 + 0
						32'd2108	: DATA_OUT = 32'h84806000; // ADDCC R2 = R1 + 0
						32'd2112	: DATA_OUT = 32'h8260c002; // SUBCC R1 = R3 + R2
						32'd2116	: DATA_OUT = 32'h88813fff; // ADDCC R4 = R4 - 1
						32'd2120	: DATA_OUT = 32'h02800008; // be 8
						32'd2124 : DATA_OUT = 32'h10bfffec; // ba -20
						default	: DATA_OUT = 32'h8880200a; // ADDCC R4 = R0 + 10
					endcase
				end
		end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule
