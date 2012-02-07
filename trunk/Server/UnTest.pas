unit UnTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Mask, Buttons, Main, UnOther;

type
  TTest = class(TForm)
    Panel3: TPanel;
    Label001: TLabel;
    GroupBox013: TGroupBox;
    Shape044: TShape;
    Shape045: TShape;
    Shape046: TShape;
    Shape047: TShape;
    StaticText065: TStaticText;
    StaticText063: TStaticText;
    StaticText062: TStaticText;
    StaticText066: TStaticText;
    Edit020: TEdit;
    StaticText064: TStaticText;
    GroupBox014: TGroupBox;
    Shape048: TShape;
    Shape049: TShape;
    Shape050: TShape;
    Shape051: TShape;
    Shape052: TShape;
    Shape053: TShape;
    Shape054: TShape;
    StaticText067: TStaticText;
    StaticText068: TStaticText;
    StaticText069: TStaticText;
    StaticText070: TStaticText;
    StaticText071: TStaticText;
    StaticText072: TStaticText;
    StaticText073: TStaticText;
    GroupBox004: TGroupBox;
    Shape018: TShape;
    Edit003: TEdit;
    Edit004: TEdit;
    Edit005: TEdit;
    StaticText018: TStaticText;
    StaticText020: TStaticText;
    StaticText021: TStaticText;
    StaticText022: TStaticText;
    StaticText025: TStaticText;
    Edit007: TEdit;
    StaticText024: TStaticText;
    StaticText026: TStaticText;
    Edit024: TEdit;
    GroupBox002: TGroupBox;
    Shape014: TShape;
    StaticText014: TStaticText;
    StaticText015: TStaticText;
    Edit025: TEdit;
    GroupBox012: TGroupBox;
    Shape039: TShape;
    Shape040: TShape;
    Shape041: TShape;
    Shape042: TShape;
    StaticText38: TStaticText;
    StaticText059: TStaticText;
    StaticText058: TStaticText;
    StaticText060: TStaticText;
    Edit018: TEdit;
    StaticText056: TStaticText;
    Edit019: TEdit;
    StaticText057: TStaticText;
    StaticText061: TStaticText;
    Edit023: TEdit;
    GroupBox007: TGroupBox;
    Shape032: TShape;
    Shape033: TShape;
    Shape026: TShape;
    Shape025: TShape;
    Shape024: TShape;
    Shape055: TShape;
    Edit008: TEdit;
    Edit009: TEdit;
    Edit010: TEdit;
    Edit011: TEdit;
    StaticText031: TStaticText;
    StaticText032: TStaticText;
    StaticText033: TStaticText;
    StaticText034: TStaticText;
    StaticText045: TStaticText;
    Edit013: TEdit;
    StaticText044: TStaticText;
    Edit014: TEdit;
    Edit012: TEdit;
    StaticText035: TStaticText;
    Edit015: TEdit;
    StaticText046: TStaticText;
    Edit016: TEdit;
    StaticText047: TStaticText;
    StaticText049: TStaticText;
    StaticText050: TStaticText;
    StaticText038: TStaticText;
    StaticText037: TStaticText;
    StaticText036: TStaticText;
    StaticText1: TStaticText;
    GroupBox003: TGroupBox;
    Shape016: TShape;
    StaticText016: TStaticText;
    StaticText017: TStaticText;
    Edit026: TEdit;
    GroupBox005: TGroupBox;
    Shape020: TShape;
    Shape021: TShape;
    StaticText027: TStaticText;
    StaticText028: TStaticText;
    GroupBox006: TGroupBox;
    Shape022: TShape;
    Shape023: TShape;
    StaticText029: TStaticText;
    StaticText030: TStaticText;
    GroupBox008: TGroupBox;
    Shape028: TShape;
    Shape029: TShape;
    StaticText040: TStaticText;
    StaticText041: TStaticText;
    GroupBox011: TGroupBox;
    Timer1: TTimer;
    StaticText9: TStaticText;
    Shape008: TShape;
    Shape056: TShape;
    GroupBox001: TGroupBox;
    Shape004: TShape;
    Shape001: TShape;
    Shape002: TShape;
    Shape007: TShape;
    Shape006: TShape;
    Shape003: TShape;
    StaticText004: TStaticText;
    StaticText001: TStaticText;
    StaticText002: TStaticText;
    StaticText007: TStaticText;
    StaticText006: TStaticText;
    StaticText003: TStaticText;
    GroupBox102: TGroupBox;
    Shape005: TShape;
    Shape009: TShape;
    Shape010: TShape;
    Shape011: TShape;
    StaticText114: TStaticText;
    StaticText115: TStaticText;
    StaticText116: TStaticText;
    StaticText117: TStaticText;
    StaticText28: TStaticText;
    StaticText6: TStaticText;
    Shape058: TShape;
    Shape057: TShape;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    procedure _Pointer;
  end;

var
  Test: TTest;
  enable_thread: boolean;
  enable_Chief: boolean;
  enable_Pointer: boolean;
  enable_Commander: boolean;
  enable_strobe: boolean;

  switches: array[0..32] of byte;
  lamps: array[0..7] of byte;
  byte_in:byte;
  byte_contr: byte;

implementation

{$R *.DFM}

procedure TTest.FormCreate(Sender: TObject);
begin
  Test.Cursor:=crNone;// Óáèðàåì êóðñîð. +++
end;


procedure TTest.Timer1Timer(Sender: TObject);
var a: word;
begin
  for a:=0 to 3 do switches[a]:=Org_Upr_Rm[Num_BMP].nav_imp[a];
  _Pointer;
end;

//=====================================:=
//                            ÐÌ íàâîä÷èêà
//=====================================:=
procedure TTest._Pointer;
begin
  //ËÑ0 ----------------------------------------------------------------------
  // Àððåòèð
  if((switches[0] and $01)=$00)then  Shape029.Brush.Color:=clRed
                               else  Shape029.Brush.Color:=clLime;
  if((switches[0] and $02)=$00)then  Shape028.Brush.Color:=clRed
                               else  Shape028.Brush.Color:=clLime;
  if((switches[0] and $04)=$00)then  Shape057.Brush.Color:=clRed
                               else  Shape057.Brush.Color:=clLime;
  // Àêòèâ-ïàññèâ ÒÏÍ
  case (switches[0] and $18)of
           $00:      Edit003.Text:='Â';
           $08:      Edit003.Text:='Ï1';
           $10:      Edit003.Text:='Ï';
           $18:      Edit003.Text:='À';
           else      Edit003.Text:='?';
   end;
   if((switches[0] and $20)=$00)then  Shape014.Brush.Color:=clRed
                                else  Shape014.Brush.Color:=clLime;
   if((switches[0] and $40)=$00)then  Shape024.Brush.Color:=clRed
                                else  Shape024.Brush.Color:=clLime;
   if((switches[0] and $80)=$00)then  Shape055.Brush.Color:=clRed
                                else  Shape055.Brush.Color:=clLime;
  //ËÑ1 ----------------------------------------------------------------------
   if((switches[1] and $01)=$00)then  Shape022.Brush.Color:=clRed
                                else  Shape022.Brush.Color:=clLime;
   if((switches[1] and $02)=$00)then  Shape023.Brush.Color:=clRed
                                else  Shape023.Brush.Color:=clLime;
   if((switches[1] and $04)=$00)then  Shape058.Brush.Color:=clRed
                                else  Shape058.Brush.Color:=clLime;
   if((switches[1] and $08)=$00)then  Shape056.Brush.Color:=clRed
                                else  Shape056.Brush.Color:=clLime;
   if((switches[1] and $10)=$00)then  Shape018.Brush.Color:=clRed
                                else  Shape018.Brush.Color:=clLime;
   // Òèï âûñòðåëà
   case (switches[1] and $e0)of
           $40:      Edit012.Text:='Ó';
           $80:      Edit012.Text:='Á';
           $a0:      Edit012.Text:='Î';
           $c0:      Edit012.Text:='Í';
           $60:      Edit012.Text:='Ï';
           else      Edit012.Text:='?';
  end;

  //ËÑ2 ----------------------------------------------------------------------
   if((switches[2] and $02)=$00)then  Shape040.Brush.Color:=clRed
                                else  Shape040.Brush.Color:=clLime;
   if((switches[2] and $01)=$00)then  Shape039.Brush.Color:=clRed
                                else  Shape039.Brush.Color:=clLime;
   if((switches[2] and $04)=$00)then  Shape041.Brush.Color:=clRed
                                else  Shape041.Brush.Color:=clLime;
   if((switches[2] and $08)=$00)then  Shape042.Brush.Color:=clRed
                                else  Shape042.Brush.Color:=clLime;
   if((switches[2] and $10)=$00)then  Shape032.Brush.Color:=clRed
                                else  Shape032.Brush.Color:=clLime;
   if((switches[2] and $20)=$00)then  Shape033.Brush.Color:=clRed
                                else  Shape033.Brush.Color:=clLime;
   if((switches[2] and $40)=$00)then  Shape025.Brush.Color:=clRed
                                else  Shape025.Brush.Color:=clLime;
   if((switches[2] and $80)=$00)then  Shape026.Brush.Color:=clRed
                                else  Shape026.Brush.Color:=clLime;
  //ËÑ3----------------------------------------------------------------------
   Edit004.Text:=inttostr(switches[3] and $0f);
   Edit005.Text:=inttostr((switches[3] and $f0)shr 4);
  //ËÑ4----------------------------------------------------------------------
   Edit008.Text:=inttostr(switches[4] and $0f);
   Edit009.Text:=inttostr((switches[4] and $f0)shr 4);
  //ËÑ5----------------------------------------------------------------------
   Edit010.Text:=inttostr(switches[5] and $0f);
   Edit011.Text:=inttostr((switches[5] and $f0)shr 4);
  //ËÑ6----------------------------------------------------------------------
   Edit013.Text:=inttostr(switches[6] and $0f);
   Edit014.Text:=inttostr((switches[6] and $f0)shr 4);
  //ËÑ7----------------------------------------------------------------------
   Edit018.Text:=inttostr(switches[7]);
  //ËÑ8----------------------------------------------------------------------
   Edit019.Text:=inttostr(switches[8]);
  //ËÑ9----------------------------------------------------------------------
   Edit015.Text:=inttostr(switches[9]);
  //ËÑ10----------------------------------------------------------------------
   Edit016.Text:=inttostr(switches[10]);
  //ËÑ11----------------------------------------------------------------------
   Edit007.Text:=inttostr(switches[11]);
  //ËÑ12----------------------------------------------------------------------
  if switches[12] and $80=0 then Edit024.Text:=inttostr(-(switches[12]and $7f))
                            else Edit024.Text:=inttostr((switches[12]and $7f));
  //ËÑ13----------------------------------------------------------------------
  if switches[13] and $80=0 then Edit023.Text:=inttostr(-(switches[13]and $7f))
                            else Edit023.Text:=inttostr((switches[13]and $7f));
  //ËÑ14----------------------------------------------------------------------
  if switches[14] and $80=0 then Edit025.Text:=inttostr(-(switches[14]and $7f))
                            else Edit025.Text:=inttostr((switches[14]and $7f));
  //ËÑ15----------------------------------------------------------------------
  if switches[15] and $80=0 then Edit026.Text:=inttostr(-(switches[15]and $7f))
                            else Edit026.Text:=inttostr((switches[15]and $7f));
  //ËÑ16 ----------------------------------------------------------------------
   if((switches[16] and $01)=$00)then  Shape001.Brush.Color:=clRed
                                 else  Shape001.Brush.Color:=clLime;
   if((switches[16] and $02)=$00)then  Shape004.Brush.Color:=clRed
                                 else  Shape004.Brush.Color:=clLime;
   if((switches[16] and $04)=$00)then  Shape007.Brush.Color:=clRed
                                 else  Shape007.Brush.Color:=clLime;
   if((switches[16] and $08)=$00)then  Shape003.Brush.Color:=clRed
                                 else  Shape003.Brush.Color:=clLime;
   if((switches[16] and $10)=$00)then  Shape002.Brush.Color:=clRed
                                 else  Shape002.Brush.Color:=clLime;
   if((switches[16] and $20)=$00)then  Shape006.Brush.Color:=clRed
                                 else  Shape006.Brush.Color:=clLime;
  //ËÑ17 ----------------------------------------------------------------------
   if((switches[17] and $01)=$00)then  Shape011.Brush.Color:=clRed
                                 else  Shape011.Brush.Color:=clLime;
   if((switches[17] and $02)=$00)then  Shape010.Brush.Color:=clRed
                                 else  Shape010.Brush.Color:=clLime;
   if((switches[17] and $04)=$00)then  Shape009.Brush.Color:=clRed
                                 else  Shape009.Brush.Color:=clLime;
   if((switches[17] and $08)=$00)then  Shape005.Brush.Color:=clRed
                                 else  Shape005.Brush.Color:=clLime;
   if((switches[17] and $10)=$00)then  Shape020.Brush.Color:=clRed
                                 else  Shape020.Brush.Color:=clLime;
   if((switches[17] and $20)=$00)then  Shape021.Brush.Color:=clRed
                                 else  Shape021.Brush.Color:=clLime;
   if((switches[17] and $40)=$00)then  Shape016.Brush.Color:=clRed
                                 else  Shape016.Brush.Color:=clLime;
   if((switches[17] and $80)=$00)then  Shape008.Brush.Color:=clRed
                                 else  Shape008.Brush.Color:=clLime;
  //ËÑ18 ----------------------------------------------------------------------
   Edit020.Text:=inttostr(switches[18] and $07);
   if((switches[18] and $08)=$00)then  Shape044.Brush.Color:=clRed
                                 else  Shape044.Brush.Color:=clLime;
   if((switches[18] and $10)=$00)then  Shape045.Brush.Color:=clRed
                                 else  Shape045.Brush.Color:=clLime;
   if((switches[18] and $20)=$00)then  Shape046.Brush.Color:=clRed
                                 else  Shape046.Brush.Color:=clLime;
   if((switches[18] and $40)=$00)then  Shape047.Brush.Color:=clRed
                                 else  Shape047.Brush.Color:=clLime;
  //ËÑ19 ----------------------------------------------------------------------
   if((switches[19] and $01)=$00)then  Shape052.Brush.Color:=clRed
                                 else  Shape052.Brush.Color:=clLime;
   if((switches[19] and $02)=$00)then  Shape051.Brush.Color:=clRed
                                 else  Shape051.Brush.Color:=clLime;
   if((switches[19] and $04)=$00)then  Shape053.Brush.Color:=clRed
                                 else  Shape053.Brush.Color:=clLime;
   if((switches[19] and $08)=$00)then  Shape054.Brush.Color:=clRed
                                 else  Shape054.Brush.Color:=clLime;
   if((switches[19] and $10)=$00)then  Shape049.Brush.Color:=clRed
                                 else  Shape049.Brush.Color:=clLime;
   if((switches[19] and $20)=$00)then  Shape048.Brush.Color:=clRed
                                 else  Shape048.Brush.Color:=clLime;
   if((switches[19] and $40)=$00)then  Shape050.Brush.Color:=clRed
                                 else  Shape050.Brush.Color:=clLime;

end;
end.
