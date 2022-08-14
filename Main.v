module Main (
    input Rst_n,Coin_in,Double_wash,CLK,Timer_pause,
    input [1:0] CLK_freq,
    output wire Wash_done
);
    wire [2:0] Duration_clk;
    wire Trigger_clk;

    FSM FSM1 (
        .Rst_n(Rst_n),
        .Coin_in(Coin_in),
        .Double_wash(Double_wash),
        .Trigger_clk_FSM(Trigger_clk),
        .Wash_done(Wash_done),
        .Duration_clk_FSM(Duration_clk)
    );

    Timer Timer1 (
        .Timer_pause(Timer_pause),
        .CLK(CLK),
        .CLK_freq(CLK_freq),
        .Duration_clk_timer(Duration_clk),
        .Trigger_clk_timer(Trigger_clk)
    );

endmodule