interface alu_interface (bit CLK, bit RST);

    // Input Ports
    logic [`DW-1:0] OPA;
    logic [`DW-1:0] OPB;
    logic CE;
    logic MODE;
    logic CIN;
    logic [`CW-1:0] CMD;
    logic [1:0] INP_VALID;

    // Output Ports
    logic [(`DW*2)-1:0] RES;
    logic COUT;
    logic OFLOW;
    logic G;
    logic E;
    logic L;
    logic ERR;

    // driver clocking block
    clocking drv_cb @(posedge CLK);
        output #1;
        output OPA;
        output OPB;
        output CE;
        output MODE;
        output CIN;
        output CMD;
        output INP_VALID;
    endclocking

    // Input monitor clocking block
    clocking inp_mon_cb @(posedge CLK);
        input #1;
        input OPA;
        input OPB;
        input CE;
        input MODE;
        input CIN;
        input CMD;
        input INP_VALID;
    endclocking

    // Output monitor clocking block
    clocking out_mon_cb @(posedge CLK);
        input #1;
        input RES;
        input COUT;
        input OFLOW;
        input G;
        input E;
        input L;
        input ERR;
    endclocking

    // Modports
    modport DRV(clocking drv, input RST);
    modport INP_MON(clocking inp_mon, input RST);
    modport OUT_MON(clocking out_mon, input RST);

endinterface //alu_interface (bit clk, bit rst)