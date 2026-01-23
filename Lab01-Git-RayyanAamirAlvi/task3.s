.text
.globl main
main:
    # 1. int a = 5;
    li x20, 5              # a (x20) = 5

    # 2. int b = 0 + 0;
    add x21, x0, x0        # b (x21) = 0

    # 3. a = b + 32;
    addi x20, x21, 32      # a (x20) = 0 + 32 = 32

    # 4. int d = (a + b) - 5;
    add x22, x20, x21      # x22 temporarily holds (a + b)
    addi x22, x22, -5      # d (x22) = (32 + 0) - 5 = 27

    # 5. int e = (((a - d) + (b - a)) + d);
    sub x23, x20, x22      # x23 holds first part: (a - d)
    sub x5, x21, x20       # x5 (temp) holds second part: (b - a)
    add x23, x23, x5       # x23 = (a - d) + (b - a)
    add x23, x23, x22      # e (x23) = result + d. (e becomes 0 here)

    # 6. e = a + b + d + e;
    add x5, x0, x0         # Clear temporary register x5
    add x5, x20, x22       # x5 = a + d
    add x5, x5, x21        # x5 = (a + d) + b
    add x23, x23, x5       # e (x23) = e + (a + b + d) = 0 + 59 = 59

end:
    j end                  # Infinite loop to halt program