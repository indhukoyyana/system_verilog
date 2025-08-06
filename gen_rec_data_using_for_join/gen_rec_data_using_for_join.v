//generation and reception of data using fork join 
module tb;
  int data1,data2;
  event done;
  //generator
  task generator();
    for(int i=0;i<8;i++)begin
      data1=$random();
      $display("generated data=%0d",data1);
      #1;
      #9;
    end
  ->done;//event trigger
  endtask
  
  //driver
  task driver();
    forever begin
    #10;
    data2=data1;
    $display("received data=%0d",data2);
    end
  endtask
  //simulation hold
  task wait_event();
    wait(done.triggered);//@(done);
    $finish;
  endtask
  initial begin
    fork
    generator();
    driver();
     wait_event();
    join
  end
endmodule
