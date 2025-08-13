// Code your testbench here
// or browse Examples
class generator;
  mailbox mbx;
  bit a,b,c;
  integer i;
  task run();
    for(i=0;i<8;i=i++)begin
      a=i[2];
      b=i[1];
      c=i[0];
      mbx.put({a,b,c});
      $display("generated test cases a=%0d,b=%0d,c=%0d",a,b,c);
     end
   endtask
endclass

               
class driver;
  mailbox mbx;
  virtual inter vif;
  task run();
     bit a,b,c;
    bit [2:0]temp;
    repeat(8) begin
      mbx.get(temp);
       a=temp[2];
      b=temp[1];
      c=temp[0];
    vif.a=a;
    vif.b=b;
    vif.c=c;
      #10;
      $display("applied test cases a=%0d,b=%0d,c=%0d,diff=%0d,barrow=%0d",a,b,c,vif.diff,vif.barrow);
    end
  endtask
endclass
               
module tb;
  inter aif();
  fs dut(.a(aif.a),.b(aif.b),.c(aif.c),.diff(aif.diff),.barrow(aif.barrow));
  mailbox mbx;
  generator gen;
  driver div;
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
      
  
      
              
       
