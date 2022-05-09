// +FHDR----------------------------------------------------------------------------
// Project Name  : IC_Design
// Device        : ASIC
// Author        : zhouyuqian
// Email         : starrynightzyq@gmail.com
// Website       : https://zhouyuqian.com
// Create On     : 2022/05/09 15:03
// Last Modified : 2022/05/09 15:03
// File Name     : my_monitor.sv
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
// 2022/05/09   zhouyuqian      1.0                     Original
// 
// -FHDR----------------------------------------------------------------------------

`ifndef MY_MONITOR__SV
`define MY_MONITOR__SV

class my_monitor extends uvm_monitor;

    virtual my_if vif;
    uvm_analysis_port#(my_transcation) ap;

    `uvm_component_utils(my_monitor);
    function new(string name = "my_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
            `uvm_fatal("my_monitor", "virtual interface must be set for vif!!!")
        ap = new("ap", this);
    endfunction

    extern task main_phase(uvm_phase phase);
    extern task collect_one_pkt(my_transcation tr);

endclass

task my_monitor::main_phase(uvm_phase phase);
    my_transcation tr;
    while(1) begin
        tr = new("tr");
        collect_one_pkt(tr);
        ap.write(tr);
    end
endtask

task my_monitor::collect_one_pkt(my_transcation tr);
    bit [7:0] data_q[$];
    int psize;
    while(1) begin
        @(posedge vif.clk);
        if(vif.valid) break;
    end

    `uvm_info("my_monitor", "begin to collect_one_pkt", UVM_LOW);
    while(vif.valid) begin
        data_q.push_back(vif.data);
        @(posedge vif.clk);
    end

    // pop dmac
    for(int i = 0; i < 6; i++) begin
        tr.dmac = {tr.dmac[39:0], data_q.pop_front()};
    end

    // pop crc
    for(int i = 0; i < 4; i++) begin
        tr.crc = {tr.crc[23:0], data_q.pop_front()};
    end

    `uvm_info("my_monitor", "end collect_one_pkt, print it:", UVM_LOW);
    tr.my_print();

endtask

`endif
