// +FHDR----------------------------------------------------------------------------
// Project Name  : IC_Design
// Device        : ASIC
// Author        : zhouyuqian
// Email         : starrynightzyq@gmail.com
// Website       : https://zhouyuqian.com
// Create On     : 2022/05/09 14:00
// Last Modified : 2022/05/09 14:00
// File Name     : ../src/my_transcation.sv
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

`ifndef MY_TRANSCATION__SV
`define MY_TRANSCATION__SV

class my_transcation extends uvm_sequence_item;

    rand bit[47:0] dmac;
    rand bit[47:0] smac;
    rand bit[15:0] ether_type;
    rand byte      pload[];
    rand bit[31:0] crc;

    constraint pload_cons{
        pload.size >= 46;
        pload.size <= 1500;
    }

    function bit[31:0] calc_crc();
        return 32'h0;
    endfunction

    function void post_randomize();
        crc = calc_crc;
    endfunction

    // function void my_print();
        // $display("dmac = %0h", dmac);
        // $display("crc = %0h", crc);
    // endfunction

    // function void my_copy(my_transcation tr);
        // if(tr == null)
            // `uvm_fatal("my_transcation", "tr is null!!!")
        // dmac = tr.dmac;
        // smac = tr.smac;
        // ether_type = tr.ether_type;
        // pload = new[tr.pload.size()];
        // for(int i = 0; i < pload.size(); i++) begin
            // pload[i] = tr.pload[i];
        // end
        // crc = tr.crc;
    // endfunction

    // `uvm_object_utils(my_transcation);

    `uvm_object_utils_begin(my_transcation)
        `uvm_field_int(dmac, UVM_ALL_ON)
        `uvm_field_int(smac, UVM_ALL_ON)
        `uvm_field_int(ether_type, UVM_ALL_ON)
        `uvm_field_array_int(pload, UVM_ALL_ON)
        `uvm_field_int(crc, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "my_transcation");
        super.new(name);
    endfunction

    // extern function bit my_compare(my_transcation tr);

endclass

// function bit my_transcation::my_compare(my_transcation tr);
    // bit result;

    // if(tr == null)
        // `uvm_fatal("my_transcation", "tr is null!!!")
    // result = ((dmac == tr.dmac) &&
                // (smac == tr.smac) &&
                // (ether_type == tr.ether_type) &&
                // (crc == tr.crc));
    // if(pload.size() != tr.pload.size())
        // result = 0;
    // else
        // for(int i = 0; i < pload.size(); i++) begin
            // if(pload[i] != tr.pload[i])
                // result = 0;
        // end

    // return result;
// endfunction

`endif
