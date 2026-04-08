/* 
 * 16 bit behavioral alu
 * authors: A.Atta, Youssif Mohammed
 * date 23/11/2025
 */

module alu
(
    input  wire [15:0] A, B,
    input  wire [4:0] F,
    input  wire Cin,
    output reg signed [15:0] Result,
    output reg  [5:0] Status            // CF ZF NF VF PF AF
);
    wire signed [15:0] sA = A;
    wire signed [15:0] sB = B;
    reg CF_ar;      // arithmetic carry
    reg VF_reg;     // overflow flag
    reg AF_reg;     // auxiliary carry

    always @(*) begin
        Result = 16'h0000;
        Status = 6'b000000;
        CF_ar = 1'b0;
        VF_reg = 1'b0;
        AF_reg = 1'b0;

        case(F)

            /* Arithmetic */
            5'b00001: begin // INC
                {CF_ar, Result} = {1'b0, sA} + 1;
                AF_reg = (A[3:0] + 1) > 4'hF;
                VF_reg = (A == 16'h7FFF);
            end

            5'b00011: begin // DEC
                {CF_ar, Result} = {1'b0, sA} - 1;
                AF_reg = (A[3:0] < 1);
                VF_reg = (A == 16'h8000);
            end

            5'b00100: begin // ADD
                {CF_ar, Result} = {1'b0, A} + {1'b0, B};
                AF_reg = (A[3:0] + B[3:0]) > 4'hF;
                VF_reg = (A[15] == B[15]) && (Result[15] != A[15]);
            end

            5'b00101: begin // ADC
                {CF_ar, Result} = {1'b0, A} + {1'b0, B} + Cin;
                AF_reg = (A[3:0] + B[3:0] + Cin) > 4'hF;
                VF_reg = (A[15] == B[15]) && (Result[15] != A[15]);
            end

            5'b00110: begin // SUB
                {CF_ar, Result} = {1'b0, A} - {1'b0, B};
                AF_reg = (A[3:0] < B[3:0]);
                VF_reg = (A[15] != B[15]) && (Result[15] != A[15]);
            end

            5'b00111: begin // SBB
                {CF_ar, Result} = {1'b0, A} - {1'b0, B} - Cin;
                AF_reg = (A[3:0] < (B[3:0] + Cin));
                VF_reg = (A[15] != B[15]) && (Result[15] != A[15]);
            end

            /* Logic */
            5'b01000: Result = A & B;
            5'b01001: Result = A | B;
            5'b01010: Result = A ^ B;
            5'b01011: Result = ~A;

            /* Shift / Rotate */
            5'b10000: begin Result = sA << 1;  CF_ar = A[15]; end            // SHL
            5'b10001: begin Result = sA >> 1;  CF_ar = A[0];  end            // SHR
            5'b10010: begin Result = sA <<< 1; CF_ar = A[15]; end            // SAL
            5'b10011: begin Result = sA >>> 1; CF_ar = A[0]; end             // SAR
            5'b10100: begin Result = {A[14:0], A[15]}; CF_ar = A[15]; end    // ROL
            5'b10101: begin Result = {A[0], A[15:1]}; CF_ar = A[0]; end      // ROR
            5'b10110: begin Result = {A[14:0], Cin}; CF_ar = A[15]; end      // RCL
            5'b10111: begin Result = {Cin, A[15:1]}; CF_ar = A[0]; end       // RCR

            default: begin Result = 16'h0000; Status = 6'b000000; end
        endcase

        /* Flags */
        Status[5] = CF_ar;                      // CF
        Status[4] = (Result == 16'h0000);       // ZF
        Status[3] = Result[15];                 // NF
        Status[2] = VF_reg;                     // VF
        Status[1] = ~^Result;                   // PF
        Status[0] = AF_reg;                     // AF

    end

endmodule