// +FHDR----------------------------------------------------------------------------
// Project Name  : IC_Design
// Device        : ASIC
// Author        : zhouyuqian
// Email         : starrynightzyq@gmail.com
// Website       : https://zhouyuqian.com
// Create On     : 2022/05/10 20:30
// Last Modified : 2022/05/10 20:30
// File Name     : my_case1.sv
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
// 2022/05/10   zhouyuqian      1.0                     Original
// 
// -FHDR----------------------------------------------------------------------------

`ifndef MY_CASE1__SV
`define MY_CASE1__SV

`include "base_test.sv"

class case1_sequence extends uvm_sequence#(my_transcation);
    my_transcation m_trans;

    function new(string name = "case1_sequence");
        super.new(name);
    endfunction

    virtual task body();
        if(starting_phase != null)
            starting_phase.raise_objection(this);

        repeat (10) begin
            `uvm_do_with(m_trans, {m_trans.pload.size() == 60;})
        end
        #1000;
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask

    `uvm_object_utils(my_sequence);

endclass

class my_case1 extends base_test;

    function new(string name = "my_case1", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);

    `uvm_component_utils(my_case1);

endclass

function void my_case1::build_phase(uvm_phase phase);
    super.build_phase(phase);

    uvm_config_db#(uvm_object_wrapper)::set(this,
                                        "env.i_agt.sqr.main_phase",
                                        "default_sequence",
                                        case1_sequence::type_id::get());

endfunction

`endif
