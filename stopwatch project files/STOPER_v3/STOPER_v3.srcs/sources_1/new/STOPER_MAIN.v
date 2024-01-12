// POLOCZENIA

module connections_testbench(
 // wejscia  
  input clk,
  input button,
  input clear,
    
 // wyjscia    
  output [6:0] s_1,
  output [6:0] s_2,
  output [6:0] s_3,
  output [6:0] s_4
    
);

 // debouncer
 // wire OUTPUT;
  
 // demux
  wire dem_1;
  wire dem_2;
  
 // preskaler
  wire pre_out;
  
 // licznik 2-bit wyjscie
 // wire bit_out;
  
 // licznik 1 z góry na enable 2-ego
  wire a;
  
 // licznik 2 z góry na enable 3-ego
  wire b;
  
 // licznik 3 z góry na enable 4-ego
  wire c;
  
 // licznik 4 z góry na enable 5-ego
  wire d;
  
 // licznik 5 z góry na enable 6-ego
  wire e;  
  
 // wyjscia licznikow / wejscia na 7 segm
  wire [3:0] count_1;
  wire [3:0] count_2;
  wire [3:0] count_3;
  wire [3:0] count_4;


 // -----------------------------------------------
 // Pojedyncze moduly
 
 preskaler preskaler_main(  // preskaler
    .clk_in(clk),
    .clk_out(pre_out),
    .clear(clear)
 
 );

 //debounc debouncer(  // debouncer
 //   .clk(clk), 
 //   .enable(pre_out), 
 //   .button(button),   
 //   .out(OUTPUT)
 //
 //);

demux demultiplexer( // demultiplekser
    
    .dmux_in(1),
    .sel(button),
    .dmux_out_0(dem_1),
    .dmux_out_1(dem_2)
    
 );

 //counter_2bit counter_2bits(  // licznik 2 bitowy na DEMUX

//.clk(clk),
//.in(button),
//.enable(pre_out),
//.MAX(3),
//.clear(clear),
//.out(bit_out)

//);

// ------------- SEKCJA LICZNIKOW G?OWYCH ------------------

 counter counter0(  // licznik dziesiatek mili sekund     DO 9
  
  .clk(clk),
  .enable(pre_out & dem_2),
  .reset(dem_1),
  .MAX(9),
  .clear(clear),
  .out(),
  .dalej(a)

);

 counter counter1(  // licznik jednosci mili sekund       DO 9
  
  .clk(clk),
  .enable(a),
  .reset(dem_1),
  .MAX(9),
  .clear(clear),
  .out(),
  .dalej(b)

);

 counter counter2(  // licznik dziesiatek sekund          DO 9
  
  .clk(clk),
  .enable(b),
  .reset(dem_1),
  .MAX(9),
  .clear(clear),
  .out(count_1),
  .dalej(c)

);

 counter counter3(  // licznik jednosci sekund            DO 5
  
  .clk(clk),
  .enable(c),
  .reset(dem_1),
  .MAX(5),
  .clear(clear),
  .out(count_2),
  .dalej(d)

);

 counter counter4(  // licznik dziesiatek minut           DO 9
  
  .clk(clk),
  .enable(d),
  .reset(dem_1),
  .MAX(9),
  .clear(clear),
  .out(count_3),
  .dalej(e)

);

 counter counter5(  // licznik jednostek minut            DO 9
  
  .clk(clk),
  .enable(e),
  .reset(dem_1),
  .MAX(9),
  .clear(clear),
  .out(count_4),
  .dalej()

);

// ------------------------- 7-segment ---------------------------

sseg sseg_1(
    
  .sseg_in(count_1),
  .sseg_out(s_1)
     
);

sseg sseg_2(
    
  .sseg_in(count_2),
  .sseg_out(s_2)
     
);

sseg sseg_3(
    
  .sseg_in(count_3),
  .sseg_out(s_3)
     
);

sseg sseg_4(
    
  .sseg_in(count_4),
  .sseg_out(s_4)
     
);

endmodule
