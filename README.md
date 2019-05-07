# Blinky

A small program, written in pure assembly (and a small linker script) (and a Makefile)...

... that blinks a light on a Raspberry Pi 3!

Specifically, GPIO 16. To run, you'll need to hook up an LED (facing the right
direction, with the right resistor) to GPIO pin 16. If you're wondering which
pin that is, have a look at [pinout.xyz](http://pinout.xyz).

## Building
You'll need to install a cross-compiler toolchain. On Ubuntu, I ran `apt-get
install binutils-aarch64-linux-gnu`. As I understand it, the [target triplet](target-triplet)
has to do with the preferred binary format and libraries it links against.
Since there's a custom linker script, I don't think the target triplet matters
apart from `aarch64`, but I could be wrong.

To use the Makefile, you'll need to change the `TARGET` variable to the prefix
for your assembler, linker, and objcopy.

[More information about cross compilers is available at the OSDev Wiki][cross-compiler].


## Booting
tl;dr: copy the built `blinky.bin` to the SD card as `kernel8.img`. Backup
files first if you need.

The Raspberry Pi starts up from a ROM on the GPU, rather than a separate BIOS
chip. The GPU looks for a FAT32-formatted filesystem on the SD card, reads a
`bootcode.bin` file from the SD card, and loads one of `kernel.img`,
`kernel7.img`, or `kernel8.img` (higher numbers seem to take precedence). It
also reads configuration options from `config.txt`, if present. I've been
running this kernel without a `config.txt`.

To get the latest `bootcode.bin` (and a correctly formatted filesystem), I
installed a NOOBS image on an SD card and then just modified `config.txt` and
`kernel*.img`.

The [official boot mode documentation][official-boot-doc] has more information,
though it doesn't seem entirely complete. [This forum post](rpi-boot-thread)
seems to have more information on the boot sequence.  I haven't found more
complete boot documentation.

## Notes
This code relies on the first instruction of `.text` being the first thing to
run, and that works fine because that's what the linker puts there by default.
A more sophisticated linker script might place a symbol first, and link
everything else after.

# License

This code files are releastd into the public domain.  The README is Copyright
(c) 2019 Galen O'Sullivan. You can use it under [CC-BY-NC 2.0][cc-by-nc]. If
you want to use it under another license, please email me and ask.

[official-boot-doc]: https://github.com/raspberrypi/documentation/tree/master/hardware/raspberrypi/bootmodes
[target-triplet]: https://wiki.osdev.org/Target_Triplet
[cross-compiler]: https://wiki.osdev.org/GCC_Cross-Compiler
[rpi-boot-thread]: https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=6685
[cc-by-nc]: https://creativecommons.org/licenses/by-nc/2.0/
