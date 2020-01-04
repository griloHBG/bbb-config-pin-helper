# BBB config-pin helper

A simple bash script that reads a file containing Beaglebone Black's pins names and respectives modes that will be applied.

How to use:

Create a text file say... pin_modex.txt and write down all pins and its modes. Like:

```
P9_24 can to communicate with motor's drive
p8_40 pruo controlled by PRU1 (or PRU0?)
p830 pruin
P932 in input for button SW3
```

Notice that everything that config-pin accepts can be used here (like `P9_24`, `p8_40`, `p830`, `P932`, `912`, ...).

It's possible to comment on the lines because the script cares only about the two first words of each line.

To comment a full line, just start it with a `#`.

To use the script just (notice the fail in pin `P8_40` beacause of a wrong mode and on th `P9_32` beacause it is not modifiable):
```
$ chmod +x config_pins_modes.sh
$ config_pins_modes.sh pins_modes.txt
------------------------------------------
Setting pin P9_24 to mode can
Final pin mode:
P9_24 Mode: can
------------------------------------------
Setting pin p8_40 to mode pruo
Invalid mode: pruo
Final pin mode:
P8_40 Mode: default Direction: in Value: 0
------------------------------------------
Setting pin p830 to mode pruin
Final pin mode:
P8_30 Mode: pruin
------------------------------------------
Setting pin P932 to mode in
Pin is not modifiable: P9_32 VADC
Final pin mode:
Pin is not modifiable: P9_32 VADC
------------------------------------------
```

## TODO

Perhaps add more config-pin's possibilities like query various pins modes
