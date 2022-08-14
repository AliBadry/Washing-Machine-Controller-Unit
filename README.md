# Washing-Machine-Controller-Unit
Washing machine controller unit implemented using verilog HDL. The operation of the machine consists of five states [Idle-Filling Water-Washing-Rinising-Spinning]. Ports are:-

I- rst_n (input): Active low asynchronous clock

II- CLK (input): system clock

III- CLK-freq[1:0] (input): input clock frequency configuration code

IV- Coin_in (input): Input flag which is asserted when a coin is deposited

V- Double_wash (input): Input flag which is asserted if the user requires double wash option

VI- Timer_pause (input): Input flag when it is set to ‘1’ spinning phase is paused until this flag is de-asserted

VII- Wash_doone (outpu): Active high output asserted when spinning phase is done and deasserted when coin_in is set to '1'

Input clock can have one of four frequencies [1-2-4-8] MHz The machine starts when a coin is deposited. There is a double wash input, when it is turned on, a second wash and rinse to occur after completing the first rinse. The double wash button is pressed before depositing the coins (if needed) and stays pressed till the job completes. If the timer_pause flag is asserted during the spin cycle, the machine stops spinning until the flag is de-asserted. Note that the machine is designed to stop when this flag is raised only during the spin cycle. The period of each state is the following:

I- Filling water: 2 Minutes

II- Washing: 5 Minutes

III- Rinising: 2 Minutes

IV- Spnning: 1 Minute
