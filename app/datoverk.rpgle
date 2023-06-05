       //%CSTD===========================================================*
       //* Application. : NICE       SpareBank 1 Skadeforsikring         *
       //* Component. . : DATOVERK                      Type: RPGLE      *
       //*===============================================================*
       //* Sub-system . :                                                *
       //* Function . . :                                                *
       //* Sub-function :                                                *
       //*%S=============================================================*
       //* Description of functions:                                     *
       //*                                                               *
       //*                                                               *
       //*                                                               *
       //*%E=============================================================*
       //* AUTHOR:    A5050RE    13.02.2023 08:28  SB.00.00              *
       //* MODIFS: 01 A5050RE    13.02.2023 08:28  SB.00.00    00/       *
       //*         ** A5050RE    13.02.2023 13:11  23.02.00    00/       *
       //%ECSTD==========================================================*
       //
       /COPY HCOPYS1S
       ctl-opt nomain;
       /include prototyper,DATOVERK

      //***********************************************************************
       dcl-proc DATOVERK_1paaskedag export;

         dcl-pi *n ;
           pInnData likeds(dvInnDataDs);
           pUtData likeds(dvUtDataDs);
        end-pi;

         dcl-s arr         int(5) dim(13) inz(*zeros);
         dcl-s saar        int(5) inz(*zeros);
         dcl-s p1paaske    char(10);
         dcl-s wp1paaske   date(*iso);
         dcl-s n           int(5) inz(*zeros);
         dcl-s p           int(5) inz(*zeros);

         dcl-s aar         char(4);
         dcl-s maaned      char(2);
         dcl-s dag         char(2);

           arr(1)  = pInnData.InnDatoAar;  //input år xxxx fra kallende program
           saar    = %rem(arr(1):4);
           arr(2)  = %rem(arr(1):19);
           arr(3)  = arr(1)/100;
           arr(4)  = %rem(arr(1):100);
           arr(5)  = arr(3)/4;
           arr(6)  = %rem(arr(3):4);
           arr(7)  = (arr(3)+8)/25;
           arr(8)  = (arr(3)-arr(7)+1)/3;
           arr(9)  = %rem(19*arr(2)+arr(3)-arr(5)-arr(8)+15:30);
           arr(10) = arr(4)/4;
           arr(11) = %rem(arr(4):4);
           arr(12) = %rem(32 + 2*arr(6) + 2*arr(10) - arr(9) - arr(11):7);
           arr(13) = (arr(2)+11*arr(9)+22*arr(12))/451;
           n = (arr(9)+arr(12)-7*arr(13)+114)/31;
           p =  %rem(arr(9)+arr(12)-7*arr(13)+114:31);
           p = p +1;

           aar =    %subst(%editc(arr(1): 'X') : 2 : 4);
           maaned = %subst(%editc(n: 'X') : 4 : 2);
           dag =    %subst(%editc(p: 'X') : 4 : 2);

           p1paaske = %char(%trim(aar +'-'+ maaned +'-'+ dag));
           wp1paaske = %date(p1paaske); //første påskedag

         pUtData.UtDatoPaaskedag = wp1paaske;
         return;

       end-proc DATOVERK_1paaskedag;

      *************************************************************************
      *************************************************************************



      //***********************************************************************
       dcl-proc DATOVERK_ukedag export;

         dcl-pi *n ;
           pInnData likeds(dvInnDataDs2);
           pUtData  likeds(dvUtDataDs2);
         end-pi;

           dcl-s wFeilmeld     char(20);
           dcl-s wIndikator    ind;
           dcl-s wInnDato      date(*iso);
           dcl-s wUkedag       char(7);

           dcl-s w_RefDato    date inz(D'0001-01-01');
           dcl-s dagNummer    packed(1:0) inz(9);

           wInnDato = pinndata.innDato;

           TEST(E) wInnDato;
            IF %ERROR;
               wIndikator = *on;
               wFeilmeld = 'Ugyldig dato';
               return;
            else;
               dagnummer = %rem(%diff(wInnDato : w_RefDato : *DAYS) : 7) + 1;
               wIndikator = *off;
               //wFeilmeld = 'OK';
            endif;

           if dagnummer =     1;
             wUkedag = 'Mandag';
             wFeilmeld = ' OK - Mandag';
           elseif dagnummer = 2;
             wUkedag = 'Tirsdag';
             wFeilmeld = 'OK - Tirsdag';
           elseif dagnummer = 3;
             wUkedag = 'Onsdag';
             wFeilmeld = 'OK - Onsdag';
           elseif dagnummer = 4;
             wUkedag = 'Torsdag';
             wFeilmeld = 'OK - Torsdag';
           elseif dagnummer = 5;
             wUkedag = 'Fredag';
             wFeilmeld = 'OK - Fredag';
           elseif dagnummer = 6;
             wUkedag = 'Lørdag';
             wFeilmeld = 'Lørdag';
             wIndikator = *on;
           elseif dagnummer = 7;
             wUkedag = 'Søndag';
             wFeilmeld = 'Søndag';
             wIndikator = *on;
           endif;


           putData.Feilmeld  = %trim(wFeilmeld);
           putData.Indikator = wIndikator;
           putData.Ukedag    = wUkedag;

           return;
       end-proc DATOVERK_ukedag;
      *************************************************************************
      *************************************************************************

      //***********************************************************************
       dcl-proc DATOVERK_rode_dager export;

          dcl-pi *n ;
           pInnData likeds(dvInnDataDs3);
           pUtData  likeds(dvUtDataDs3);
         end-pi;

           dcl-s wInnDato             date(*iso);
           dcl-s aar                  char(4);
           dcl-s wp1paaske            date(*iso);
           dcl-s wFeilmeld            char(20);
           dcl-s wIndikator           ind;

           wInnDato = pInnData.InnDato;
           aar =   %char(%subdt(wInnDato:*YEARS));
           // hardkodede røde datoer for utsendelser
           if wInnDato =
                %date(aar + '-01-01');
                wFeilmeld = 'Første Nyttårsdag';
                wIndikator = *on;
           elseif wInnDato =
                %date(aar + '-05-01');
                wFeilmeld = 'Første Mai';
                wIndikator = *on;
           elseif wInnDato =
                %date(aar + '-05-17');
                wFeilmeld = '17. Mai';
                wIndikator = *on;
           elseif wInnDato =
                %date(aar + '-12-24');
                wFeilmeld = 'Julaften';
                wIndikator = *on;
           elseif wInnDato =
                %date(aar + '-12-25');
                wFeilmeld = 'Første juledag';
                wIndikator = *on;
           elseif wInnDato =
                %date(aar + '-12-26');
                wFeilmeld = 'Andre juledag';
                wIndikator = *on;
           endif;

           // røde datoer basert på utregning fra 1.ste påskedag
           dvInnDataDs.InnDatoAar = %int(aar);
           DATOVERK_1paaskedag(dvInnDataDs:dvutDataDS);
           wp1paaske = dvutDataDS.UtDatoPaaskedag;
           if wInnDato =
                wp1paaske + %days(1);
                wFeilmeld = 'Andre påskedag';
                wIndikator = *on;

           elseif wInnDato =
                wp1paaske - %days(3);
                wFeilmeld = 'Skjærtorsdag';
                wIndikator = *on;

           elseif wInnDato =
                wp1paaske - %days(2);
                wFeilmeld = 'Langfredag';
                wIndikator = *on;

           elseif wInnDato =
                wp1paaske + %days(39);
                wFeilmeld = 'Kristi Himmelfartsdag';
                wIndikator = *on;

           elseif wInnDato =
                wp1paaske + %days(50);
                wFeilmeld = 'Andre pinsedag';
                wIndikator = *on;
           endif;

           putData.Feilmeld  = %trim(wFeilmeld);
           putData.Indikator = wIndikator;
          return;

       end-proc DATOVERK_rode_dager;

      *************************************************************************
      *************************************************************************

      *************************************************************************

          dcl-proc DATOVERK_arbeidsdager export;


               dcl-pi *n ;
                   pInnData likeds(dvInnDataDs4);
                   pUtData  likeds(dvUtDataDs4);
               end-pi;

              dcl-s wInnDato             date(*iso);
              dcl-s wFeilmeld            char(30);
              dcl-s wIndikator           ind;

              wInndato =  pInnData.InnDato;

              exsr sjekkdato;
              putData.Feilmeld  = %trim(wFeilmeld);
              putData.Indikator = wIndikator;

              return;



              begsr sjekkdato;

              dvInnDataDS2.InnDato = wInndato;
              DATOVERK_ukedag(dvInnDataDs2:dvutDataDS2);
              if dvutDataDS2.Indikator = *on;
                wFeilmeld = dvutDataDs2.Feilmeld;
                wIndikator =  *on;
                leavesr;
              else;

                wFeilmeld = dvutDataDs2.Feilmeld;
                wIndikator =  *off;
              endif;

              dvInnDataDS3.InnDato = wInndato;
              DATOVERK_rode_dager(dvInnDataDs3:dvutDataDS3);
              if dvutDataDS3.Indikator = *on;
                wFeilmeld = dvutDataDs3.Feilmeld;
                wIndikator =  *on;
                leavesr;
              else;
                wFeilmeld = dvutDataDs3.Feilmeld;
                wIndikator =  *off;
              endif;

              endsr;



          end-proc DATOVERK_arbeidsdager;
      *************************************************************************
      *************************************************************************