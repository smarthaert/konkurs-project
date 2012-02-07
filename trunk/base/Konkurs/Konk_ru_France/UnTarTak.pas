unit UnTarTak; //Тактические мишени

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, Dialogs,
  Buttons, Main, ExtCtrls, Spin, UnOther;

type
  TTar_Tak = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    SpinEdit1: TSpinEdit;
    Label3: TLabel;
    Image1: TImage;
    Panel1: TPanel;
    Label4: TLabel;
    Button1: TButton;
    Label5: TLabel;
    procedure ComboBox1Change(Sender: TObject);
    procedure LoadTarget(Num: integer);
    procedure Ris_target(x,y: integer);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Oto_ris;
    function Name_Target(Num: integer): string;
    procedure MyPaint;
    procedure FormActivate(Sender: TObject);
    function Name_Target_Full(Num: integer): string;
    procedure SetComboBox;
  private
    { Private declarations }
  public
    Num_Tar_Tak:word;
    Color_Mask: word;
    function GetModelNum(num: word): word;
  end;

var
  Tar_Tak: TTar_Tak;
  Mich: array[0..1,1..COL_MAX_TCHK_MICH] of TPoint;// Координаты 20 мишений
                                             //на 30 точек
  Km: integer;
  Rects,RectBtnFace: TRect;
  ModelName : array[1..COL_MAX_TIPE_TECHN] of string[20] =
  ('T55','T72','T80','T90','T59','T69','T84','ARJUN','VJAYANTA','LEOPARD',
  'M1A1','M48','','','','','','','','',
  '','','','','','','','','','',
  'BMP1','BMP2','BMD3','M2','SCORPION','BREDLY','','','','',
  'BTR80','M113','BTR_RD','','','','','','','',
  'APACH','COBRA','MI24','','','','','','','',
  'A10A','F15','F16','SU25','','','','','','',
  '','','','','','','','','','',
  'ALKM','SAPSAN','','','','','','','','',
  'KAMAZ','UAZ-469','2C9','D30','BUNKER','','','','','',
  '','','','','','','','','','',
  '','','','','','','','','','',
  '','','','','','','','','','',
  '','','','','','','','','','',
  '','','','','','','','','','',
  '','','','','','','','','','',
  '','','','','','','','','','',
  '','','','','','','','','','',
  '','','','','','','','','','',
  '','','','','','','','','','');
  ModelNum : array[0..COL_MAX_TIPE_TECHN] of word;

implementation

uses UnColor;

{$R *.DFM}

procedure TTar_Tak.FormCreate(Sender: TObject);
begin
  SetComboBox;
  Km:=3;
  RectBtnFace.Left:=132;
  RectBtnFace.Top:=80;
  RectBtnFace.Right:=270;
  RectBtnFace.Bottom:=180;
  ComboBox1.ItemIndex:=0;
end;

procedure TTar_Tak.ComboBox1Change(Sender: TObject);
begin
  MyPaint;
end;

(*********Загрузка рисунка мишени*********)
procedure TTar_Tak.LoadTarget(Num: integer);
var  F: TextFile;
     S: String;
     a,b: integer;
     c: real;
     n: word;
begin
  case num of
    1..30: S:='12';
    31..40: S:='14';
    41..50: S:='13';
    51..60: S:='25';
  end;
  S:=dirBase+'res\Target\Targ_'+S+'.txt';
  if not FileExists(s) then begin
    MessageDlg('Нет файла '+s, mtInformation,[mbOk], 0);
    exit;
  end;
  AssignFile(F,S);  {Связывание файла с именем}
  Reset(F);
  ReadLn(F, S);
  b:=strtoint(copy(S,1,Pos(' ',s)-1));//Количество точек мишени
  for a:=1 to b do begin
    ReadLn(F, S);         //Координаты точек, описывающих контур мишени
    Mich[1][a].x:=strtoint(copy(S,1,Pos(' ',s)-1));
    delete(S,1,Pos(' ',s));
    Mich[1][a].y:=strtoint(copy(S,1,Pos(' ',s)-1));
  end;
  ReadLn(F, S);           //Координаты точек описывающего прямоугольника
  Rects.Right:=strtoint(copy(S,1,Pos(' ',s)-1));
  delete(S,1,Pos(' ',s));
  Rects.Bottom:=strtoint(copy(S,1,Pos(' ',s)-1));
  c:=Rects.Right;                           // Пересчёт размеров описывающего
  Rects.Right:=round(c/Km);                 // прямоугольника
  c:=Rects.Bottom;
  Rects.Bottom:=round(c/Km);
  ReadLn(F, S);
  Caption:=s;
  CloseFile(F);
end;

(******** Рисование мишени *******)
procedure TTar_Tak.Ris_target(x,y: integer);
var c: integer;
b: real;
begin
  Canvas.Rectangle(RectBtnFace);
  x:=x-Rects.Right div 2; //Вычисление текущих координат
  y:=y-Rects.Bottom div 2; // c учётом размеров мишени
  b:=Mich[1][1].x;
  Mich[0][1].x:=x+round(b/Km);
  b:=Mich[1][1].y;
  Mich[0][1].y:=y+round(b/Km);
  for c:=2 to COL_MAX_TCHK_MICH do begin
    b:=Mich[1][c].x;
    Mich[0][c].x:=Mich[0][c-1].x+round(b/Km);
    b:=Mich[1][c].y;
    Mich[0][c].y:=Mich[0][c-1].y+round(b/Km);
  end;
  Canvas.Brush.Color:=clBlack;
  Canvas.Polygon(Mich[0]);
  Canvas.Brush.Color:=clWhite;
end;

procedure TTar_Tak.MyPaint;
begin
  Num_Tar_Tak:=ModelNum[ComboBox1.ItemIndex];
  LoadTarget(Num_Tar_Tak);
  Ris_target(200,130);
  Label4.Caption:=Name_Target_Full(Num_Tar_Tak);
end;

procedure TTar_Tak.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_ESCAPE then close;
end;

procedure TTar_Tak.Button1Click(Sender: TObject);
begin
  Application.CreateForm(TChangColor, ChangColor);
  ChangColor.Num_color:=Color_Mask;
  if ChangColor.ShowModal=mrOk then begin
    Color_Mask:=ChangColor.Num_color;
//    Oto_ris;
  end;
end;

procedure TTar_Tak.Oto_ris;
var Bit: TBitmap;
begin
  Bit:=TBitmap.Create;;
  if (Color_Mask>0)and(Color_Mask<10) then begin
    Bit.LoadFromFile(DirBase+'bmp\Maska'+inttostr(Color_Mask)+'.bmp');
  end
  else begin
    Bit.LoadFromFile(DirBase+'bmp\Maska10.bmp');
  end;
//  Image1.Canvas.Draw(0,0,Bit);
  Bit.Free;
end;

function TTar_Tak.Name_Target(Num: integer): string;
begin
  result:='12';
  case Num of
    MODEL_T55:result:='12';
    MODEL_BMP1:result:='14';
    MODEL_BMP2:result:='14';
    MODEL_T80:result:='12';
  end;
end;


procedure TTar_Tak.FormActivate(Sender: TObject);
begin
  MyPaint;
end;

function TTar_Tak.Name_Target_Full(Num: integer): string;
begin
  result:=ModelName[Num];
end;

procedure TTar_Tak.SetComboBox;
var
  a: word;
  b: word;
begin
  b:=0;
  for a:=1 to COL_MAX_TIPE_TECHN do begin
    if Task.enableModel[a] then begin
      ComboBox1.Items.add(ModelName[a]);
      ModelNum[b]:=a;
      inc(b);
    end;
  end;
end;

function TTar_Tak.GetModelNum(num: word): word;
var
  a: word;
begin
  for a:=1 to COL_MAX_TIPE_TECHN do begin
    if ModelNum[a]=num then begin
      result:=a;
      exit;
    end;
  end;
end;

end.
