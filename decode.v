module decode (
	Op,
	Funct,
	Rd,
	mult,
	FlagW,
	PCS,
	RegW,
	MemW,
	MemtoReg,
	ALUSrc,
	ImmSrc,
	RegSrc,
	ALUControl,	
	RegaSrc
);
	input wire [1:0] Op;
	input wire [5:0] Funct;
	input wire [3:0] Rd;
	input wire mult;
	output reg [1:0] FlagW;
	output wire PCS;
	output wire RegW;
	output wire MemW;
	output wire MemtoReg;
	output wire ALUSrc;
	output wire [1:0] ImmSrc;
	output wire [1:0] RegSrc;
	output wire RegaSrc;
	output reg [2:0] ALUControl;
	reg [10:0] controls;
	wire Branch;
	wire ALUOp;

	//Main Decoder

	always @(*)
		casex (Op)
			2'b00:
				if (Funct[5])
					controls = 11'b00001010010;
				else begin
				  	if(mult) begin
						controls = 11'b00000010011; 
					end 
					else controls = 11'b00000010010;
				end
					
			2'b01:
				if (Funct[0])
					controls = 11'b00011110000;
				else
					controls = 11'b10011101000;
			2'b10: controls = 11'b01101000100;
			default: controls = 11'bxxxxxxxxxxx;
		endcase
	assign {RegSrc, ImmSrc, ALUSrc, MemtoReg, RegW, MemW, Branch, ALUOp, RegaSrc} = controls;

	//ALU Decoder

	always @(*)
		if (ALUOp) begin
			case (Funct[4:1])
				4'b0100: ALUControl = 3'b000; //add
				4'b0010: ALUControl = 3'b001; //sub
				4'b0000: ALUControl = 3'b010; //and
				4'b1100: ALUControl = 3'b011; //or
				4'b0001: ALUControl = 3'b100; //sdiv
				4'b1001: ALUControl = 3'b101; //udiv
				4'b0011: ALUControl = 3'b110; //mla						
				default: ALUControl = 3'bxx;
			endcase
			FlagW[1] = Funct[0];
			FlagW[0] = Funct[0] & ((ALUControl == 3'b000) | (ALUControl == 3'b001));
		end
		else begin
			ALUControl = 3'b000;
			FlagW = 2'b00;
		end
	assign PCS = ((Rd == 4'b1111) & RegW) | Branch;
endmodule
