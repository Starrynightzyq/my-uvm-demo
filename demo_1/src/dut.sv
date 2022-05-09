// +FHDR----------------------------------------------------------------------------
// Project Name  : IC_Design
// Device        : ASIC
// Author        : zhouyuqian
// Email         : starrynightzyq@gmail.com
// Website       : https://zhouyuqian.com
// Create On     : 2022/05/07 12:00
// Last Modified : 2022/05/07 12:00
// File Name     : dut.sv
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

module dut
(
    input            clk,
    input            rst_n,
    input      [7:0] rxd,
    input            rx_dv,
    output reg [7:0] txd,
    output reg       tx_en
);

    always@(posedge clk) begin
        if(!rst_n)begin
             txd    <= 8'h0;
             tx_en  <= 1'h0;
        end else begin
             txd    <= rxd;
             tx_en  <= rx_dv;
        end
    end

endmodule

