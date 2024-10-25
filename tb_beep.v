`timescale 1ns/1ps
module tb_beep;
    reg  rst     ;
    reg  clk     ;
    wire beep   ;
    defparam beep1.time_500ms = 25_000;
    defparam beep1.Do_freq = 191;
    defparam beep1.Ri_freq = 170;
    defparam beep1.Mi_freq = 152;
    defparam beep1.Fa_freq = 143;
    defparam beep1.So_freq = 128;
    defparam beep1.La_freq = 114;
    defparam beep1.Xi_freq = 100;   
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
        #40_000_000;
        $stop; 
    end
    always #10 clk = ~clk;
endmodule