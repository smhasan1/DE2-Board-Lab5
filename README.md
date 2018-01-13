# DE2-Board-Lab5
**Part 1:**  
We wish to implement a finite state machine (FSM) that recognizes two specific sequences of applied input symbols, namely four consecutive 0s or the sequence 0110. There is an input w and an output z. Whenever w = 0 for four consecutive clock pulses, or when the sequence 0110 appears on w across four consecutive clock pulses, the value of z has to be 1; otherwise, z = 0. Overlapping sequences are allowed, so, for example, if w = 0 for five consecutive clock pulses the output z will be equal to1 after the fourth and fifth pulses. Figure 1 illustrates the required relationship between w and z.  


Figure 1. Required timing for the output z.  

A state diagram for this FSM is shown in Figure 2. For this part you are to manually derive an FSM circuit that implements this state diagram, including the logic expressions that feed each of the state flip-flops. To implement the FSM, use seven state flip-flops called y7…y0 and the onehot state assignment given in Table 1.  


Figure 2. A state diagram for the FSM.  

|  | State Code |
| Name  | y7 y6 y5 y4 y3 y2 y1 y0 |
| ------------- | ------------- |
| A | 00000001 |
| B | 00000010 |
| C | 00000100 |
| D | 00001000 |
| E | 00010000 |
| F | 00100000 |
| G | 01000000 |
| H | 10000000 |
Table 1: One-hot codes for the FSM.  

Design and implement your circuit on the DE2 board as follows:  
1. Create a new Quartus II project for the FSM circuit. Select the appropriate target chip that matches the FPGA chip on the Altera DE2.
2. Write a Verilog file that instantiates the eight flip-flops in the circuit and which specifies the logic expressions that drive the flip-flop input ports. Use only simple assign statements in your Verilog code to specify the logic feeding the flip-flops. Note that the one-hot code enables you to derive these expressions by inspection.  
    a. Use the toggle switch SW0 on the DE2-series board as an active-low synchronous reset input for the FSM,  
    b. use SW1 as the w input,  
    c. and the pushbutton KEY0 as the clock input which is applied manually.  
    d. Use the green light LEDG0 as the output z,  
    e. and assign the state flip-flop outputs to the red lights LEDR7 to LEDR0.  
3. Include the Verilog file in your project, and assign the pins on the FPGA to connect to the switches and the LEDs on the DE2. Compile the circuit.
4. Simulate the behavior of your circuit with QSim. Label the states on your timing diagram.
5. Once you are confident that the circuit works properly as a result of your simulation, download the circuit into the FPGA chip. Test the functionality of your design by applying the input sequences and observing the output LEDs. Make sure that the FSM properly transitions between states as displayed on the red LEDs, and that it produces the correct output values on LEDG0.  

**Part 2.**  
For this part you are to write another style of Verilog code for the FSM in Figure 2. In this version of the code you should not manually derive the logic expressions needed for each state flip-flop. Instead, describe the state table for the FSM by using a Verilog case statement in an always block, and use another always block to instantiate the state flip-flops. You can use a third always block or simple assignment statements to specify the output z. To implement the FSM, use three state flip-flops y2…y0 and binary codes, as shown in Table 3.  


Table 2: Binary codes for the FSM.  

A suggested skeleton of the Verilog code is given in Figure 3.  


Figure 3: Skeleton Verilog code for the FSM.  

Implement your circuit as follows.  
1. Create a new project for the FSM.  
2. Include in the project your Verilog file that uses the style of code in Figure 3. Use the toggle switch SW0 on the DE2-series board as an active-low synchronous reset input for the FSM, use SW1 as the w input, and the pushbutton KEY0 as the clock input which is applied manually. Use the green light LEDG0 as the output z, and assign the state flip-flop outputs to the red lights LEDR2 to LEDR0. Assign the pins on the FPGA to connect to the switches and the LEDs on the DE2.  
3. Before compiling your code it is necessary to explicitly tell the Synthesis tool in Quartus II that you wish to have the finite state machine implemented using the state assignment specified in your Verilog code. If you do not explicitly give this setting to Quartus II, the Synthesis tool will automatically use a state assignment of its own choosing, and it will ignore the state codes specified in your Verilog code. To make this setting, choose Assignments > Settings in Quartus II, and click on the Analysis and Synthesis item on the left side of the window, then click on the More Settings button. Change the parameter State Machine Processing to the setting User-Encoded.  
4. To examine the circuit produced by Quartus II open the RTL Viewer tool. Double-click on the box shown in the circuit that represents the finite state machine, and determine whether the state diagram that it shows properly corresponds to the one in Figure 2. To see the state codes used for your FSM, open the Compilation Report, select the Analysis and Synthesis section of the report, and click on State Machines.  
5. Simulate the behaviour of your circuit.  
6. Once you are confident that the circuit works properly as a result of your simulation, download the circuit into the FPGA chip. Test the functionality of your design by applying the input sequences and observing the output LEDs. Make sure that the FSM properly transitions between states as displayed on the red LEDs, and that it produces the correct output values on LEDG0.  

**Part 3.**  
The sequence detector can be implemented in a straightforward manner using a 4-bit shift register, instead of using the more formal FSM design approach. Draw a shift register-based circuit for the sequence detector in your lab book and show it to the TAs as pre-work. No Verilog is required for this step.  

**Part 4.**  
In this part of the exercise you are to implement aMorse code encoder using an FSM. TheMorse code uses patterns of short and long pulses to represent a message. Each letter is represented as a sequence of dots (a short pulse), and dashes (a long pulse). For example, starting fromQ, eight letters of the alphabet have the following representation:  



Design and implement a Morse code encoder circuit using an FSM. Your circuit should take as input one of the eight letters of the alphabet starting from Q (as in the table above) and display the Morse code for it on a red LED, LEDR0. Use switches SW2−0 and pushbuttons KEY1−0 as inputs. When a user presses KEY1, the circuit should display the Morse code for a letter specified by SW2−0 (000 for Q, 001 for R, etc.), using 0.5-second pulses to represent dots, and 1.5-second pulses to represent dashes. Pushbutton KEY0 should function as an asynchronous reset.  
You are free to design the circuit however you wish. One possibility is to use shift registers(s) to hold the symbols (i.e. dots and dashes) for each letter, with the idea being to shift each time a symbol is output to the red LED, thereby allowing the symbols for the letter to be displayed in the proper succession. Additional register(s) and a counter can then be used to make sure that the right number of symbols are output for each letter (since, for example, T has only one symbol, and Q has 4 symbols).

**Hint for part 4 (Lab 7):**  
Here is a suggested architecture you can use. Feel free to modify this architecture or use another approach.



• There should be a top-level reset signal, not shown in the figure that resets the FSM to its starting state.  
• The Start signal tells the FSM to output the flashes according to the SymbolCode. The SymbolCode input specifies the letter to output.  
• "Symbol" in the following descriptions refers to Q, R, S etc. and not to dots/dashes. Symbol Shift Reg: contains a 1 or 0 for each dot or dash in the symbol to be displayed up to a maximum of 4 dots/dashes.  
• Symbol Down Counter: contains the number of dots/dashes for the symbol to be displayed (max 4 dots/dashes hence 2 bits). It is loaded with the number of dots/dashes and counts down to zero to indicate that all dots/dashes have been output to the LED.  
• 0.5 Sec Timer: starts counting to 0.5s after it is reset. elapsed goes high for 1 cycle every 0.5s after the reset. There are many ways to do the required timing, so you may choose to use another method. The main point is that you need something to do the timing.  
• Symbol Decode Logic: translates the SymbolCode to the Morse Code as a pattern of 1's and 0's and also specifies the number of bits (dots/dashes) in the Morse Code. These values can then be loaded in the Symbol Shift Reg and the Symbol Down Counter.  
• FSM is then used to control each element in the system. Inputs to the FSM are Start, ShiftOut, elapsed, CounterIsZero. Outputs are enables, loads, resets, FlashingLED.  
