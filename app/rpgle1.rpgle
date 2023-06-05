**free

dcl-s var1 char(15)  inz(*blanks);
dcl-s var2 char(10)  inz(*blanks);

exsr startpgm;

begsr startpgm;
  var1 = 'RB'
  var2 = 'Er en bot'
endsr;

/endfree