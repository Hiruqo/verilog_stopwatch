
// LICZNIKI

module counter(
  
   // wejscia
  input clk,
  input enable,
  input reset,
  input clear,
  
  input [3:0] MAX,
  
 // wyjscia
  output reg [3:0] out,
  output reg dalej = 0

);

always @(posedge clk, posedge clear)
    begin
     if (clear) out = 0;         // reset przed startem programu
     else begin          
      if (reset == 1) out = 0;   // warunek na reset
       if (enable == 1) begin    // warunek na enable
        if (out != MAX) begin    // rozpoczecie zliczania
            out = out + 1;
        end
        else begin              
            out = 0;                 // po dojsciu do MAX wartosci, zeruje licznik
            dalej = 1;               // flaga wskazujaca bit przeniesienia
        end
    end 
        else begin 
            dalej = 0;
        end
 
    end
end
    
endmodule

//--------------------------------------------
// Licznik 2-bit  ( NIE TRZEBA CHYBA ) 

//module counter_2bit(

//    // wejscia
//  input clk,
//  input in,
//  input enable,
//  input clear,
  
//  input [1:0] MAX,
  
// // wyjscia
//  output reg [1:0] out

//);

//always @(posedge clk, posedge clear)
//    begin
//      if (clear) out = 0;         // reset przed startem programu
//     else begin
//       if (enable & in) begin  // warunek na enable
//        if (out != MAX) begin  // rozpoczecie zliczania
//            out = out + 1;
//        end
//        else begin             // po dojsciu do MAX wartosci, zeruje licznik
//        out = 0;
//        end
//    end
//end
//end
    
//endmodule

//--------------------------------------------
// PRESKALER  -  na bazie prostego licznika  100 MHz ~~ 1 Hz  ( raz na 100 MHz - 1 tick )

module preskaler(

 // wejscia
  input clk_in,
  input clear,
  
 // wyjscia  
  output clk_out
    
 );

reg [31:0] counter_state;    // 27 bit aby zrobic dzielnik 100 MHz

always @(posedge clk_in, posedge clear)
      if (clear) counter_state = 1;         // reset przed startem programu
        else 
            begin
                if(counter_state != 1)
                    counter_state <= counter_state + 1; 
            
            else
                counter_state = 0;
      
            end
      
      assign clk_out = (counter_state == 1);

endmodule

//--------------------------------------------
// DEMUX

module demux(
    
    dmux_in,
    sel,
    dmux_out_0,
    dmux_out_1
    
 );
  
 // wejscia  
  input dmux_in;
  input sel;
  
 // wyjscia
  output dmux_out_0;
  output dmux_out_1;
  
 // zmienne
  reg dmux_out_0;
  reg dmux_out_1;
  
always @(dmux_in or sel)
begin
    case (sel)
        2'b0 : begin
            dmux_out_0 = dmux_in;
            dmux_out_1 = 0;
           
end
        2'b1 : begin
            dmux_out_0 = 0;
            dmux_out_1 = dmux_in;
            
end
endcase
end

endmodule

//--------------------------------------------
// DEBOUNCER  ( NIE ZAIMPLEMENTOWANY BO NIE DZIALA )

//module debounc(
//
   // wejscia
//    input clk, 
//    input enable, 
//    input button,
       
   // wyjscia
//    output out

//);

//    parameter l_bit = 4;

//    reg [l_bit-1:0] P_OUT;

//   always @(posedge clk)
//    begin
//            if (enable)
//                P_OUT <= {P_OUT[l_bit-2:0],button};
//    end

//    assign out = enable & (&P_OUT[l_bit-2:0]) & ~P_OUT[l_bit-1];
  
// endmodule


//--------------------------------------------
// 7-seg

module sseg( sseg_in, sseg_out );
    
 // wejscia
  input [3:0] sseg_in;
  output [6:0] sseg_out;

reg [6:0] sseg_out;

always @(sseg_in)
      case (sseg_in)
      
          4'b0001 : sseg_out = 7'b0000110;   // 1
          4'b0010 : sseg_out = 7'b1011011;   // 2
          4'b0011 : sseg_out = 7'b1001111;   // 3
          4'b0100 : sseg_out = 7'b1100110;   // 4
          4'b0101 : sseg_out = 7'b1101101;   // 5
          4'b0110 : sseg_out = 7'b1111101;   // 6
          4'b0111 : sseg_out = 7'b0000111;   // 7
          4'b1000 : sseg_out = 7'b1111111;   // 8
          4'b1001 : sseg_out = 7'b1101111;   // 9
          4'b1010 : sseg_out = 7'b1110111;   // A
          4'b1011 : sseg_out = 7'b1111100;   // b
          4'b1100 : sseg_out = 7'b0111001;   // C
          4'b1101 : sseg_out = 7'b1011110;   // d
          4'b1110 : sseg_out = 7'b1111001;   // E
          4'b1111 : sseg_out = 7'b1110001;   // F
          default : sseg_out = 7'b1000000;   // 0
          
      endcase
      
endmodule