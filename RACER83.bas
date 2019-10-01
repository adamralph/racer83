   10 MODE 1                                          : REM 320x256, 4 colours, 40x32 chars
   20 VDU 23,1,0;0;0;0;                               : REM switch off cursor
   30 ENVELOPE 1,7,2,1,1,1,1,1,121,-10,-5,-2,120,120  : REM level up
   40 ENVELOPE 2,1,2,-2,2,10,20,10,1,0,0,-1,100,100   : REM turn
   50 ENVELOPE 3,3,0,0,0,0,0,0,121,-10,-5,-2, 120,120 : REM pothole
   60 ENVELOPE 4,8,1,-1,1,1,1,1,121,-10,-5,-2,120,120 : REM crash
   61 KA$=CHR$(185)                                   : REM car symbol
   62 RD$=CHR$(191)                                   : REM road symbol
   63 HL$=CHR$(196)                                   : REM pothole symbol
   65 BC$=" "                                         : REM blank char
   67 BL$="                                       "   : REM blank line
   66 RG$="        "                                  : REM road gap
   70 KA=19                                           : REM car position
   80 OK=KA                                           : REM old car position
   90 RD=14                                           : REM road position
  100 NG=0                                            : REM turn angle
  110 LV=0                                            : REM level
  120 MT=-20                                          : REM metres
  121 REM begin game loop
  130 REPEAT
  140   SOUND &10,-11,7,10:MT=MT+1:IF (MT) MOD 100=0 AND LV<20 THEN LV=LV+1:SOUND &11,1,LV*5,100
  141   RP=INT(RD):R$=STRING$(RP+1,RD$)+RG$+STRING$(29-RP,RD$):S$=" L"+STR$(LV)+": "+STR$(MT)+" m ":REM *FX 19
  180   COLOUR 2:PRINT TAB(1, 2) BL$:PRINT TAB(1, 31) R$:PRINT TAB(OK,9) BC$:COLOUR 3:PRINT TAB(KA,10) KA$:COLOUR 129:PRINT TAB(15,0) S$:COLOUR 128
  181   IF MT MOD (21-LV)=0 THEN COLOUR 1:PRINT TAB(RD+1+RND(8),30) HL$:SOUND &13,3,200,20
  220   IF KA<>OK THEN SOUND &12,2,110,20
  260   OK=KA:IF INKEY(-66) AND KA>1 THEN KA=KA-1 ELSE IF INKEY(-82) AND KA<38 THEN KA=KA+1
  290   RD=RD+NG:IF RD<1 THEN RD=1 ELSE IF RD>27 THEN RD=27
  310   IF RND(10)=1 THEN NG=RND(1)-0.5:IF (RD=1 AND NG<0) OR (RD=27 AND NG>0) THEN NG=0-NG
  340 UNTIL POINT((KA*32)+16,671)<>0
  341 REM end game loop
  342 VDU 19,0,1,0,0,0
  360 SOUND &310,4,6,100
  370 SOUND &311,4,0,100
  380 SOUND &312,4,10,100
  390 SOUND &313,4,160,100
  400 COLOUR 3:COLOUR 129
  410 PRINT TAB(6,14) "                           "
  420 PRINT TAB(6,15) "         GAME OVER!        "
  430 PRINT TAB(6,16) "                           "
  440 PRINT TAB(6,17) " Press SPACE to play again "
  450 PRINT TAB(6,18) "                           "
  451 VDU 19,0,0,0,0,0
  460 REPEAT UNTIL INKEY(-99)
  470 RUN
