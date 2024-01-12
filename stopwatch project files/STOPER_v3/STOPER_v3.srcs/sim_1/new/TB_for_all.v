`timescale 1ps / 1ps


module TB_forall();

 // wejscia
  reg clk;
  reg button;
  reg clear;

 // wyjscia
  wire [6:0] sseg_out_1;
  wire [6:0] sseg_out_2;
  wire [6:0] sseg_out_3;
  wire [6:0] sseg_out_4;

 // UUT
    connections_testbench uut(
        .clk(clk),
        .button(button),
        .clear(clear),
        .s_1(sseg_out_1),
        .s_2(sseg_out_2),
        .s_3(sseg_out_3),
        .s_4(sseg_out_4)
        
);

 // initial dla jednorazowego stanow poczatkowych inputow

initial
    begin
        clk =0;
        button = 0;
        clear = 1;
    end


 // initial dla clocka systemowego 100 MHz

initial clk = 1'b0;
always #1 clk = ~clk;


 // initial dla inputow

initial 
    begin
        #1 clear = 0;
        #200000 button = 1;
        
end

endmodule