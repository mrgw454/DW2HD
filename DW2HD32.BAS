10 'Please reserve DRIVE0 for YA-DOS partition on SD/CF card or HD image file
20 'Please reserve DRIVE1 for Drivewire 0 (blank.dsk)
30 'Please reserve DRIVE2 for Drivewire 1 (DW2SD.DSK)
31 'Please reserve DRIVE3 for Drivewire 2 (AUTOEXEC.DSK)
40 '
140 CLS
150 '
160 CLEAR 1200 ' Reserve some STRING space
170 '
180 PRINT @0,"DW2HD Transfer Utility 1.6";
190 '
200 PRINT @64,"":LINE INPUT "Index file: ";D$
201 PRINT @64,"                                   "
210 PRINT @64,"":INPUT "Starting HD disk";M
220 '
240 R=1 'set DSK image index # counter
250 '
260 OPEN "I",#1,D$ 'Text file containing list of all DSK image names
270 IF EOF(1)=-1 THEN 610 'Check for EOF
280 '
290 INPUT #1,AA,A$,BB$,CC$,DD$,BB 'Read record from xxxxx.TXT
300 '
301 'Set disk image VOLUME label'
302 IF LEN(DD$)>8 THEN BB$=DD$
303 '
310 'Display output to screen
320 PRINT @64,A$;
330 '
340 'Set YA-DOS (DECB) with starting floppy disk image
350 DRIVE0:DRIVE.M
360 '
370 PRINT @192,"DW DSK";R;"to HDD DSK";M;"  ";
372 'LOCATE 1,9:PRINT "Disk Volume: ";BB$
373 '
380 PRINT @224,"";
390 '
400 C$="DISK INSERT 0 "+A$ 'Build Drivewire DW command string to mount the proper DSK image
410 DRIVE E 0,C$ 'Execute Drivewire DW command string to mount the proper DSK image
420 '
430 ' Slow way to perform a DSK to DSK copy
431 FOR T=0 TO 34
432 FOR S=1 TO 18
433 PRINT @416,"READ TRK";T;"SEC";S;"DSK 1";"  "
434 DSKI$ 1,T,S,S1$,S2$
435 PRINT @448,"WRTE TRK";T;"SEC";S;"DSK 0";"  "
436 DSKO$ 0,T,S,S1$,S2$
437 NEXT S
438 NEXT T
439 '
440 'Write the disk image VOLUME label'
443 RENAME DRIVE 0,BB$
444 '
448 'PRINT @448,"Disk ";M;" backup complete.          ";
449 '
450 'K$ = INKEY$:IF K$ = "" GOTO 450
460 '
470 PRINT @224,"";
480 '
490 DRIVE E 0,"DISK EJECT 0" 'Eject DSK image from Drivewire
500 '
510 M=M+1 'Increment YA-DOS floppy disk
520 IF M>255 GOTO 560
530 R=R+1
540 GOTO 290 'Loop through all index file records until EOF
550 '
560 ' Reached max capacity for floppy disk images on YA-DOS partition
570 PRINT @448,"Partition has reached max capacity ";M; "floppies";
580 CLOSE #1
590 END
600 '
610 CLOSE #1
620 END
