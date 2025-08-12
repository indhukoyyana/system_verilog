interface inter;
  logic clk;
  logic reset;
  logic d;
  logic q;
endinterface
module tb;
  inter haif();
  initial begin
    haif.clk=0;
    forever #5 haif.clk=~haif.clk;
  end
  dff DUT(.clk(haif.clk),.reset(haif.reset),.d(haif.d),.q(haif.q));
  initial begin
    haif.d=0; #10;
    haif.d=1; #10;
  end
  initial begin
    $monitor("clk=%0b,d=%0b,q=%0b",haif.clk,haif.d,haif.q);
    #20;
    $finish;
  end
endmodule
