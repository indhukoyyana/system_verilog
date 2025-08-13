// Code your design here
module fs(a,b,c,diff,barrow);
  input a,b,c;
  output diff,barrow;
  assign diff=a^b^c;
  assign barrow=((~a&b)|(b&c)|(c&~a));
endmodule

interface inter;
  logic a;
   logic b;
   logic c;
   logic diff;
   logic barrow;
  endinterface
  
