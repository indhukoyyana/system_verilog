// Code your design here
module fa(a,b,c,sum,carry);
  input a,b,c;
  output sum,carry;
  assign sum=a^b^c;
  assign carry=((a&b)|(b&c)|(c&a));
endmodule

interface inter;
  logic a;
  logic b;
  logic c;
  logic sum;
  logic carry;
endinterface
