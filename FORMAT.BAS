0 PRINT "THIS FORMATS EACH SUBPARTITION"
1 PRINT "ON A DISK OF A YA-DOS MOUNT"
5 A=PEEK(&HD930)*256 + PEEK(&HD931)
6 IF A <> &H5941 GOTO 1000
7 A=PEEK(&HD932)*256 + PEEK(&HD933)
8 IF A <> &H4453 THEN 1000
10 PRINT "FORMAT WHICH MOUNT?"
20 INPUT X
25 IF X > 3 THEN 1010
26 IF X < 0 THEN 1010
27 DRIVE X
30 PRINT "HOW MANY DISKS?"
40 INPUT N
45 IF N > 256 THEN 1020
46 IF N < 1 THEN 1030
50 FOR D = 0 TO N-1
60 PRINT D;
70 DRIVE.D
80 DSKINI X
90 NEXT D
100 PRINT "DONE!"
110 SOUND 40,5
120 STOP
1000 PRINT "YA-DOS REQUIRED" : STOP
1010 PRINT "BAD MOUNT NO" : GOTO 10
1020 PRINT "TOO MANY DISKS" : GOTO 30
1030 PRINT "TOO FEW DISKS" : GOTO 30