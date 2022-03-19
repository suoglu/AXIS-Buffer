`timescale 1 ns / 1 ps
/* ------------------------------------------------ *
 * Title       : AXIS Buffer                        *
 * Project     : AXIS Buffer                        *
 * ------------------------------------------------ *
 * File        : AXIS_Buffer_v1_0.v                 *
 * Author      : Yigit Suoglu                       *
 * Last Edit   : 19/03/2022                         *
 * ------------------------------------------------ *
 * Description : AXIS buffer to keep data until     *
 *               next stage accepts it. Does not    *
 *               add latency.                       *
 * -------------------------------------------------*/

  module AXIS_Buffer_v1_0 #(
    //Interface enables 
    parameter BUFFERING_O_EN = 0,
    parameter TLAST_EN = 0,
    parameter TSTRB_EN = 0,
    parameter DROP_COUNTER_EN = 0,
    parameter DROP_COUNTER_WIDTH = 32,
    parameter SLAVE_ALWAYS_READY = 0,

    //Axi widths
    parameter C_S00_AXIS_TDATA_WIDTH = 32,
    parameter C_M00_AXIS_TDATA_WIDTH = 32
  )(
    input  axis_aclk,
    input  axis_aresetn,

    output buffering,
    output [DROP_COUNTER_WIDTH-1:0] dropped,
    input dropped_reset,
    
    // Ports of Axi Slave Bus Interface S00_AXIS
    input  s00_axis_tvalid,
    output s00_axis_tready,
    input  s00_axis_tlast,
    input [C_S00_AXIS_TDATA_WIDTH-1:0] s00_axis_tdata,
    input [(C_S00_AXIS_TDATA_WIDTH/8)-1:0] s00_axis_tstrb,

    // Ports of Axi Master Bus Interface M00_AXIS
    output m00_axis_tvalid,
    input  m00_axis_tready,
    output m00_axis_tlast,
    output [C_M00_AXIS_TDATA_WIDTH-1:0] m00_axis_tdata,
    output [(C_M00_AXIS_TDATA_WIDTH/8)-1:0] m00_axis_tstrb
  );
    localparam PASS = 1'b0,
             BUFFER = 1'b1;
    reg state;

    wire pass = (state == PASS);

    assign s00_axis_tready  = (SLAVE_ALWAYS_READY) ? 1'b1 : pass;
    assign m00_axis_tvalid  = ~pass|s00_axis_tvalid;

    //State transactions
    always@(posedge axis_aclk) begin
      if(~axis_aresetn) begin
        state <= PASS;
      end else case(state)
          PASS: state <= (~m00_axis_tready & s00_axis_tvalid) ? BUFFER : PASS;
        BUFFER: state <= (~m00_axis_tready)                   ? BUFFER : PASS;
      endcase
    end

    //Buffering flag output
    generate
      if(BUFFERING_O_EN) begin
        assign buffering = ~pass;
      end
    endgenerate

    //Dropped Counter
    generate
      if(DROP_COUNTER_EN) begin
        reg [DROP_COUNTER_WIDTH-1:0] dropped_counter;

        always@(posedge axis_aclk or posedge dropped_reset)
          if(dropped_reset) begin
            dropped_counter <= 0;
          end else begin
            dropped_counter <= dropped_counter + {{DROP_COUNTER_WIDTH-1{1'b0}},(~pass & s00_axis_tvalid)};
          end

        assign dropped = dropped_counter;
      end
    endgenerate

    //Buffer for tlast signal
    generate
      if(TLAST_EN) begin
        reg tlast_reg;

        always@(posedge axis_aclk) begin
          if(~axis_aresetn) begin
            tlast_reg <= 0;
          end else begin
            tlast_reg <= (pass) ? s00_axis_tlast : tlast_reg;
          end
        end

        assign m00_axis_tlast = (pass) ? s00_axis_tlast : tlast_reg;
      end
    endgenerate

    //Buffer for strobe signal
    generate
      if(TSTRB_EN) begin
        reg [(C_S00_AXIS_TDATA_WIDTH/8)-1:0] tstrb_reg;

        always@(posedge axis_aclk) begin
          if(~axis_aresetn) begin
            tstrb_reg <= 0;
          end else begin
            tstrb_reg <= (pass) ? s00_axis_tstrb : tstrb_reg;
          end
        end

        assign m00_axis_tstrb = (pass) ? s00_axis_tstrb : tstrb_reg;
      end
    endgenerate

    //Buffer for Data
    reg [C_S00_AXIS_TDATA_WIDTH-1:0] data_reg;

    always@(posedge axis_aclk) begin
      if(~axis_aresetn) begin
        data_reg <= 0;
      end else begin
        data_reg <= (pass) ? s00_axis_tdata : data_reg;
      end
    end

    assign m00_axis_tdata = (pass) ? s00_axis_tdata : data_reg;
  endmodule
