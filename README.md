Lock in amplifier implementation running on the RedPitaya's FPGA

To edit the project enter `source RedPitaya_LockInAmplifier.tcl` after navigating to the project folder
in the Vivado TCL console

To just use the lock in amplifier copy the file onto the RedPitaya's SD card
and enter `cat "path"/LockIn.bit > /dev/xdevcfg`, where "path" is the location of LockIn.bit on your SD card

Still in a really early stage, so there are timing issues and no GUI

To change settings while running use the Red Pitaya's monitor tool after connecting to it via SSH

The address for the input gain is `0x41220000`, the output gain `0x41210000`, the phase `0x41200000`,
the frequency `0x41230000`, and for the low pass filter frequency `0x41240000`
