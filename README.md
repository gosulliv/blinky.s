# Blinky

A small program, written in pure assembly (and a small linker script) (and a Makefile)...

... that blinks a light on a Raspberry Pi 3!

Specifically, GPIO 16. To run, you'll need to hook up an LED (with the right
resistor) to GPIO pin 16. If you're wondering which pin that is, have a look at
[pinout.xyz](http://pinout.xyz).


This code relies on the first instruction of `.text` being the first thing to run, because linker scripts. It runs fine for me without a `config.txt`, which should mean settings are all at their defaults.

# License

This code is public domain to the extent possible by law.
