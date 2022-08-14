//----------- assume 4 different clk sources determined ----------//
module Timer
#(  parameter   MHz1 = 2'b00,
    parameter   MHz2 = 2'b01,
    parameter   MHz4 = 2'b10,
    parameter   MHz8 = 2'b11,
    parameter   A = 3'b000,
    parameter   B = 3'b001,
    parameter   C = 3'b010,
    parameter   D = 3'b011,
    parameter   E = 3'b100,
    parameter   F = 3'b101)
 (
    input wire CLK,Timer_pause,
    input wire [1:0] CLK_freq,
    input wire [2:0] Duration_clk_timer,
    output reg Trigger_clk_timer
);
reg [31:0] Timer_factor;
reg [31:0] Counter;
reg Timer_pause_flag;

//-----------------always block to determine the Timer_factor---------//
always @ (Duration_clk_timer) 
begin

//-----------Timer_factor = (make it 1 second)*(make it 1 minute)----------------//
    case (CLK_freq)
        MHz1: Timer_factor = 1000000*60;
        MHz2: Timer_factor = 2000000*60;
        MHz4: Timer_factor = 4000000*60;
        MHz8: Timer_factor = 8000000*60;
        default: Timer_factor = 1000000*60;
    endcase

//-----------Timer_factor = Timer_factor * time duration----------------//

    case (Duration_clk_timer)
        B: Timer_factor = Timer_factor *2;
        C: Timer_factor = Timer_factor *5;
        D: Timer_factor = Timer_factor *2;
        E: Timer_factor = Timer_factor *1;
        default: Timer_factor = Timer_factor / (1000000*60);
    endcase
    Counter = 0;
    Trigger_clk_timer = 0;
end

//---------------Beginning the timer------------------------//
always @(posedge CLK) 
begin
    if ((Timer_factor > Counter) && ~Timer_pause_flag)
    begin
        Counter = Counter + 1;
    end
    if (Counter >= Timer_factor) 
    begin
        Trigger_clk_timer <= 1;    
    end
end

//-----------checking the timer pause of the spinning state------------------------//
always @(Timer_pause) 
begin
    Timer_pause_flag = Timer_pause && (Duration_clk_timer==E);
end
endmodule