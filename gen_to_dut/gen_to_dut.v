// Code your design here
module add(a,b,c);
  input [2:0]a,b;
  output [3:0]c;
  assign c=a+b;
endmodule

//interface
interface inter;
  logic [2:0]a;
  logic [2:0]b;
  logic [3:0]c;
endinterface
