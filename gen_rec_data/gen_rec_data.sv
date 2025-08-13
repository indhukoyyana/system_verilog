// Code your testbench here
// or browse Examples
module tb;
  int data1,data2;
  event done,done1;
  //generator
  initial begin
    for(int i=0;i<8;i++)begin
      data1=$random();
      $display("generated data=%0d",data1);
      #1;
      #9;
    end
  ->done;//event trigger
  end
  
  //driver
  initial begin
    forever begin
    #10;
    data2=data1;
    $display("received data=%0d",data2);
    end
  end
  //simulation hold
  initial begin
    wait(done.triggered);
    $finish;
  end
endmodule
    
