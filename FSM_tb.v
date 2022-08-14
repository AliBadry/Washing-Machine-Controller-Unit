`timescale 1us/1ns
module FSM_tb ();
    
    //--------------------defining in/outs------------------//
    reg Rst_n_tb;
    reg Coin_in_tb;
    reg Double_wash_tb;
    reg CLK_tb;
    reg Timer_pause_tb;
    reg [1:0] CLK_freq_tb;
    //reg Trigger_clk_tb;
    //wire [2:0] Duration_clk_tb;
    wire Wash_done_tb;

    //-----------------initial block-----------------------//
    initial 
    begin
        Rst_n_tb = 1'b1;
        Coin_in_tb = 1'b0;
        Double_wash_tb = 1'b0;
        CLK_tb = 1'b0;
        Timer_pause_tb = 1'b0;
        //CLK_freq_tb = 2'b00; //at freq 1MHz
        CLK_freq_tb = 2'b01; //at freq 2MHz

        #50
        Rst_n_tb = 1'b0;
        #50
        Rst_n_tb = 1'b1;
        #50
        Double_wash_tb = 1'b1;
        Coin_in_tb = 1'b1;
        #50
        Coin_in_tb = 1'b0;

        /*$display("Test case 1! Reset the machine");
        Rst_n_tb = 1'b0;
        #5 Rst_n_tb = 1'b1;
        if (Duration_clk_tb == 3'b0) 
        begin
            $display("Test 1 succeeded!");
        end
        else 
        begin
            $display("Test 1 failed!!!!");
        end

        $display("Test case 2! All the sequence without double wash");
        #2
        Coin_in_tb = 1'b1;
        #5
        if (Duration_clk_tb == 3'b1) 
        begin
            $display("State B success");
        end
        else
        begin
            $display("State B failed");
        end
         #2 
         Coin_in_tb = 1'b0;

        #30
        if (Duration_clk_tb == 3'b101) 
        begin
            $display("State F success");
        end
        else
        begin
            $display("State F failed");
        end

        $display("Test case 3! All the sequence with double wash");
        #2 
        Coin_in_tb = 1'b1;
        #5
        if (Duration_clk_tb == 3'b1) 
        begin
            $display("State B success");
        end
        else
        begin
            $display("State B failed");
        end
         #2 
         Coin_in_tb = 1'b0;

        #20
        if (Duration_clk_tb == 3'b010) 
        begin
            $display("State C success");
        end
        else
        begin
            $display("State C failed");
        end*/

        #1080000000
        $finish;

    end

    //-----------------Trigger interchanging------------------//
    always #0.25 CLK_tb = ~CLK_tb;
    //------------------instantiation of FSM module--------------//
    Main DUT 
    (
        .Rst_n(Rst_n_tb),
        .Coin_in(Coin_in_tb),
        .Double_wash(Double_wash_tb),
        .CLK(CLK_tb),
        .Timer_pause(Timer_pause_tb),
        .CLK_freq(CLK_freq_tb),
        .Wash_done(Wash_done_tb)
    );

endmodule