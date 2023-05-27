module traffic_ctr_topmodule (
    input built_in_clk, glob_rst_n,
    input car,
    output [6:0] led_highway, led_country
);

    wire clk;
    wire start_t_h, start_t_c;
    wire start_T_h, start_T_c;
    wire t_timeout_h, T_timeout_h;
    wire t_timeout_c, T_timeout_c;
    wire enable_h, enable_c;
    
    // Generate clk 1Hz
    clk_1Hz clk1hz(
        .built_in_clk(built_in_clk),
        .clk(clk)
    );

    // t = 5
    timer #(.TIME(5), .WIDTH(3)) t_counter_h (
        .clk(clk),
        .glob_rst_n(glob_rst_n),
        .start(start_t_h),
        .timeout(t_timeout_h)
    );

    // T = 7
    timer #(.TIME(7), .WIDTH(3)) T_counter_h (
        .clk(clk),
        .glob_rst_n(glob_rst_n),
        .start(start_T_h),
        .timeout(T_timeout_h)
    );

        // t = 5
    timer #(.TIME(5), .WIDTH(3)) t_counter_c (
        .clk(clk),
        .glob_rst_n(glob_rst_n),
        .start(start_t_c),
        .timeout(t_timeout_c)
    );

    // T = 7
    timer #(.TIME(7), .WIDTH(3)) T_counter_c (
        .clk(clk),
        .glob_rst_n(glob_rst_n),
        .start(start_T_c),
        .timeout(T_timeout_c)
    );

    highway highway_ctr (
        .clk(clk),
        .glob_rst_n(glob_rst_n),
        .car(car),
        .enable_h(enable_h),
        .t_timeout(t_timeout_h),
        .T_timeout(T_timeout_h),
        .enable_c(enable_c),
        .start_t(start_t_h),
        .start_T(start_T_h),
        .led_highway(led_highway)
    );

    country country_ctr (
        .clk(clk),
        .glob_rst_n(glob_rst_n),
        .enable_c(enable_c),
        .t_timeout(t_timeout_c),
        .T_timeout(T_timeout_c),
        .enable_h(enable_h),
        .start_t(start_t_c),
        .start_T(start_T_c),
        .led_country(led_country)
    );
endmodule