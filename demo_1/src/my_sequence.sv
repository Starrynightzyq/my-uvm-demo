// +FHDR----------------------------------------------------------------------------
// Project Name  : IC_Design
// Device        : ASIC
// Author        : zhouyuqian
// Email         : starrynightzyq@gmail.com
// Website       : https://zhouyuqian.com
// Create On     : 2022/05/10 17:27
// Last Modified : 2022/05/10 17:27
// File Name     : my_sequence.sv
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

class my_sequence extends uvm_sequence#(my_transcation);
    my_transcation m_trans;

    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    virtual task body();
        if(starting_phase != null)
            starting_phase.raise_objection(this);

        repeat (10) begin
            `uvm_do(m_trans);
        end
        #1000;
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask

    `uvm_object_utils(my_sequence);
endclass
