.text
  // read processor number, halt processors other than #0.
  mrs	x7, mpidr_el1
  and	x7, x7, #3
  cbnz x7, halt

setup:
  // put GPIO_BASE into a register.
  movz x10, #0x3F20, LSL #16

  // GPIO_FSEL1
  add x1, x10, #4

  // set the bit signifying read access.
  mov w2, #0x40000
  str w2, [x1] 

  // on address
  add x4, x10, #0x1C
  // off address
  add x5, x10, #0x28

blink:
  // bit for GPIO pin 16 (0-indexed)
  mov w1, #0x00010000

on:
  str w1, [x4]

  mov x6, 0xf0000 // spin awhile
loop1:
  sub x6, x6, #1
  cbnz x6, loop1

off:
  str w1, [x5]

  mov x6, 0xf0000 // spin awhile
loop2:
  sub x6, x6, #1
  cbnz x6, loop2

  b on

halt:
  wfe
  b halt

