main:
    # --- Step 1: Set up the memory pointers ---
    # Think of these registers as "bookmarks" pointing to where our arrays live.
    li x10, 0x100       # x10 points to where we will store the first list (byte values)
    li x11, 0x200       # x11 points to where we will store the second list (half-word values)
    li x12, 0x300       # x12 points to where we will save the final answers (full words)

    # --- Step 2: Initialize the First Array (The Bytes) ---
    # We are writing the values 10, 20, 30, 40 into memory starting at 0x100.
    # Since these are bytes (8-bit), they sit right next to each other (offset 0, 1, 2, 3).
    
    li x30, 10          # Get the number 10 ready
    sb x30, 0(x10)      # Write 10 to the 1st slot of array 1
    li x30, 20          # Get the number 20 ready
    sb x30, 1(x10)      # Write 20 to the 2nd slot (just 1 byte over)
    li x30, 30          # Get the number 30 ready
    sb x30, 2(x10)      # Write 30 to the 3rd slot
    li x30, 40          # Get the number 40 ready
    sb x30, 3(x10)      # Write 40 to the 4th slot

    # --- Step 3: Initialize the Second Array (The Half-Words) ---
    # We are writing 100, 200, 300, 400 into memory starting at 0x200.
    # Since these are half-words (16-bit/2 bytes), we have to skip 2 steps for every number (offset 0, 2, 4, 6).

    li x31, 100         # Get the number 100 ready
    sh x31, 0(x11)      # Write 100 to the 1st slot of array 2
    li x31, 200         # Get the number 200 ready
    sh x31, 2(x11)      # Write 200 to the 2nd slot (jumping 2 bytes ahead)
    li x31, 300         # Get the number 300 ready
    sh x31, 4(x11)      # Write 300 to the 3rd slot
    li x31, 400         # Get the number 400 ready
    sh x31, 6(x11)      # Write 400 to the 4th slot

    # --- Step 4: The Calculation Loop ---
    # Now we grab one number from list A, one from list B, add them, and save to list C.
    
    # Calculation 1: 10 + 100
    lb  x5, 0(x10)      # Fetch the 1st byte (10)
    lh  x6, 0(x11)      # Fetch the 1st half-word (100)
    add x7, x5, x6      # Add them together (110)
    sw  x7, 0(x12)      # Save the result as a full word (4 bytes) at the start of the result area

    # Calculation 2: 20 + 200
    lb  x5, 1(x10)      # Fetch the 2nd byte (offset is 1)
    lh  x6, 2(x11)      # Fetch the 2nd half-word (offset is 2)
    add x7, x5, x6      # Add them (220)
    sw  x7, 4(x12)      # Save result. Note: We offset by 4 this time because the previous answer took up 4 bytes.

    # Calculation 3: 30 + 300
    lb  x5, 2(x10)      # Fetch 3rd byte
    lh  x6, 4(x11)      # Fetch 3rd half-word
    add x7, x5, x6      # Add them (330)
    sw  x7, 8(x12)      # Save result. Offset is now 8.

    # Calculation 4: 40 + 400
    lb  x5, 3(x10)      # Fetch 4th byte
    lh  x6, 6(x11)      # Fetch 4th half-word
    add x7, x5, x6      # Add them (440)
    sw  x7, 12(x12)     # Save result. Offset is now 12.

end:
    j end               # Stuck in a loop here so the program doesn't crash or run off into empty memory.