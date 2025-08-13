// half adder tb using sv components
class generator;
   logic  a=1,b=1;
 mailbox mbx;
  task run();
    mbx.put({a,b});
    $display("generated test cases a=%0b,b=%0b",a,b);
  endtask
endclass

class driver;
 mailbox mbx;
  virtual inter vif;
  task run();
    logic [1:0]temp;
    logic a,b;
    mbx.get(temp);
    a=temp[1];
    b=temp[0];
    vif.a=a;
    vif.b=b;
    #10;
    $display("driver receied data a=%0d,b=%0b,sum=%0d,carry=%0d",a,b,vif.sum,vif.carry);
  endtask
endclass

module tb;
  inter aif();
  hf dut(.a(aif.a),.b(aif.b),.sum(aif.sum),.carry(aif.carry));
  generator gen;
  driver div;
 mailbox mbx;
  initial begin
    gen=new();
    div=new();
    mbx=new();
    gen.mbx=mbx;
    div.mbx=mbx;
    div.vif=aif;
    fork
      gen.run();
      div.run();
    join
  end
endmodule
