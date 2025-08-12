class generator;
  mailbox mbx;

  task run();
    // Loop through all 4 combinations
    for (int i = 0; i < 8; i++) begin 
      bit a = i[2]; // MSB
      bit b = i[1]; 
      bit c = i[0];// LSB
      mbx.put({a,b,c});
      $display("Generator: a=%0d, b=%0d,c=%0d", a, b,c);
    end
  endtask
endclass

// ---------------- DRIVER CLASS ----------------
class driver;
  mailbox mbx;
  virtual inter vif;

  task run();
    bit [2:0] temp;
    bit a,b,c;

    // Get 4 test cases from generator
    repeat (8) begin
      mbx.get(temp);
      a = temp[2];
      b = temp[1];
      c = temp[0];

      vif.a = a;
      vif.b = b;
      vif.c = c;

      #1; // small delay for DUT to compute
      $display("Driver: a=%0d, b=%0d,c=%0d => Sum=%0d, Carry=%0d",
                a, b,c, vif.sum, vif.carry);
    end
  endtask
endclass

// ---------------- TESTBENCH ----------------
module tb;
  inter aif();
  fa dut (.a(aif.a), .b(aif.b), .c(aif.c),.sum(aif.sum), .carry(aif.carry));

  generator gen;
  driver div;
  mailbox mbx;

  initial begin
    gen = new();
    div = new();
    mbx = new();

    gen.mbx = mbx;
    div.mbx = mbx;
    div.vif = aif;

    fork
      gen.run();
      div.run();
    join
  end
endmodule
