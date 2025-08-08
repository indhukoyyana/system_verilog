// from generator to dut 
class generator;
  int a=5;
  int b=4;
  mailbox mbx;
  task run();
    mbx.put({a[2:0],b[2:0]});//concatintion of 2 test cases
    $display("Generator test cases a=%0d, b=%0d", a,b);
  endtask
endclass

class driver;
  mailbox mbx;
  virtual inter vif;//virtual interface
  task run();
    bit [5:0]temp;//temporary variable to store the received data from generator  
    bit [2:0]a,b;
    mbx.get(temp);
    a=temp[5:3];
    b=temp[2:0];
    vif.a=a;//assign the test vectors
    vif.b=b;
    #10;
    $display("Driver applied Data  a=%0d ,b=%0d dut output=%0d",a,b,vif.c);
  endtask
endclass

module tb;
  inter aif();
  add dut(.a(aif.a),.b(aif.b),.c(aif.c));
  generator gen;
  driver div;
  mailbox mbx;
  initial begin
    gen=new();
    div=new();
    mbx=new();
    gen.mbx =mbx;
    div.mbx=mbx;
    div.vif=aif;
    fork
    gen.run();
    div.run();
    join
  end
endmodule
