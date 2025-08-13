// Code your testbench here
// or browse Examples
class generator;
  //mailbox mbx;
  mailbox #(bit [8:0]) mbx;
  bit [3:0]a,b;
  bit [0:0]cin;
  integer i;
  task run();
    for(i=0;i<8;i++)begin
//       a[2]=i;
//       b[1]=i;
//       cin[0]=i;
             a   = i;
            b   = 7 - i;      
            cin = i[0];  
      mbx.put({a,b,cin});
      $display("generatted test cases a=%04b,b=%04b,Cin=%0b",a,b,cin);
    end
  endtask
endclass

class driver;
  //mailbox mbx;
  mailbox #(bit [8:0]) mbx;
  virtual inter vif;
  task run();
    bit [8:0]temp;
    bit [3:0]a,b;
    bit  [0:0]cin;
    repeat(8) begin
      mbx.get(temp);
//       a[2]=temp;
//       b[1]=temp;
//       cin[0]=temp;
      a   = temp[8:5];
            b   = temp[4:1];
            cin = temp[0];
      vif.a=a;
      vif.b=b;
      vif.cin=cin;
      #10;
      $display("driver applied test cases a=%04b,b=%04b,Cin=%0b,sum=%04b,cout=%0b",a,b,cin,vif.sum,vif.cout);
    end
  endtask
endclass
module tb;
  inter aif();
  parallel dut(.a(aif.a),.b(aif.b),.cin(aif.cin),.sum(aif.sum),.cout(aif.cout));
  generator gen;
  driver div;
 // mailbox mbx;
  mailbox #(bit [8:0]) mbx;
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
  

      
