    5 MODE 1                                          : REM 320x256, 4 colours, 40x32 chars
    6 VDU 23,1,0;0;0;0;                               : REM switch off cursor
    7 SOUND &11,1,120,100
   10 COLOUR 2
   12 PRINT TAB(6,4)  "###        #####            "
   13 PRINT TAB(6,5)  "###   ##########            "
   14 PRINT TAB(6,6)  "################            "
   15 PRINT TAB(6,7)  " #########################  "
   16 PRINT TAB(6,8)  "   ####  ##############  ###"
   17 PRINT TAB(6,9)  "    ###  ##############  ###"
   18 PRINT TAB(6,10) "      ####            ####  "
   20 COLOUR 1
   30 PRINT TAB(2,14) "  __                     "
   40 PRINT TAB(2,15) " /  |                    "
   50 PRINT TAB(2,16) "(___| ___  ___  ___  ___ "
   60 PRINT TAB(2,17) "|\   |   )|    |___)|   )"
   70 PRINT TAB(2,18) "| \  |__/||__  |__  |    "
   80 COLOUR 2
   90 PRINT TAB(28,14) "  __   __ "
  100 PRINT TAB(28,15) " /  |    |"
  110 PRINT TAB(28,16) "(___| ___|"
  120 PRINT TAB(28,17) "|   )    )"
  130 PRINT TAB(28,18) "|__/  __/ "
  140 COLOUR 3
  141 PRINT TAB(10,24) "Press SPACE to play"
  142 ENVELOPE 1,7,2,1,1,1,1,1,121,-10,-5,-2,120,120  : REM level up
  143 ENVELOPE 2,1,2,-2,2,10,20,10,1,0,0,-1,100,100   : REM turn
  144 ENVELOPE 3,3,0,0,0,0,0,0,121,-10,-5,-2,120,120  : REM pothole
  145 ENVELOPE 4,8,1,-1,1,1,1,1,121,-10,-5,-2,120,120 : REM crash
  155 REPEAT UNTIL INKEY(-99)
  160 SOUND &11,1,100,100
  170 CLS
  180 VDU 19,1,9,0,0,0
  230 KA$=CHR$(185)                                   : REM car symbol
  240 RD$=CHR$(191)                                   : REM road symbol
  250 DIM HL$(8)                                      : REM pothole symbols
  260 HL$(0)=CHR$(196)
  270 HL$(1)=CHR$(203)
  280 HL$(2)=CHR$(175)
  290 HL$(3)=CHR$(191)
  300 HL$(4)=CHR$(185)
  310 HL$(5)=CHR$(184)
  320 HL$(6)=CHR$(220)
  330 HL$(7)=CHR$(255)
  340 BC$=" "                                         : REM blank char
  350 RG$="        "                                  : REM road gap
  360 KA=19                                           : REM car position
  370 OK=KA                                           : REM old car position
  380 RD=14                                           : REM road position
  390 NG=0                                            : REM turn angle
  400 LV=0                                            : REM level
  410 MT=-20                                          : REM metres
  420 REM begin game loop
  430 REPEAT
  440   SOUND &10,-11,7,10:MT=MT+1:IF (MT) MOD 100=0 THEN LV=LV+1:SOUND &11,1,LV*5,100:VDU 19,2,(LV MOD 8)+1,0,0,0:IF LV > 10 THEN *FX 9,50
  450   RP=INT(RD):R$=STRING$(RP+1,RD$)+RG$+STRING$(29-RP,RD$):S$=" L"+STR$(LV)+": "+STR$(MT)+" m ":REM *FX 19
  460   COLOUR 2:PRINT TAB(1, 31) R$:PRINT TAB(OK,9) BC$:COLOUR 3:PRINT TAB(KA,10) KA$:COLOUR 0:COLOUR 131:PRINT TAB(15,0) S$:COLOUR 128
  470   IF LV>20 THEN COLOUR 1:PRINT TAB(RD+1+RND(8),30) HL$(RND(8)-1):VDU 19,1,(LV MOD 3)+9,0,0,0:SOUND &13,3,220,20 ELSE IF MT MOD (21-LV)=0 THEN COLOUR 1:PRINT TAB(RD+1+RND(8),30) HL$((LV-1) MOD 8):SOUND &13,3,200,20
  480   IF KA<>OK THEN SOUND &12,2,110,20
  490   OK=KA:IF INKEY(-66) AND KA>1 THEN KA=KA-1 ELSE IF INKEY(-82) AND KA<38 THEN KA=KA+1
  500   RD=RD+NG:IF RD<1 THEN RD=1 ELSE IF RD>27 THEN RD=27
  510   IF RND(10)=1 THEN NG=RND(1)-0.5:IF (RD=1 AND NG<0) OR (RD=27 AND NG>0) THEN NG=0-NG
  520 UNTIL POINT((KA*32)+16,671)<>0
  530 REM end game loop
  540 VDU 19,0,7,0,0,0
  550 SOUND &310,4,6,100
  560 SOUND &311,4,0,100
  570 SOUND &312,4,10,100
  580 SOUND &313,4,160,100
  590 COLOUR 0:COLOUR 131
  600 PRINT TAB(6,14) "                           "
  610 PRINT TAB(6,15) "         GAME OVER!        "
  620 PRINT TAB(6,16) "                           "
  630 PRINT TAB(6,17) "  Press SPACE to continue  "
  640 PRINT TAB(6,18) "                           "
  660 VDU 19,0,0,0,0,0
  670 REPEAT UNTIL INKEY(-99)
  680 RUN
