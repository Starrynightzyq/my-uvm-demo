// +FHDR----------------------------------------------------------------------------
// Project Name  : IC_Design
// Device        : ASIC
// Author        : zhouyuqian
// Email         : starrynightzyq@gmail.com
// Website       : https://zhouyuqian.com
// Create On     : 2022/05/10 20:17
// Last Modified : 2022/05/10 20:17
// File Name     : my_case0.sv
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

`ifndef MY_CASE0__SV
`define MY_CASE0__SV

`include "base_test.sv"

class case0_sequence extends uvm_sequence#(my_transcation);
    my_transcation m_trans;

    function new(string name = "case0_sequence");
        super.new(name);
    endfunction

    virtual task body();
        if(starting_phase != null)
            starting_phase.raise_objection(this);

        repeat (10) begin
            `uvm_do(m_trans)
        end
        #1000;
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask

    `uvm_object_utils(my_sequence);

endclass

class my_case0 extends base_test;

    function new(string name = "my_case0", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);

    `uvm_component_utils(my_case0);

endclass

function void my_case0::build_phase(uvm_phase phase);
    super.build_phase(phase);

    uvm_config_db#(uvm_object_wrapper)::set(this,
                                        "env.i_agt.sqr.main_phase",
                                        "default_sequence",
                                        case0_sequence::type_id::get());

endfunction

`endif
