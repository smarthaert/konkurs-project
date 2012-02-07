unit UnOper;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls,UnTrenir,mxgrid, Buttons,shellapi;
                                         
type
  TOrg_Upr=record
    kom_imp: array[0..6] of byte;
    kom_anal: array[0..2] of word;
    nav_imp: array[0..15,0..1] of byte;
    nav_anal: array[0..6] of word;
    vod_imp: array[0..1,0..1] of byte;
    vod_anal: array[0..4] of word;
  end;

  TFOper = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Labela: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Labelb: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
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
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;

    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure AlarmClock(cou_sek:integer);
    procedure CheckPos11(kind: integer);
    function PreCheckPos11 : integer;
    procedure CheckPos12;
    function PreCheckPos12 : integer;
    procedure CheckPos13;
    function PreCheckPos13 : integer;
    procedure CheckPos2;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OutputText(tex1,tex2,tex3: array of string);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TClrScreen = class
    public
       procedure CleanScr(han: TCanvas;
                       x0,y0: integer;
                       x1,y1: integer;
                       rr,gg,bb: longint); overload;
    private
      procedure CleanScr(han: TCanvas;
                       x0,y0: integer;
                       x1,y1: integer;
                       clll: TColor); overload;
      procedure CleanScr(han: TCanvas;
                       x0,y0: integer;
                       r: integer;
                       rr,gg,bb: longint); overload;
      procedure CleanScr(han: TCanvas;
                       x0,y0: integer;
                       r: integer;
                       clll: longint); overload;
  end;

var
  rezhim: integer; //Отвечает за выбор режима: Командир, Наводчик, Водитель
  FOper: TFOper;
  Org_Upr,Org_Upr2: TOrg_Upr; //запись массивов сигналов
  Oper: array[1..17,1..100,1..5] of String;

  num_punkt: integer=1; //Индекс в массиве, отвечающий за выполнение опрерации
  cp11: integer = 2;   //
  cp12: integer = 2;   // Переменные, увеличиваемая в случае выполнения
  cp13: integer = 2;   //  условий в процедуре CheckPos
  cp2:  integer {= 2}; //
  cp3:  integer = 2;   //
  cp4:  integer = 2;   //
  flag11: boolean = true;  //
  flag12: boolean = true;  //
  flag13: boolean = true;  //
  flag2:  boolean = false; //
  flag3:  boolean = true;  //
  flag4:  boolean = true;  //
  hhh: integer  = 0;
  csgl: TClrScreen;    // Переменная используется в процедуре очистки экрана

const
  CurPath = 'Text\';
  KOMANDIR = 1;
  NAVODCHIK = 2;
  VODITEL = 3;
  SECON=5; // Длительность (секунды) задержки на операциях
  XX=200; // Константы для задания координат вывода
  YY=150; //
implementation

uses Main;


  {$R *.DFM}
//процедура не требуется в конечном варианте
procedure TFOper.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  rese: byte;
begin
  case key of
81 : begin
       cp2:=cp2+1;
       cp3:=cp3+1;
       cp4:=cp4+1;
       formpaint(nil);
     end;
192: begin
      If Org_Upr.vod_imp[0,0] and $40=$00 then
      Org_Upr.vod_imp[0,0]:=Org_Upr.vod_imp[0,0] or $40 else
      Org_Upr.vod_imp[0,0]:=Org_Upr.vod_imp[0,0] and $BF;
     end;
49: begin
      If Org_Upr.kom_imp[3] and $08=$00 then
      Org_Upr.kom_imp[3]:=Org_Upr.kom_imp[3] or $08 else
      Org_Upr.kom_imp[3]:=Org_Upr.kom_imp[3] and $F7;

    end;
50: begin
      If Org_Upr.kom_imp[3] and $04=$00 then
      Org_Upr.kom_imp[3]:=Org_Upr.kom_imp[3] or $04 else
      Org_Upr.kom_imp[3]:=Org_Upr.kom_imp[3] and $FB;
    end;
51: begin
      If Org_Upr.kom_imp[3] and $02=$00 then
      Org_Upr.kom_imp[3]:=Org_Upr.kom_imp[3] or $02 else
      Org_Upr.kom_imp[3]:=Org_Upr.kom_imp[3] and $FD;
    end;
52: begin
      If Org_Upr.kom_imp[3] and $01=$00 then
      Org_Upr.kom_imp[3]:=Org_Upr.kom_imp[3] or $01 else
      Org_Upr.kom_imp[3]:=Org_Upr.kom_imp[3] and $FE;
    end;
53: begin
      If Org_Upr.kom_imp[5] and $04=$00 then
      Org_Upr.kom_imp[5]:=Org_Upr.kom_imp[5] or $04 else
      Org_Upr.kom_imp[5]:=Org_Upr.kom_imp[5] and $FB;
    end;
54: begin
      If Org_Upr.nav_imp[0,1] and $02=$00 then
      Org_Upr.nav_imp[0,1]:=Org_Upr.nav_imp[0,1] or $02 else
      Org_Upr.nav_imp[0,1]:=Org_Upr.nav_imp[0,1] and $FD;
    end;
55: begin
      If Org_Upr.nav_imp[7,0] and $40=$00 then
      Org_Upr.nav_imp[7,0]:=Org_Upr.nav_imp[7,0] or $40 else
      Org_Upr.nav_imp[7,0]:=Org_Upr.nav_imp[7,0] and $BF;
    end;
56: begin
      If Org_Upr.kom_imp[3] and $20=$00 then
      Org_Upr.kom_imp[3]:=Org_Upr.kom_imp[3] or $20 else
      Org_Upr.kom_imp[3]:=Org_Upr.kom_imp[3] and $DF;
    end;
57: begin
      If Org_Upr.kom_imp[5] and $40=$00 then
      Org_Upr.kom_imp[5]:=Org_Upr.kom_imp[5] or $40 else
      Org_Upr.kom_imp[5]:=Org_Upr.kom_imp[5] and $BF;
    end;
48: begin
      Org_Upr.nav_imp[7,0]:=Org_Upr.nav_imp[7,0] and $7F;
    end;
189:begin
      Org_Upr.kom_imp[3]:=Org_Upr.kom_imp[3] and $EF;
    end;
187:begin
      If Org_Upr.nav_imp[7,0] and $20=$00 then begin
        Org_Upr.nav_imp[7,0]:=Org_Upr.nav_imp[7,0] or $20;
        Org_Upr.nav_imp[7,0]:=Org_Upr.nav_imp[7,0] and $EF;
      end else begin
        Org_Upr.nav_imp[7,0]:=Org_Upr.nav_imp[7,0] and $DF;
        Org_Upr.nav_imp[7,0]:=Org_Upr.nav_imp[7,0] or $10;
      end;
    end;
87: begin
      rese:=org_upr.kom_imp[1] and $C0;
      if org_upr.kom_imp[1] and $20 <> $00 then begin
        org_upr.kom_imp[1]:=org_upr.kom_imp[1] shl 1;
        org_upr.kom_imp[1]:=org_upr.kom_imp[1] or $01;
      end;
      org_upr.kom_imp[1]:=org_upr.kom_imp[1] and $3F;
      org_upr.kom_imp[1]:=org_upr.kom_imp[1] or rese;
    end;
69: begin
      rese:=org_upr.kom_imp[1] and $C0;
      if org_upr.kom_imp[1] and $01 <> $00 then begin
        org_upr.kom_imp[1]:=org_upr.kom_imp[1] shr 1;
        org_upr.kom_imp[1]:=org_upr.kom_imp[1] or $20;
      end;
      org_upr.kom_imp[1]:=org_upr.kom_imp[1] and $3F;
      org_upr.kom_imp[1]:=org_upr.kom_imp[1] or rese;
    end;
82: begin
      rese:=org_upr.kom_imp[2] and $E0;
      if org_upr.kom_imp[2] and $10 <> $00 then begin
        org_upr.kom_imp[2]:=org_upr.kom_imp[2] shl 1;
        org_upr.kom_imp[2]:=org_upr.kom_imp[2] or $01;
      end;
      org_upr.kom_imp[2]:=org_upr.kom_imp[2] and $1F;
      org_upr.kom_imp[2]:=org_upr.kom_imp[2] or rese;
    end;
84: begin
      rese:=org_upr.kom_imp[2] and $E0;
      if org_upr.kom_imp[2] and $01 <> $00 then begin
        org_upr.kom_imp[2]:=org_upr.kom_imp[2] shr 1;
        org_upr.kom_imp[2]:=org_upr.kom_imp[2] or $10;
      end;
      org_upr.kom_imp[2]:=org_upr.kom_imp[2] and $1F;
      org_upr.kom_imp[2]:=org_upr.kom_imp[2] or rese;
    end;
89: begin
      If Org_Upr.kom_imp[0] and $20=$00 then
      Org_Upr.kom_imp[0]:=Org_Upr.kom_imp[0] or $20 else
      Org_Upr.kom_imp[0]:=Org_Upr.kom_imp[0] and $CF;
    end;
85: begin
      If Org_Upr.kom_imp[0] and $02=$00 then
      Org_Upr.kom_imp[0]:=Org_Upr.kom_imp[0] or $02 else
      Org_Upr.kom_imp[0]:=Org_Upr.kom_imp[0] and $FD;
    end;
73: begin
      If Org_Upr.kom_imp[5] and $80=$00 then
      Org_Upr.kom_imp[5]:=Org_Upr.kom_imp[5] or $80 else
      Org_Upr.kom_imp[5]:=Org_Upr.kom_imp[5] and $7F;
    end;
79: begin
      If Org_Upr.nav_imp[0,1] and $80=$00 then
      Org_Upr.nav_imp[0,1]:=Org_Upr.nav_imp[0,1] or $80 else
      Org_Upr.nav_imp[0,1]:=Org_Upr.nav_imp[0,1] and $7F;
    end;
219: begin
      If Org_Upr.vod_imp[0,1] and $04=$00 then
      Org_Upr.vod_imp[0,1]:=Org_Upr.vod_imp[0,1] or $04 else
      Org_Upr.vod_imp[0,1]:=Org_Upr.vod_imp[0,1] and $FB;
    end;

221: begin
      If Org_Upr.nav_imp[7,0] and $04=$00 then
      Org_Upr.nav_imp[7,0]:=Org_Upr.nav_imp[7,0] or $04 else
      Org_Upr.nav_imp[7,0]:=Org_Upr.nav_imp[7,0] and $FB;
    end;

65: begin
      If Org_Upr.nav_imp[5,1] and $01=$00 then begin
        Org_Upr.nav_imp[5,1]:=Org_Upr.nav_imp[5,1] or $01;
        Org_Upr.nav_imp[5,1]:=Org_Upr.nav_imp[5,1] and $FD;
      end else begin
        Org_Upr.nav_imp[5,1]:=Org_Upr.nav_imp[5,1] and $FE;
        Org_Upr.nav_imp[5,1]:=Org_Upr.nav_imp[5,1] or $02;
      end;
    end;

83: begin
      If Org_Upr.nav_imp[2,1] and $40=$00 then begin
        Org_Upr.nav_imp[2,1]:=Org_Upr.nav_imp[2,1] or $40;
        Org_Upr.nav_imp[2,1]:=Org_Upr.nav_imp[2,1] and $7F;
      end else begin
        Org_Upr.nav_imp[2,1]:=Org_Upr.nav_imp[2,1] and $BF;
        Org_Upr.nav_imp[2,1]:=Org_Upr.nav_imp[2,1] or $80;
      end;
    end;

68: begin
      If Org_Upr.nav_imp[5,1] and $04=$00 then begin
        Org_Upr.nav_imp[5,1]:=Org_Upr.nav_imp[5,1] or $04;
        Org_Upr.nav_imp[5,1]:=Org_Upr.nav_imp[5,1] and $F7;
      end else begin
        Org_Upr.nav_imp[5,1]:=Org_Upr.nav_imp[5,1] and $FB;
        Org_Upr.nav_imp[5,1]:=Org_Upr.nav_imp[5,1] or $08;
      end;
    end;

70: begin
      If Org_Upr.nav_imp[7,0] and $02=$00 then
      Org_Upr.nav_imp[7,0]:=Org_Upr.nav_imp[7,0] or $02 else
      Org_Upr.nav_imp[7,0]:=Org_Upr.nav_imp[7,0] and $FD;
    end;

71: begin
      If Org_Upr.nav_imp[6,0] and $40=$00 then
      Org_Upr.nav_imp[6,0]:=Org_Upr.nav_imp[6,0] or $40 else
      Org_Upr.nav_imp[6,0]:=Org_Upr.nav_imp[6,0] and $BF;
    end;


72: begin
      If Org_Upr.nav_imp[4,0] and $20=$00 then
      Org_Upr.nav_imp[4,0]:=Org_Upr.nav_imp[4,0] or $20 else
      Org_Upr.nav_imp[4,0]:=Org_Upr.nav_imp[4,0] and $DF;
    end;

74: begin
      If Org_Upr.nav_imp[7,0] and $01=$00 then
      Org_Upr.nav_imp[7,0]:=Org_Upr.nav_imp[7,0] or $01 else
      Org_Upr.nav_imp[7,0]:=Org_Upr.nav_imp[7,0] and $FE;
    end;

75: begin
      If Org_Upr.nav_imp[4,1] and $02=$00 then
      Org_Upr.nav_imp[4,1]:=Org_Upr.nav_imp[4,1] or $02 else
      Org_Upr.nav_imp[4,1]:=Org_Upr.nav_imp[4,1] and $FD;
    end;

76: begin
      If Org_Upr.nav_imp[4,1] and $02=$00 then
      Org_Upr.nav_imp[4,1]:=Org_Upr.nav_imp[4,1] or $02 else
      Org_Upr.nav_imp[4,1]:=Org_Upr.nav_imp[4,1] and $FD;
    end;



end;
end;
procedure TFOper.FormCreate(Sender: TObject);
var
  DeviceMode: TDevMode;
begin
  //Установка исходного положения (в окончательном тексте будет удалена)
  Org_Upr.vod_imp[0,0]:=$40;
  Org_Upr.kom_imp[3]:=$1F;
  Org_Upr.kom_imp[5]:=$43;
  Org_Upr.nav_imp[0,1]:=$80;
  Org_Upr.nav_imp[7,0]:=$A7;
  Org_Upr.nav_imp[4,0]:=$20;
  Org_Upr.kom_imp[1]:=$00;
  Org_Upr.kom_imp[2]:=$00;
  Org_Upr.nav_imp[5,1]:=$05;
  Org_Upr.nav_imp[2,1]:=$40;
  Org_Upr2.vod_imp[0,0]:=Org_Upr.vod_imp[0,0]; //
  Org_Upr2.kom_imp[3]:=Org_Upr.kom_imp[3];     // Запоминание исходных параметров
  Org_Upr2.kom_imp[5]:=Org_Upr.kom_imp[5];     // для определения момента их
  Org_Upr2.nav_imp[0,1]:=Org_Upr.nav_imp[0,1]; // изменения
  Org_Upr2.nav_imp[7,0]:=Org_Upr.nav_imp[7,0]; //
  Org_Upr2.kom_imp[0]:=Org_Upr.kom_imp[0];
  Org_Upr2.kom_imp[1]:=Org_Upr.kom_imp[1];
  Org_Upr2.kom_imp[2]:=Org_Upr.kom_imp[2];
  Org_Upr2.nav_imp[5,1]:=Org_Upr.nav_imp[5,1];
  Org_Upr2.nav_imp[2,1]:=Org_Upr.nav_imp[2,1];
  Org_Upr2.nav_imp[6,0]:=Org_Upr.nav_imp[6,0];
  Org_Upr2.nav_imp[4,0]:=Org_Upr.nav_imp[4,0];
  Org_Upr2.nav_imp[4,1]:=Org_Upr.nav_imp[4,1];
//  Timer1.Enabled:=true;
    Oper[1,num_punkt,1]:='                 1.1 Исходное положение органов управления';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='       - Включить выключатель батарей';
    Oper[1,num_punkt,2]:='';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='+';
    Oper[1,num_punkt,5]:='Вкл';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='       - Проверить положение переключателей на правом распределительном щитке башни';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='ЩИТОК ПР';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='             - СП. ПОД.';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='Вкл';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='             - ДОС.';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='Вкл';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='             - Л.Р.В.Т.';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='Вкл';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='             - АЗ ЭМ.';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='Вкл';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='             - АЗ УПР.';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='Выкл';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='       - Проверить положение переключателей на левом распределительном щитке башни';
    Oper[1,num_punkt,2]:='';
    Oper[1,num_punkt,3]:='+';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='ЩИТОК ЛЕВ';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='             - ЭЛ. СПУСК';
    Oper[1,num_punkt,2]:='';
    Oper[1,num_punkt,3]:='+';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='Выкл';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='      - Проверить положение органов управления  на ПУ АЗ (пульт управления) наводчика.';
    Oper[1,num_punkt,2]:='';
    Oper[1,num_punkt,3]:='+';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='            - ЗАГР., У,О,Б,К';
    Oper[1,num_punkt,2]:='';
    Oper[1,num_punkt,3]:='+';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='О';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='            - АВТ.- РУЧ.';
    Oper[1,num_punkt,2]:='';
    Oper[1,num_punkt,3]:='+';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='АВТ.';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='      - Проверить положение органов управления на ПЗ АЗ (пульте загрузки)';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='            - АВТ.-РУЧ. РАЗГР.';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='АВТ.';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='            - ПОДДОН АВТ.-РУЧ.';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='АВТ.';
    num_punkt:=1;
    Oper[2,num_punkt,1]:='                 1.2 Загрузка "выстрелов" в "транспортер АЗ"';
   num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='       - Включить АЗР ЭЛ. СПУСК';
    Oper[2,num_punkt,2]:='';
    Oper[2,num_punkt,3]:='+';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='Вкл';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='       - Включить АЗР УПР.';
    Oper[2,num_punkt,2]:='+';
    Oper[2,num_punkt,3]:='';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='Вкл';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='       - Включить переключатель АВТ.-РУЧ.РАЗГР';
    Oper[2,num_punkt,2]:='+';
    Oper[2,num_punkt,3]:='';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='РУЧ.РАЗГР';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='       - Установить переключатель типов на ПУ АЗ';
    Oper[2,num_punkt,2]:='+';
    Oper[2,num_punkt,3]:='';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='ЗАГР';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='             - Нажать кнопку АЗ ВКЛ';
    Oper[2,num_punkt,2]:='';
    Oper[2,num_punkt,3]:='+';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='Вкл';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='             - Установить переключатель типов';
    Oper[2,num_punkt,2]:='';
    Oper[2,num_punkt,3]:='+';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='Б';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='             - Нажать кнопку АЗ ВКЛ';
    Oper[2,num_punkt,2]:='';
    Oper[2,num_punkt,3]:='+';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='Вкл';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='       - Аналогично провести загрузку остальных выстрелов';
    Oper[2,num_punkt,2]:='+';
    Oper[2,num_punkt,3]:='+';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='             - Установить органы управления в АЗ в исходное положение';
    Oper[2,num_punkt,2]:='+';
    Oper[2,num_punkt,3]:='+';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='      - Проверить показания цифроиндикатора по фактическому количеств "загруженных выстрелов"';
    Oper[2,num_punkt,2]:='';
    Oper[2,num_punkt,3]:='+';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='';

    num_punkt:=1;
    Oper[3,num_punkt,1]:='      - 1.3 Разгрузка "выстрелов" из "транспортера АЗ"';
    Oper[3,num_punkt,2]:='';
    Oper[3,num_punkt,3]:='';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='      - Включить АЗР ЭЛ. СПУСК';
    Oper[3,num_punkt,2]:='';
    Oper[3,num_punkt,3]:='+';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='Вкл';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='      - Включить АЗР УПР.';
    Oper[3,num_punkt,2]:='+';
    Oper[3,num_punkt,3]:='';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='Вкл';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='       - Перевести переключатель АВТ.-РУЧ.РАЗГР';
    Oper[3,num_punkt,2]:='+';
    Oper[3,num_punkt,3]:='';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='РУЧ.РАЗГР';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='       - Установить переключатель типов поочередно в положение соответствующее типу разгр. "выстрела"';
    Oper[3,num_punkt,2]:='';
    Oper[3,num_punkt,3]:='+';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='Б';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='             - Нажать кнопку АЗ ВКЛ';
    Oper[3,num_punkt,2]:='';
    Oper[3,num_punkt,3]:='+';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='Вкл';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='             - Нажать кнопку РАЗГРУЖЕНО';
    Oper[3,num_punkt,2]:='+';
    Oper[3,num_punkt,3]:='';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='Вкл';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='       - Аналогично провести разгрузку остальных выстрелов';
    Oper[3,num_punkt,2]:='+';
    Oper[3,num_punkt,3]:='+';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='       - Выключить и снова включить АЗР АЗ УПР';
    Oper[3,num_punkt,2]:='+';
    Oper[3,num_punkt,3]:='';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='-Выкл -Вкл';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='       - Органы управления АЗ перевести в исходное положение';
    Oper[3,num_punkt,2]:='+';
    Oper[3,num_punkt,3]:='+';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='';

    ////////////Oper2/////////////////////////////////////////////////
    num_punkt:=1;
    Oper[4,num_punkt,1]:='                     Командир танка';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Подать команду "К Бою"';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Занять место в боевом отделении, закрыть люк и застопорить его';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Включить освещение башни';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Проверить положение переключателей';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - СП.ПОД.';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - ДОС.';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Л.Р.В.Т.';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - АЗ ЭМ. ';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - АЗ УПР.';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     Выкл';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Открыть затвор пушки';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ОТКР';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Подготовить прибор ТКН-3 для работы в дневное время';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='            - Отстопорить прибор';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='            - Убедиться, что рукоятки шторки и диафрагмы в положении ЗАКР';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ЗАКР';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='            - Убедиться, что выключатель блока питания в положении ВЫКЛ';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='      ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='            - Установить рукоятку диафрагмы в положение Д';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='      Д';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Отстопорить и проверить поворот командирской башенки';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Механик-водитель закрывает люк';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='     ЗАКРЫТ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Проверить работу командирского целеуказания';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='           - Повернуть рукоятки прибора ТКН-3 влево или вправо предупредив экипаж командой';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='           - Нажать правую и левую кнопки прибора ТКН-3 в торцах рукояток';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='           - Контролировать загорание лампочки КОМАНДИР';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Проверить работоспособность пулемета.';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Нажать по команде командира кнопку стрельбы из пулемета';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Дать команду наводчику "Клин закрыть, электроспуск пушки проверить"';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Проверить работоспособность пушки                                                                         .';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:=' ЗАКР,ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Перевести рычаг механизма блокировки в положение РАЗБЛ';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     РАЗБЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - По команде проверить работу механизмов повторного взвода ударника механизма затвора пушки';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Перевести рычаг механизма блокировки в положение ЗАБЛ';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ЗАБЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Получит метеоданные, определить поправки, сообщить наводчику';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Установит рукоятку ввода поправок на деление, соответствующее суммарной поправке';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     0';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Подключить шлемофон к аппарату ТПУ и прверить связь с руководителем занятия';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Подать команду механику-водителю заводи, а после пуска двигателя наводчику-"Включить стабилизатор"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='                    Наводчик орудия';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Занять место в боевом отделении, закрыть и застопорить его';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Подключиться к аппарату ТПУ, проверить наличие с членами экипажа';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Отстопорить башню';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     РАССТОП';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Проверить работу подъемного и поворотного механизмов';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Включить выключатель ПРИВОД после доклада "Люк закрыт"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Подготовить прицельный комплекс 1А40-1 к работе';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Проверить положение переключателей АЗ УПР.';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Проверить положение переключателей ЭЛ СПУСК';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='        ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Проверить положение переключателя АВТ.-РУЧ на ПУ АЗ и переключателя типов "выстрела"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     АВТ,Б(ОилиК)';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Проверить положение переключателя АВТ.-РУЧ на ПЗ АЗ';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     АВТ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Расстопорить гироскоп через 1.5-2 мин';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     РАССТ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Перевести рычаг расцепления червячной пары';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     СТАБ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Включить выключатель СТАБИЛ на прицельном комплексе';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     СТАБИЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Включить выключатель РУЧ.-АВТ. на передней панели прицельного комплекса';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     АВТ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Включить выключатель Д. на передней панели прицельного комплекса';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Устанавливить дистанционную шкалу прицельного комплекса на нулевые деления';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Проверить установку потенциометров поправок УВБВ и УВП';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='0 ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Включить выключатель МЕХ. dД';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='      ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - В предвидении стрельбы УР включить прицельный комплекс';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Включить стабилизатор вооружения';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Установить переключатель типов выстрелов на ПУ АЗ ';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     У';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Убедиться, что тумблер У-ДЕНЬ - У-НОЧЬ в положении У-ДЕНЬ';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     У-ДЕНЬ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Подготовить прибор 1К13 к работе для чего';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Установить рычаг переключателя режимов на турели БОМ';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='      Д';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Установить рукоятку ДИАФРАГМА на передней панели БОМ';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ОТКР';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Установить рукоятку ШТОРКА на передней панели БОМ';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ЗАКР';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Установить рукоятку ВЫВЕРКА ПУ на передней панели БОМ';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ОТКЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Установить переключатель У-ДЕНЬ-У-НОЧЬ';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     У-ДЕНЬ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Установить тумблер АВТ-РУЧ на пульте КАС';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     АВТ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Включить тумблер Уна передней панели прибора 1К13';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Перевести рукоятку СТАБ. 3 в верхнее положение';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ВЕРХНЕЕ ПОЛОЖЕНИЕ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Проверить работу механизма ручного закрывания клина системы 2А46М-1';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ОТКР ЗАКР';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Проверить работу механизмов повторного взвода ударника и мехаического спуска ударника механизма затвора 2А46М-1';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Проверить положение АЗР на левом щитке башни';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Включить электроспуски пушки и пулеметов на щитке АЗР';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='      ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Включить тумблер НАГНЕТАТЕЛЬ-ЭЛ-СПУК';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='      ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - Проверить работу электроспусков';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - По команде командира танка включить стабилизатор';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='            - После доклада механика-водителя "Люк закрыт" по команде командира включить выключатель ПРИВОД';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='            - Через 1.5-2 минуты расстопорить гироскоп прицела';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     РАССТ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Установить рычаг расцепления червячной пары подъемного механизма пушки';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     СТАБ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Включить выключатель СТАБИЛ на прицельном комплексе 1А40-1';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     СТАБИЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - Включить выключатель РУЧ.-АВТ. на передней панели комплекса 1А40-1';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     АВТ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Проверить работу стабилизатора поворотом ПУ прицельного комплекса 1А40-1';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Подать механику-водителю команду "Проверить сигнализацию выхода пушки за габариты танка"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Проверить работу механизма ручного закрывания клина системы 2А46М-1';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ОТКР ЗАКР';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Доложить командиру танка о готовности "Наводчик к бою готов"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='                    Механик-водитель';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Занимает место в отделении управления и закрывает люк';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='     ЗАКР';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Включает выключатель аккумуляторных батарей';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='   ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Включить освещение рабочего места';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Подключить шлемофон к аппарату ТПУ и доложить "Люк закрыт"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Подготовить двигатель к запуску и запустить его по команде командира';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Проверить (по команде наводчика) сигнализацию выхода пушки за габариты';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='   СИГН ЛАМПА - ВЛЕВО(ВПРАВО)';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - При закрытом люке и расстопоренной башне проверить аварийный поворот башни, включив "АВАРИЙНЫЙ ПОВОРОТ КОЛПАКА"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Доложить командиру о готовности "Механик-водитель к бою готов"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='                    Командир танка';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - Получив от наводчика и механика-водителя о готовности, доложить руководителю о готовности танка к бою';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
//////////////Oper3///////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[5,num_punkt,1]:='                     Командир танка';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='       - Подать команду "К Бою"';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='       - Занять место в боевом отделении, закрыть люк и застопорить его';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='       - Включить освещение башни';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='       - Проверить положение переключателей';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='             - СП.ПОД.';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='             - ДОС.';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='             - Л.Р.В.Т.';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='             - АЗ ЭМ. ';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='             - АЗ УПР.';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     Выкл';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='      - Открыть затвор пушки';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     ОТКР';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='      - Подготовить прибор ТКН-3 для работы в ночное время';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='            - Установит рукоятку механизма переключения режимов';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     Н';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='            - Включить блок питания прибора ТКН-3';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='            - Установить рукоятку шторки';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='      ОТКР';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='            - Открыть диафрагму';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='      ОТКР';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='      - Включить АЗР ЛЮК на правом распределительном щитке башни';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='      ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='      - Включить осветитель ОУ-3ГКМ';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='  ПОСТОЯННО (ОТ КНОПКИ)';

//////////////Oper4///////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[6,num_punkt,1]:='                     Командир танка';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - Подать команду "Отбой"';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - Дать команду наводчику "Клин затвора пушки закрыть произвести спуск ударника"';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='    ЗАКР';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - Произвести контрольный спуск пулемета';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='     ПРОИЗВЕДЕН';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - Перевести рукоятку поправочника';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='     О';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - Выключить радиостанцию, ТПУ и отключить шлемофон от своего аппарата ';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - Застопорить башенку прибора ТКН-3';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - Открыть люк и застопорить его';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - Выключить АЗР на правом распределительном щитке(АЗР УПР. и ЛЮК.)';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='     ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Проверить положение выключателей на пульте загрузки)';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='    АВТ.РУЧ-АВТ, ЛЮК-АВТ';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Выключить освещение рабочего места';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Скомадовать механику-водителю "Выключить выключатель батарей"';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='                    Наводчик орудия';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Повернуть башню на угол 32-00 и застопорить ее';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ЗАСТОП';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Выключить выключатель МЕХ. dД ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Выключить выключатель Д ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Выключить выключатель СТАБИЛ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Перевести рычаг подъемного механизма';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   РУЧ';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Застопорить гироскоп прицела';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ЗАСТОП';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Выключить выключатель ПРИВОД на передней панели 1А40-1 ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Сообщить механику-водителю о выключении стабилизатора ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Выключить ППН 1К13 ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='            - Выключить тумблер У на передней панели прибора ППН 1К13';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='            - Перевести рукоятку СТАБ.З ППН 1К13';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='            - Установить рукоятку ДИАФРАГМА на передней панели БОМ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ЗАКР';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='            - Установить рукоятку ШТОРКА на передней панели БОМ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='    ОТКР';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='            - Установить рукоятку ВЫВЕРКА ПУ на передней панели БОМ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='     ОТКЛ';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='            - Установить рукоятку ВЫВЕРКА ПУ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='     ОТКЛ';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - Отключает шлемофон от аппаратуры ТПУ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - Выключить тумблер НАГНЕТАТЕЛЬ-ЭЛ.СПУСК на левом щитке башни';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='     ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - Проверить расход артвыстрелов и управлямых ракет во ВТ АЗ по типам снарядов';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - По приказу командира танка закрыть клин затвора и произвести контрольный спуск ударного механизма';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Открыть люк и застопорить его';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Выключить освещение азимутального указателя и своего рабочего места';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Выйти из боевого отделения, доложить командиру о количестве оставшихся выстрелов';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='                    Механик-водитель';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - После выключения наводчиком стабилизатора, по команде командира останавливает двигатель';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='+';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Отключить блок шлемофон от аппарата ТПУ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='+';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Выключить освещение своего рабочего места, выключатель батарей и выйти из отделения управления';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='+';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Доложить командиру танка о выполнении команды отбой';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='                 Командир танка';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - Доложить командиру взвода о выполнении команды "Отбой" и оставшихся боеприпасах';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';

///////////Oper5/////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[7,num_punkt,1]:='                     Командир танка';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='       - Подать команду "Отбой"';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='       - Дать команду наводчику "Клин затвора пушки закрыть произвести спуск ударника"';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='    ЗАКР';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='       - Произвести контрольный спуск пулемета';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='     ПРОИЗВЕДЕН';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='       - Перевести рукоятку поправочника';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='     О';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='       - Выключить радиостанцию, ТПУ и отключить шлемофон от своего аппарата ';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='       - Выключить прибор ТКН-3';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='     ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='            - Выключить БП прибора ТКН-3';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='            Перевести рукоятку шторки';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='     ЗАКР';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='      - Закрыть диафрагму';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='    ЗАКР';

///////////Oper6////////////////////////////////////////////
    num_punkt:=1;
    Oper[8,num_punkt,1]:='       - Проверить исходное положение органов управления согласно п.1.1';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='       - Проверить положение переключателей АЗ.УПР на правом распределительном щитке башни';
    Oper[8,num_punkt,2]:='+';
    Oper[8,num_punkt,3]:='';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='       - Проверить положение переключателей АЗ.УПР на левом распределительном щитке башни';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='       - Проверить положение переключателя АВТ.-РУЧ и переключателя типов выстрелов на ПУ АЗ';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    АВТ, Б(О или К)';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='       - Проверить положение переключателя АВТ.-РУЧ на ПЗ АЗ';
    Oper[8,num_punkt,2]:='+';
    Oper[8,num_punkt,3]:='';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    АВТ';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='       - После доклада механика-водителя "Люк зарыт" по команде командира включает ПРИВОД на передней панели комплекса 1А40-1';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='       - Через 1.5-2 мин расстопорить гироскоп прицела';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    РАССТ';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='       - Перевести рычаг расцепления червячной пары подъемного механизма пушки.';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='     СТАБ';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='      - Включить выключатель СТАБИЛ на приуельном комплексе 1А40-1';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    СТАБИЛ';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='      - Включить выключатель РУЧ.-АВТ на передней панели комплекса 1А40-1';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    АВТ';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='      - Включить выключатель Д на передней панели прицельного комплекса 1А40-1';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='      - Устанавливает дистанционную шкалу комплекса 1А40-1 на нулевые деления';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='      - Проверить установку потенциометров поправок УБВК';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='   О (или указанное командиром танка значение)';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='      - Включить выключатель МЕХ. dД ';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='   ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='      - Включить стабилизатор вооружения';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='';

/////////////Oper7//////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[9,num_punkt,1]:='       - Проверить исходное положение органов управления согласно п.1.1';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='       - Включить прицельный комплекс 1А40-1';
    Oper[9,num_punkt,2]:='+';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='+';
    Oper[9,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='       - Установить переключатель типов выстрелов ЗАГР.,У,О,Б,К';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    У';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='       - Установить, что тумблер У-ДЕНЬ - У-НОЧЬ';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    У-ДЕНЬ';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='       - Установить рычаг переключателя режимов на турели БОМ';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    Д';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='       - Установить рукоятку ДИАФРАГМА на передней панели БОМ';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    ОТКР';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='       - Установить рукоятку ШТОРКА на передней панели БОМ';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    ЗАКР';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='       - Установить рукоятку ВЫВЕРКА ПУ на передней панели БОМ';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='     ОТКЛ';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='      - Установить тумблер АВТ-РУЧ на пульте КА1С';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    АВТ';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='      - Включить тумблер У на передней панели прибора 1К13';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='      - Перевести рукоятку СТАБ.З в верхнее положение';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    ВЕРХНЕЕ ПОЛОЖ.';

/////////Oper8/////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[10,num_punkt,1]:='       - Отстопорить прибор';
    Oper[10,num_punkt,2]:='+';
    Oper[10,num_punkt,3]:='';
    Oper[10,num_punkt,4]:='';
    Oper[10,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[10,num_punkt,1]:='       - Установить рукоятки шторки и диафрагмы';
    Oper[10,num_punkt,2]:='+';
    Oper[10,num_punkt,3]:='';
    Oper[10,num_punkt,4]:='';
    Oper[10,num_punkt,5]:='    ЗАКР, ЗАКР';
    num_punkt:=num_punkt+1;
    Oper[10,num_punkt,1]:='       - Установить выключатель блока питания';
    Oper[10,num_punkt,2]:='+';
    Oper[10,num_punkt,3]:='';
    Oper[10,num_punkt,4]:='';
    Oper[10,num_punkt,5]:='    ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[10,num_punkt,1]:='       - Установить рукоятку диафрагмы';
    Oper[10,num_punkt,2]:='+';
    Oper[10,num_punkt,3]:='';
    Oper[10,num_punkt,4]:='';
    Oper[10,num_punkt,5]:='    Д';
    num_punkt:=num_punkt+1;
    Oper[10,num_punkt,1]:='       - Отстопорить и проверить поворот командирской башенки';
    Oper[10,num_punkt,2]:='+';
    Oper[10,num_punkt,3]:='';
    Oper[10,num_punkt,4]:='';
    Oper[10,num_punkt,5]:='';

////////Oper9/////////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[11,num_punkt,1]:='       - Остановить рукоятку механизма переключения режимов работы';
    Oper[11,num_punkt,2]:='+';
    Oper[11,num_punkt,3]:='';
    Oper[11,num_punkt,4]:='';
    Oper[11,num_punkt,5]:='    Н';
    num_punkt:=num_punkt+1;
    Oper[11,num_punkt,1]:='       - Включить блок питания прибора ТКН-3';
    Oper[11,num_punkt,2]:='+';
    Oper[11,num_punkt,3]:='';
    Oper[11,num_punkt,4]:='';
    Oper[11,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[11,num_punkt,1]:='       - Установить рукоятку ШТОРКА';
    Oper[11,num_punkt,2]:='+';
    Oper[11,num_punkt,3]:='';
    Oper[11,num_punkt,4]:='';
    Oper[11,num_punkt,5]:='    ОТКР';
    num_punkt:=num_punkt+1;
    Oper[11,num_punkt,1]:='       - Открыть диафрагму';
    Oper[11,num_punkt,2]:='+';
    Oper[11,num_punkt,3]:='';
    Oper[11,num_punkt,4]:='';
    Oper[11,num_punkt,5]:='    ОТКР';
////////Oper10.1.1////////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[12,num_punkt,1]:='      - Включить выключатель батарей';
    Oper[12,num_punkt,2]:='';
    Oper[12,num_punkt,3]:='';
    Oper[12,num_punkt,4]:='+';
    Oper[12,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[12,num_punkt,1]:='      - Запустить двигатель и установить частоту вращения коленчатого вала не менее 1250 об/мин. и закрыть люк';
    Oper[12,num_punkt,2]:='';
    Oper[12,num_punkt,3]:='';
    Oper[12,num_punkt,4]:='+';
    Oper[12,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[12,num_punkt,1]:='      - Проверить положение переключателей на правом распределительном щитке башни, все включены кроме -ЛЮК и -АЗ УПР.';
    Oper[12,num_punkt,2]:='+';
    Oper[12,num_punkt,3]:='';
    Oper[12,num_punkt,4]:='';
    Oper[12,num_punkt,5]:='    ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[12,num_punkt,1]:='      - Проверить положение переключателей на левом распределительном щитке башни, все включены кроме -ЭЛ.СПУСК, -ОСВ.АЗУ., ПУСК.УСТ';
    Oper[12,num_punkt,2]:='';
    Oper[12,num_punkt,3]:='+';
    Oper[12,num_punkt,4]:='';
    Oper[12,num_punkt,5]:='    ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[12,num_punkt,1]:='      - Проверить положение выключателя -АВТ.-РУЧ. на ПУ АЗ, наводчика при необходимости поставить в положение АВТ';
    Oper[12,num_punkt,2]:='';
    Oper[12,num_punkt,3]:='+';
    Oper[12,num_punkt,4]:='';
    Oper[12,num_punkt,5]:='    АВТ.';
    num_punkt:=num_punkt+1;
    Oper[12,num_punkt,1]:='      - Проверить положение переключателя типов снарядов на ПУ АЗ, наводчика, поставить в положение ВЫКЛ.';
    Oper[12,num_punkt,2]:='';
    Oper[12,num_punkt,3]:='+';
    Oper[12,num_punkt,4]:='';
    Oper[12,num_punkt,5]:='    ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[12,num_punkt,1]:='      - Проверить положение переключателя АВТ.-РУЧ.РАЗГР на ПЗ АЗ, при необходимости поставить в положение АВТ';
    Oper[12,num_punkt,2]:='+';
    Oper[12,num_punkt,3]:='';
    Oper[12,num_punkt,4]:='';
    Oper[12,num_punkt,5]:='    ВЫКЛ';
////////Oper10.1.2////////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[13,num_punkt,1]:='   Режим "автомат"';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   Порядок включения режима "автомат"';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Включить АЗР ЭЛ.СПУСК';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Включить АЗР ЛЮК';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - После доклада механика водителя "Люк закрыт", по команде командира включает ПРИВОД';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Через 1.5-2 мин расстопорить гироскоп прицел, при эом загорится сигнальная лампа РАССТ';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    РАССТ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Перевести рычаг расцепления червячной пары подъемного механизма пушки';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    СТАБ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Включить выключатель СТАБИЛ, при этом загорится лампа СТАБИЛ.';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    СТАБИЛ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   Порядок выключения режима "автомат"';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Выключить выключатель СТАБИЛ, при этом погаснет лампа СТАБИЛ.';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Перевести рычаг расцепления червячной пары подъемного механизма пушки';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    РУЧН';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Выключить выключатель ПРИВОД';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   Режим "полуавтомат"';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    РАССТ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   Порядок включения режима "полуавтомат"';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Включить выключатель ПРИВОД';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   Режим стабилизиованного наблюдения';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   Порядок включения режима стабилизированного наблюдения';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Включить выключатель ПРИВОД';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Через 1.5-2 мин расстопорить гироскоп прицела, при этом загорится сигнальная лампа РАССТ';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    РАССТ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   Порядок вылючения режима стабилизированного наблюдения ';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    РАССТ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Застопорить гироскоп прицела, при этом загорится сигнальная лампа ЗАСТ и погаснет лампа РАССТОП.';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ЗАСТ.';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Выключить выключатель ПРИВОД, при этом погаснет лампа ПРИВОД.';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ВЫКЛ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   Режим целеуказания';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   Порядок включения режима целеуказания';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Расстопорить командрскую башенку ';
    Oper[13,num_punkt,2]:='+';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Включить АЗР ЛЮК';
    Oper[13,num_punkt,2]:='+';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Повернуть рукоятки прибора ТКН-3 влево или вправо предупреди экипаж командой "Башня вправо(влево)"';
    Oper[13,num_punkt,2]:='+';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Нажать правую и левую кнопки прибора ТКН-3 в торцах рукояток';
    Oper[13,num_punkt,2]:='+';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Контролировать загорание сигнальной лампы КОМАНДИР(горит от момента нажатия до момента отпускания крмандиром кнопок)';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Отпустить кнопки целеуказания, при этом управление башни передается наводчику, гаснет лампа КОМАНДР';
    Oper[13,num_punkt,2]:='+';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='   ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   Режим аварийного поворота башни механиком-водителем';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   Порядок включения режима аварийного поворота башни';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - При закрытом люке механика-водителя и расстопоренной башне нажать и удерживать кнопку АВАРИЙНЫЙ ПОВОРОТ КОЛПАКА до выхода пушки за габариты танка';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='+';
    Oper[13,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Контролирует загорание сгнальной лампы КОМАНДИР';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - Проверить управление воружением от ПУ прицельного комплекса 1А40-1';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='   ';

////////Oper10.3.1////////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[14,num_punkt,1]:='   Включение комплекса 1А40-1';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='   Порядок включения режима "автомат"';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='      - Включить АЗР ЭЛ.СПУСК';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='+';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='      - Включить АЗР ЛЮК';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='+';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='      - После доклада механика водителя "Люк закрыт", по команде командира включает ПРИВОД';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='+';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='      - Через 1.5-2 мин расстопорить гироскоп прицел, при эом загорится сигнальная лампа РАССТ';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='+';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    РАССТ';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='      - Перевести рычаг расцепления червячной пары подъемного механизма пушки';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='+';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    СТАБ';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='      - Включить выключатель СТАБИЛ, при этом загорится лампа СТАБИЛ.';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='+';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    СТАБИЛ';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='   Порядок выключения режима "автомат"';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='      - Выключить выключатель СТАБИЛ, при этом погаснет лампа СТАБИЛ.';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='+';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ВКЛ';


////////Oper12.1////////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[15,num_punkt,1]:='       - Включить выключатель батарей';
    Oper[15,num_punkt,2]:='';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='+';
    Oper[15,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='       - Проверить положение переключателей на правом распределительном щитке башни';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='ЩИТОК ПР';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='             - СП. ПОД.';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='             - ДОС.';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='             - Л.Р.В.Т.';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='             - АЗ ЭМ.';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='     Вкл';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='             - АЗ УПР.';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='     Выкл';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='       - Проверить положение переключателей на левом распределительном щитке башни';
    Oper[15,num_punkt,2]:='';
    Oper[15,num_punkt,3]:='+';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='ЩИТОК ЛЕВ';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='             - ЭЛ. СПУСК';
    Oper[15,num_punkt,2]:='';
    Oper[15,num_punkt,3]:='+';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='     Выкл';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='      - Проверить положение органов управления  на ПУ АЗ (пульт управления) наводчика.';
    Oper[15,num_punkt,2]:='';
    Oper[15,num_punkt,3]:='+';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='            - ЗАГР., У,О,Б,К';
    Oper[15,num_punkt,2]:='';
    Oper[15,num_punkt,3]:='+';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='         О';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='            - АВТ.- РУЧ.';
    Oper[15,num_punkt,2]:='';
    Oper[15,num_punkt,3]:='+';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='      АВТ.';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='      - Проверить положение органов управления на ПЗ АЗ (пульте загрузки)';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='            - АВТ.-РУЧ. РАЗГР.';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='      АВТ.';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='            - ПОДДОН АВТ.-РУЧ.';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='      АВТ.';

////////Oper12.2////////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[16,num_punkt,1]:='      - Проверить положение переключателей АЗ УПР. на правом распределительном щитке';
    Oper[16,num_punkt,2]:='+';
    Oper[16,num_punkt,3]:='';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - Проверить положение переключателей АЗ УПР. на левом распределительном щитке';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='    ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - Проверить положение переключателя АВТ. -РУЧ и переключателя типов выстрелов на ПУ АЗ';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     АВТ, Б(О или К)';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - Проверить положение переключателя АВТ. -РУЧ на ПЗ АЗ';
    Oper[16,num_punkt,2]:='+';
    Oper[16,num_punkt,3]:='';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     АВТ';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - Запустить двигатель танка и установить эксплуатационные обороты (1250 об/мин)';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='';
    Oper[16,num_punkt,4]:='+';
    Oper[16,num_punkt,5]:='     ';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - После доклада механика-водителя "Люк закрыт", по команде командира танка включить ПРИВОД(загорается зеленая лампочка)';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - Через 1.5-2 мин. расстопорить гироскоп прицела, при этом загорается синальная лампа РАССТ';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     РАССТ';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - Перевести рычаг расцепления червячной пары подъемного механизма пушки в положение СТАБ.(загорается лампа СТАБИЛ.)';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     СТАБ.';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - Включить выключтель СТАБИЛ (загорается лампа СТАБИЛ.)';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     СТАБИЛ.';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - Включить выключатель РУЧ.-АВТ на передей панели прицельного комплекса';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     АВТ';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - Включить выключатель Д. на передней панели прицельного комплекса(загораеся лампа ОТРАБОТКА Д, не позднее чем через 30 с. ГОТОВ Д и дальномерная мерка)';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     ВКЛ';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - Установить дистанционную шкалу прицельного комплекса на нулевые деления';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='      ';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - Проверить установку рукоятки на потенциометре поправок прицельного комплекса УВБВ и УВП в 0 положение';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='      0';

////////Oper12.3////////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[17,num_punkt,1]:='      - Навести прицел дальномера в небо';
    Oper[17,num_punkt,2]:='';
    Oper[17,num_punkt,3]:='+';
    Oper[17,num_punkt,4]:='';
    Oper[17,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[17,num_punkt,1]:='      - При нейтральном положении ПУ и любой установленной балистике нажать кнопку измрения дальности';
    Oper[17,num_punkt,2]:='';
    Oper[17,num_punkt,3]:='+';
    Oper[17,num_punkt,4]:='';
    Oper[17,num_punkt,5]:='    БИД-"..." Дальность ПЗ-"800+-80" Цифроиндикатор-"-00.0"';
    num_punkt:=num_punkt+1;
    Oper[17,num_punkt,1]:='      - Отпустить кнопку - показания цифроиндикатора гаснут';
    Oper[17,num_punkt,2]:='';
    Oper[17,num_punkt,3]:='+';
    Oper[17,num_punkt,4]:='';
    Oper[17,num_punkt,5]:='     ';
    num_punkt:=num_punkt+1;
    Oper[17,num_punkt,1]:='      - Установить переключатель типов выстрелов в положения О,Б или К и в процессе наведения нажать кнопку измерения дальности на цифроиндикаторе должны появиться величина и знак упреждеия';
    Oper[17,num_punkt,2]:='';
    Oper[17,num_punkt,3]:='+';
    Oper[17,num_punkt,4]:='';
    Oper[17,num_punkt,5]:='     АВТ';


end;



procedure TFOper.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled:=false;
end;

//В данной процедуре идет проверка изменения состояния органов управления
procedure TFOper.Timer1Timer(Sender: TObject);
begin
case numEx of
11: begin                                                   //
      if (Org_Upr.vod_imp[0,0] <> Org_Upr2.vod_imp[0,0]) or //
         (Org_Upr.kom_imp[3]   <> Org_Upr2.kom_imp[3])   or //
         (Org_Upr.kom_imp[5]   <> Org_Upr2.kom_imp[5])   or //
         (Org_Upr.nav_imp[0,1] <> Org_Upr2.nav_imp[0,1]) or //
         (Org_Upr.nav_imp[7,0] <> Org_Upr2.nav_imp[7,0]) or //
         (flag11 = false)
            then checkpos11(1);                             //
      if cp11 = 17 then begin                               //
        Trenir.Show;                                         //
        cp11 := 2;                                          //
      end;                                                  //
    end;                                                    //

12: begin
      if (Org_Upr.kom_imp[5]   <> Org_Upr2.kom_imp[5])   or
         (Org_Upr.nav_imp[0,1] <> Org_Upr2.nav_imp[0,1]) or
         (Org_Upr.kom_imp[3]   <> Org_Upr2.kom_imp[3])   or
         (Org_Upr.nav_imp[7,0] <> Org_Upr2.nav_imp[7,0]) or
         (flag12 = false)
            then checkpos12;
      if cp12 = 11 then begin
        Trenir.Show;
        cp12 := 2;
      end;
    end;

13: begin
      if (Org_Upr.kom_imp[5]   <> Org_Upr2.kom_imp[5])   or
         (Org_Upr.nav_imp[0,1] <> Org_Upr2.nav_imp[0,1]) or
         (Org_Upr.kom_imp[3]   <> Org_Upr2.kom_imp[3])   or
         (Org_Upr.nav_imp[7,0] <> Org_Upr2.nav_imp[7,0]) or
         (flag13 = false)
            then checkpos13;
      if cp13 = 11 then begin
        Trenir.Show;
        cp13 := 2;
      end;
    end;

20: begin
      if (Org_Upr.kom_imp[0]   <> Org_Upr2.kom_imp[0])   or
         (Org_Upr.kom_imp[1]   <> Org_Upr2.kom_imp[1])   or
         (Org_Upr.kom_imp[2]   <> Org_Upr2.kom_imp[2])   or
         (Org_Upr.kom_imp[5]   <> Org_Upr2.kom_imp[5])   or
         (Org_Upr.nav_imp[0,1] <> Org_Upr2.nav_imp[0,1]) or
         (Org_Upr.kom_imp[3]   <> Org_Upr2.kom_imp[3])   or
         (Org_Upr.nav_imp[7,0] <> Org_Upr2.nav_imp[7,0]) or
         (Org_Upr.nav_imp[6,0] <> Org_Upr2.nav_imp[6,0]) or
         (Org_Upr.nav_imp[4,0] <> Org_Upr2.nav_imp[4,0]) or
         (Org_Upr.vod_imp[0,1] <> Org_Upr2.vod_imp[0,1]) or
         (Org_Upr.nav_imp[5,1] <> Org_Upr2.nav_imp[5,1]) or
         (Org_Upr.nav_imp[2,1] <> Org_Upr2.nav_imp[2,1]) or
         (flag2 = false)
            then begin

              checkpos2;

            end;
      if cp2 = 34 then begin
        Trenir.Show;
        cp2 := 2;
      end;
    end;

   end;
   //Дальнейшие строки (до конца процедуры)должны быть удалены в
   // конечном варианте
   If Org_Upr.vod_imp[0,0] and $40=$00 then Label2.Caption:='Вкл'
    else Label2.Caption:='Выкл';

   If Org_Upr.kom_imp[3] and $08 = $00 then Label3.Caption:='Вкл'
    else Label3.Caption:='Выкл';

   If Org_Upr.kom_imp[3] and $04 = $00 then Label4.Caption:='Вкл'
    else Label4.Caption:='Выкл';

   If Org_Upr.kom_imp[3] and $02 = $00 then Label5.Caption:='Вкл'
    else Label5.Caption:='Выкл';

   If Org_Upr.kom_imp[3] and $01 = $00 then Label6.Caption:='Вкл'
    else Label6.Caption:='Выкл';

   If Org_Upr.kom_imp[3] and $20 = $00 then Label11.Caption:= 'Руч'
    else Label11.Caption:='Авт';

   If Org_Upr.kom_imp[5] and $04 = $00 then Label7.Caption:='Вкл'
    else Label7.Caption:='Выкл';

   If Org_Upr.kom_imp[5] and $40 = $00 then Label12.Caption:= 'Руч'
    else Label12.Caption:='Авт';

   If Org_Upr.nav_imp[0,1] and $02 = $00 then Label8.Caption:= 'Вкл'
    else Label8.Caption:='Выкл';

   If Org_Upr.nav_imp[7,0] and $40 = $00 then Label10.Caption:= 'Руч'
    else Label10.Caption:='Авт';

   If Org_Upr.nav_imp[7,0] and $80 = $00 then Label14.Caption:= 'Вкл'
    else Label14.Caption:='Выкл';

   If Org_Upr.kom_imp[3] and $10 = $00 then Label15.Caption:= 'Вкл'
    else Label15.Caption:='Выкл';

   if (Org_Upr.nav_imp[7,0] and $20 = $00) and
    (Org_Upr.nav_imp[7,0] and $10 = $10) then Label9.Caption:= 'ЗАГР'
    else Label9.Caption:='У';

   if (Org_Upr.kom_imp[1] and $01 = $00) then label30.Caption:='1';
   if (Org_Upr.kom_imp[1] and $02 = $00) then label30.Caption:='2';
   if (Org_Upr.kom_imp[1] and $04 = $00) then label30.Caption:='3';
   if (Org_Upr.kom_imp[1] and $08 = $00) then label30.Caption:='4';
   if (Org_Upr.kom_imp[1] and $10 = $00) then label30.Caption:='5';
   if (Org_Upr.kom_imp[1] and $20 = $00) then label30.Caption:='6';

   if (Org_Upr.kom_imp[2] and $01 = $00) then label31.Caption:='1';
   if (Org_Upr.kom_imp[2] and $02 = $00) then label31.Caption:='2';
   if (Org_Upr.kom_imp[2] and $04 = $00) then label31.Caption:='3';
   if (Org_Upr.kom_imp[2] and $08 = $00) then label31.Caption:='4';
   if (Org_Upr.kom_imp[2] and $10 = $00) then label31.Caption:='5';

   If Org_Upr.kom_imp[0] and $20 = $00 then Label32.Caption:= 'Вкл'
    else Label32.Caption:='Выкл';

   If Org_Upr.kom_imp[0] and $02 = $00 then Label34.Caption:= 'Д'
    else Label34.Caption:='Н';

   If Org_Upr.kom_imp[5] and $80 = $00 then Label36.Caption:= 'ЗАСТОП'
    else Label36.Caption:='РАССТОП';

   If Org_Upr.nav_imp[0,1] and $80 = $00 then Label38.Caption:= 'ОТКР'
    else Label38.Caption:='ЗАКР';

   if Org_Upr.vod_imp[0,1] and $04 = $00 then Label40.Caption:= 'ЗАКР'
    else Label40.Caption:='ОТКР';

   if Org_Upr.nav_imp[7,0] and $04 = $00 then Label42.Caption:= 'ВКЛ'
    else Label42.Caption:='ВЫКЛ';

   if Org_Upr.nav_imp[5,1] and $01 = $00 then Label44.Caption:= 'РАССТОП'
    else Label44.Caption:='ЗАСТОП';

   if Org_Upr.nav_imp[2,1] and $40 = $00 then Label46.Caption:= 'РАССТОП'
    else Label46.Caption:='ЗАСТОП';

   if Org_Upr.nav_imp[5,1] and $04 = $00 then Label48.Caption:= 'СТАБ'
    else Label48.Caption:='РУЧ';

   if Org_Upr.nav_imp[7,0] and $02 = $00 then Label50.Caption:= 'ВКЛ'
    else Label50.Caption:='ВЫКЛ';

   if Org_Upr.nav_imp[6,0] and $40 = $00 then Label52.Caption:= 'РУЧ'
    else Label52.Caption:='АВТ';

   if Org_Upr.nav_imp[4,0] and $20 = $00 then Label54.Caption:= 'ВКЛ'
    else Label54.Caption:='ВЫКЛ';

   if Org_Upr.nav_imp[7,0] and $01 = $00 then Label56.Caption:= 'ВКЛ'
    else Label56.Caption:='ВЫКЛ';

end;
//Процедуры обработки  алгоритмов
procedure TFOper.CheckPos11(kind: integer);
var
  CurCol: TColor; // Вспомогательная переменная для запоминания цвета
begin

if flag11 = true then begin
   flag11:=false;
  if cp11 = 2 then begin
    if (org_upr.vod_imp[0,0] and $40=$00)  then begin
      flag11:=true;
      cp11:=4;
      org_upr2.vod_imp[0,0]:=org_upr.vod_imp[0,0];
    end;
  end;

   if cp11 = 4 then begin
      if org_upr.kom_imp[3] and $08=$00 then begin
        flag11:=true;
        cp11:=5;
        org_upr2.kom_imp[3]:=org_upr.kom_imp[3];
      end;
    end;

  if cp11 = 5 then begin
    if org_upr.kom_imp[3] and $04=$00 then begin
      flag11:=true;
      cp11:=cp11+1;
      org_upr2.kom_imp[3]:=org_upr.kom_imp[3];
    end;
  end;

  if cp11 = 6 then begin
    if org_upr.kom_imp[3] and $02=$00 then begin
      flag11:=true;
      cp11:=cp11+1;
      org_upr2.kom_imp[3]:=org_upr.kom_imp[3];
    end;
  end;

  if cp11 = 7 then begin
    if org_upr.kom_imp[3] and $01=$00 then begin
      flag11:=true;
      cp11:=cp11+1;
      org_upr2.kom_imp[3]:=org_upr.kom_imp[3];
    end;
  end;

  if cp11 = 8 then begin
    if org_upr.kom_imp[5] and $04=$04 then begin
      flag11:=true;
      cp11:=15;
      org_upr2.kom_imp[5]:=org_upr.kom_imp[5];
    end;
  end;

  if cp11 = 10 then begin
    if org_upr.nav_imp[0,1] and $02=$02 then begin
      flag11:=true;
      cp11:=cp11+2;
      org_upr2.nav_imp[0,1]:=org_upr.nav_imp[0,1];
    end;
  end;

  if cp11 = 12 then begin
    if org_upr.nav_imp[7,0] and $10=$00 then begin
      flag11:=true;
      cp11:=cp11+1;
      org_upr2.nav_imp[7,0]:=org_upr.nav_imp[7,0];
    end;
  end;


  if cp11 = 13 then begin
    if org_upr.nav_imp[7,0] and $40=$40 then begin
      flag11:=true;
      cp11:=cp11+2;
      org_upr2.nav_imp[7,0]:=org_upr.nav_imp[7,0];
    end;
  end;

  if cp11 = 15 then begin
    if org_upr.kom_imp[3] and $20=$20 then begin
      flag11:=true;
      cp11:=cp11+1;
      org_upr2.kom_imp[3]:=org_upr.kom_imp[3];
    end;
  end;

  if cp11 = 16 then begin
    if org_upr.kom_imp[5] and $40=$40 then begin
      flag11:=true;
      cp11:=cp11+1;
      org_upr2.kom_imp[5]:=org_upr.kom_imp[5];
    end;
  end;
  formpaint(nil);
end else begin
           if (Org_Upr.vod_imp[0,0] <> Org_Upr2.vod_imp[0,0]) or //
              (Org_Upr.kom_imp[3]   <> Org_Upr2.kom_imp[3])   or //
              (Org_Upr.kom_imp[5]   <> Org_Upr2.kom_imp[5])   or //
              (Org_Upr.nav_imp[0,1] <> Org_Upr2.nav_imp[0,1]) or //
              (Org_Upr.nav_imp[7,0] <> Org_Upr2.nav_imp[7,0]) then begin
                 //label29.Caption:='ОШИБОЧКА ВЫШЛА';
                  csgl.CleanScr(Canvas,150,233,750,366,clRed);
                  CurCol:=Canvas.Brush.color;
                  Canvas.brush.Color:=clRed;
                  Canvas.TextOut(160,290,'Нарушена последовательность. Верните ручку обратно');
                  Canvas.Brush.Color:=CurCol;
              end else begin
                label29.Caption:='';
                flag11:=true;
                formpaint(nil);
              end;

         end;
end;
 // Предварительный просмотр положения органов управления
 // при установке в исходное положение
function TFOper.PreCheckPos11: integer;
begin
  if org_upr.kom_imp[5] and $40=$40 then   cp11:=17;
  if org_upr.kom_imp[5] and $40<>$40 then   cp11:=16;
  if org_upr.kom_imp[3] and $20<>$20   then cp11:=15;
  if org_upr.nav_imp[7,0] and $40<>$40 then   cp11:=13;
  if org_upr.nav_imp[7,0] and $10<>$00 then cp11:=12;
  if org_upr.nav_imp[0,1] and $02<>$02 then cp11:=10;
  if org_upr.kom_imp[5] and $04<>$04 then   cp11:=8;
  if org_upr.kom_imp[3] and $01<>$00 then   cp11:=7;
  if org_upr.kom_imp[3] and $02<>$00 then   cp11:=6;
  if org_upr.kom_imp[3] and $04<>$00 then   cp11:=5;
  if org_upr.kom_imp[3] and $08<>$00 then   cp11:=4;
  if org_upr.vod_imp[0,0] and $40<>$00 then cp11:=2;
  labelb.Caption:=inttostr(cp11);
end;

procedure TFOper.CheckPos12;
var
  CurCol: TColor;
begin
if flag12 = true then begin
   flag12:=false;
  if cp12 = 2 then begin
    if org_upr.nav_imp[0,1] and $02=$00 then begin
      flag12:=true;
      cp12:=cp12+1;
      org_upr2.nav_imp[0,1]:=org_upr.nav_imp[0,1];
    end;
  end;

  if cp12 = 3 then begin
    if org_upr.kom_imp[5] and $04=$00 then begin
      flag12:=true;
      cp12:=cp12+1;
      org_upr2.kom_imp[5]:=org_upr.kom_imp[5];
    end;
  end;

   if cp12 = 4 then begin
    if org_upr.kom_imp[3] and $20=$00 then begin
      flag12:=true;
      cp12:=cp12+1;
      org_upr2.kom_imp[3]:=org_upr.kom_imp[3];
    end;
  end;

  if cp12 = 5 then begin
    if (org_upr.nav_imp[7,0] and $20=$00) and
    (org_upr.nav_imp[7,0] and $10=$10) then begin
      flag12:=true;
      cp12:=cp12+1;
      org_upr2.nav_imp[7,0]:=org_upr.nav_imp[7,0];
    end;
  end;

  if cp12 = 6 then begin
    if Org_Upr.nav_imp[7,0] and $80=$00 then begin
      flag12:=true;
      cp12:=cp12+1;
    end;
  end;

  if cp12 = 7 then begin
    if (org_upr.nav_imp[7,0] and $10=$00) and
       (org_upr.nav_imp[7,0] and $20=$20) then begin
      flag12:=true;
      cp12:=cp12+1;
      org_upr2.nav_imp[7,0]:=org_upr.nav_imp[7,0];
    end;
   end;

   if cp12 = 8 then begin
    if Org_Upr.nav_imp[7,0] and $80=$00 then begin
      flag12:=true;
      cp12:=cp12+2;
    end;
  end;

  if cp12 = 10 then begin
   if  (org_upr.nav_imp[0,1] and $02=$02) or
       (org_upr.kom_imp[5]   and $04=$04) or
       (org_upr.kom_imp[3]   and $20=$20) or
       (org_upr.nav_imp[7,0] and $10=$00) or
       (org_upr.nav_imp[7,0] and $20=$20) then begin
         flag12:=true;
         if  (org_upr.nav_imp[0,1] and $02=$02) and
       (org_upr.kom_imp[5]   and $04=$04) and
       (org_upr.kom_imp[3]   and $20=$20) and
       (org_upr.nav_imp[7,0] and $10=$00) and
       (org_upr.nav_imp[7,0] and $20=$20) then begin
         cp12:=cp12+1;
         org_upr2.nav_imp[0,1]:=org_upr.nav_imp[0,1];
         org_upr2.kom_imp[5]:=org_upr.kom_imp[5];
         org_upr2.kom_imp[3]:=org_upr.kom_imp[3];
         org_upr2.nav_imp[7,0]:=org_upr.nav_imp[7,0];
         end;
       end;

  end;
  formpaint(nil);
  end else begin
          if (Org_Upr.kom_imp[5]   <> Org_Upr2.kom_imp[5])   or
            (Org_Upr.nav_imp[0,1] <> Org_Upr2.nav_imp[0,1]) or
            (Org_Upr.kom_imp[3]   <> Org_Upr2.kom_imp[3])   or
            (Org_Upr.nav_imp[7,0] <> Org_Upr2.nav_imp[7,0])  then begin
                 csgl.CleanScr(Canvas,150,233,750,366,clRed);
                  CurCol:=Canvas.Brush.color;
                  Canvas.brush.Color:=clRed;
                  Canvas.TextOut(160,290,'Нарушена последовательность. Верните ручку обратно');
                  Canvas.Brush.Color:=CurCol;
              end else begin
                label29.Caption:='';
                flag12:=true;
                formpaint(nil);
              end;

          end;
end;
function TFOper.PreCheckPos12: integer;
begin
  labelb.Caption:=inttostr(cp12);
end;

procedure TFOper.CheckPos13;
var
  CurCol: TColor;
begin
if flag13 = true then begin
   flag13:=false;
  if cp13 = 2 then begin
    if org_upr.nav_imp[0,1] and $02=$00 then begin
      flag13:=true;
      cp13:=cp13+1;
      org_upr2.nav_imp[0,1]:=org_upr.nav_imp[0,1];
    end;
  end;

  if cp13 = 3 then begin
    if org_upr.kom_imp[5] and $04=$00 then begin
      flag13:=true;
      cp13:=cp13+1;
      org_upr2.kom_imp[5]:=org_upr.kom_imp[5];
    end;
  end;

   if cp13 = 4 then begin
    if org_upr.kom_imp[3] and $20=$00 then begin
      flag13:=true;
      cp13:=cp13+1;
      org_upr2.kom_imp[3]:=org_upr.kom_imp[3];
    end;
  end;

  if cp13 = 5 then begin
    if (org_upr.nav_imp[7,0] and $10=$00) and
       (org_upr.nav_imp[7,0] and $20=$20) then begin
      flag13:=true;
      cp13:=cp13+1;
      org_upr2.nav_imp[7,0]:=org_upr.nav_imp[7,0];
    end;
   end;

   if cp13 = 6 then begin
    if Org_Upr.nav_imp[7,0] and $80=$00 then begin
      flag13:=true;
      cp13:=cp13+1;
    end;
  end;

  if cp13 = 7 then begin
    if Org_Upr.kom_imp[3] and $10=$00 then begin
      flag13:=true;
      cp13:=cp13+2;
    end;
  end;

  if (cp13 = 9) and (hhh<>10000) then begin
    if org_upr.kom_imp[5] and $04=$04 then begin
      flag13:=true;
      hhh:=10000;
      org_upr2.kom_imp[5]:=org_upr.kom_imp[5];
    end;
  end;

  if (cp13 = 9) and (hhh=10000) then begin
    if org_upr.kom_imp[5] and $04=$00 then begin
      flag13:=true;
      cp13:=cp13+1;
      org_upr2.kom_imp[5]:=org_upr.kom_imp[5];
    end;
  end;

  if cp13 = 10 then begin
   if  (org_upr.nav_imp[0,1] and $02=$02) or
       (org_upr.kom_imp[5]   and $04=$04) or
       (org_upr.kom_imp[3]   and $20=$20) or
       (org_upr.nav_imp[7,0] and $10=$00) or
       (org_upr.nav_imp[7,0] and $20=$20) then begin
         flag13:=true;
      if (org_upr.nav_imp[0,1] and $02=$02) and
       (org_upr.kom_imp[5]   and $04=$04) and
       (org_upr.kom_imp[3]   and $20=$20) and
       (org_upr.nav_imp[7,0] and $10=$00) and
       (org_upr.nav_imp[7,0] and $20=$20) then begin
         cp13:=cp13+1;
         org_upr2.nav_imp[0,1]:=org_upr.nav_imp[0,1];
         org_upr2.kom_imp[5]:=org_upr.kom_imp[5];
         org_upr2.kom_imp[3]:=org_upr.kom_imp[3];
         org_upr2.nav_imp[7,0]:=org_upr.nav_imp[7,0];
         end;
       end;
   end;
   formpaint(nil);
end else begin
         if (Org_Upr.kom_imp[5]   <> Org_Upr2.kom_imp[5])   or
            (Org_Upr.nav_imp[0,1] <> Org_Upr2.nav_imp[0,1]) or
            (Org_Upr.kom_imp[3]   <> Org_Upr2.kom_imp[3])   or
            (Org_Upr.nav_imp[7,0] <> Org_Upr2.nav_imp[7,0])  then begin
                 //label29.Caption:='ОШИБОЧКА ВЫШЛА';
                  csgl.CleanScr(Canvas,150,233,750,366,clRed);
                  CurCol:=Canvas.Brush.color;
                  Canvas.brush.Color:=clRed;
                  Canvas.TextOut(160,290,'Нарушена последовательность. Верните ручку обратно');
                  Canvas.Brush.Color:=CurCol;
              end else begin
                label29.Caption:='';
                flag13:=true;
                formpaint(nil);
              end;
         end;
end;

procedure TFOper.CheckPos2;
var
  CurCol: TColor;
begin


if cp2 = 2 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;

if cp2 = 3 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;

if cp2 = 4 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+2;
      formpaint(nil);
    end;

if cp2 = 11 then begin
    if Org_Upr.nav_imp[0,1] and $80=$00 then begin
      flag2:=true;
      cp2:=cp2+2;
      Org_Upr2.nav_imp[0,1]:=Org_Upr.nav_imp[0,1];
    end;
end;

if cp2 = 13 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;

    if cp2 = 20 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;

  if cp2 = 21 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;

  if cp2 = 22 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;

  if cp2 = 23 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+3;
      formpaint(nil);
    end;

  if cp2 = 26 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+4;
      formpaint(nil);
    end;

  if cp2 = 30 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;

  if cp2 = 31 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;

  if cp2 = 32 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;
    if cp2 = 35 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;
    if cp2 = 36 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;
    if cp2 = 38 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;

    if cp2 = 50 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;

    if cp2 = 51 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+3;
      formpaint(nil);
    end;

    if cp2 = 54 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;

    if cp2 = 55 then begin
      flag2:=true;
      AlarmClock(secon);
      cp2:=cp2+1;
      formpaint(nil);
    end;

if flag2 = true then begin
   flag2:=false;
   if cp2 = 6 then begin
    if Org_Upr.kom_imp[3] and $08=$00 then begin
      flag2:=true;
      cp2:=cp2+1;
      org_upr2.kom_imp[3]:=org_upr.kom_imp[3];
    end;
  end;

  if cp2 = 7 then begin
    if Org_Upr.kom_imp[3] and $04=$00 then begin
      flag2:=true;
      cp2:=cp2+1;
      org_upr2.kom_imp[3]:=org_upr.kom_imp[3];
    end;
  end;

  if cp2 = 8 then begin
    if org_upr.kom_imp[3] and $02=$00 then begin
      flag2:=true;
      cp2:=cp2+1;
      org_upr2.kom_imp[3]:=org_upr.kom_imp[3];
    end;
  end;

  if cp2 = 9 then begin
    if org_upr.kom_imp[3] and $01=$00 then begin
      flag2:=true;
      cp2:=cp2+1;
      org_upr2.kom_imp[3]:=org_upr.kom_imp[3];
    end;
  end;

  if cp2 = 10 then begin
    if org_upr.kom_imp[5] and $04=$04 then begin
      cp2:=cp2+1;
      org_upr2.kom_imp[5]:=org_upr.kom_imp[5];
    end;
  end;

  if cp2 = 14 then begin
    if (org_upr.kom_imp[1] and $3F=$00) and
        (org_upr.kom_imp[2] and $1F=$00) then begin
      flag2:=true;
      cp2:=cp2+1;
      org_upr2.kom_imp[1]:=org_upr.kom_imp[1];
      org_upr2.kom_imp[2]:=org_upr.kom_imp[2];
    end;
  end;

  if cp2 = 15 then begin
    if org_upr.kom_imp[0] and $20=$20 then begin
      flag2:=true;
      cp2:=cp2+1;
      org_upr2.kom_imp[0]:=org_upr.kom_imp[0];
    end;
  end;
   label1.Caption:=IntToStr(cp2);
  if cp2 = 16 then begin
    if org_upr.kom_imp[0] and $02=$00 then begin
      flag2:=true;
      cp2:=cp2+1;
      org_upr2.kom_imp[0]:=org_upr.kom_imp[0];
    end;
  end;

  if cp2 = 17 then begin
    if org_upr.kom_imp[5] and $80=$80 then begin
      flag2:=true;
      cp2:=cp2+1;
      org_upr2.kom_imp[5]:=org_upr.kom_imp[5];
    end;
  end;

  if cp2 = 18 then begin
    if org_upr.vod_imp[0,1] and $04=$00 then begin
      flag2:=true;
      cp2:=cp2+1;
      org_upr2.vod_imp[0,1]:=org_upr.vod_imp[0,1];
    end;
  end;

  if cp2 = 19 then begin
    if org_upr.nav_imp[7,0] and $04=$00 then begin
      cp2:=cp2+1;
      org_upr2.nav_imp[7,0]:=org_upr.nav_imp[7,0];
    end;
  end;

    if cp2 = 37 then begin
      if org_upr.nav_imp[5,1] and $01=$00 then begin
        cp2:=cp2+1;
        org_upr2.nav_imp[5,1]:=org_upr.nav_imp[5,1];
      end;
    end;

    if cp2 = 39 then begin
      if org_upr.nav_imp[7,0] and $04=$00 then begin
        cp2:=cp2+2;
        org_upr2.nav_imp[7,0]:=org_upr.nav_imp[7,0];
      end;
    end;

    if cp2 = 41 then begin
      if org_upr.kom_imp[5] and $04=$00 then begin
        flag2:=true;
        cp2:=cp2+1;
        org_upr2.kom_imp[5]:=org_upr.kom_imp[5];
      end;
    end;

    if cp2 = 42 then begin
      if org_upr.nav_imp[0,1] and $02=$00 then begin
        flag2:=true;
        cp2:=cp2+1;
        org_upr2.nav_imp[0,1]:=org_upr.nav_imp[0,1];
      end;
    end;

    if cp2 = 43 then begin
      if org_upr.nav_imp[7,0] and $40=$40 then begin
        flag2:=true;
        cp2:=cp2+1;
        org_upr2.nav_imp[7,0]:=org_upr.nav_imp[7,0];
      end;
    end;

    if cp2 = 44 then begin
      if org_upr.kom_imp[3] and $20=$20 then begin
        flag2:=true;
        cp2:=cp2+1;
        org_upr2.kom_imp[3]:=org_upr.kom_imp[3];
      end;
    end;

    if cp2 = 45 then begin
      if org_upr.nav_imp[2,1] and $40=$00 then begin
        flag2:=true;
        cp2:=cp2+1;
        org_upr2.nav_imp[2,1]:=org_upr.nav_imp[2,1];
      end;
    end;

    if cp2 = 46 then begin
      if org_upr.nav_imp[5,1] and $04=$00 then begin
        flag2:=true;
        cp2:=cp2+1;
        org_upr2.nav_imp[5,1]:=org_upr.nav_imp[5,1];
      end;
    end;

    if cp2 = 47 then begin
      if org_upr.nav_imp[7,0] and $02=$00 then begin
        flag2:=true;
        cp2:=cp2+1;
        org_upr2.nav_imp[7,0]:=org_upr.nav_imp[7,0];
      end;
    end;

    if cp2 = 48 then begin
      if org_upr.nav_imp[6,0] and $40=$40 then begin
        flag2:=true;
        cp2:=cp2+1;
        org_upr2.nav_imp[6,0]:=org_upr.nav_imp[6,0];
      end;
    end;

    if cp2 = 49 then begin
      if org_upr.nav_imp[4,0] and $20=$00 then begin
        cp2:=cp2+1;
        org_upr2.nav_imp[4,0]:=org_upr.nav_imp[4,0];
      end;
    end;

    if cp2 = 56 then begin
      if org_upr.nav_imp[4,1] and $02=$00 then begin
        flag2:=true;
        cp2:=cp2+2;
        org_upr2.nav_imp[4,1]:=org_upr.nav_imp[4,1];
      end;
    end;
    if cp2 = 33 then begin
      cp2:=cp2+1;
    end;
   formpaint(nil);
end else begin
         if (Org_Upr.kom_imp[5]   <> Org_Upr2.kom_imp[5])   or
            (Org_Upr.nav_imp[0,1] <> Org_Upr2.nav_imp[0,1]) or
            (Org_Upr.vod_imp[0,1] <> Org_Upr2.vod_imp[0,1]) or
            (Org_Upr.kom_imp[3]   <> Org_Upr2.kom_imp[3])   or
            (Org_Upr.nav_imp[7,0] <> Org_Upr2.nav_imp[7,0]) or
            (Org_Upr.nav_imp[6,0] <> Org_Upr2.nav_imp[6,0]) or
            (Org_Upr.nav_imp[4,0] <> Org_Upr2.nav_imp[4,0]) or
            (Org_Upr.nav_imp[5,1] <> Org_Upr2.nav_imp[5,1]) or
            (Org_Upr.nav_imp[2,1] <> Org_Upr2.nav_imp[2,1])  then begin

                  csgl.CleanScr(Canvas,XX,283,XX+600,416,clRed);
                  CurCol:=Canvas.Brush.color;
                  Canvas.brush.Color:=clRed;
                  Canvas.TextOut(XX+10,YY+190,'Нарушена последовательность. Верните ручку обратно');
                  Canvas.Brush.Color:=CurCol;
              end else begin
                label29.Caption:='';
                flag2:=true;
                formpaint(nil);
              end;

          end;
end;
function TFOper.PreCheckPos13: integer;
begin
 labelb.Caption:=inttostr(cp13);
end;

procedure TFOper.FormPaint(Sender: TObject);
var i,j: integer;
  textt:array[0..2] of string;
begin

  case numEx of
11: begin
      OutputText(Oper[1,cp11-1],Oper[1,cp11],Oper[1,cp11+1]);
      Trenir.Caption:=Trenir.TreeView1.Selected.Parent.Text;
      PreCheckPos11;
    end;

12:  begin
       OutputText(Oper[2,cp12-1],Oper[2,cp12],Oper[2,cp12+1]);
       Trenir.Caption:=Trenir.TreeView1.Selected.Parent.Text;
       PreCheckPos12;
     end;

13:  begin
       OutputText(Oper[3,cp13-1],Oper[3,cp13],Oper[3,cp13+1]);
       Trenir.Caption:=Trenir.TreeView1.Selected.Parent.Text;
       PreCheckPos13;
     end;

20:  begin
      OutputText(Oper[4,cp2-1],Oper[4,cp2],Oper[4,cp2+1]);
      Trenir.Caption:=Trenir.TreeView1.Selected.Text;
    end;

30:  begin
      OutputText(Oper[5,cp3-1],Oper[5,cp3],Oper[5,cp3+1]);
      Trenir.Caption:=Trenir.TreeView1.Selected.Text;
    end;

40:  begin
     Label1.Caption:=Trenir.TreeView1.Selected.Text;
     for i:=1 to Length(Oper[6]) do begin
      for j:=1 to Length(Oper[6,1]) do begin
      end;
     end;
    end;

50:  begin
     Label1.Caption:=Trenir.TreeView1.Selected.Text;
     for i:=1 to Length(Oper[7]) do begin
      for j:=1 to Length(Oper[7,1]) do begin
      end;
     end;
    end;

60:  begin
      Label1.Caption:=Trenir.TreeView1.Selected.Text;
    end;

70:  begin
     Label1.Caption:=Trenir.TreeView1.Selected.Text;
    end;

80:  begin
      Label1.Caption:=Trenir.TreeView1.Selected.Text;
    end;

90:  begin
      Label1.Caption:=Trenir.TreeView1.Selected.Text;
    end;



1011: begin
        Label1.Caption:=Trenir.TreeView1.Selected.Text;
      end;

1012:  begin
        Label1.Caption:=Trenir.TreeView1.Selected.Text;
       end;

1031:  begin
         Label1.Caption:=Trenir.TreeView1.Selected.Text;
       end;

121:  begin
        Label1.Caption:=Trenir.TreeView1.Selected.Text;
      end;

122:  begin
        Label1.Caption:=Trenir.TreeView1.Selected.Text;
       end;

123:  begin
        Label1.Caption:=Trenir.TreeView1.Selected.Text;
      end;
  end;
  labela.Caption:=IntToStr(numEx);

end;

procedure TFOper.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case key of
48: begin
      Org_Upr.nav_imp[7,0]:=Org_Upr.nav_imp[7,0] or $80;
    end;
189:begin
      Org_Upr.kom_imp[3]:=Org_Upr.kom_imp[3] or $10;
    end;
end;
end;

procedure TFOper.OutputText(tex1,tex2,tex3: array  of string);
var
  i,len: integer;
  helpstr: string;
  cs:TClrScreen;
begin
  cs.CleanScr(Canvas,XX,YY,XX+600,YY+400,$0089BC85);
  cs.CleanScr(Canvas,XX,YY+133,XX+600,YY+266,clBlue);
  with Canvas do begin


    MoveTo(XX,YY); LineTo(XX+600,YY);
    LineTo(XX+600,YY+400); LineTo(XX,YY+400);
    LineTo(XX,YY);
    MoveTo(XX,YY+133); LineTo(XX+600,YY+133);
    MoveTo(XX,YY+266); LineTo(XX+600,YY+266);
    MoveTo(XX+400,YY); LineTo(XX+400,YY+400);

    Font.Size:=15;
    if Length(tex1[0])>40 then begin
      for i:=1 to Trunc(Length(tex1[0])/40+1) do begin
        helpstr:=Copy(tex1[0],1+(i-1)*40,40);
        TextOut(XX+10,YY-20+25*i,helpstr);
        TextOut(XX+455,YY+10,tex1[4]);
      end;
    end else begin
      TextOut(XX+10,YY+55,tex1[0]);
      TextOut(XX+455,YY+10,tex1[4]);
    end;

    if Length(tex2[0])>40 then begin
      for i:=1 to Trunc(Length(tex2[0])/40+1) do begin
        helpstr:=Copy(tex2[0],1+(i-1)*40,40);
        Brush.Color:=$FF0000;
        TextOut(XX+10,YY+113+25*i,helpstr);
        TextOut(XX+455,YY+190,tex2[4]);
        Brush.Color:=$0089BC85;
      end;
    end else begin
      Brush.Color:=$FF0000;
      TextOut(XX+10,YY+190,tex2[0]);
      TextOut(XX+455,YY+190,tex2[4]);
      Brush.Color:=$0089BC85;
    end;

     if Length(tex3[0])>40 then begin
      for i:=1 to Trunc(Length(tex3[0])/40+1) do begin
        helpstr:=Copy(tex3[0],1+(i-1)*40,40);
        TextOut(XX+10,YY+246+25*i,helpstr);
        TextOut(XX+455,YY+310,tex3[4]);
      end;
    end else begin
      TextOut(XX+10,YY+310,tex3[0]);
      TextOut(XX+455,YY+310,tex3[4]);
    end;
  end;
end;

procedure TClrScreen.CleanScr(han: TCanvas;
                       x0,y0: integer;
                       x1,y1: integer;
                       rr,gg,bb: longint);


begin
  With han do begin
    Brush.Color:=(bb * $10000 + gg * $100 + rr);
    font.Color:=(bb * $10000 + gg * $100 + rr);
    Rectangle(x0,y0,x1,y1);
  end;
end;

procedure TClrScreen.CleanScr(han: TCanvas;
                       x0,y0: integer;
                       x1,y1: integer;
                       clll: TColor);
var clhelp1,clhelp2: longint;
begin
   With han do begin
    clhelp1:=Brush.Color;
    clhelp2:=pen.Color;
    Brush.Color:=clll;
    pen.Color:=clll;
    Rectangle(x0,y0,x1,y1);
    pen.Color:=Brush.Color;
    Brush.Color:=clhelp1;
    pen.Color:=clhelp2;
  end;
end;

procedure TClrScreen.CleanScr(han: TCanvas;
                       x0,y0: integer;
                       r: integer;
                       rr,gg,bb: longint);
begin
  With han do begin
    Brush.Color:=(bb * $10000 + gg * $100 + rr);
    font.Color:=(bb * $10000 + gg * $100 + rr);
    Ellipse(x0-r,y0-r,x0+r,y0+r);
  end;
end;

procedure TClrScreen.CleanScr(han: TCanvas;
                       x0,y0: integer;
                       r: integer;
                       clll: longint);
begin
  With han do begin
    Brush.Color:=clll;
    font.Color:=clll;
    Ellipse(x0-r,y0-r,x0+r,y0+r);
  end;
end;

procedure TFOper.AlarmClock(cou_sek:integer);
var tim1,tim2: TSystemTime;
    alarmm: integer;
begin
  GetLocalTime(tim1);
  Repeat
    GetLocalTime(tim2);
    alarmm:=(tim2.wHour-tim1.wHour)*3600+(tim2.wMinute-tim1.wMinute)*60+(tim2.wSecond-tim1.wSecond);
  Until alarmm >= cou_sek;
end;
//Вывод doc файлов в окне MsWord
procedure TFOper.BitBtn1Click(Sender: TObject);
begin
case numEx of
11: ShellExecute(handle,'open',CurPath+'1.doc',nil,nil,SW_MAXIMIZE);
12: ShellExecute(handle,'open',CurPath+'2.doc',nil,nil,SW_MAXIMIZE);
13: ShellExecute(handle,'open',CurPath+'3.doc',nil,nil,SW_MAXIMIZE);
20: ShellExecute(handle,'open',CurPath+'4.doc',nil,nil,SW_MAXIMIZE);
30: ShellExecute(handle,'open',CurPath+'5.doc',nil,nil,SW_MAXIMIZE);
40: ShellExecute(handle,'open',CurPath+'6.doc',nil,nil,SW_MAXIMIZE);
50: ShellExecute(handle,'open',CurPath+'7.doc',nil,nil,SW_MAXIMIZE);
60: ShellExecute(handle,'open',CurPath+'8.doc',nil,nil,SW_MAXIMIZE);

end;
end;

procedure TFOper.Button1Click(Sender: TObject);
begin
  Kommand[1]:=OPERATION;
  case  Trenir.RadioGroup2.ItemIndex of
    0: Kommand[2]:=OPER_SAMOOB_BEGIN;
    1: Kommand[2]:=OPER_TRENIR_BEGIN;
    2: Kommand[2]:=OPER_KONTRL_BEGIN;
  end;
  Form1.Trans_kom($ff);
end;

procedure TFOper.Button2Click(Sender: TObject);
begin
  Kommand[1]:=OPERATION;
  Kommand[2]:=OPER_END;
  Form1.Trans_kom($ff);
end;

end.
