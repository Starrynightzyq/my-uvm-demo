// +FHDR----------------------------------------------------------------------------
// Project Name  : IC_Design
// Device        : ASIC
// Author        : zhouyuqian
// Email         : starrynightzyq@gmail.com
// Website       : https://zhouyuqian.com
// Create On     : 2022/05/10 17:22
// Last Modified : 2022/05/10 17:22
// File Name     : my_sequencer.sv
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

class my_sequencer extends uvm_sequencer#(my_transcation);

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    `uvm_component_utils(my_sequencer);
endclass
