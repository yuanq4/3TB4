module part1_clock(
    input Clock,
    input Reset_n,
    output reg clk_ms
);

    parameter factor=(10-1);
    reg [31:0] countQ;

    always @(posedge Clock, negedge Reset_n)
    begin
      if(!Reset_n) 
        begin
            countQ <= 32'd0;
            clk_ms <= 1'b0;
        end
    else 
        begin
            if(countQ<factor/2)
                begin
                    countQ<=countQ+1;
						  clk_ms<=1'b0;
                end
            else if (countQ<factor)
                begin
                    countQ<=countQ+1;
						  clk_ms<=1'b1;
                end
            else //countQ==factor
                begin
                    countQ<=0;
                    clk_ms<=0;
                end
        end
    end
endmodule