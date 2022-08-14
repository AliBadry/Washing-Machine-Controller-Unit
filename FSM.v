module FSM 
// defining the states of our machine
#(  parameter   A = 3'b000,
    parameter   B = 3'b001,
    parameter   C = 3'b010,
    parameter   D = 3'b011,
    parameter   E = 3'b100,
    parameter   F = 3'b101)
(
    input wire Rst_n,Coin_in,Double_wash,
    input wire Trigger_clk_FSM, //sent from the CLK module when the duration of the state expires
    output reg [2:0] Duration_clk_FSM, // sent to the CLK module to determine the state duration
    //output reg Pause_clk, //Sent to the CLK module to pause the timer in the spinning state
    output reg Wash_done
);
    reg [2:0] State;
    reg Double_wash_flag;
    reg Coin_in_flag;
    
    //-----------------------Reset----------------------//
    // the asynchrounus reset transfers the maschine to the idle state 
    always @(negedge Rst_n) 
    begin
        State <= A;
        Duration_clk_FSM <= A;
    end

    //----------------State block---------------------------//
    //the machine triggers on the signal of the clk module
    always @(posedge Trigger_clk_FSM or posedge Coin_in) 
    begin
        case (State)
        A:
        begin
            if (Coin_in == 1'b1 )
            begin
                State <= B;
                Duration_clk_FSM <=B;
                Double_wash_flag <= Double_wash;
            end
            else
            begin
                State <= A;
                Duration_clk_FSM <=A;
            end
        end 
        B:
        begin
            State <= C;
            Duration_clk_FSM <= C;
        end
        C:
        begin
            State <= D;
            Duration_clk_FSM <= D;
        end
        D:
        begin
            if (Double_wash == 1'b1 && Double_wash_flag == 1'b1)
            begin
                State <= C;
                Duration_clk_FSM <= C;
                Double_wash_flag <= 0;
            end
            else
            begin
                State <= E;
                Duration_clk_FSM <= E;
            end
        end
        E:
        begin
            State <= F;
            Duration_clk_FSM <= F;

        end
        F:
        begin
            if (Coin_in == 1'b1 )
            begin
                State <= B;
                Duration_clk_FSM <= B;
                Double_wash_flag <= Double_wash;
            end
            else
            begin
                State <= F;
                Duration_clk_FSM <= F;
            end
        end
        default:
        begin
            State <= A;
            Duration_clk_FSM <=A;
        end
        endcase

    end

    //------------------------Output block---------------//
    always @(State) 
    begin
        case (State)
            F: Wash_done <= 1'b1; 
            default: Wash_done <= 1'b0;
        endcase    
    end
endmodule