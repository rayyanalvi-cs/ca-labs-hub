.text                   
.globl main             

main:
    # 1. SETUP REGISTERS
    li x10, 0x78786464  # Load immediate value 0x78786464 into register x10
    li x11, 0xA8A81919  # Load immediate value 0xA8A81919 into register x11

    # 2. STORE TO MEMORY
    sw x10, 0x100(x0)   # Store word (4 bytes) from x10 to address 0x100
                        # Memory [0x100] = 0x64 (LSB)
                        # Memory [0x101] = 0x64
                        # Memory [0x102] = 0x78
                        # Memory [0x103] = 0x78 (MSB)

    sw x11, 0x1F0(x0)   # Store word (4 bytes) from x11 to address 0x1F0
                        # Memory [0x1F0] = 0x19 (LSB)
                        # Memory [0x1F1] = 0x19
                        # Memory [0x1F2] = 0xA8
                        # Memory [0x1F3] = 0xA8 (MSB)

    lhu x12, 0x100(x0)  # Load Halfword Unsigned from 0x100
                        # Reads 2 bytes: 0x64, 0x64 -> 0x6464
                        # Unsigned: Zero-extends upper bits.
                        # Result x12: 0x00006464

    lh x13, 0x1F0(x0)   # Load Halfword Signed from 0x1F0
                        # Reads 2 bytes: 0x19, 0x19 -> 0x1919
                        # Check Sign: 0x1... is positive (bit 15 is 0).
                        # Signed: Sign-extends with 0s.
                        # Result x13: 0x00001919

    lb x14, 0x1F0(x0)   # Load Byte Signed from 0x1F0
                        # Reads 1 byte: 0x19
                        # Check Sign: 0x19 (0001 1001) is positive (bit 7 is 0).
                        # Signed: Sign-extends with 0s.
                        # Result x14: 0x00000019

end:
    j end               