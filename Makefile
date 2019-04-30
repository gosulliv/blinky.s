TARGET ?= aarch64-none-elf
CROSS ?= $(TARGET)

.PHONY: all

all: blinky.bin

blinky.o: blinky.s
	@$(CROSS)-as -o blinky.o blinky.s

blinky.elf: blinky.o blinky.ld
	@$(CROSS)-ld -Tblinky.ld -o blinky.elf blinky.o

blinky.bin: blinky.elf
	@$(CROSS)-objcopy $< -O binary $@

clean:
	rm blinky.o blinky.elf blinky.bin
