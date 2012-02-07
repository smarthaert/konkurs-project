unit UnOper_Ruk;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Main, UnOther;

type
  TOper_Ruk = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    Label2: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label3: TLabel;
    Panel1: TPanel;
    Bevel3: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label23: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Button1: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  public
    procedure Isx_Pol;
  private
    procedure Error_proc;
    procedure Load_Isx;
    procedure Load_Prog;
    procedure OutputText;
    procedure Init_Label;
    procedure Color_Isx_Pol;
  end;

const
  KOMANDIR = 1;
  NAVODCHIK = 2;
  VODITEL = 3;
  PAUSE=5; // Длительность (секунды) задержки на операциях
  COL_LINE=18;
var
  MESTO: string;
  num_Mesto:word;
  Oper_Ruk: TOper_Ruk;
  Num_Oper: word; //Индекс в массиве, отвечающий за выполнение опрерации
  Time_pause: word;
  Oper: array[1..2,1..100,0..3] of String;
  Line_isx_pol: array[1..2,1..40] of String;

  Org_Upr2: TOrg_Upr_Rm; //запись массивов сигналов
  Isx_Oper: array[1..2,1..100,1..6] of word;// 6-Номер label
  Programma: array[1..2,1..100,1..5] of word;
      // индексы :  № прог, № пункта, Действие
      //1- 0-если проверка не производится(пауза 5с),1- Проверка,2-Проскакивание,3-Конец
      //2- ЛС(0-12)
      //3- ЛB(0-15)
      //4- 0-вкл, 1-выкл- Значение, которому должно равнятся сравнение
      //5- Номер РМ, где находится орган
  error: boolean;
  Name_Oper:array[1..2] of string;
  Col_Org, Col_Isx_Pol: word;
  Isx_Pre: boolean;
  HLabel : array[1..36] of TLabel;
  Num_Prog: word;

implementation

{$R *.DFM}
procedure TOper_Ruk.FormCreate(Sender: TObject);
begin
  SetCursorPos(1048,0);
///  Screen.Cursor:=crNone;// Убираем курсор. +++
  Init_Label;
end;

procedure TOper_Ruk.Isx_Pol;
begin
  Panel1.Visible:=true;
  Label3.Visible:=true;
  Isx_Pre:=false;
  Time_pause:=15;
  Num_Oper:=1;
  Load_Isx;      // Читаем исходное положение из файла
  Load_Prog;     // Читаем алгоритм из файла
  Label1.Caption:=Name_Oper[1];  // Название операции
  Label2.Caption:=Name_Oper[2];
  Color_Isx_Pol;
end;

procedure TOper_Ruk.Load_Isx;
var
  tf: textfile;
  s: string;
  a,n,k: word;
begin
  for a:=1 to COL_LINE*2 do Hlabel[a].Caption:='';
  s:=Dir+'Res\Prog\Isx_n'+IntToStr(Num_Prog)+'.shp';
  AssignFile(tf,s);
  Reset(tf);
  ReadLn(tf,s);              // Название операции
  ReadLn(tf,s);
  ReadLn(tf,s);              // "Исх пол"
  ReadLn(tf,Col_Isx_Pol);              // Количество действий
  ReadLn(tf,s); // Название рабочего места
  k:=1;
  for a:=1 to Col_Isx_Pol do begin
    inc(k);
    ReadLn(tf,s); //
    Line_isx_pol[1,k]:=s;
    ReadLn(tf,s); //
    Line_isx_pol[1,k+COL_LINE]:=s;
    Isx_Oper[1,a,6]:=k+COL_LINE;
    ReadLn(tf,Isx_Oper[1,a,1]); //     как реагировать
    ReadLn(tf,Isx_Oper[1,a,2]); //     линия
    ReadLn(tf,Isx_Oper[1,a,3]); //     столбец
    ReadLn(tf,Isx_Oper[1,a,4]); //     значение
    ReadLn(tf,Isx_Oper[1,a,5]); //     РМ
  end;
  ReadLn(tf,n);              // Количество cтрок
  inc(k);
  inc(k);
  ReadLn(tf,s); // Название рабочего места
  for a:=1 to n do begin
    ReadLn(tf,s); //
    inc(k);
    ReadLn(tf,s); //
  end;
  CloseFile(tf);
  s:=Dir+'Res\Prog\Isx_k'+IntToStr(Num_Prog)+'.shp';
  AssignFile(tf,s);
  Reset(tf);
  ReadLn(tf,s);              // Название операции
  ReadLn(tf,s);
  ReadLn(tf,s);              // "Исх пол"
  ReadLn(tf,Col_Isx_Pol);              // Количество действий
  ReadLn(tf,s); // Название рабочего места
  k:=1;
  for a:=1 to Col_Isx_Pol do begin
    inc(k);
    ReadLn(tf,s); //
    Line_isx_pol[2,k]:=s;
    ReadLn(tf,s); //
    Line_isx_pol[2,k+COL_LINE]:=s;
    Isx_Oper[2,a,6]:=k+COL_LINE;
    ReadLn(tf,Isx_Oper[2,a,1]); //     как реагировать
    ReadLn(tf,Isx_Oper[2,a,2]); //     линия
    ReadLn(tf,Isx_Oper[2,a,3]); //     столбец
    ReadLn(tf,Isx_Oper[2,a,4]); //     значение
    ReadLn(tf,Isx_Oper[2,a,5]); //     РМ
  end;
  ReadLn(tf,n);              // Количество cтрок
  CloseFile(tf);
end;

procedure TOper_Ruk.Load_Prog;
var
  tf: textfile;
  s: string;
  a: word;
begin
  s:=Dir+'Res\Prog\Oper_n'+IntToStr(Num_Prog)+'.shp';
  AssignFile(tf,s);
  Reset(tf);
  ReadLn(tf,Name_Oper[1]);        // Название операции
  ReadLn(tf,Name_Oper[2]);
  for a:=1 to 5 do ReadLn(tf,s);  // Коментарии
  ReadLn(tf,s);             // Количество действий
  ReadLn(tf,s);             // Количество действий
  Col_Org:=0;
  while not EOF(tf) do begin
    inc(Col_Org);
    ReadLn(tf,Oper[1,Col_Org,1]);         // Название действия
    ReadLn(tf,Oper[1,Col_Org,2]);
    ReadLn(tf,Oper[1,Col_Org,3]);
    ReadLn(tf,Programma[1,Col_Org,1]);    // Как реагировать
    ReadLn(tf,Programma[1,Col_Org,2]);    // ЛС
    ReadLn(tf,Programma[1,Col_Org,3]);    // ЛВ
    ReadLn(tf,Programma[1,Col_Org,4]);    // Положение органа(вкл-выкл)
    ReadLn(tf,Programma[1,Col_Org,5]);    // РМ
  end;
  CloseFile(tf);
  s:=Dir+'Res\Prog\Oper_k'+IntToStr(Num_Prog)+'.shp';
  AssignFile(tf,s);
  Reset(tf);
  ReadLn(tf,Name_Oper[1]);        // Название операции
  ReadLn(tf,Name_Oper[2]);
  for a:=1 to 5 do ReadLn(tf,s);  // Коментарии
  ReadLn(tf,s);             // Количество действий
  ReadLn(tf,s);             // Количество действий
  Col_Org:=0;
  while not EOF(tf) do begin
    inc(Col_Org);
    ReadLn(tf,Oper[1,Col_Org,1]);         // Название действия
    ReadLn(tf,Oper[1,Col_Org,2]);
    ReadLn(tf,Oper[1,Col_Org,3]);
    ReadLn(tf,Programma[1,Col_Org,1]);    // Как реагировать
    ReadLn(tf,Programma[1,Col_Org,2]);    // ЛС
    ReadLn(tf,Programma[1,Col_Org,3]);    // ЛВ
    ReadLn(tf,Programma[1,Col_Org,4]);    // Положение органа(вкл-выкл)
    ReadLn(tf,Programma[1,Col_Org,5]);    // РМ
  end;
  CloseFile(tf);
end;


procedure TOper_Ruk.Timer1Timer(Sender: TObject);
begin
  label44.Caption:=inttostr(Time_pause);
  Num_Oper:=Position_Oper[num_BMP,num_Mesto];
  label43.Caption:=inttostr(Num_Oper);
  if Num_Oper=$ff then Error_proc
  else begin
    if Num_Oper=0 then begin
      Panel1.Visible:=true;
      Label3.Visible:=true;
      Color_Isx_Pol
    end
    else begin
      Panel1.Visible:=false;
      Label3.Visible:=false;
      OutputText;
    end;
  end;
end;

procedure TOper_Ruk.Error_proc;
begin
  StaticText1.Color:=clWhite;
  StaticText2.Color:=clWhite;
  StaticText3.Color:=clWhite;
  StaticText1.Font.Color:=clRed;
  StaticText2.Font.Color:=clRed;
  StaticText3.Font.Color:=clRed;
  StaticText1.Caption:='Ошибка!';
  StaticText2.Caption:='Верните орган управления';
  StaticText3.Caption:='в прежнее положение';
end;

procedure TOper_Ruk.OutputText;
var a,n,k: word;
begin
  if mesto='n' then n:=1 else n:=2;
  case Programma[n,Num_Oper,1] of
    0: begin
      StaticText1.Color:=$0080FF80;
      StaticText2.Color:=$0080FF80;
      StaticText3.Color:=$0080FF80;
    end;
    1: begin
      StaticText1.Color:=$00C080FF;
      StaticText2.Color:=$00C080FF;
      StaticText3.Color:=$00C080FF;
    end;
    2: begin
      StaticText1.Color:=clWhite;
      StaticText2.Color:=clWhite;
      StaticText3.Color:=clWhite;
    end;
    3: begin
      StaticText1.Color:=clWhite;
      StaticText2.Color:=clWhite;
      StaticText3.Color:=clWhite;
    end;
  end;
  k:=1;
  if n=1 then  Hlabel[k].Caption:='Рабочее место наводчика'
         else  Hlabel[k].Caption:='Рабочее место командира';
  for a:=1 to Col_Isx_Pol do begin
    inc(k);
    Hlabel[k].Caption:=Line_isx_pol[n,k];
    Hlabel[k+COL_LINE].Caption:=Line_isx_pol[n,k+COL_LINE];
  end;
  StaticText1.Font.Color:=clBlack;
  StaticText2.Font.Color:=clBlack;
  StaticText3.Font.Color:=clBlack;
  StaticText1.Caption:=Oper[a,Num_Oper,1];
  StaticText2.Caption:=Oper[a,Num_Oper,2];
  StaticText3.Caption:=Oper[a,Num_Oper,3];
end;

procedure TOper_Ruk.Init_Label;
begin
  HLabel[1]:=label5;
  HLabel[2]:=label6;
  HLabel[3]:=label7;
  HLabel[4]:=label8;
  HLabel[5]:=label9;
  HLabel[6]:=label10;
  HLabel[7]:=label11;
  HLabel[8]:=label12;
  HLabel[9]:=label13;
  HLabel[10]:=label14;
  HLabel[11]:=label15;
  HLabel[12]:=label16;
  HLabel[13]:=label17;
  HLabel[14]:=label18;
  HLabel[15]:=label19;
  HLabel[16]:=label20;
  HLabel[17]:=label21;
  HLabel[18]:=label22;
  HLabel[19]:=label24;
  HLabel[20]:=label25;
  HLabel[21]:=label26;
  HLabel[22]:=label27;
  HLabel[23]:=label28;
  HLabel[24]:=label29;
  HLabel[25]:=label30;
  HLabel[26]:=label31;
  HLabel[27]:=label32;
  HLabel[28]:=label33;
  HLabel[29]:=label34;
  HLabel[30]:=label35;
  HLabel[31]:=label36;
  HLabel[32]:=label37;
  HLabel[33]:=label38;
  HLabel[34]:=label39;
  HLabel[35]:=label40;
  HLabel[36]:=label41;
end;

procedure TOper_Ruk.Color_Isx_Pol;
var yes: boolean;
a,b: word;
begin
  if mesto='n' then b:=1 else b:=2;
  for a:=1 to Col_Isx_Pol do begin
      HLabel[Isx_Oper[b,a, 6]].Color:=$0080FF80;
      HLabel[Isx_Oper[b,a, 6]].Color:=$00C080FF;
  end;
end;

procedure TOper_Ruk.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: begin
      Timer1.Enabled:=false;
      NumScene:=NumScene_old;
      Close;
    end;
    VK_F1:Num_BMP:=1;
    VK_F2:Num_BMP:=2;
    VK_F3:Num_BMP:=3;
  end;
  label47.Caption:='Экипаж '+inttostr(Num_BMP);
end;

procedure TOper_Ruk.Button1Click(Sender: TObject);
begin
  inc(Position_Oper[num_BMP,num_Mesto]);
end;

end.


procedure TFOper.Isx_Pol;
begin
  Panel1.Visible:=true;
  Label3.Visible:=true;
  Isx_Pre:=false;
  Time_pause:=15;
  Num_Oper:=1;
  Memory_Organ;     // Запомнить положение органов
  Load_Isx;      // Читаем исходное положение из файла
  Load_Prog;     // Читаем алгоритм из файла
  Label1.Caption:=Name_Oper[1];  // Название операции
  Label2.Caption:=Name_Oper[2];
  Color_Isx_Pol;
end;

procedure TFOper.Begin_Oper;
begin
  Panel1.Visible:=false;
  Label3.Visible:=false;
  Memory_Organ;  // Запоминаем органы управления
  Num_Oper:=1;
  if Programma[1, 1]=0 then Time_pause:=PAUSE*9;
  OutputText;   //
end;

