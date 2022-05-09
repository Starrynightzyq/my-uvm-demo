// +FHDR----------------------------------------------------------------------------
// Project Name  : IC_Design
// Device        : ASIC
// Author        : zhouyuqian
// Email         : starrynightzyq@gmail.com
// Website       : https://zhouyuqian.com
// Create On     : 2022/05/07 13:53
// Last Modified : 2022/05/07 13:53
// File Name     : my_driver.sv
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

`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV

`include "my_transcation.sv"

class my_driver extends uvm_driver;
    `uvm_component_utils(my_driver);
    virtual my_if vif;

    function new(string name = "my_driver", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("my_driver", "new is called", UVM_LOW);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("my_driver", "build_phase is called", UVM_LOW);
        if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
            `uvm_fatal("my_driver", "virtual interface must be set for vif!!!")
    endfunction

    extern virtual task main_phase(uvm_phase phase);
    extern virtual task drive_one_pkt(my_transcation tr);
endclass

task my_driver::main_phase(uvm_phase phase);
    my_transcation tr;

    phase.raise_objection(this);
    `uvm_info("my_driver", "main_phase is called", UVM_LOW);

    vif.data        <=8'h0;
    vif.valid       <= 1'h0;
    while(!vif.rst_n)
        @(posedge vif.clk);
    for(int i = 0; i < 2; i++) begin
        tr = new("tr");
        assert(tr.randomize() with {pload.size == 200;});
        drive_one_pkt(tr);
    end
    repeat(8) @(posedge vif.clk);
    phase.drop_objection(this);
endtask

task my_driver::drive_one_pkt(my_transcation tr);
    byte unsigned data_q[];
    int data_size;

    data_size = tr.pack_bytes(data_q) / 8;
    `uvm_info("my_driver", "begin to drive_one_pkt", UVM_LOW);
    repeat(3) @(posedge vif.clk);

    for(int i = 0; i < data_size; i++) begin
        @(posedge vif.clk);
        vif.valid <= 1'b1;
        vif.data <= data_q[i];
    end

    @(posedge vif.clk);
    vif.valid <= 1'b0;
    `uvm_info("my_driver", "end drive_one_pkt", UVM_LOW);

endtask

`endif
