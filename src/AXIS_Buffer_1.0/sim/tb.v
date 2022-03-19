`timescale 1 ns / 1 ps
/* ------------------------------------------------ *
 * Title       : Testbench for AXIS Buffer          *
 * Project     : AXIS Buffer                        *
 * ------------------------------------------------ *
 * File        : tb.v                               *
 * Author      : Yigit Suoglu                       *
 * Last Edit   : 19/03/2022                         *
 * -------------------------------------------------*/

module tb();

  reg clk;

  always begin
    clk <= 0;
    forever #5 clk <= ~clk;
  end

  reg rstn = 0;
  wire buffering;
  wire [31:0] dropped;

  wire s00_axis_tready;
  wire m00_axis_tvalid;
  wire [31:0] m00_axis_tdata;

  reg s00_axis_tvalid = 0;
  reg [31:0] s00_axis_tdata = 32'he1100000;
  reg m00_axis_tready = 1;

  reg[30*8:0] state = "setup";

  AXIS_Buffer_v1_0 #(
    .BUFFERING_O_EN(1),
    .DROP_COUNTER_EN(1)
  )uut(
    .axis_aclk(clk),
    .axis_aresetn(rstn),
    .buffering(buffering),
    .dropped(dropped),
    .dropped_reset(~rstn),
    .s00_axis_tvalid(s00_axis_tvalid),
    .s00_axis_tready(s00_axis_tready),
    .s00_axis_tdata(s00_axis_tdata),
    .m00_axis_tvalid(m00_axis_tvalid),
    .m00_axis_tready(m00_axis_tready),
    .m00_axis_tdata(m00_axis_tdata)
  );

  initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0,tb);
  end

  integer i;

  initial begin
    repeat(2) @(posedge clk); #1;
    rstn = 1;
    repeat(2) @(posedge clk); #1;
    state = "Pass";
    repeat(2) @(posedge clk); #1;
    s00_axis_tvalid = 1;
    for (i=0; i<15; i=i+1) begin
      @(posedge clk); #1;
      s00_axis_tdata = s00_axis_tdata + 1;
    end
    s00_axis_tvalid = 0;
    repeat(2) @(posedge clk); #1;
    state = "Drop";
    m00_axis_tready = 0;
    repeat(2) @(posedge clk); #1;
    s00_axis_tvalid = 1;
    for (i=0; i<15; i=i+1) begin
      @(posedge clk); #1;
      s00_axis_tdata = s00_axis_tdata + 1;
    end
    s00_axis_tvalid = 0;
    repeat(2) @(posedge clk); #1;
    state = "Drop+Pass";
    m00_axis_tready = 1;
    repeat(2) @(posedge clk); #1;
    fork
      begin
        s00_axis_tvalid = 1;
        for (i=0; i<15; i=i+1) begin
          @(posedge clk); #1;
          s00_axis_tdata = s00_axis_tdata + 1;
        end
        s00_axis_tvalid = 0;
      end
      begin
        repeat(3) @(posedge clk); #1;
        m00_axis_tready = 0;
        repeat(2) @(posedge clk); #1;
        m00_axis_tready = 1;
        repeat(5) @(posedge clk); #1;
        m00_axis_tready = 0;
        @(posedge clk); #1;
        m00_axis_tready = 0;
      end
    join
    repeat(2) @(posedge clk); #1;
    state = "Finish";
    m00_axis_tready = 1;
    repeat(2) @(posedge clk); #1;
    $finish;
  end
endmodule
