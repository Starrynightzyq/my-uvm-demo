// +FHDR----------------------------------------------------------------------------
// Project Name  : IC_Design
// Device        : ASIC
// Author        : zhouyuqian
// Email         : starrynightzyq@gmail.com
// Website       : https://zhouyuqian.com
// Create On     : 2022/05/07 15:51
// Last Modified : 2022/05/07 15:51
// File Name     : my_if.sv
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

interface my_if(
    input clk,
    input rst_n
);

    logic [7:0] data;
    logic       valid;

endinterface
