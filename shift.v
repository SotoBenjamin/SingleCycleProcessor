module shift(ShiftD, WD,WriteData);
input wire [6:0] ShiftD; 
input wire [31:0] WD;
output reg [31:0] WriteData; 
// WD : [32 bits]
// ShiftD = Istr[11:5]

// lsl 00 , lsr 01 , ars 10 , ror 11

//shiftD[1:0] = sh
//shiftD[6:2] = shamt5

always @(*) begin
    case (ShiftD[1:0] )
        2'b00: WriteData = WD << ShiftD[6:2];
        2'b01: WriteData = WD >> ShiftD[6:2];
        2'b10: WriteData = $signed(WD) >>> ShiftD[6:2] ;
        2'b11: WriteData = (WD >> ShiftD[6:2]) | (WD << (32 - ShiftD[6:2])); 
    endcase
end
endmodule   