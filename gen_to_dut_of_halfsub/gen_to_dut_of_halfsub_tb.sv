// Code your testbench here
// or browse Examples
class generator;
  mailbox mbx;
  logic a,b;
  integer i;
  task run();
    for(i=0;i<4;i=i++)begin
      a=i[1];
      b=i[0];
      mbx.put({a,b});
      $display("generated test cases a=%0b,b=%0b",a,b);
      //#10;
    end
  endtask
endclass

class driver;
  mailbox mbx;
  virtual inter vif;
  //integer i;
  task run();
  //for(i=0;i<4;i=i++)begin
  repeat(4)begin
    logic [1:0]temp;
    logic a,b;
    mbx.get(temp);
    //{a,b}=temp[1:0];
    a=temp[1];
    b=temp[0];
    vif.a=a;
    vif.b=b;
    #10;
    $display("driver applied data a=%0b,b=%0b,diff=%0b,barrrow=%0b",a,b,vif.diff,vif.barrow);
  end
  endtask
endclass

module tb;
  inter aif();
  hs dut(.a(aif.a),.b(aif.b),.diff(aif.diff),.barrow(aif.barrow));
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
      
    
    
    
    
