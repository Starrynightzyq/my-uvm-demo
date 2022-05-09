// +FHDR----------------------------------------------------------------------------
// Project Name  : IC_Design
// Device        : ASIC
// Author        : zhouyuqian
// Email         : starrynightzyq@gmail.com
// Website       : https://zhouyuqian.com
// Create On     : 2022/05/09 14:45
// Last Modified : 2022/05/09 14:45
// File Name     : my_env.sv
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

`ifndef MY_ENV__SV
`define MY_ENV__SV

`include "my_agent.sv"
`include "my_model.sv"
`include "my_scoreboard.sv"

class my_env extends uvm_env;

    my_agent i_agt;
    my_agent o_agt;
    my_model mdl;
    my_scoreboard msd;
    uvm_tlm_analysis_fifo#(my_transcation) agt_mdl_fifo;
    uvm_tlm_analysis_fifo#(my_transcation) mdl_msd_fifo;
    uvm_tlm_analysis_fifo#(my_transcation) oagt_msd_fifo;

    function new(string name = "my_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        i_agt = my_agent::type_id::create("i_agt", this);
        o_agt = my_agent::type_id::create("o_agt", this);
        i_agt.is_active = UVM_ACTIVE;
        o_agt.is_active = UVM_PASSIVE;
        mdl = my_model::type_id::create("mdl", this);
        agt_mdl_fifo = new("agt_mdl_fifo", this);
        mdl_msd_fifo = new("mdl_msd_fifo", this);
        oagt_msd_fifo = new("oagt_msd_fifo", this);
        msd = my_scoreboard::type_id::create("msd", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        i_agt.ap.connect(agt_mdl_fifo.analysis_export);
        mdl.port.connect(agt_mdl_fifo.blocking_get_export);

        mdl.ap.connect(mdl_msd_fifo.analysis_export);
        msd.exp_port.connect(mdl_msd_fifo.blocking_get_export);

        o_agt.ap.connect(oagt_msd_fifo.analysis_export);
        msd.act_port.connect(oagt_msd_fifo.blocking_get_export);
    endfunction

    `uvm_component_utils(my_env);

endclass

`endif
