module display_converter(
    input wire clk,
    input wire reset,
    input wire [19:0] hex_number,
    output [3:0] bcd_digit_0, bcd_digit_1, bcd_digit_2, bcd_digit_3, bcd_digit_4, bcd_digit_5
);
    integer i, k;
    wire [19:0] hex_number1;
    reg [3:0] bcd_digit [5:0];
    assign hex_number1 = hex_number[19:0];

    assign bcd_digit_0 = bcd_digit[0];
    assign bcd_digit_1 = bcd_digit[1];
    assign bcd_digit_2 = bcd_digit[2];
    assign bcd_digit_3 = bcd_digit[3];
    assign bcd_digit_4 = bcd_digit[4];
    assign bcd_digit_5 = bcd_digit[5];

    always @ (*)
        begin
         /*   bcd_digit[0] = 4'd0;
            bcd_digit[1] = 4'd0;
            bcd_digit[2] = 4'd0;
            bcd_digit[3] = 4'd0;
            bcd_digit[4] = 4'd0;
            bcd_digit[5] = 4'd0;*/

            for(i = 13; i>0; i = i-1)
            begin
                //check all 6 BCD tetrads, if >=5 then add 3
                for (k = 5; k >= 0; k = k-1)
                begin
                    if (bcd_digit[k] >= 4'b0101)
                    begin
                        bcd_digit[k] = bcd_digit[k]+3;
                    end
                end//end of add 3
                //shift one bit of BIN/HEX left 
                //for the first 5 tetrads
                for (k = 5; k >= 1; k = k-1)
                begin
                    bcd_digit[k] = bcd_digit[k] << 1;
                    bcd_digit[k][0] = bcd_digit[k-1][3];
                end//end of shift for first 5 tetrads
                //shift one bit of BIN/HEX left, for the last tetrad
                bcd_digit[0] = bcd_digit[0] << 1;
                bcd_digit[0][0] = hex_number1[i];
            end//end of for loop
        end//end of always
endmodule