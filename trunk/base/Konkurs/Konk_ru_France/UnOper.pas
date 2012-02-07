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
  rezhim: integer; //�������� �� ����� ������: ��������, ��������, ��������
  FOper: TFOper;
  Org_Upr,Org_Upr2: TOrg_Upr; //������ �������� ��������
  Oper: array[1..17,1..100,1..5] of String;

  num_punkt: integer=1; //������ � �������, ���������� �� ���������� ���������
  cp11: integer = 2;   //
  cp12: integer = 2;   // ����������, ������������� � ������ ����������
  cp13: integer = 2;   //  ������� � ��������� CheckPos
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
  csgl: TClrScreen;    // ���������� ������������ � ��������� ������� ������

const
  CurPath = 'Text\';
  KOMANDIR = 1;
  NAVODCHIK = 2;
  VODITEL = 3;
  SECON=5; // ������������ (�������) �������� �� ���������
  XX=200; // ��������� ��� ������� ��������� ������
  YY=150; //
implementation

uses Main;


  {$R *.DFM}
//��������� �� ��������� � �������� ��������
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
  //��������� ��������� ��������� (� ������������� ������ ����� �������)
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
  Org_Upr2.kom_imp[3]:=Org_Upr.kom_imp[3];     // ����������� �������� ����������
  Org_Upr2.kom_imp[5]:=Org_Upr.kom_imp[5];     // ��� ����������� ������� ��
  Org_Upr2.nav_imp[0,1]:=Org_Upr.nav_imp[0,1]; // ���������
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
    Oper[1,num_punkt,1]:='                 1.1 �������� ��������� ������� ����������';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='       - �������� ����������� �������';
    Oper[1,num_punkt,2]:='';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='+';
    Oper[1,num_punkt,5]:='���';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='       - ��������� ��������� �������������� �� ������ ����������������� ����� �����';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='����� ��';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='             - ��. ���.';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='���';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='             - ���.';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='���';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='             - �.�.�.�.';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='���';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='             - �� ��.';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='���';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='             - �� ���.';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='����';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='       - ��������� ��������� �������������� �� ����� ����������������� ����� �����';
    Oper[1,num_punkt,2]:='';
    Oper[1,num_punkt,3]:='+';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='����� ���';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='             - ��. �����';
    Oper[1,num_punkt,2]:='';
    Oper[1,num_punkt,3]:='+';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='����';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='      - ��������� ��������� ������� ����������  �� �� �� (����� ����������) ���������.';
    Oper[1,num_punkt,2]:='';
    Oper[1,num_punkt,3]:='+';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='            - ����., �,�,�,�';
    Oper[1,num_punkt,2]:='';
    Oper[1,num_punkt,3]:='+';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='�';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='            - ���.- ���.';
    Oper[1,num_punkt,2]:='';
    Oper[1,num_punkt,3]:='+';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='���.';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='      - ��������� ��������� ������� ���������� �� �� �� (������ ��������)';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='            - ���.-���. �����.';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='���.';
    num_punkt:=num_punkt+1;
    Oper[1,num_punkt,1]:='            - ������ ���.-���.';
    Oper[1,num_punkt,2]:='+';
    Oper[1,num_punkt,3]:='';
    Oper[1,num_punkt,4]:='';
    Oper[1,num_punkt,5]:='���.';
    num_punkt:=1;
    Oper[2,num_punkt,1]:='                 1.2 �������� "���������" � "����������� ��"';
   num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='       - �������� ��� ��. �����';
    Oper[2,num_punkt,2]:='';
    Oper[2,num_punkt,3]:='+';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='���';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='       - �������� ��� ���.';
    Oper[2,num_punkt,2]:='+';
    Oper[2,num_punkt,3]:='';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='���';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='       - �������� ������������� ���.-���.�����';
    Oper[2,num_punkt,2]:='+';
    Oper[2,num_punkt,3]:='';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='���.�����';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='       - ���������� ������������� ����� �� �� ��';
    Oper[2,num_punkt,2]:='+';
    Oper[2,num_punkt,3]:='';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='����';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='             - ������ ������ �� ���';
    Oper[2,num_punkt,2]:='';
    Oper[2,num_punkt,3]:='+';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='���';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='             - ���������� ������������� �����';
    Oper[2,num_punkt,2]:='';
    Oper[2,num_punkt,3]:='+';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='�';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='             - ������ ������ �� ���';
    Oper[2,num_punkt,2]:='';
    Oper[2,num_punkt,3]:='+';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='���';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='       - ���������� �������� �������� ��������� ���������';
    Oper[2,num_punkt,2]:='+';
    Oper[2,num_punkt,3]:='+';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='             - ���������� ������ ���������� � �� � �������� ���������';
    Oper[2,num_punkt,2]:='+';
    Oper[2,num_punkt,3]:='+';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[2,num_punkt,1]:='      - ��������� ��������� ��������������� �� ������������ ��������� "����������� ���������"';
    Oper[2,num_punkt,2]:='';
    Oper[2,num_punkt,3]:='+';
    Oper[2,num_punkt,4]:='';
    Oper[2,num_punkt,5]:='';

    num_punkt:=1;
    Oper[3,num_punkt,1]:='      - 1.3 ��������� "���������" �� "������������ ��"';
    Oper[3,num_punkt,2]:='';
    Oper[3,num_punkt,3]:='';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='      - �������� ��� ��. �����';
    Oper[3,num_punkt,2]:='';
    Oper[3,num_punkt,3]:='+';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='���';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='      - �������� ��� ���.';
    Oper[3,num_punkt,2]:='+';
    Oper[3,num_punkt,3]:='';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='���';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='       - ��������� ������������� ���.-���.�����';
    Oper[3,num_punkt,2]:='+';
    Oper[3,num_punkt,3]:='';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='���.�����';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='       - ���������� ������������� ����� ���������� � ��������� ��������������� ���� �����. "��������"';
    Oper[3,num_punkt,2]:='';
    Oper[3,num_punkt,3]:='+';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='�';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='             - ������ ������ �� ���';
    Oper[3,num_punkt,2]:='';
    Oper[3,num_punkt,3]:='+';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='���';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='             - ������ ������ ����������';
    Oper[3,num_punkt,2]:='+';
    Oper[3,num_punkt,3]:='';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='���';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='       - ���������� �������� ��������� ��������� ���������';
    Oper[3,num_punkt,2]:='+';
    Oper[3,num_punkt,3]:='+';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='       - ��������� � ����� �������� ��� �� ���';
    Oper[3,num_punkt,2]:='+';
    Oper[3,num_punkt,3]:='';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='-���� -���';
    num_punkt:=num_punkt+1;
    Oper[3,num_punkt,1]:='       - ������ ���������� �� ��������� � �������� ���������';
    Oper[3,num_punkt,2]:='+';
    Oper[3,num_punkt,3]:='+';
    Oper[3,num_punkt,4]:='';
    Oper[3,num_punkt,5]:='';

    ////////////Oper2/////////////////////////////////////////////////
    num_punkt:=1;
    Oper[4,num_punkt,1]:='                     �������� �����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ������ ������� "� ���"';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ������ ����� � ������ ���������, ������� ��� � ����������� ���';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - �������� ��������� �����';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ��������� ��������� ��������������';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - ��.���.';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - ���.';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - �.�.�.�.';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - �� ��. ';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - �� ���.';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ������� ������ �����';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ����������� ������ ���-3 ��� ������ � ������� �����';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='            - ����������� ������';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='            - ���������, ��� �������� ������ � ��������� � ��������� ����';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='            - ���������, ��� ����������� ����� ������� � ��������� ����';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='      ����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='            - ���������� �������� ��������� � ��������� �';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='      �';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ����������� � ��������� ������� ������������ �������';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - �������-�������� ��������� ���';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='     ������';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��������� ������ ������������� ������������';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='           - ��������� �������� ������� ���-3 ����� ��� ������ ����������� ������ ��������';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='           - ������ ������ � ����� ������ ������� ���-3 � ������ ��������';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='           - �������������� ��������� �������� ��������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��������� ����������������� ��������.';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ������ �� ������� ��������� ������ �������� �� ��������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ���� ������� ��������� "���� �������, ������������ ����� ���������"';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��������� ����������������� �����                                                                         .';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:=' ����,���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��������� ����� ��������� ���������� � ��������� �����';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     �����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - �� ������� ��������� ������ ���������� ���������� ������ �������� ��������� ������� �����';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��������� ����� ��������� ���������� � ��������� ����';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ������� �����������, ���������� ��������, �������� ���������';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��������� �������� ����� �������� �� �������, ��������������� ��������� ��������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     0';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ���������� �������� � �������� ��� � �������� ����� � ������������� �������';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ������ ������� ��������-�������� ������, � ����� ����� ��������� ���������-"�������� ������������"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='                    �������� ������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ������ ����� � ������ ���������, ������� � ����������� ���';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ������������ � �������� ���, ��������� ������� � ������� �������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ����������� �����';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     �������';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ��������� ������ ���������� � ����������� ����������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - �������� ����������� ������ ����� ������� "��� ������"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ����������� ���������� �������� 1�40-1 � ������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ��������� ��������� �������������� �� ���.';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ��������� ��������� �������������� �� �����';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='        ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ��������� ��������� ������������� ���.-��� �� �� �� � ������������� ����� "��������"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���,�(�����)';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ��������� ��������� ������������� ���.-��� �� �� ��';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ������������ �������� ����� 1.5-2 ���';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     �����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��������� ����� ����������� ��������� ����';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - �������� ����������� ������ �� ���������� ���������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ������';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - �������� ����������� ���.-���. �� �������� ������ ����������� ���������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - �������� ����������� �. �� �������� ������ ����������� ���������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ������������� ������������� ����� ����������� ��������� �� ������� �������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��������� ��������� �������������� �������� ���� � ���';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='0 ';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - �������� ����������� ���. d�';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='      ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - � ����������� �������� �� �������� ���������� ��������';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - �������� ������������ ����������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - ���������� ������������� ����� ��������� �� �� �� ';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     �';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - ���������, ��� ������� �-���� - �-���� � ��������� �-����';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     �-����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ����������� ������ 1�13 � ������ ��� ����';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - ���������� ����� ������������� ������� �� ������ ���';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='      �';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - ���������� �������� ��������� �� �������� ������ ���';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - ���������� �������� ������ �� �������� ������ ���';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - ���������� �������� ������� �� �� �������� ������ ���';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - ���������� ������������� �-����-�-����';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     �-����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - ���������� ������� ���-��� �� ������ ���';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - �������� ������� ��� �������� ������ ������� 1�13';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - ��������� �������� ����. 3 � ������� ���������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ������� ���������';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��������� ������ ��������� ������� ���������� ����� ������� 2�46�-1';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���� ����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��������� ������ ���������� ���������� ������ �������� � ������������ ������ �������� ��������� ������� 2�46�-1';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��������� ��������� ��� �� ����� ����� �����';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - �������� ������������� ����� � ��������� �� ����� ���';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='      ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - �������� ������� �����������-��-����';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='      ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - ��������� ������ ��������������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='       - �� ������� ��������� ����� �������� ������������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='            - ����� ������� ��������-�������� "��� ������" �� ������� ��������� �������� ����������� ������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='            - ����� 1.5-2 ������ ������������ �������� �������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     �����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - ���������� ����� ����������� ��������� ���� ���������� ��������� �����';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - �������� ����������� ������ �� ���������� ��������� 1�40-1';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ������';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='             - �������� ����������� ���.-���. �� �������� ������ ��������� 1�40-1';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��������� ������ ������������� ��������� �� ����������� ��������� 1�40-1';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ������ ��������-�������� ������� "��������� ������������ ������ ����� �� �������� �����"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��������� ������ ��������� ������� ���������� ����� ������� 2�46�-1';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='     ���� ����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - �������� ��������� ����� � ���������� "�������� � ��� �����"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='                    �������-��������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - �������� ����� � ��������� ���������� � ��������� ���';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - �������� ����������� �������������� �������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='   ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - �������� ��������� �������� �����';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ���������� �������� � �������� ��� � �������� "��� ������"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='+';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ����������� ��������� � ������� � ��������� ��� �� ������� ���������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��������� (�� ������� ���������) ������������ ������ ����� �� ��������';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='   ���� ����� - �����(������)';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ��� �������� ���� � �������������� ����� ��������� ��������� ������� �����, ������� "��������� ������� �������"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - �������� ��������� � ���������� "�������-�������� � ��� �����"';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='                    �������� �����';
    Oper[4,num_punkt,2]:='';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='+';
    Oper[4,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[4,num_punkt,1]:='      - ������� �� ��������� � ��������-�������� � ����������, �������� ������������ � ���������� ����� � ���';
    Oper[4,num_punkt,2]:='+';
    Oper[4,num_punkt,3]:='';
    Oper[4,num_punkt,4]:='';
    Oper[4,num_punkt,5]:='';
//////////////Oper3///////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[5,num_punkt,1]:='                     �������� �����';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='       - ������ ������� "� ���"';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='       - ������ ����� � ������ ���������, ������� ��� � ����������� ���';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='       - �������� ��������� �����';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='       - ��������� ��������� ��������������';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='             - ��.���.';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='             - ���.';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='             - �.�.�.�.';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='             - �� ��. ';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='             - �� ���.';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='      - ������� ������ �����';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='      - ����������� ������ ���-3 ��� ������ � ������ �����';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='            - ��������� �������� ��������� ������������ �������';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     �';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='            - �������� ���� ������� ������� ���-3';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='            - ���������� �������� ������';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='      ����';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='            - ������� ���������';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='      ����';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='      - �������� ��� ��� �� ������ ����������������� ����� �����';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='      ���';
    num_punkt:=num_punkt+1;
    Oper[5,num_punkt,1]:='      - �������� ���������� ��-3���';
    Oper[5,num_punkt,2]:='+';
    Oper[5,num_punkt,3]:='';
    Oper[5,num_punkt,4]:='';
    Oper[5,num_punkt,5]:='  ��������� (�� ������)';

//////////////Oper4///////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[6,num_punkt,1]:='                     �������� �����';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - ������ ������� "�����"';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - ���� ������� ��������� "���� ������� ����� ������� ���������� ����� ��������"';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - ���������� ����������� ����� ��������';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='     ����������';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - ��������� �������� ������������';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='     �';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - ��������� ������������, ��� � ��������� �������� �� ������ �������� ';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - ����������� ������� ������� ���-3';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - ������� ��� � ����������� ���';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - ��������� ��� �� ������ ����������������� �����(��� ���. � ���.)';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ��������� ��������� ������������ �� ������ ��������)';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='    ���.���-���, ���-���';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ��������� ��������� �������� �����';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ����������� ��������-�������� "��������� ����������� �������"';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='                    �������� ������';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ��������� ����� �� ���� 32-00 � ����������� ��';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ������';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ��������� ����������� ���. d� ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ����';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ��������� ����������� � ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ����';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ��������� ����������� ������';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ����';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ��������� ����� ���������� ���������';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ���';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ����������� �������� �������';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ������';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ��������� ����������� ������ �� �������� ������ 1�40-1 ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ����';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - �������� ��������-�������� � ���������� ������������� ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ��������� ��� 1�13 ';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='            - ��������� ������� � �� �������� ������ ������� ��� 1�13';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ����';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='            - ��������� �������� ����.� ��� 1�13';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ����';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='            - ���������� �������� ��������� �� �������� ������ ���';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='   ����';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='            - ���������� �������� ������ �� �������� ������ ���';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='            - ���������� �������� ������� �� �� �������� ������ ���';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='            - ���������� �������� ������� ��';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - ��������� �������� �� ���������� ���';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - ��������� ������� �����������-��.����� �� ����� ����� �����';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - ��������� ������ ������������ � ���������� ����� �� �� �� �� ����� ��������';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='       - �� ������� ��������� ����� ������� ���� ������� � ���������� ����������� ����� �������� ���������';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ������� ��� � ����������� ���';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ��������� ��������� ������������� ��������� � ������ �������� �����';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ����� �� ������� ���������, �������� ��������� � ���������� ���������� ���������';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='                    �������-��������';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ����� ���������� ���������� �������������, �� ������� ��������� ������������� ���������';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='+';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ��������� ���� �������� �� �������� ���';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='+';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - ��������� ��������� ������ �������� �����, ����������� ������� � ����� �� ��������� ����������';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='+';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - �������� ��������� ����� � ���������� ������� �����';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='+';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='                 �������� �����';
    Oper[6,num_punkt,2]:='';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[6,num_punkt,1]:='      - �������� ��������� ������ � ���������� ������� "�����" � ���������� �����������';
    Oper[6,num_punkt,2]:='+';
    Oper[6,num_punkt,3]:='';
    Oper[6,num_punkt,4]:='';
    Oper[6,num_punkt,5]:='';

///////////Oper5/////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[7,num_punkt,1]:='                     �������� �����';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='       - ������ ������� "�����"';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='       - ���� ������� ��������� "���� ������� ����� ������� ���������� ����� ��������"';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='       - ���������� ����������� ����� ��������';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='     ����������';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='       - ��������� �������� ������������';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='     �';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='       - ��������� ������������, ��� � ��������� �������� �� ������ �������� ';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='       - ��������� ������ ���-3';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='            - ��������� �� ������� ���-3';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='            ��������� �������� ������';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[7,num_punkt,1]:='      - ������� ���������';
    Oper[7,num_punkt,2]:='+';
    Oper[7,num_punkt,3]:='';
    Oper[7,num_punkt,4]:='';
    Oper[7,num_punkt,5]:='    ����';

///////////Oper6////////////////////////////////////////////
    num_punkt:=1;
    Oper[8,num_punkt,1]:='       - ��������� �������� ��������� ������� ���������� �������� �.1.1';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='       - ��������� ��������� �������������� ��.��� �� ������ ����������������� ����� �����';
    Oper[8,num_punkt,2]:='+';
    Oper[8,num_punkt,3]:='';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='       - ��������� ��������� �������������� ��.��� �� ����� ����������������� ����� �����';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='       - ��������� ��������� ������������� ���.-��� � ������������� ����� ��������� �� �� ��';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    ���, �(� ��� �)';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='       - ��������� ��������� ������������� ���.-��� �� �� ��';
    Oper[8,num_punkt,2]:='+';
    Oper[8,num_punkt,3]:='';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='       - ����� ������� ��������-�������� "��� �����" �� ������� ��������� �������� ������ �� �������� ������ ��������� 1�40-1';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='       - ����� 1.5-2 ��� ������������ �������� �������';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    �����';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='       - ��������� ����� ����������� ��������� ���� ���������� ��������� �����.';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='      - �������� ����������� ������ �� ���������� ��������� 1�40-1';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    ������';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='      - �������� ����������� ���.-��� �� �������� ������ ��������� 1�40-1';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='      - �������� ����������� � �� �������� ������ ����������� ��������� 1�40-1';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='      - ������������� ������������� ����� ��������� 1�40-1 �� ������� �������';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='      - ��������� ��������� �������������� �������� ����';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='   � (��� ��������� ���������� ����� ��������)';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='      - �������� ����������� ���. d� ';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='   ���';
    num_punkt:=num_punkt+1;
    Oper[8,num_punkt,1]:='      - �������� ������������ ����������';
    Oper[8,num_punkt,2]:='';
    Oper[8,num_punkt,3]:='+';
    Oper[8,num_punkt,4]:='';
    Oper[8,num_punkt,5]:='';

/////////////Oper7//////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[9,num_punkt,1]:='       - ��������� �������� ��������� ������� ���������� �������� �.1.1';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='       - �������� ���������� �������� 1�40-1';
    Oper[9,num_punkt,2]:='+';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='+';
    Oper[9,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='       - ���������� ������������� ����� ��������� ����.,�,�,�,�';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    �';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='       - ����������, ��� ������� �-���� - �-����';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    �-����';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='       - ���������� ����� ������������� ������� �� ������ ���';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    �';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='       - ���������� �������� ��������� �� �������� ������ ���';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='       - ���������� �������� ������ �� �������� ������ ���';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='       - ���������� �������� ������� �� �� �������� ������ ���';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='      - ���������� ������� ���-��� �� ������ ��1�';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='      - �������� ������� � �� �������� ������ ������� 1�13';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[9,num_punkt,1]:='      - ��������� �������� ����.� � ������� ���������';
    Oper[9,num_punkt,2]:='';
    Oper[9,num_punkt,3]:='+';
    Oper[9,num_punkt,4]:='';
    Oper[9,num_punkt,5]:='    ������� �����.';

/////////Oper8/////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[10,num_punkt,1]:='       - ����������� ������';
    Oper[10,num_punkt,2]:='+';
    Oper[10,num_punkt,3]:='';
    Oper[10,num_punkt,4]:='';
    Oper[10,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[10,num_punkt,1]:='       - ���������� �������� ������ � ���������';
    Oper[10,num_punkt,2]:='+';
    Oper[10,num_punkt,3]:='';
    Oper[10,num_punkt,4]:='';
    Oper[10,num_punkt,5]:='    ����, ����';
    num_punkt:=num_punkt+1;
    Oper[10,num_punkt,1]:='       - ���������� ����������� ����� �������';
    Oper[10,num_punkt,2]:='+';
    Oper[10,num_punkt,3]:='';
    Oper[10,num_punkt,4]:='';
    Oper[10,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[10,num_punkt,1]:='       - ���������� �������� ���������';
    Oper[10,num_punkt,2]:='+';
    Oper[10,num_punkt,3]:='';
    Oper[10,num_punkt,4]:='';
    Oper[10,num_punkt,5]:='    �';
    num_punkt:=num_punkt+1;
    Oper[10,num_punkt,1]:='       - ����������� � ��������� ������� ������������ �������';
    Oper[10,num_punkt,2]:='+';
    Oper[10,num_punkt,3]:='';
    Oper[10,num_punkt,4]:='';
    Oper[10,num_punkt,5]:='';

////////Oper9/////////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[11,num_punkt,1]:='       - ���������� �������� ��������� ������������ ������� ������';
    Oper[11,num_punkt,2]:='+';
    Oper[11,num_punkt,3]:='';
    Oper[11,num_punkt,4]:='';
    Oper[11,num_punkt,5]:='    �';
    num_punkt:=num_punkt+1;
    Oper[11,num_punkt,1]:='       - �������� ���� ������� ������� ���-3';
    Oper[11,num_punkt,2]:='+';
    Oper[11,num_punkt,3]:='';
    Oper[11,num_punkt,4]:='';
    Oper[11,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[11,num_punkt,1]:='       - ���������� �������� ������';
    Oper[11,num_punkt,2]:='+';
    Oper[11,num_punkt,3]:='';
    Oper[11,num_punkt,4]:='';
    Oper[11,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[11,num_punkt,1]:='       - ������� ���������';
    Oper[11,num_punkt,2]:='+';
    Oper[11,num_punkt,3]:='';
    Oper[11,num_punkt,4]:='';
    Oper[11,num_punkt,5]:='    ����';
////////Oper10.1.1////////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[12,num_punkt,1]:='      - �������� ����������� �������';
    Oper[12,num_punkt,2]:='';
    Oper[12,num_punkt,3]:='';
    Oper[12,num_punkt,4]:='+';
    Oper[12,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[12,num_punkt,1]:='      - ��������� ��������� � ���������� ������� �������� ����������� ���� �� ����� 1250 ��/���. � ������� ���';
    Oper[12,num_punkt,2]:='';
    Oper[12,num_punkt,3]:='';
    Oper[12,num_punkt,4]:='+';
    Oper[12,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[12,num_punkt,1]:='      - ��������� ��������� �������������� �� ������ ����������������� ����� �����, ��� �������� ����� -��� � -�� ���.';
    Oper[12,num_punkt,2]:='+';
    Oper[12,num_punkt,3]:='';
    Oper[12,num_punkt,4]:='';
    Oper[12,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[12,num_punkt,1]:='      - ��������� ��������� �������������� �� ����� ����������������� ����� �����, ��� �������� ����� -��.�����, -���.���., ����.���';
    Oper[12,num_punkt,2]:='';
    Oper[12,num_punkt,3]:='+';
    Oper[12,num_punkt,4]:='';
    Oper[12,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[12,num_punkt,1]:='      - ��������� ��������� ����������� -���.-���. �� �� ��, ��������� ��� ������������� ��������� � ��������� ���';
    Oper[12,num_punkt,2]:='';
    Oper[12,num_punkt,3]:='+';
    Oper[12,num_punkt,4]:='';
    Oper[12,num_punkt,5]:='    ���.';
    num_punkt:=num_punkt+1;
    Oper[12,num_punkt,1]:='      - ��������� ��������� ������������� ����� �������� �� �� ��, ���������, ��������� � ��������� ����.';
    Oper[12,num_punkt,2]:='';
    Oper[12,num_punkt,3]:='+';
    Oper[12,num_punkt,4]:='';
    Oper[12,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[12,num_punkt,1]:='      - ��������� ��������� ������������� ���.-���.����� �� �� ��, ��� ������������� ��������� � ��������� ���';
    Oper[12,num_punkt,2]:='+';
    Oper[12,num_punkt,3]:='';
    Oper[12,num_punkt,4]:='';
    Oper[12,num_punkt,5]:='    ����';
////////Oper10.1.2////////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[13,num_punkt,1]:='   ����� "�������"';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   ������� ��������� ������ "�������"';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - �������� ��� ��.�����';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - �������� ��� ���';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ����� ������� �������� �������� "��� ������", �� ������� ��������� �������� ������';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ����� 1.5-2 ��� ������������ �������� ������, ��� ��� ��������� ���������� ����� �����';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    �����';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ��������� ����� ����������� ��������� ���� ���������� ��������� �����';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - �������� ����������� ������, ��� ���� ��������� ����� ������.';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ������';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   ������� ���������� ������ "�������"';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ��������� ����������� ������, ��� ���� �������� ����� ������.';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ��������� ����� ����������� ��������� ���� ���������� ��������� �����';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ��������� ����������� ������';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   ����� "�����������"';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    �����';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   ������� ��������� ������ "�����������"';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - �������� ����������� ������';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   ����� ����������������� ����������';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   ������� ��������� ������ ������������������ ����������';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - �������� ����������� ������';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ����� 1.5-2 ��� ������������ �������� �������, ��� ���� ��������� ���������� ����� �����';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    �����';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   ������� ��������� ������ ������������������ ���������� ';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    �����';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ����������� �������� �������, ��� ���� ��������� ���������� ����� ���� � �������� ����� �������.';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ����.';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ��������� ����������� ������, ��� ���� �������� ����� ������.';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   ����� ������������';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   ������� ��������� ������ ������������';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ������������ ����������� ������� ';
    Oper[13,num_punkt,2]:='+';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - �������� ��� ���';
    Oper[13,num_punkt,2]:='+';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ��������� �������� ������� ���-3 ����� ��� ������ ���������� ������ �������� "����� ������(�����)"';
    Oper[13,num_punkt,2]:='+';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ������ ������ � ����� ������ ������� ���-3 � ������ ��������';
    Oper[13,num_punkt,2]:='+';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - �������������� ��������� ���������� ����� ��������(����� �� ������� ������� �� ������� ���������� ���������� ������)';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ��������� ������ ������������, ��� ���� ���������� ����� ���������� ���������, ������ ����� �������';
    Oper[13,num_punkt,2]:='+';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='   ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   ����� ���������� �������� ����� ���������-���������';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='   ������� ��������� ������ ���������� �������� �����';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ��� �������� ���� ��������-�������� � �������������� ����� ������ � ���������� ������ ��������� ������� ������� �� ������ ����� �� �������� �����';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='';
    Oper[13,num_punkt,4]:='+';
    Oper[13,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ������������ ��������� ��������� ����� ��������';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[13,num_punkt,1]:='      - ��������� ���������� ���������� �� �� ����������� ��������� 1�40-1';
    Oper[13,num_punkt,2]:='';
    Oper[13,num_punkt,3]:='+';
    Oper[13,num_punkt,4]:='';
    Oper[13,num_punkt,5]:='   ';

////////Oper10.3.1////////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[14,num_punkt,1]:='   ��������� ��������� 1�40-1';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='   ������� ��������� ������ "�������"';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='      - �������� ��� ��.�����';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='+';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='      - �������� ��� ���';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='+';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='      - ����� ������� �������� �������� "��� ������", �� ������� ��������� �������� ������';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='+';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='      - ����� 1.5-2 ��� ������������ �������� ������, ��� ��� ��������� ���������� ����� �����';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='+';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    �����';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='      - ��������� ����� ����������� ��������� ���� ���������� ��������� �����';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='+';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ����';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='      - �������� ����������� ������, ��� ���� ��������� ����� ������.';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='+';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ������';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='   ������� ���������� ������ "�������"';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[14,num_punkt,1]:='      - ��������� ����������� ������, ��� ���� �������� ����� ������.';
    Oper[14,num_punkt,2]:='';
    Oper[14,num_punkt,3]:='+';
    Oper[14,num_punkt,4]:='';
    Oper[14,num_punkt,5]:='    ���';


////////Oper12.1////////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[15,num_punkt,1]:='       - �������� ����������� �������';
    Oper[15,num_punkt,2]:='';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='+';
    Oper[15,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='       - ��������� ��������� �������������� �� ������ ����������������� ����� �����';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='����� ��';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='             - ��. ���.';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='             - ���.';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='             - �.�.�.�.';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='             - �� ��.';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='             - �� ���.';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='       - ��������� ��������� �������������� �� ����� ����������������� ����� �����';
    Oper[15,num_punkt,2]:='';
    Oper[15,num_punkt,3]:='+';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='����� ���';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='             - ��. �����';
    Oper[15,num_punkt,2]:='';
    Oper[15,num_punkt,3]:='+';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='     ����';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='      - ��������� ��������� ������� ����������  �� �� �� (����� ����������) ���������.';
    Oper[15,num_punkt,2]:='';
    Oper[15,num_punkt,3]:='+';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='            - ����., �,�,�,�';
    Oper[15,num_punkt,2]:='';
    Oper[15,num_punkt,3]:='+';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='         �';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='            - ���.- ���.';
    Oper[15,num_punkt,2]:='';
    Oper[15,num_punkt,3]:='+';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='      ���.';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='      - ��������� ��������� ������� ���������� �� �� �� (������ ��������)';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='            - ���.-���. �����.';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='      ���.';
    num_punkt:=num_punkt+1;
    Oper[15,num_punkt,1]:='            - ������ ���.-���.';
    Oper[15,num_punkt,2]:='+';
    Oper[15,num_punkt,3]:='';
    Oper[15,num_punkt,4]:='';
    Oper[15,num_punkt,5]:='      ���.';

////////Oper12.2////////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[16,num_punkt,1]:='      - ��������� ��������� �������������� �� ���. �� ������ ����������������� �����';
    Oper[16,num_punkt,2]:='+';
    Oper[16,num_punkt,3]:='';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - ��������� ��������� �������������� �� ���. �� ����� ����������������� �����';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='    ���';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - ��������� ��������� ������������� ���. -��� � ������������� ����� ��������� �� �� ��';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     ���, �(� ��� �)';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - ��������� ��������� ������������� ���. -��� �� �� ��';
    Oper[16,num_punkt,2]:='+';
    Oper[16,num_punkt,3]:='';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - ��������� ��������� ����� � ���������� ���������������� ������� (1250 ��/���)';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='';
    Oper[16,num_punkt,4]:='+';
    Oper[16,num_punkt,5]:='     ';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - ����� ������� ��������-�������� "��� ������", �� ������� ��������� ����� �������� ������(���������� ������� ��������)';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - ����� 1.5-2 ���. ������������ �������� �������, ��� ���� ���������� ��������� ����� �����';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     �����';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - ��������� ����� ����������� ��������� ���� ���������� ��������� ����� � ��������� ����.(���������� ����� ������.)';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     ����.';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - �������� ���������� ������ (���������� ����� ������.)';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     ������.';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - �������� ����������� ���.-��� �� ������� ������ ����������� ���������';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - �������� ����������� �. �� �������� ������ ����������� ���������(��������� ����� ��������� �, �� ������� ��� ����� 30 �. ����� � � ������������ �����)';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='     ���';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - ���������� ������������� ����� ����������� ��������� �� ������� �������';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='      ';
    num_punkt:=num_punkt+1;
    Oper[16,num_punkt,1]:='      - ��������� ��������� �������� �� ������������� �������� ����������� ��������� ���� � ��� � 0 ���������';
    Oper[16,num_punkt,2]:='';
    Oper[16,num_punkt,3]:='+';
    Oper[16,num_punkt,4]:='';
    Oper[16,num_punkt,5]:='      0';

////////Oper12.3////////////////////////////////////////////////////////////
    num_punkt:=1;
    Oper[17,num_punkt,1]:='      - ������� ������ ���������� � ����';
    Oper[17,num_punkt,2]:='';
    Oper[17,num_punkt,3]:='+';
    Oper[17,num_punkt,4]:='';
    Oper[17,num_punkt,5]:='    ';
    num_punkt:=num_punkt+1;
    Oper[17,num_punkt,1]:='      - ��� ����������� ��������� �� � ����� ������������� ��������� ������ ������ �������� ���������';
    Oper[17,num_punkt,2]:='';
    Oper[17,num_punkt,3]:='+';
    Oper[17,num_punkt,4]:='';
    Oper[17,num_punkt,5]:='    ���-"..." ��������� ��-"800+-80" ��������������-"-00.0"';
    num_punkt:=num_punkt+1;
    Oper[17,num_punkt,1]:='      - ��������� ������ - ��������� ��������������� ������';
    Oper[17,num_punkt,2]:='';
    Oper[17,num_punkt,3]:='+';
    Oper[17,num_punkt,4]:='';
    Oper[17,num_punkt,5]:='     ';
    num_punkt:=num_punkt+1;
    Oper[17,num_punkt,1]:='      - ���������� ������������� ����� ��������� � ��������� �,� ��� � � � �������� ��������� ������ ������ ��������� ��������� �� ��������������� ������ ��������� �������� � ���� ���������';
    Oper[17,num_punkt,2]:='';
    Oper[17,num_punkt,3]:='+';
    Oper[17,num_punkt,4]:='';
    Oper[17,num_punkt,5]:='     ���';


end;



procedure TFOper.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled:=false;
end;

//� ������ ��������� ���� �������� ��������� ��������� ������� ����������
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
   //���������� ������ (�� ����� ���������)������ ���� ������� �
   // �������� ��������
   If Org_Upr.vod_imp[0,0] and $40=$00 then Label2.Caption:='���'
    else Label2.Caption:='����';

   If Org_Upr.kom_imp[3] and $08 = $00 then Label3.Caption:='���'
    else Label3.Caption:='����';

   If Org_Upr.kom_imp[3] and $04 = $00 then Label4.Caption:='���'
    else Label4.Caption:='����';

   If Org_Upr.kom_imp[3] and $02 = $00 then Label5.Caption:='���'
    else Label5.Caption:='����';

   If Org_Upr.kom_imp[3] and $01 = $00 then Label6.Caption:='���'
    else Label6.Caption:='����';

   If Org_Upr.kom_imp[3] and $20 = $00 then Label11.Caption:= '���'
    else Label11.Caption:='���';

   If Org_Upr.kom_imp[5] and $04 = $00 then Label7.Caption:='���'
    else Label7.Caption:='����';

   If Org_Upr.kom_imp[5] and $40 = $00 then Label12.Caption:= '���'
    else Label12.Caption:='���';

   If Org_Upr.nav_imp[0,1] and $02 = $00 then Label8.Caption:= '���'
    else Label8.Caption:='����';

   If Org_Upr.nav_imp[7,0] and $40 = $00 then Label10.Caption:= '���'
    else Label10.Caption:='���';

   If Org_Upr.nav_imp[7,0] and $80 = $00 then Label14.Caption:= '���'
    else Label14.Caption:='����';

   If Org_Upr.kom_imp[3] and $10 = $00 then Label15.Caption:= '���'
    else Label15.Caption:='����';

   if (Org_Upr.nav_imp[7,0] and $20 = $00) and
    (Org_Upr.nav_imp[7,0] and $10 = $10) then Label9.Caption:= '����'
    else Label9.Caption:='�';

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

   If Org_Upr.kom_imp[0] and $20 = $00 then Label32.Caption:= '���'
    else Label32.Caption:='����';

   If Org_Upr.kom_imp[0] and $02 = $00 then Label34.Caption:= '�'
    else Label34.Caption:='�';

   If Org_Upr.kom_imp[5] and $80 = $00 then Label36.Caption:= '������'
    else Label36.Caption:='�������';

   If Org_Upr.nav_imp[0,1] and $80 = $00 then Label38.Caption:= '����'
    else Label38.Caption:='����';

   if Org_Upr.vod_imp[0,1] and $04 = $00 then Label40.Caption:= '����'
    else Label40.Caption:='����';

   if Org_Upr.nav_imp[7,0] and $04 = $00 then Label42.Caption:= '���'
    else Label42.Caption:='����';

   if Org_Upr.nav_imp[5,1] and $01 = $00 then Label44.Caption:= '�������'
    else Label44.Caption:='������';

   if Org_Upr.nav_imp[2,1] and $40 = $00 then Label46.Caption:= '�������'
    else Label46.Caption:='������';

   if Org_Upr.nav_imp[5,1] and $04 = $00 then Label48.Caption:= '����'
    else Label48.Caption:='���';

   if Org_Upr.nav_imp[7,0] and $02 = $00 then Label50.Caption:= '���'
    else Label50.Caption:='����';

   if Org_Upr.nav_imp[6,0] and $40 = $00 then Label52.Caption:= '���'
    else Label52.Caption:='���';

   if Org_Upr.nav_imp[4,0] and $20 = $00 then Label54.Caption:= '���'
    else Label54.Caption:='����';

   if Org_Upr.nav_imp[7,0] and $01 = $00 then Label56.Caption:= '���'
    else Label56.Caption:='����';

end;
//��������� ���������  ����������
procedure TFOper.CheckPos11(kind: integer);
var
  CurCol: TColor; // ��������������� ���������� ��� ����������� �����
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
                 //label29.Caption:='�������� �����';
                  csgl.CleanScr(Canvas,150,233,750,366,clRed);
                  CurCol:=Canvas.Brush.color;
                  Canvas.brush.Color:=clRed;
                  Canvas.TextOut(160,290,'�������� ������������������. ������� ����� �������');
                  Canvas.Brush.Color:=CurCol;
              end else begin
                label29.Caption:='';
                flag11:=true;
                formpaint(nil);
              end;

         end;
end;
 // ��������������� �������� ��������� ������� ����������
 // ��� ��������� � �������� ���������
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
                  Canvas.TextOut(160,290,'�������� ������������������. ������� ����� �������');
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
                 //label29.Caption:='�������� �����';
                  csgl.CleanScr(Canvas,150,233,750,366,clRed);
                  CurCol:=Canvas.Brush.color;
                  Canvas.brush.Color:=clRed;
                  Canvas.TextOut(160,290,'�������� ������������������. ������� ����� �������');
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
                  Canvas.TextOut(XX+10,YY+190,'�������� ������������������. ������� ����� �������');
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
//����� doc ������ � ���� MsWord
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
