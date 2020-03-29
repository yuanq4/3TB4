module clock_divider(
    input Clock,
    input Reset_n,
    output reg pulse_ms
);

    parameter factor=(12500-1);
    reg [31:0] countQ;

    always @(posedge Clock, negedge Reset_n)
    begin
      if(!Reset_n) 
        begin
            countQ <= 32'd0;
            pulse_ms <= 1'b0;
        end
    else 
        begin
            if(countQ<factor/2)
                begin
                    countQ<=countQ+1;
                end
            else if (countQ<factor)
                begin
                    countQ<=countQ+1;
                end
            else //countQ==factor
                begin
                    countQ<=0;
                    pulse_ms = ~pulse_ms;
                end
        end
    end
endmodule