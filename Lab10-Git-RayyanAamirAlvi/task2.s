# --- Initialization ---
addi x28, x0, 5      # x28 = 5 (Initial value/constant)
addi x2, x0, 511     # x2 = 511 (Initialize Stack Pointer or memory limit)
addi x5, x0, 768     # x5 = 768 (Base address for INPUT, e.g., Switches)
addi x6, x0, 512     # x6 = 512 (Base address for OUTPUT, e.g., LEDs/Display)
sw x28, 0(x5)        # Store 5 into input address (simulating initial input)

# --- Main Input Loop ---
INPUT_WAIT:
    sw x0, 0(x6)     # Clear the output display (write 0 to x6)

POLL_SWITCH:
    lw x11, 0(x5)    # Read value from input device into x11
    beq x11, x0, POLL_SWITCH  # If input is 0, keep polling (wait for input)
    
    add x10, x11, x0 # Copy input value to x10 (argument for countdown)
    jal x1, COUNTDOWN # Jump to COUNTDOWN, save return address in x1
    beq x0, x0, INPUT_WAIT    # After countdown finishes, loop back to wait for next input

# --- Countdown Subroutine ---
COUNTDOWN:
    addi x2, x2, -8  # Decrement stack pointer (allocate 8 bytes)
    sw x1, 4(x2)     # Save return address (x1) to stack
    sw x12, 0(x2)    # Save x12 to stack (to preserve its value)
    add x12, x10, x0 # Load the countdown start value into x12

COUNT_LOOP:
    sw x12, 0(x6)    # Write current count to output display
    beq x12, x0, COUNT_DONE   # If count reaches 0, exit loop
    addi x12, x12, -1         # Decrement the counter

    # --- Nested Delay Loop ---
    addi x13, x0, 3  # Set delay duration (very short here, 3 cycles)
DELAY:
    addi x13, x13, -1         # Decrement delay counter
    bne x13, x0, DELAY        # Loop until delay reaches 0
    
    beq x0, x0, COUNT_LOOP    # Repeat the count loop

COUNT_DONE:
    sw x0, 0(x6)     # Ensure display is cleared at the end
    lw x12, 0(x2)    # Restore x12 from stack
    lw x1, 4(x2)     # Restore return address (x1) from stack
    addi x2, x2, 8   # Deallocate stack space
    jalr x0, 0(x1)   # Return to caller (INPUT_WAIT)

# --- Final Program End ---
end:
    j end            # Infinite loop to stop execution