//fork join none
module tb;
  int task1,task2,task3;
  task task_1();
    $display("task1 started at =%0t",$time);
    #10;
    $display("task1 completed at =%0t",$time);
  endtask
  task task_2();
    $display("task2 started at =%0t",$time);
    #20;
    $display("task2 completed at =%0t",$time);
  endtask
  task task_3();
    $display("task3 started at =%0t",$time);
    #30;
    $display("task3 completed at =%0t",$time);
  endtask
  initial begin 
    fork
      task_1();
       task_2();
    join_none
    task_3();
  end
endmodule
