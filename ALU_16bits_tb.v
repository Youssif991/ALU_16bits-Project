/* 
 * 16-bit ALU Testbench
 * Author: Youssef Mohammed Ibrahim
 * Date: 26/11/2025
 */
`timescale 1ns/1ps

module ALU_tb;

    /* Inputs */
    reg [15:0] A, B;
    reg [4:0]  F;
    reg        Cin;

    /* Outputs */
    wire [15:0] Result;
    wire [5:0]  Status;

    /* Operation codes */
    localparam NOP1      = 5'b00000;
    localparam INC       = 5'b00001;
    localparam NOP2      = 5'b00010;
    localparam DEC       = 5'b00011;
    localparam ADD       = 5'b00100;
    localparam ADD_CARRY = 5'b00101;
    localparam SUB       = 5'b00110;
    localparam SUB_BORROW= 5'b00111;
    localparam AND       = 5'b01000;
    localparam OR        = 5'b01001;
    localparam XOR       = 5'b01010;
    localparam NOT       = 5'b01011;
    localparam SHL       = 5'b10000;
    localparam SHR       = 5'b10001;
    localparam SAL       = 5'b10010;
    localparam SAR       = 5'b10011;
    localparam ROL       = 5'b10100;
    localparam ROR       = 5'b10101;
    localparam RCL       = 5'b10110;
    localparam RCR       = 5'b10111;

    ALU UUT (
        .A(A),
        .B(B),
        .F(F),
        .Cin(Cin),
        .Result(Result),
        .Status(Status)
    );

    initial begin
        /* ------------------- NO OPERATIONS ------------------- */
        // NOP1 Tests
        A = 16'h0000; B = 16'h0000; F = NOP1; Cin = 1'b0; #10;
        A = 16'hFFFF; B = 16'hFFFF; F = NOP1; Cin = 1'b1; #10;
        A = 16'h1234; B = 16'h5678; F = NOP1; Cin = 1'b0; #10;
        A = 16'h8000; B = 16'h7FFF; F = NOP1; Cin = 1'b1; #10;

        // NOP2 Tests
        A = 16'h0000; B = 16'h0000; F = NOP2; Cin = 1'b0; #10;
        A = 16'hFFFF; B = 16'hFFFF; F = NOP2; Cin = 1'b1; #10;
        A = 16'h1234; B = 16'h5678; F = NOP2; Cin = 1'b0; #10;
        A = 16'h8000; B = 16'h7FFF; F = NOP2; Cin = 1'b1; #10;

        /* ------------------- ARITHMETIC OPERATIONS ------------------- */
        // INC Tests
        A = 16'h0000; B = 16'h0000; F = INC; Cin = 1'b0; #10;
        A = 16'h0001; B = 16'h0000; F = INC; Cin = 1'b0; #10;
        A = 16'hFFFF; B = 16'h0000; F = INC; Cin = 1'b0; #10;

        // DEC Tests
        A = 16'h0001; B = 16'h0000; F = DEC; Cin = 1'b0; #10;
        A = 16'h0002; B = 16'h0000; F = DEC; Cin = 1'b0; #10;
        A = 16'h0000; B = 16'h0000; F = DEC; Cin = 1'b0; #10;

        // ADD Tests
        A = 16'h0000; B = 16'h0000; F = ADD; Cin = 1'b0; #10;
        A = 16'h1234; B = 16'h5678; F = ADD; Cin = 1'b0; #10;
        A = 16'hFFFF; B = 16'h0001; F = ADD; Cin = 1'b0; #10;

        // ADD_CARRY Tests
        A = 16'h0003; B = 16'h0002; F = ADD_CARRY; Cin = 1'b1; #10;
        A = 16'h0003; B = 16'h0002; F = ADD_CARRY; Cin = 1'b0; #10;
        A = 16'hFFFF; B = 16'h0000; F = ADD_CARRY; Cin = 1'b1; #10;

        // SUB Tests
        A = 16'h0005; B = 16'h0003; F = SUB; Cin = 1'b0; #10;
        A = 16'h0000; B = 16'h0001; F = SUB; Cin = 1'b0; #10;
        A = 16'h8000; B = 16'h0001; F = SUB; Cin = 1'b0; #10;

        // SUB_BORROW Tests
        A = 16'h0005; B = 16'h0003; F = SUB_BORROW; Cin = 1'b1; #10;
        A = 16'h0005; B = 16'h0003; F = SUB_BORROW; Cin = 1'b0; #10;
        A = 16'h0000; B = 16'h0000; F = SUB_BORROW; Cin = 1'b1; #10;

        /* ------------------- LOGIC OPERATIONS ------------------- */
        // AND Tests
        A = 16'hAAAA; B = 16'h5555; F = AND; Cin = 1'b0; #10;
        A = 16'hFFFF; B = 16'h1234; F = AND; Cin = 1'b0; #10;
        A = 16'h00FF; B = 16'h0F0F; F = AND; Cin = 1'b0; #10;

        // OR Tests
        A = 16'hAAAA; B = 16'h5555; F = OR; Cin = 1'b0; #10;
        A = 16'h00FF; B = 16'h0F00; F = OR; Cin = 1'b0; #10;
        A = 16'h1234; B = 16'h0000; F = OR; Cin = 1'b0; #10;

        // XOR Tests
        A = 16'hAAAA; B = 16'h5555; F = XOR; Cin = 1'b0; #10;
        A = 16'hFFFF; B = 16'hFFFF; F = XOR; Cin = 1'b0; #10;
        A = 16'h1234; B = 16'h00FF; F = XOR; Cin = 1'b0; #10;

        // NOT Tests
        A = 16'hAAAA; B = 16'h0000; F = NOT; Cin = 1'b0; #10;
        A = 16'hFFFF; B = 16'h0000; F = NOT; Cin = 1'b0; #10;
        A = 16'h1234; B = 16'h0000; F = NOT; Cin = 1'b0; #10;

        /* ------------------- SHIFT/ROTATE OPERATIONS ------------------- */
        // SHL Tests
        A = 16'h8001; B = 16'h0000; F = SHL; Cin = 1'b0; #10;
        A = 16'h4000; B = 16'h0000; F = SHL; Cin = 1'b0; #10;
        A = 16'h0001; B = 16'h0000; F = SHL; Cin = 1'b0; #10;

        // SHR Tests
        A = 16'h8001; B = 16'h0000; F = SHR; Cin = 1'b0; #10;
        A = 16'h0002; B = 16'h0000; F = SHR; Cin = 1'b0; #10;
        A = 16'h0001; B = 16'h0000; F = SHR; Cin = 1'b0; #10;

        // SAL Tests
        A = 16'h8001; B = 16'h0000; F = SAL; Cin = 1'b0; #10;
        A = 16'h4000; B = 16'h0000; F = SAL; Cin = 1'b0; #10;
        A = 16'h0001; B = 16'h0000; F = SAL; Cin = 1'b0; #10;

        // SAR Tests
        A = 16'h8001; B = 16'h0000; F = SAR; Cin = 1'b0; #10;
        A = 16'h4001; B = 16'h0000; F = SAR; Cin = 1'b0; #10;
        A = 16'h0001; B = 16'h0000; F = SAR; Cin = 1'b0; #10;

        // ROL Tests
        A = 16'h8001; B = 16'h0000; F = ROL; Cin = 1'b0; #10;
        A = 16'h4000; B = 16'h0000; F = ROL; Cin = 1'b0; #10;
        A = 16'h0001; B = 16'h0000; F = ROL; Cin = 1'b0; #10;

        // ROR Tests
        A = 16'h8001; B = 16'h0000; F = ROR; Cin = 1'b0; #10;
        A = 16'h0002; B = 16'h0000; F = ROR; Cin = 1'b0; #10;
        A = 16'h0001; B = 16'h0000; F = ROR; Cin = 1'b0; #10;

        // RCL Tests
        A = 16'h8001; B = 16'h0000; F = RCL; Cin = 1'b1; #10;
        A = 16'h8001; B = 16'h0000; F = RCL; Cin = 1'b0; #10;
        A = 16'h4000; B = 16'h0000; F = RCL; Cin = 1'b1; #10;

        // RCR Tests
        A = 16'h8001; B = 16'h0000; F = RCR; Cin = 1'b1; #10;
        A = 16'h8001; B = 16'h0000; F = RCR; Cin = 1'b0; #10;
        A = 16'h0001; B = 16'h0000; F = RCR; Cin = 1'b1; #10;

        $stop;
    end

endmodule
