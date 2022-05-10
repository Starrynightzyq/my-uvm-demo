// +FHDR----------------------------------------------------------------------------
// Project Name  : IC_Design
// Device        : ASIC
// Author        : zhouyuqian
// Email         : starrynightzyq@gmail.com
// Website       : https://zhouyuqian.com
// Create On     : 2022/05/07 14:23
// Last Modified : 2022/05/07 14:23
// File Name     : top_tb.sv
// Description   :
//         
// 
// Copyright (c) 2022 .
// ALL RIGHTS RESERVED
// 
// ---------------------------------------------------------------------------------
// Modification History:
// Date         By              Version                 Change Description
// ---------------------------------------------------------------------------------
// 2022/05/07   zhouyuqian      1.0                     Original
// 
// -FHDR----------------------------------------------------------------------------
`timescale 1ns/1ns
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "base_test.sv"

module top_tb;

    parameter PERIOD = 10;

    reg         clk;
    reg         rst_n;

    my_if       input_if(clk, rst_n);
    my_if       output_if(clk, rst_n);

    dut u_dut(/*autoinst*/
        .clk                    (clk                            ), //input
        .rst_n                  (rst_n                          ), //input
        .rxd                    (input_if.data                  ), //input
        .rx_dv                  (input_if.valid                 ), //input
        .txd                    (output_if.data                 ), //output
        .tx_en                  (output_if.valid                )  //output
    );

    initial begin
        run_test("base_test");
    end

    initial begin
        uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.i_agt.drv", "vif", input_if);
        uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.i_agt.mon", "vif", input_if);
        uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.o_agt.mon", "vif", output_if);
    end

    initial begin
        clk = 0;
        forever begin
            #(PERIOD/2) clk = ~clk;
        end
    end

    initial begin
        rst_n = 1'b0;
        #(PERIOD*5);
        rst_n = 1'b1;
    end

    // dump fsdb
    initial begin
        if($test$plusargs("DUMP_FSDB")) begin
            $fsdbDumpfile("top.fsdb");
            $fsdbDumpvars();
            $fsdbDumpSVA();
            $fsdbDumpMDA();
        end
    end

endmodule

