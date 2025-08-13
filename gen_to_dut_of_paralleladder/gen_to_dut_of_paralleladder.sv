/ Code your design here
module fa(a,b,cin,sum,cout);
  input a,b,cin;
  output sum,cout;
  assign sum=a^b^cin;
  assign cout=((a&b)|(b&cin)|(cin&a));
endmodule

module parallel(a,b,cin,sum,cout);
  input [3:0]a;
  input [3:0]b;
  output [3:0]sum;
  input cin;
  output cout;
  wire c1,c2,c3;
  fa f1(a[0],b[0],cin,sum[0],c1);
  fa f2(a[1],b[1],c1,sum[1],c2);
  fa f3(a[2],b[2],c2,sum[2],c3);
  fa f4(a[3],b[3],c3,sum[3],cout);
endmodule
  
interface inter;
  logic [3:0]a,b;
  logic cin;
  logic [3:0]sum;
  logic cout;
endinterface
    
