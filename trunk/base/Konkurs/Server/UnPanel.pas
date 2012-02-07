unit UnPanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UnMatrix, ComCtrls;

type
  TForm3 = class(TForm)
    Shape1: TShape;
    Label1: TLabel;
    Timer1: TTimer;
    Shape2: TShape;
    Label2: TLabel;
    Shape3: TShape;
    Label3: TLabel;
    Shape4: TShape;
    Label4: TLabel;
    Label5: TLabel;
    Shape5: TShape;
    Label6: TLabel;
    Shape6: TShape;
    Label7: TLabel;
    Shape7: TShape;
    Label8: TLabel;
    Shape8: TShape;
    Shape9: TShape;
    Label9: TLabel;
    Shape10: TShape;
    Label10: TLabel;
    TrackBar1: TTrackBar;
    Label11: TLabel;
    TrackBar3: TTrackBar;
    Label13: TLabel;
    Label14: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label15: TLabel;
    Label17: TLabel;
    Button3: TButton;
    Button4: TButton;
    Label18: TLabel;
    TrackBar4: TTrackBar;
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RePaintPanel;
    procedure FormActivate(Sender: TObject);
    procedure Invert(line,pos:byte);
    procedure OnOrgan(line,pos:byte);
    procedure OffOrgan(line,pos:byte);

    procedure Timer1Timer(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  summ:real;
implementation

{$R *.DFM}

const
  COLOR_ON=clGreen;
  COLOR_OFF=clRed;

procedure TForm3.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if sender = Shape1 then OnOrgan(0,0);
  if sender = Shape2 then Invert(0,1);
  if sender = Shape3 then Invert(0,2);
  if sender = Shape4 then Invert(0,3);
  if sender = Shape5 then Invert(0,4);
  if sender = Shape6 then Invert(0,5);
  if sender = Shape7 then Invert(0,6);
  if sender = Shape8 then Invert(0,7);
  if sender = Shape9 then Invert(5,0);
  if sender = Shape10 then Invert(5,1);

end;

procedure TForm3.Shape1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if sender = Shape1 then OffOrgan(0,0);
end;

procedure TForm3.FormActivate(Sender: TObject);
begin
  RePaintPanel;
end;

procedure TForm3.RePaintPanel;
var
  n: word;
  i: integer;
begin
  n:=0;
  if Org_upr[n] and $01 =0 then Shape1.Brush.Color:=COLOR_ON
                           else Shape1.Brush.Color:=COLOR_OFF;
  if Org_upr[n] and $02 =0 then Shape2.Brush.Color:=COLOR_ON
                           else Shape2.Brush.Color:=COLOR_OFF;
  if Org_upr[n] and $04 =0 then Shape3.Brush.Color:=COLOR_ON
                           else Shape3.Brush.Color:=COLOR_OFF;
  if Org_upr[n] and $08 =0 then Shape4.Brush.Color:=COLOR_ON
                           else Shape4.Brush.Color:=COLOR_OFF;
  if Org_upr[n] and $10 =0 then Shape5.Brush.Color:=COLOR_ON
                           else Shape5.Brush.Color:=COLOR_OFF;
  if Org_upr[n] and $20 =0 then Shape6.Brush.Color:=COLOR_ON
                           else Shape6.Brush.Color:=COLOR_OFF;
  if Org_upr[n] and $40 =0 then Shape7.Brush.Color:=COLOR_ON
                           else Shape7.Brush.Color:=COLOR_OFF;
  if Org_upr[n] and $80 =0 then Shape8.Brush.Color:=COLOR_ON
                           else Shape8.Brush.Color:=COLOR_OFF;
  n:=5;
  if Org_upr[n] and $01 =0 then Shape9.Brush.Color:=COLOR_ON
                           else Shape9.Brush.Color:=COLOR_OFF;
  if Org_upr[n] and $02 =0 then Shape10.Brush.Color:=COLOR_ON
                           else Shape10.Brush.Color:=COLOR_OFF;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  RePaintPanel;
end;

procedure TForm3.Invert(line,pos:byte);
begin
  case pos of
    0: if Org_upr[line] and $01 =0 then Org_upr[line]:=Org_upr[line] or $01
                                   else Org_upr[line]:=Org_upr[line] and $fe;
    1: if Org_upr[line] and $02 =0 then Org_upr[line]:=Org_upr[line] or $02
                                   else Org_upr[line]:=Org_upr[line] and $fd;
    2: if Org_upr[line] and $04 =0 then Org_upr[line]:=Org_upr[line] or $04
                                   else Org_upr[line]:=Org_upr[line] and $fb;
    3: if Org_upr[line] and $08 =0 then Org_upr[line]:=Org_upr[line] or $08
                                   else Org_upr[line]:=Org_upr[line] and $f7;
    4: if Org_upr[line] and $10 =0 then Org_upr[line]:=Org_upr[line] or $10
                                   else Org_upr[line]:=Org_upr[line] and $ef;
    5: if Org_upr[line] and $20 =0 then Org_upr[line]:=Org_upr[line] or $20
                                   else Org_upr[line]:=Org_upr[line] and $df;
    6: if Org_upr[line] and $40 =0 then Org_upr[line]:=Org_upr[line] or $40
                                   else Org_upr[line]:=Org_upr[line] and $bf;
    7: if Org_upr[line] and $80 =0 then Org_upr[line]:=Org_upr[line] or $80
                                   else Org_upr[line]:=Org_upr[line] and $7f;
  end;
end;

procedure TForm3.OnOrgan(line,pos:byte);
begin
  case pos of
    0: Org_upr[line]:=Org_upr[line] and $fe;
    1: Org_upr[line]:=Org_upr[line] and $fd;
    2: Org_upr[line]:=Org_upr[line] and $fb;
    3: Org_upr[line]:=Org_upr[line] and $f7;
    4: Org_upr[line]:=Org_upr[line] and $ef;
    5: Org_upr[line]:=Org_upr[line] and $df;
    6: Org_upr[line]:=Org_upr[line] and $bf;
    7: Org_upr[line]:=Org_upr[line] and $7f;
  end;
end;

procedure TForm3.OffOrgan(line,pos:byte);
begin
  case pos of
    0: Org_upr[line]:=Org_upr[line] or $01;
    1: Org_upr[line]:=Org_upr[line] or $02;
    2: Org_upr[line]:=Org_upr[line] or $04;
    3: Org_upr[line]:=Org_upr[line] or $08;
    4: Org_upr[line]:=Org_upr[line] or $10;
    5: Org_upr[line]:=Org_upr[line] or $20;
    6: Org_upr[line]:=Org_upr[line] or $40;
    7: Org_upr[line]:=Org_upr[line] or $80;
  end;
end;

procedure TForm3.TrackBar4Change(Sender: TObject);
begin
  Org_upr[3]:=TrackBar4.Position and $ff;
  Org_upr[4]:=(TrackBar4.Position shr 8)and $ff;
end;

procedure TForm3.TrackBar3Change(Sender: TObject);
begin
  Org_upr[11]:=TrackBar3.Position and $ff;
  Org_upr[12]:=(TrackBar3.Position shr 8)and $ff;
end;


end.
