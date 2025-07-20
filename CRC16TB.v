
`timescale 1ns / 1ps

module tb_crc16parallel;

    reg clk;
    reg rst_n;
    reg enable;
    reg [7:0] data_in;
    reg clear;
    wire [15:0] crc_out;

    // Instantiate your CRC module
    crc16 uut (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .data_in(data_in),
        .clear(clear),
        .crc_out(crc_out)
    );

    // Clock generation (100MHz)
    always #5 clk = ~clk;

    // Test vector: "12345678" as bytes
  reg [7:0] message_mem [0:8];
    integer i;

    initial begin
        // Initialize
      $dumpfile("crc.vcd");
      $dumpvars(0,tb_crc16parallel);
        clk = 0;
        rst_n = 0;
        enable = 0;
        data_in = 8'd0;
        clear = 0;

        // Message: ASCII "12345678"
        message_mem[0] = 8'h31; // '1'
        message_mem[1] = 8'h32; // '2'
        message_mem[2] = 8'h33; // '3'
        message_mem[3] = 8'h34; // '4'
        message_mem[4] = 8'h35; // '5'
        message_mem[5] = 8'h36; // '6'
        message_mem[6] = 8'h37; // '7'
        message_mem[7] = 8'h38; // '8'
      	message_mem[8] = 8'h39; // '9'

        // De-assert reset, clear CRC register
        #10 rst_n = 1;
        #10 clear = 1;
        #10 clear = 0;

        // Feed input bytes and check CRC after each
      for (i = 0; i < 9; i = i + 1) begin
            data_in = message_mem[i];
            enable = 1;
            #10; // Wait for clock edge

            // Turn off enable after data_in is accepted
            enable = 0;
            #5; // Small gap for readable output

            // Print current CRC value after each byte
            $display("After byte %0d ('%c' = 0x%02X): CRC = 0x%04X", 
                i+1, message_mem[i], message_mem[i], crc_out);
        end

        // Final CRC output after all data
        $display("Final CRC after all bytes: 0x%04X", crc_out);

        #20 $finish;
    end

endmodule

//OUTPUT FOR THE ABOVE TESTBENCH
/*
After byte 1 ('1' = 0x31): CRC = 0xc782
After byte 2 ('2' = 0x32): CRC = 0x3dba
After byte 3 ('3' = 0x33): CRC = 0x5bce
After byte 4 ('4' = 0x34): CRC = 0x5349
After byte 5 ('5' = 0x35): CRC = 0x4560
After byte 6 ('6' = 0x36): CRC = 0x2ef4
After byte 7 ('7' = 0x37): CRC = 0x7718
After byte 8 ('8' = 0x38): CRC = 0xa12b
After byte 9 ('9' = 0x39): CRC = 0x29b1
Final CRC after all bytes: 0x29b1
*/