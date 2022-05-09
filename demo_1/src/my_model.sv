// +FHDR----------------------------------------------------------------------------
// Project Name  : IC_Design
// Device        : ASIC
// Author        : zhouyuqian
// Email         : starrynightzyq@gmail.com
// Website       : https://zhouyuqian.com
// Create On     : 2022/05/09 16:20
// Last Modified : 2022/05/09 16:20
// File Name     : my_model.sv
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

`ifndef MY_MODEL__SV
`define MY_MODEL__SV

`include "my_transcation.sv"

class my_model extends uvm_component;

    uvm_blocking_get_port#(my_transcation) port;
    uvm_analysis_port#(my_transcation) ap;

    extern function new(string name, uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);

    `uvm_component_utils(my_model);
endclass

function my_model::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void my_model::build_phase(uvm_phase phase);
    super.build_phase(phase);
    port = new("port", this);
    ap = new("ap", this);
endfunction

task my_model::main_phase(uvm_phase phase);
    my_transcation tr;
    my_transcation new_tr;
    super.main_phase(phase);
    while(1) begin
        port.get(tr);
        new_tr = new("new_tr");
        new_tr.my_copy(tr);
        `uvm_info("my_model", "get one transcation, copy and print it:", UVM_LOW);
        new_tr.my_print();
        ap.write(new_tr);
    end
endtask

`endif
