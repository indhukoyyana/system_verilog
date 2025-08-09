// Code your testbench here
// or browse Examples
class generator;
  logic a,b;
  integer i;
  mailbox mbx;
    task run();
      for(i=0;i<4;i=i++)begin
        {a,b}=i;
	     #5;
         mbx.put({a,b});
         $display("generated test cases a=%0b,b=%0b",a,b);
        #10;
      end
    endtask
    endclass
class driver;
  mailbox mbx;
  virtual inter vif;
  integer i;
  task run();
    for(i=0;i<4;i=i++)begin
    logic [1:0]temp;
      logic a,b;
      mbx.get(temp);
      {a,b}=temp[1:0];
      vif.a=a;
      vif.b=b;
      #10;
      $display("driver applied data a=%0b,b=%0b, sum=%0b,carry=%0b",a,b,vif.sum,vif.carry);
    end
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
