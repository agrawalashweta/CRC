module crc16(
    input clk,
    input rst_n,
    input enable,
    input [7:0] data_in,
    input clear,
    output reg [15:0] crc_out
);
    reg [15:0] crc_reg;
    reg [15:0] crc_next;

    integer i;
    reg b;
    reg [15:0] crc_temp;

    always @(*) begin
        crc_temp = crc_reg;
        for (i = 0; i < 8; i = i + 1) begin
            b = ((crc_temp[15]) ^ (data_in[7 - i])); // MSB first
            crc_temp = crc_temp << 1;
          if (b)
                crc_temp = crc_temp ^ 16'h1021;
        end
        crc_next = crc_temp;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            crc_reg <= 16'hFFFF;
        else if (clear)
            crc_reg <= 16'hFFFF;
        else if (enable)
            crc_reg <= crc_next;
    end

    always @(*) begin
        crc_out = crc_reg;
    end

endmodule