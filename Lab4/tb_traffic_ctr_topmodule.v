`timescale 1ps/1ps
module tb_traffic_ctr_topmodule();
    reg built_in_clk, glob_rst_n;
    reg car;
    wire [6:0] led_highway, led_country;

    traffic_ctr_topmodule duv (
        .built_in_clk(built_in_clk),
        .glob_rst_n(glob_rst_n),
        .car(car),
        .led_highway(led_highway),
        .led_country(led_country)
    );

    // Generate input clock
    initial begin
        built_in_clk = 1;
        forever #10 built_in_clk = ~built_in_clk;
    end

    initial begin
        glob_rst_n = 1;
    end


    // Generate car
    initial begin
        car = 0;
        #20 car = 1;
        #200 car = 0;
        repeat(100) #80 car = $random;
    end

endmodule