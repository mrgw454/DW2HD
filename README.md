# DW2HD
Drivewire to HD (SD, CF or even HD image for emulators) mass DSK image transfer utility for the TRS-80 Color Computer.

In order to use this program, you will need a Coco 3 (real or emulated).  I used MAME for my initial development and testing:

https://www.mamedev.org/

XRoar works, too:

https://www.6809.org.uk/xroar/


This program is compatible with Gary Becker's CoCo3FPGA as well:

http://www.davebiz.com/wiki/CoCo3FPGA


You will also need Brett Gordon's YA-DOS (a DECB/HDBDOS replacement with additional features):

https://sites.google.com/site/cocoboot2/ya-dos


In addition, you will need a working Drivewire or pyDriveWire installation:

https://sites.google.com/site/drivewire4/

https://github.com/n6il/pyDriveWire


Drivewire/PyDriveWire is designed to work with real Coco's via the bit-banger port (in some cases a Deluxe RS232 Pak) or emulators/CoCo3FPGA via the Becker port.

Finally, you will need a Coco mass storage device, such as a Cloud-9 SuperIDE or Glenside IDE controller (real Coco's) or create a virtual HD image using tools such as 'dd' in Linux (for emulators).

The first step to is generate an index file of DSK images you wish to copy.  The script(s) included are designed to work with DSK image files obtained from the TRS-80 Color Computer Archive:

http://www.colorcomputerarchive.com/coco/Disks/


Once the index files are generated, you copy those and the DW2HD*.BAS programs to a DSK image you load on the Coco.  I wrote the DW2SD.BAS program to work with 80 column mode, so it's a Coco 3 only thing for now.  It could be modified for 32 column or even 64 column mode if using a CoCoVGA adapter on a Coco 1 or 2.  More information about the CoCoVGA can be found here:

http://www.cocovga.com/


I'll be creating a video of the entire process to share on Youtube.  Link to be posted soon.  For now, this repo is a WIP until I get a few more things completed.
