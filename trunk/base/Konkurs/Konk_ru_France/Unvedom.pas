unit UnVedom;     //Ведомость тренировки

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  Grids, Printers, UnOther, StdCtrls, ExtCtrls, UnOcenka;

type
  TZapis = record
    NumOfEx: string[10]; //Номер упражнения
    tzDate: string[12]; // Дата
    tzTime: string[12]; // Время
    VoenCh: string[8]; // Воинская часть
    Rota: string[5]; // Рота
    Vzvod: string[5]; // Взвод
    VidOruzh:array[1..5]of string[10]; //Вид оружия
    TimeOfMission: string[6]; // Время выполнения задачи
    TimeOfFirstShoot: string[3]; //Время первого выстрела
    Rang1: string[15]; //  Звание обучаемого
    Rang2: String[15];
//    Rang3: String[15];
    SurnameKom: String[16]; // Фамилия командира
    SurnameNav: String[16]; // Фамилия наводчика
//    SurnameMV:  String[16];
    Col_Mish: string[3];  // Число  мишеней В ЗАДАЧЕ
    Type_Mish: array[1..10] of string[10];// Tип мишеней
    Col_Poraj_Mish: string[3];  // Число пораженных мишеней
    Vid_Poraj_Oruzh: array[1..10] of string[10];
    Type_Poraj_Mish: array[1..10] of string[10];// Tип пораженных мишеней
    sbpPKT: array[1..10] of string[3]; // Расход на каждую мишень ПКТ
    sbpOF:  array[1..10] of string[3]; // Расход на каждую мишень OF
    sbpBR:  array[1..10] of string[3]; // Расход Б
    sbpU:   array[1..10] of string[3]; // Расход У
    sbpKUM: array[1..10] of string[3]; //
    LessonMark: string[2]; //Оценка за стрельбу
  end;
  TVedom = class(TForm)
    Button6: TButton;
    Button2: TButton;
    Panel1: TPanel;
    StringGrid1: TStringGrid;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    File_Name_Vedom : string;
    procedure Init_Grid;
    procedure Resort;
    procedure WriteRecIn(reco: TZapis); //Процедура, пишущая в файл из записи reco
    { Public declarations }
  end;
var
  Vedom: TVedom;
//  Zap_Ved: array[1..3] of TZap_Ved;
  Zapis: array[1..3] of TZapis;
  dx: word;
  dy: word;
  systime: TSYSTEMTIME;
  Print_vedom: boolean;
  Index: word;
  Temp,Ceson,Mestn: word;
  Zap_Ved: TZapis;
  File_Vedom: file of TZapis;

const
  ddx = 1;
  ddy = 1;
  deltax = 100;
  deltay = 100;
implementation
uses Main;
{$R *.DFM}
procedure TVedom.FormCreate(Sender: TObject);
var a, b, n: word;
begin
   for a:=1 to 3 do begin
     Zapis[a].Col_Mish:='';
     Zapis[a].Col_Poraj_Mish:='';
     Zapis[a].LessonMark:='';
     for b:=1 to 10 do begin
       Zapis[a].Type_Mish[b]:='';
       Zapis[a].Vid_Poraj_Oruzh[b]:='';
       Zapis[a].Type_Poraj_Mish[b]:='';
       Zapis[a].sbpPKT[b]:='';
       Zapis[a].sbpOF[b]:='';
       Zapis[a].sbpU[b]:='';
       Zapis[a].sbpBR[b]:='';
       Zapis[a].sbpKUM[b]:='';
     end;
   end;
  GetLocalTime(systime);
  Zapis[1].NumOfEx:='';
  case Task.m_index of
    1111,1112,1113:   Zapis[1].NumOfEx:='УУС1';
    1121,1122,1123:   Zapis[1].NumOfEx:='УУС2';
    1131,1132,1133:   Zapis[1].NumOfEx:='УУС3';
    1211,1212,1213:   Zapis[1].NumOfEx:='УКС1';
    1221,1222,1223:   Zapis[1].NumOfEx:='УКС2';

    2111,2112,2113:   Zapis[1].NumOfEx:='УНС1';
    2121,2122,2123:   Zapis[1].NumOfEx:='УНС2';
    2131,2132,2133:   Zapis[1].NumOfEx:='УНС3';
    2141,2142,2143:   Zapis[1].NumOfEx:='УНС4';
    2151,2152,2153:   Zapis[1].NumOfEx:='УНС5';
    2161,2162,2163:   Zapis[1].NumOfEx:='УНС6';

    2211,2212,2213:   Zapis[1].NumOfEx:='УПС1';
    2221,2222,2223:   Zapis[1].NumOfEx:='УПС2';
    2231,2232,2233:   Zapis[1].NumOfEx:='УПС3';
    2241,2242,2243:   Zapis[1].NumOfEx:='УПС4';
    2251,2252,2253:   Zapis[1].NumOfEx:='УПС5';
  end;
  Zapis[1].VoenCh:=Form1.VoenCh;
  Zapis[1].Rota:=Form1.Rota;
  Zapis[1].Vzvod:=Form1.Vzvod;

  Zapis[1].tzDate:=IntToStr(systime.wDay)+'/'+IntToStr(systime.wMonth)+'/'+IntToStr(systime.wYear)+' г.';
  Zapis[2].tzDate:=IntToStr(systime.wDay)+'/'+IntToStr(systime.wMonth)+'/'+IntToStr(systime.wYear)+' г.';
  Zapis[3].tzDate:=IntToStr(systime.wDay)+'/'+IntToStr(systime.wMonth)+'/'+IntToStr(systime.wYear)+' г.';

  Zapis[1].SurnameKom:=Form1.Name[1][1];
  Zapis[2].SurnameKom:=Form1.Name[2][1];
  Zapis[3].SurnameKom:=Form1.Name[3][1];

  Zapis[1].SurnameNav:=Form1.Name[1][2];
  Zapis[2].SurnameNav:=Form1.Name[2][2];
  Zapis[3].SurnameNav:=Form1.Name[3][2];

//  Zapis[1].SurnameMV:=Form1.Name[1][3];
//  Zapis[2].SurnameMv:=Form1.Name[2][3];
//  Zapis[3].SurnameMv:=Form1.Name[3][3];

  for a:=1 to 3 do begin
    Zapis[a].Rang1:=Form1.Zvanie[a,1];
    Zapis[a].Rang2:=Form1.Zvanie[a,2];
//    Zapis[a].Rang3:=Form1.Zvanie[a,3];

    Zapis[a].VidOruzh[1]:='PKT';
    Zapis[a].VidOruzh[2]:='HES';
    Zapis[a].VidOruzh[3]:='APS';
    Zapis[a].VidOruzh[4]:='GM';
    Zapis[a].VidOruzh[5]:='HEAT';

    Zapis[a].TimeOfMission:=inttostr(Task.Tstr);
    Zapis[a].Col_Mish:=inttostr(Task.Col_targ);
    if Ocenka[a].Oc>0 then Zapis[a].LessonMark:=inttostr(Ocenka[a].Oc)
                            else Zapis[a].LessonMark:='';
    for b:=1 to Task.Col_targ do begin
      Zapis[a].Type_Mish[b]:=Name_Target_rus(Task.Target[a,b].Num);
    end;
    Zapis[a].sbpU[1]:=inttostr(Task.Bk.Col_UPR-Boek[a].Col_UPR);

    for b:=1 to Ocenka[a].col_PTUR do begin
      n:=Ocenka[a].num_PTUR[b];
      Zapis[a].Vid_Poraj_Oruzh[n]:='PTUR';
      Zapis[a].Type_Poraj_Mish[n]:='1';
    end;
  end;
//  Zapis[1].TimeOfFirstShoot:=inttostr(Edit29.tag);
//  Zapis[2].TimeOfFirstShoot:=inttostr(Edit30.tag);
//  Zapis[3].TimeOfFirstShoot:=inttostr(Edit31.tag);
  WriteRecIn(Zapis[2]);
  File_Name_Vedom:='data.txt';
  Init_Grid;
end;

procedure TVedom.FormPaint(Sender: TObject);
var
  i,j,p: integer;
  razb: real;
  colmish: real;
  sbppkt_chisl: array[1..10] of real;
  sbpog_chisl: array[1..10] of real;
  sbpbr_chisl: array[1..10] of real;
  sbpptur_chisl: array[1..10] of real;
  summa1,summa2, summa3,summa4,summa5: string;
  summast1,summast2,summast3,summast4,summast5: real;
  s: string;
begin
  if Panel1.Visible then exit;
  dx:=10;
  dy:=10;
  razb:=0;
  summast1:=0;
  summast2:=0;
  summast3:=0;
  summast4:=0;
  summast5:=0;
  with Canvas do begin
  // Вывод шапки ведомости
    Font.Size:=12;
    TextOut(50*dx,dy,'Bulletin');
    if index<1200 then TextOut(31*dx,3*dy,'du compte des resultats de l''execution tir d''exercice');
    if (index>1200)and(index<1300) then
                     TextOut(31*dx,3*dy,'du compte des resultats de l''execution tir de controle');
    if index>1300 then
                     TextOut(31*dx,3*dy,'du compte des resultats de l''execution tir');
    TextOut(29*dx,6*dy,'"'+Zap_Ved.NumOfEx+'"');
    Font.Size:=8;
    if Temp=DAY then s:='(de jour,' else s:='(la nuit,';
    if Ceson=SUMMER then s:=s+' en ete,' else s:=s+' en hiver,';
    if Mestn=GORA then s:=s+' dans les montagnes,' else s:=s+' sur la plaine,';
    s:=s+' A simulateur TREKON )';
    TextOut(40*dx,9*dy,s);
    TextOut(50*dx,14*dy,'(subdivision)');
    TextOut(52*dx,18*dy,'( Date )');
    Font.Size:=12;
    TextOut(45*dx,12*dy,Zap_Ved.Rota+' compagnie, '+Zap_Ved.Vzvod+' section, corps de troupe '+Zap_Ved.VoenCh);
    TextOut(50*dx,16*dy,IntToStr(systime.wDay)+'.'+IntToStr(systime.wMonth)+'.'+IntToStr(systime.wYear)+' .');

    // Рисование таблицы
    MoveTo(dx,21*dy); LineTo(101*dx,21*dy);////
    MoveTo(dx,33*dy); LineTo(101*dx,33*dy);  // Рисование основных
//    MoveTo(dx,45*dy); LineTo(101*dx,45*dy);  // горизонтальных
    MoveTo(dx,57*dy); LineTo(101*dx,57*dy);  // линийй
//    MoveTo(dx,69*dy); LineTo(101*dx,69*dy);////

    MoveTo(dx,21*dy); LineTo(dx,57*dy);         ////
    MoveTo(3*dx,21*dy); LineTo(3*dx,57*dy);       //
    MoveTo(17*dx,21*dy); LineTo(17*dx,57*dy);     //Рисование основных
    MoveTo(24*dx,21*dy); LineTo(24*dx,57*dy);     //
    MoveTo(30*dx,21*dy); LineTo(30*dx,57*dy);     // вертикальных
    MoveTo(36*dx,21*dy); LineTo(36*dx,57*dy);     //
    MoveTo(66*dx,21*dy); LineTo(66*dx,57*dy);     // линий
    MoveTo(74*dx,21*dy); LineTo(74*dx,57*dy);     //
    MoveTo(94*dx,21*dy); LineTo(94*dx,57*dy);     //
    MoveTo(101*dx,21*dy); LineTo(101*dx,57*dy); ////

    MoveTo(36*dx,25*dy); LineTo(66*dx,25*dy); //Рисование доп. гор. линии в графе 'Поражение целей'
    MoveTo(74*dx,25*dy); LineTo(94*dx,25*dy); //Рисование доп. гор. линии в графе 'Расход боеприпасов'
    MoveTo(84*dx,25*dy); LineTo(84*dx,57*dy); //Рисование доп. верт. линии в графе 'Расход боеприпасов'
    //Заполнение шапки таблицы
    Font.Size:=10;
    TextOut(dx+5*ddx,26*dy,'N');      // ?????? ?????
    TextOut(6*dx,22*dy,'poste,'); ////
    TextOut(6*dx,24*dy,'le grade');     // ??????
    TextOut(6*dx,26*dy,'militaire');       //
    TextOut(6*dx,28*dy,'nom de famille');      // ?????
    TextOut(6*dx,30*dy,'et les initiales'); ////
    TextOut(18*dx,25*dy,'La variete');       //// ??????
    TextOut(18*dx,27*dy,'de l''arme');    //// ?????
    TextOut(25*dx,23*dy,'Le temps');    ////
    TextOut(25*dx,25*dy,'pour');         // ?????????
    TextOut(25*dx,27*dy,'le');    // ?????
    TextOut(25*dx,29*dy,'tir');       ////
    TextOut(31*dx,23*dy,'Le temps');         ////
    TextOut(30*dx+5*ddx,25*dy,'du premier');   // ?????
    TextOut(30*dx+5*ddx,27*dy,'coup');   // ?????
    TextOut(30*dx+5*ddx,29*dy,'de feu');      ////
    TextOut(45*dx,22*dy,'La defaite des buts'); // ?????? ?????
    TextOut(67*dx,26*dy,'L''estimation');  // ??????? ?????
    TextOut(78*dx,22*dy,'La depense des munitions'); ////
    TextOut(76*dx,26*dy,'le canon?? ?????');             // ???????
    TextOut(75*dx,28*dy,'(obus,');           //
    TextOut(75*dx,30*dy,'grenades)');              // ?????
    TextOut(87*dx,26*dy,'cartouches');              ////
    TextOut(95*dx,22*dy,'Les re-');
    TextOut(95*dx,24*dy,'marques');
    TextOut(95*dx,26*dy,'du');
    TextOut(95*dx,28*dy,'chef');
    // ?????????? ???? ???????
    for i:=1 to 1 do begin
      dy:=10;
      TextOut(2*dx,(27+12*i)*dy+30,inttostr(i));
      if Zap_Ved.SurnameNav<>'' then begin                   //// Вторая
        font.Size:=8;
        TextOut(4*dx,(27*ddy+15*i)*dy,'Commander '+Zap_Ved.Rang1);
        font.Size:=10;
        TextOut(6*dx,(29*ddy+15*i)*dy,Zap_Ved.SurnameKom);
      end;                                                  //// графа
      if Zap_Ved.SurnameKom<>'' then begin                   //// Вторая
        font.Size:=8;
        TextOut(4*dx,(32*ddy+15*i)*dy,'Pointer '+Zap_Ved.Rang2);
        font.Size:=10;
        TextOut(6*dx,(34*ddy+15*i)*dy,Zap_Ved.SurnameNav);
      end;
//      if Zap_Ved[i].SurnameMV<>'' then begin                   //// Вторая
//        font.Size:=8;
//        TextOut(4*dx,(37*ddy+15*i)*dy,'Мех.-вод. '+Zap_Ved[i].Rang3);
//        font.Size:=10;
//        TextOut(6*dx,(39*ddy+15*i)*dy,Zap_Ved[i].SurnameMV);
//      end;
      dy:=12;
      if Zap_Ved.VidOruzh[1]<>'' then                   ////
          TextOut(18*dx,(23+12*i)*dy,Zap_Ved.VidOruzh[1]);  // Третья
      if Zap_Ved.VidOruzh[2]<>'' then                     // графа
          TextOut(18*dx,(25+12*i)*dy,Zap_Ved.VidOruzh[2]);  //
      if Zap_Ved.VidOruzh[3]<>'' then                     //
          TextOut(18*dx,(27+12*i)*dy,Zap_Ved.VidOruzh[3]);  //
      if Zap_Ved.VidOruzh[4]<>'' then                     //
          TextOut(18*dx,(29+12*i)*dy,Zap_Ved.VidOruzh[4]);  //
      if Zap_Ved.VidOruzh[4]<>'' then                     //
          TextOut(18*dx,(31+12*i)*dy,Zap_Ved.VidOruzh[5]);////

      if Zap_Ved.TimeOfMission<>'' then                     //// Четвертая
        TextOut(26*dx,(26+12*i)*dy,Zap_Ved.TimeOfMission);  //// графа
      if Zap_Ved.TimeOfFirstShoot<>'' then                     //// Пятая
        TextOut(32*dx,(26+12*i)*dy,Zap_Ved.TimeOfFirstShoot);  //// графа
      Val(Zap_Ved.Col_Mish,colmish,p);
      if (colmish <> 0)  then razb:=30/(colmish);                                                              ////
      for j:=1 to round(colmish) do begin
        //if Print_vedom then else
        dy:=10;
        if j<>round(colmish) then begin                                            //
          MoveTo(36*dx+j*Round(razb*dx),25*dy); LineTo(36*dx+j*Round(razb*dx),57*dy);      // Шестая
        end;
        TextOut(36*dx+round((j-0.5)*Round(razb*dx)-dx),28*dy,Zap_Ved.Type_Mish[j]);             //
        dy:=12;
        if Zap_Ved.Vid_Poraj_Oruzh[j] = 'PKT' then begin
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(23+12*i)*dy,Zap_Ved.Type_Poraj_Mish[j]);
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(25+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(27+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(29+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(31+12*i)*dy,'0');
        end;
        if Zap_Ved.Vid_Poraj_Oruzh[j] = 'OF' then begin
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(23+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(25+12*i)*dy,Zap_Ved.Type_Poraj_Mish[j]);
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(27+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(29+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(31+12*i)*dy,'0');
        end;
        if Zap_Ved.Vid_Poraj_Oruzh[j] = 'BR' then begin
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(23+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(25+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(27+12*i)*dy,Zap_Ved.Type_Poraj_Mish[j]);
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(29+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(31+12*i)*dy,'0');
        end;
        if Zap_Ved.Vid_Poraj_Oruzh[j] = 'U' then begin
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(23+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(25+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(27+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(29+12*i)*dy,Zap_Ved.Type_Poraj_Mish[j]);
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(31+12*i)*dy,'0');
        end;
        if Zap_Ved.Vid_Poraj_Oruzh[j] = 'KUM' then begin
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(23+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(25+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(27+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(29+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(31+12*i)*dy,Zap_Ved.Type_Poraj_Mish[j]);
        end;
        if Zap_Ved.Type_Poraj_Mish[j] = '' then begin                                        //
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(23+12*i)*dy,'0');                      //
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(25+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(27+12*i)*dy,'0');                      //
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(29+12*i)*dy,'0');
          TextOut(36*dx+round((j-0.5)*Round(razb*dx)),(31+12*i)*dy,'0');
        end;
      end;
      if Zap_Ved.LessonMark<>'' then                     //// Седьмая
        TextOut(69*dx,(28+10*i)*dy,Zap_Ved.LessonMark);  //// графа
      for j:=1 to 10 do begin                          ////
        Val(Zap_Ved.sbpPKT[j],sbppkt_chisl[j],p);     //
        summast1:=summast1+sbppkt_chisl[j];            //
        Val(Zap_Ved.sbpOF[j],sbpog_chisl[j],p);   //
        summast2:=summast2+sbpog_chisl[j];
        Val(Zap_Ved.sbpBR[j],sbpbr_chisl[j],p);     //
        summast3:=summast3+sbpbr_chisl[j];            //
        Val(Zap_Ved.sbpU[j],sbpptur_chisl[j],p);   //
        summast4:=summast4+sbpptur_chisl[j];           // Восьмая
        Val(Zap_Ved.sbpKUM[j],sbpptur_chisl[j],p);   //
        summast5:=summast5+sbpptur_chisl[j];           // Восьмая
      end;                                               //
        Str(summast1:3:0,summa1);                        //
        Str(summast2:3:0,summa2);
        Str(summast3:3:0,summa3);                        //
        Str(summast4:3:0,summa4);                        //
        Str(summast5:3:0,summa5);                        //
        TextOut(89*dx,(23+12*i)*dy,summa1);              //
        TextOut(78*dx,(25+12*i)*dy,summa2);
        TextOut(78*dx,(27+12*i)*dy,summa3);
        TextOut(78*dx,(29+12*i)*dy,summa4);              //
        TextOut(78*dx,(31+12*i)*dy,summa5);              // графа
        summast1:=0;                                     //
        summast2:=0;
        summast3:=0;                                     //
        summast4:=0;                                     ////
        summast5:=0;                                     ////
    end;
  end;
end;

procedure TVedom.Button6Click(Sender: TObject);
begin
  Print_vedom:=true;
  Button1.Visible:=false;
  Button2.Visible:=false;
  Button6.Visible:=false;
  Printer.Orientation:=poLandscape;
  Print;
  Button1.Visible:=true;
  Button2.Visible:=true;
  Button6.Visible:=true;
  Print_vedom:=false;
end;

procedure TVedom.Init_Grid;
var a: word;
begin
  StringGrid1.Cells[0,0]:='numero';
  StringGrid1.Cells[1,0]:='Unite, compagnie, section';
  StringGrid1.Cells[2,0]:='Chef';
  StringGrid1.Cells[3,0]:='Pointeur';
  StringGrid1.Cells[4,0]:='La date et le temps';
  StringGrid1.Cells[5,0]:='Exercice';
  StringGrid1.Cells[6,0]:='Au total des cibles';
  StringGrid1.Cells[7,0]:='Des cibles frappees';
  StringGrid1.Cells[8,0]:='Le premier coup de feu';
  StringGrid1.Cells[9,0]:='Note';
  Reset(File_Vedom);                // открыть файл
  StringGrid1.RowCount:=FileSize(File_Vedom);
  for a:=1 to StringGrid1.RowCount do begin
    Seek(File_Vedom,a-1);
    Read(File_Vedom,Zap_Ved);
    StringGrid1.Cells[0,a]:=inttostr(a);
    StringGrid1.Cells[1,a]:=Zap_Ved.VoenCh+' / '+Zap_Ved.Rota+' / '+Zap_Ved.Vzvod;
    StringGrid1.Cells[2,a]:=Zap_Ved.SurnameKom;
    StringGrid1.Cells[3,a]:=Zap_Ved.SurnameNav;
    StringGrid1.Cells[4,a]:=Zap_Ved.tzDate+' '+Zap_Ved.tzTime;
    StringGrid1.Cells[5,a]:=Zap_Ved.NumOfEx;
    StringGrid1.Cells[6,a]:=Zap_Ved.Col_Mish;
    StringGrid1.Cells[7,a]:=Zap_Ved.Col_Poraj_Mish;
    StringGrid1.Cells[8,a]:=Zap_Ved.TimeOfFirstShoot;
    StringGrid1.Cells[9,a]:=Zap_Ved.LessonMark;
  end;
  CloseFile(File_Vedom);               // закрыть файл
end;

procedure TVedom.Button1Click(Sender: TObject);
begin
  Panel1.Visible:=true;
end;

procedure TVedom.StringGrid1DblClick(Sender: TObject);
begin
  if StringGrid1.Row=0 then exit;
  Reset(File_Vedom);                 // открыть файл
  Seek(File_Vedom,StringGrid1.Row-1);
  Read(File_Vedom,Zap_Ved);
  CloseFile(File_Vedom);               // закрыть файл
//  Index:=strtoint(Zap_Ved.Task_index);
//  Temp:=strtoint(Zap_Ved.Task_Temp);
//  Ceson:=strtoint(Zap_Ved.Task_Ceson);
//  Mestn:=strtoint(Zap_Ved.Task_Mestn);
  CloseFile(File_Vedom);               // закрыть файл
  Panel1.Visible:=false;
end;

procedure TVedom.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_ESCAPE then close;
end;

procedure TVedom.Resort;
var  i: Integer;
     reco1 : TZapis;
begin
  Reset(File_Vedom);
  For i:=1 to 269 do begin
    Seek(File_Vedom,i);
    Read(File_Vedom,reco1);
    Seek(File_Vedom,(i-1));
    Write(File_Vedom,reco1);
  end;
  CloseFile(File_Vedom);
end;

procedure TVedom.WriteRecIn(reco: TZapis);
begin
  {$I-}
  Reset(File_Vedom);
  {$I+}
  if IOResult<>0 then Rewrite(File_Vedom);
  Closefile(File_Vedom);
  Reset(File_Vedom);
  If FileSize(File_Vedom) = 270 then begin
    CloseFile(File_Vedom);
    Resort;
    Reset(File_Vedom);
    Seek(File_Vedom,FileSize(File_Vedom)-1);
    Write(File_Vedom,reco);
    CloseFile(File_Vedom);
  end
  else begin
  Reset(File_Vedom);
  Seek(File_Vedom,FileSize(File_Vedom));
  Write(File_Vedom,reco);
  CloseFile(File_Vedom);
  end;
end;

end.
