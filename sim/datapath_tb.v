// module data_path_tb;
//     reg [7:0] Dn;
//     reg [7:0] Xn;
//     reg [7:0] Wn;
//     reg clock;
//     wire [7:0] z;
//     wire done_read_Dn;
//     wire done_read_Xn;
//     wire done_yn;
//     wire done_en;
//     wire done_write_wn;
//     wire done_wn1;
//     reg memory_Dn_active;
//     reg memory_Xn_active;
//     reg memory_bobot_active;
//     reg y_active;
//     reg e_active;
//     reg w_active;
//     reg sys_reset_active;

//     data_path uut (
//         .Dn(Dn),
//         .Xn(Xn),
//         .Wn(Wn),
//         .clock(clock),
//         .z(z),
//         .done_read_Dn(done_read_Dn),
//         .done_read_Xn(done_read_Xn),
//         .done_yn(done_yn),
//         .done_en(done_en),
//         .done_write_wn(done_write_wn),
//         .done_wn1(done_wn1),
//         .memory_Dn_active(memory_Dn_active),
//         .memory_Xn_active(memory_Xn_active),
//         .memory_bobot_active(memory_bobot_active),
//         .y_active(y_active),
//         .e_active(e_active),
//         .w_active(w_active),
//         .sys_reset_active(sys_reset_active)
//     );

//     always begin
//         clock <= 1'b0;
//         forever begin
//            #5 clock = ~clock; 
//         end
//     end

//     initial begin
//         Dn = 8'b11001100;
//         Xn = 8'b10101010;
//         Wn = 8'b11110000;
//         clock = 0;
//         memory_Dn_active = 1;
//         memory_Xn_active = 1;
//         memory_bobot_active = 1;
//         y_active = 1;
//         e_active = 1;
//         w_active = 1;
//         sys_reset_active = 0;
//         $dumpfile("datapath_tb1.vcd");
//         $dumpvars(0, data_path_tb);
//         #100 $finish;
//     end

// endmodule







module data_path_tb;
    reg [7:0] Dn;
    reg [7:0] Xn;
    reg [7:0] Wn;
    reg clock;
    wire [7:0] z;
    wire done_read_Dn;
    wire done_read_Xn;
    wire done_yn;
    wire done_en;
    wire done_write_wn;
    wire done_wn1;
    reg memory_Dn_active;
    reg memory_Xn_active;
    reg memory_bobot_active;
    reg y_active;
    reg e_active;
    reg w_active;
    reg sys_reset_active;

    integer xn_file;
    integer wn_file;
    integer dn_file;

    reg [7:0] data_in;

    data_path uut (
        .Dn(Dn),
        .Xn(Xn),
        .Wn(Wn),
        .clock(clock),
        .z(z),
        .done_read_Dn(done_read_Dn),
        .done_read_Xn(done_read_Xn),
        .done_yn(done_yn),
        .done_en(done_en),
        .done_write_wn(done_write_wn),
        .done_wn1(done_wn1),
        .memory_Dn_active(memory_Dn_active),
        .memory_Xn_active(memory_Xn_active),
        .memory_bobot_active(memory_bobot_active),
        .y_active(y_active),
        .e_active(e_active),
        .w_active(w_active),
        .sys_reset_active(sys_reset_active)
    );

        always begin
        clock <= 1'b0;
        forever begin
           #5 clock = ~clock; 
        end
    end

    integer line_num;

    initial begin
        xn_file = $fopen("sim/xn_test.txt", "r");
        wn_file = $fopen("sim/wn_test.txt", "r");
        dn_file = $fopen("sim/dn_test.txt", "r");
        $dumpfile("datapath_tb1.vcd");
        $dumpvars(0, data_path_tb);

        data_in = 8'b0;
        line_num = 0;

        while (line_num < 50) begin
            // Read lines from each file
            if ($fscanf(xn_file, "%b", data_in) != 1) $finish; // Check for EOF
            Xn = data_in;

            if ($fscanf(wn_file, "%b", data_in) != 1) $finish; // Check for EOF
            Wn = data_in;

            if ($fscanf(dn_file, "%b", data_in) != 1) $finish; // Check for EOF
            Dn = data_in;

            $display("Updated Xn, Dn, and Wn at line %d", line_num);
   
            memory_Dn_active = 1;
            memory_Xn_active = 1;
            memory_bobot_active = 1;
            y_active = 1;
            e_active = 1;
            w_active = 1;
            sys_reset_active = 0;
            line_num = line_num + 1;
            #10;
        end

        // Close files
        $fclose(xn_file);
        $fclose(wn_file);
        $fclose(dn_file);

        $display("Simulation completed.");
        $finish;
    end

    // Rest of the module...
endmodule
