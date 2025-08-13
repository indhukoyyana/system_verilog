// Code your design here
module hs(a,b,diff,barrow);
  input a,b;
  output diff,barrow;
  assign diff=a^b;
  assign barrow=~a&b;
endmodule

interface inter;
  logic a;
  logic b;
  logic diff;
  logic barrow;
endinterface
