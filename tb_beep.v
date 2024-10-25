`timescale 1ns/1ps
module tb_beep;
    reg rst     ;
    reg clk     ;
    wire beep   ;
     defparam beep1.time_500ms = 25_000;
    beep beep1(
    . rst (rst )    ,
    . clk (clk )    ,
    . beep(beep)
);
    initial begin
        clk = 1'b0;
        rst = 1'b0;
        #201;
        rst = 1'b1;
        #200_000;
        $stop;
    end
    always  #10 clk = ~clk;
endmodule