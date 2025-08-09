// Code your design here
module hf(a,b,sum,carry);
  input a,b;
  output sum,carry;
  assign  sum=a^b;
  assign carry=a&b;
endmodule
interface inter;
  logic a;
  logic b;
  logic sum;
  logic carry;
endinterface
