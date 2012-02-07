
unit UnEd_Tak;  // Редактор с элементами тактики
                // Координаты мишеней относительно середины начала дорожек
                // Координаты ориентиров относительно левого ближнего края поверхности

interface

uses Windows, SysUtils, Classes, Forms, Controls, StdCtrls, Dialogs,
  Buttons, ExtCtrls, Main, Menus, Graphics, UnBuildSetka, UnOther, Spin,
  UnModel, UnTask;

type
  PTaskRec_TAK=^TTaskRec_TAK;
  POrient=^TOrient;            // Описано в Form1

  TEdit_Tak = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    PopupMenu2: TPopupMenu;
    N10: TMenuItem;
    N11: TMenuItem;
    PopupMenu3: TPopupMenu;
    N12: TMenuItem;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Bevel3: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label7: TLabel;
    SpeedButton14: TSpeedButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Bevel7: TBevel;
    Edit1: TEdit;
    BitBtn3: TBitBtn;
    SpinEdit4: TSpinEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    BitBtn4: TBitBtn;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Panel3: TPanel;
    SpeedButton7: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton12: TSpeedButton;
    Edit2: TEdit;
    Label1: TLabel;
    Bevel4: TBevel;
    ComboBox1: TComboBox;
    Label64: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    procedure Scale_top;
    procedure Scale_left;
    procedure RePaint_My;
    procedure Ris_task;
    procedure Init;
    procedure LoadTarget(Num,Np: integer);
    procedure Ris_target(a,x,y: integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RectLine(Rects: TRect);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    function Count_X_m_ekr(x: integer): integer;
    function Count_Y_m_ekr(y: integer): integer;
    function Count_X_ekr_m(x: integer): integer;
    function Count_Y_ekr_m(y: integer): integer;
    procedure InformTarg(a,x,y,b: integer);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure RisPoint(x,y: integer);
    procedure RisPointMov(x,y: integer);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure Draw_Simvol(x,y, num: integer);
    procedure Draw_Orientirs;
    procedure FormDestroy(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure Image_Draw;
    procedure Sort_List;
    function Count_dX(n: integer): integer;
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    TaskRec_TAK: PTaskRec_TAK;
    Orient: POrient;            // Описано в Form1
    Orient_Temp: TOrient;
  end;
const
  MAX_COL_RIS=21;
  MASHT_X=3;
  MASHT_Y_1=1;
  MASHT_Y_2=2;
  RIS_X=45;        // Cмещение рисунка с дорогами по X вправо
  RIS_Y=173;        // Cмещение рисунка с дорогами по Y вниз
  RIS_Y2=23;        // Cмещение рисунка с дорогами по Y вниз
  CMR_X=10;         // Цена младшего разряда шкалы
  CMR_Y=50;
  DY_NEW_POINT=200;  // Сиещение новой точки
  MIN_T_MICH=30;     /// минимальное время показа мишени
  OKOP_Y1=1500;
  OKOP_Y2=2250;
  OKOP_Y3=3000;
  OKOP_X=450;
  // Значки, обозначающие ориентиры
  SIMVOL:array[1..12,0..15]of word=
  (($0, $180, $240, $420, $810, $1008, $3ffc, $500a,$13c8, $1248, $1248, $1248, $13c8,$1008,$1ff8,$0),// дом
  ($0, $180, $240, $420, $810, $1008, $3ffc, $500a,$13c8, $1248, $1248, $1248, $13c8,$1008,$1ff8,$0),// дом
  ($0,$0,$0,$40,$40,$1f8,$60,$50,$50,$50,$48,$48,$48,$44,$44,$44),/// эл. столб
  ($180,$180,$7e0,$180,$240,$ff0,$240,$240,$420,$420,$660,$5a0,$990,$bd0,$a50,$c30),/// в.в.столб
  ($180, $180, $240, $240, $240, $420, $420, $420,$bd0, $ff0, $ff0, $ff0, $ff0,$ff0,$7e0,$3c0),//водонапор
  ($180, $180, $240, $240, $240, $420, $420, $420,$bd0, $ff0, $ff0, $ff0, $ff0,$ff0,$7e0,$3c0),// водонапор
  ($0, $180, $240, $420, $810, $1008, $3ffc, $500a,$13c8, $1248, $1248, $1248, $13c8,$1008,$1ff8,$0),// дом
  ($0, $180, $240, $420, $810, $1008, $3ffc, $500a,$13c8, $1248, $1248, $1248, $13c8,$1008,$1ff8,$0),// дом
  ($07c0,$0820,$0820,$0440,$0820,$1010,$0820,$0440,$1830,$2008,$2008,$1830,$06c0,$0100,$0100,$01f0),/// дерево
  ($07c0,$0820,$0820,$0440,$0820,$1010,$0820,$0440,$1830,$2008,$2008,$1830,$06c0,$0100,$0100,$01f0),/// дерево
  ($0,$0,$0,$0,$0,$0,$c0,$3b20,$4410,$8016,$8009, $8001, $7ffe,$0,$0,$0),// куст
  ($0, $180, $240, $420, $810, $1008, $3ffc, $500a,$13c8, $1248, $1248, $1248, $13c8,$1008,$1ff8,$0));// дом
var
  Edit_Tak: TEdit_Tak;
  x_delta: integer;// Смещение поля по Х в метрах
  y_delta: integer;// Смещение поля по Y в метрах
  x_mem, y_mem: integer; //
  xc, yc: integer;
  xtek, ytek, xpolig_max, ypolig_max, masht_y: integer;
  x_ris_tek, y_ris_tek: integer;
  mov,mov_targ: boolean;
  Mich:         array[0..(COL_MAX_MICH_TAK+COL_MAX_OBJEKT_TAK_TEX),1..COL_MAX_TCHK_MICH] of TPoint;// Координаты 10 мишений
                                                         //на 30 точек
  col_tch_targ: array[0..(COL_MAX_MICH_TAK+COL_MAX_OBJEKT_TAK_TEX)] of integer;   //кол-во точек
  Rects:        array[1..(COL_MAX_MICH_TAK+COL_MAX_OBJEKT_TAK_TEX)] of TRect;     // Описывающий мишень пр-к
  RectsRis:     array[1..(COL_MAX_MICH_TAK+COL_MAX_OBJEKT_TAK_TEX)] of TRect;  // Перемещаемый пр-к
  Kmich: integer;         // Коэфф. пересчёта размера мишени
  NAktiv,NAktiv_point: integer;     // N выбранной мишени
  RectWhite: TRect;    //Белое поле
  Risunok: array[1..3,1..3] of  TBitmap;
  BitMapTak:  TBitmap;
  mode_otobr,inform: boolean;
  Vvod_orient,Move_orient: word;
  Mascht, Num_Ris: word;
implementation

uses UnEkip, UnBoepr, UnTarTak, UnPoint;

{$R *.DFM}

procedure TEdit_Tak.FormCreate(Sender: TObject);
var a:word;
begin
  Num_ris:=0;
  Left:=0;
  Width:=1024;
  Top:=0;
  Height:=768;
  x_delta:=0;
  xpolig_max:=200;
  y_delta:=0;
  ypolig_max:=550;
  Kmich:=12;
  NAktiv:=0;
  Vvod_orient:=0;
  masht_y:=MASHT_Y_2;
  RectWhite.Left:=0; // Поле, где находятся мишени
  RectWhite.Right:=Image3.Width;
  RectWhite.Top:=0;
  RectWhite.Bottom:=Image3.Height;
//  Risunok[1][1]:=TBitmap.Create;
//  Risunok[1][1].LoadFromFile(Dir+'bmp\edit\Kleto3s.BMP');
    for a:=1 to 3 do begin
      Risunok[a][1]:=TBitmap.Create;
      Risunok[a][1].LoadFromFile(DirBase+'bmp\edit\Pole_bT'+inttostr(a)+'.BMP');
      Risunok[a][2]:=TBitmap.Create;
      Risunok[a][2].LoadFromFile(DirBase+'bmp\edit\Pole_eT'+inttostr(a)+'.BMP');
      Risunok[a][3]:=TBitmap.Create;
      Risunok[a][3].LoadFromFile(DirBase+'bmp\edit\Okop'+inttostr(a)+'.BMP');
    end;
  BitMapTak:=TBitmap.Create;
  Mascht:=8;
  ComboBox1.ItemIndex:=Aktivnost;
end;

procedure TEdit_Tak.Init;
var a: integer;
begin
  for a:=1 to TaskRec_TAK.Col_targ do begin             //Загрузка мишенней
    LoadTarget(TaskRec_TAK.TarRec[a].Num,a);
  end;
  for a:=1 to Col_Model do begin             //Загрузка мишенней
    LoadTarget(Target_Model_Isx[a].Num,COL_MAX_MICH_TAK+a);
  end;
  edit1.Text:=inttostr(Col_Model);
  edit2.Text:=inttostr(Orient.Col_orient);
  SpinEdit4.Value:=TaskRec_TAK.Tstr;

end;

procedure TEdit_Tak.RePaint_My;
begin
  Scale_top;                    // Шкала верхняя
  Scale_left;                   // Шкала нижняя
  Image3.Canvas.Brush.Color:=clWhite;
  Image3.Canvas.Pen.Color:=clWhite;
  Image3.Canvas.Rectangle(RectWhite);  // Очистка поля
  Image3.Canvas.Pen.Color:=clBlack;
  Image_Draw;
  Ris_task;                     // Рисование мишеней
  Draw_Orientirs;               // Рисование ориентиров
end;

procedure TEdit_Tak.Image_Draw;
var a:word;
d: integer;

begin
    for a:=1 to 3 do begin
      x_ris_tek:=xc-(Risunok[a][1].Width div 2)+  //Середина дорожки
                Count_dX(a)*MASHT_X*Mascht div CMR_X;        // положение по Х
      y_ris_tek:=yc-(STOLB_DY_BL div DDD)*masht_y*Mascht div CMR_Y;
      Image3.Canvas.Draw(x_ris_tek,y_ris_tek,Risunok[a][1]);// Рисунок с дорогой
      y_ris_tek:=yc;
      Image3.Canvas.Draw(x_ris_tek,y_ris_tek,Risunok[a][2]);// Рисунок с дорогой

      y_ris_tek:=yc-(OKOP_Y1 div DDD)*masht_y*Mascht div CMR_Y;
      d:=(OKOP_X div DDD)*masht_y*Mascht div CMR_Y+(Risunok[a][3].Width div 2);
      Image3.Canvas.Draw(x_ris_tek-d,y_ris_tek,Risunok[a][3]);// Рисунок с окопом
      y_ris_tek:=yc-(OKOP_Y2 div DDD)*masht_y*Mascht div CMR_Y;
      Image3.Canvas.Draw(x_ris_tek+d,y_ris_tek,Risunok[a][3]);// Рисунок с окопом
      y_ris_tek:=yc-(OKOP_Y3 div DDD)*masht_y*Mascht div CMR_Y;
      Image3.Canvas.Draw(x_ris_tek-d,y_ris_tek,Risunok[a][3]);// Рисунок с окопом
    end;
////  Image3.Canvas.Draw(0,0,Risunok[1][1]);
end;

// Рисование верхней шкалы
procedure TEdit_Tak.Scale_top;
var x, y, xmin, ymin, xmax, ymax, xst: integer;
begin
  xmin:=Bevel1.Left+2;
  xmax:=Bevel1.Left+Bevel1.Width-2;
  ymin:=Bevel1.Top+2;
  ymax:=Bevel1.Top+Bevel1.Height;      // Размеры шкалы по размерам Bevel
  Canvas.Brush.Color:=clBtnFace;
  Canvas.Pen.Color:=clBtnFace;
  Canvas.Rectangle(xmin,ymin,xmax,ymax);// Очистка шкалы
  Canvas.Pen.Color:=clBlack;
  y:=ymin+1;
  Canvas.MoveTo(xmin,ymin);             // Продольная линия
  Canvas.LineTo(xmax,ymin);
  xc:=((xmax-xmin) div 2)-(x_delta*MASHT_X*Mascht) div CMR_X; //Координата х точки=0
  xst:=x_delta-((xmax-xmin) div 2)*10 div (MASHT_X*Mascht);  //Значение начальной точки шкалы
  x:=(xst mod 10)+xmin;          //координаты начала шкалы
  xst:=xst-(xst mod 10);
  while (x+(MASHT_X*Mascht))<xmax do begin
    x:=x+(MASHT_X*Mascht);
    xst:=xst+10;
    if (xst mod 50)=0 then begin        // Длинные поперечные штрихи
      Canvas.MoveTo(x,y);
      Canvas.LineTo(x,y+9);
    end;
    if (xst mod 100)=0 then begin       // Длинные жирные поперечные штрихи с цифрами
      Canvas.Pen.Width:=2;
      Canvas.MoveTo(x,y);
      Canvas.LineTo(x,y+10);
      Canvas.Pen.Width:=1;
      if (x+(MASHT_X*Mascht)+20)<xmax then Canvas.TextOut(x+2,y+7,IntToStr(xst));
    end
    else begin
      Canvas.MoveTo(x,y);                // Короткие поперечные штрихи
      Canvas.LineTo(x,y+4);
    end;
  end;
  Canvas.Brush.Color:=clWhite;
end;

// Рисование нижней шкалы
procedure TEdit_Tak.Scale_left;
var x, y, xmin, ymin, xmax, ymax, yst: integer;
begin
  xmin:=Bevel2.Left+2;
  xmax:=Bevel2.Left+Bevel2.Width-2;
  ymin:=Bevel2.Top+2;
  ymax:=Bevel2.Top+Bevel2.Height-2;
  Canvas.Brush.Color:=clBtnFace;
  Canvas.Pen.Color:=clBtnFace;
  Canvas.Rectangle(xmin,ymin,xmax,ymax);
  Canvas.Pen.Color:=clBlack;
  x:=xmin+1;
  Canvas.MoveTo(xmin,ymax);
  Canvas.LineTo(xmin,ymin);
  yc:=ymax-ymin+(y_delta*(masht_y*Mascht)) div 10;
  yst:=y_delta-10 div (masht_y*Mascht);  //Значение начальной точки шкалы
  y:=(yst mod 10)+ymax-10;          //координаты начала шкалы
  yst:=yst-(yst mod 10);
  while y>(ymin+4) do begin
    if (yst mod 50)=0 then begin
      Canvas.MoveTo(x,y);
      Canvas.LineTo(x+9,y);
    end;
    if (yst mod 100)=0 then begin
      Canvas.Pen.Width:=2;
      Canvas.MoveTo(x,y);
      Canvas.LineTo(x+10,y);
      Canvas.Pen.Width:=1;
      if (y>(ymin+10)) then Canvas.TextOut(x+6,y-12,IntToStr(yst*5));
    end
    else begin
      Canvas.MoveTo(x,y);
      Canvas.LineTo(x+4,y);
    end;
    y:=y-(masht_y*Mascht);
    yst:=yst+10;
  end;
  Canvas.Brush.Color:=clWhite;
  Bevel2.Visible:=true;
end;

// Щелчок по верхней шкале
procedure TEdit_Tak.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  x_mem:=x;
  xtek:=x_delta;
  y_mem:=y;
  mov:=true;
end;

// Перемещение по верхней шкале
procedure TEdit_Tak.Image1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if mov then begin
    if (((x_mem-x)>0)and(x_delta<xpolig_max))or
      (((x_mem-x)<0)and(x_delta>-xpolig_max))then begin
      x_delta:=xtek+(x_mem-x)*10 div (MASHT_X*Mascht);
      Scale_top;
    end;
  end;
end;

// Отпускание на верхней шкале
procedure TEdit_Tak.Image1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mov:=false;
  RePaint_My;
end;

// Щелчок по нижней шкале
procedure TEdit_Tak.Image2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  y_mem:=y;
  ytek:=y_delta;
  mov:=true;
end;

// Перемещение по нижней шкале
procedure TEdit_Tak.Image2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if mov then begin
    if (((y_mem-y)<0)and(y_delta<ypolig_max))or(((y_mem-y)>0)and(y_delta>0))then begin
      y_delta:=ytek-(y_mem-y)*10 div (masht_y*Mascht);
      Scale_left;
    end;
  end;
end;

// Отпускание на нижней шкале
procedure TEdit_Tak.Image2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mov:=false;
  RePaint_My;
end;

procedure TEdit_Tak.BitBtn1Click(Sender: TObject);
begin
  if Mascht<18 then Mascht:=Mascht+2;
  RePaint_My;
end;

procedure TEdit_Tak.BitBtn2Click(Sender: TObject);
begin
  if Mascht>6 then Mascht:=Mascht -2;
  RePaint_My;
end;

// Перевод положения объектов в метрах в экранные координаты
function TEdit_Tak.Count_X_m_ekr(x: integer): integer;
var a: real;
begin
// -200  т.к. начало отсчёта по х находится по координате=0, а при
// визуализации по левому краю .
  a:=x*MASHT_X*Mascht;
  result:=round(xc+a/CMR_X);
end;

// Перевод положения объектов в метрах в экранные координаты
function TEdit_Tak.Count_Y_m_ekr(y: integer): integer;
var a: real;
begin
  a:=y*(masht_y*Mascht);
  result:=round(yc-a/CMR_Y);
end;

function TEdit_Tak.Count_X_ekr_m(x: integer): integer;
begin
  result:=(X-xc)*CMR_X div (MASHT_X*Mascht);
end;

// Перевод положения объектов в метрах в экранные координаты
function TEdit_Tak.Count_Y_ekr_m(y: integer): integer;
begin
  if yc-y<=0 then result:=0 else result:=(yc-y)*CMR_Y div (masht_y*Mascht);
end;

procedure TEdit_Tak.Ris_task;
var a,b,x,y: integer;
begin
  for a:=1 to TaskRec_TAK.Col_targ do begin
    x:=Count_X_m_ekr(TaskRec_TAK.TarRec[a].Xtek[0]-round((stolbDX1+stolbLeft)/ DDD));
    y:=Count_Y_m_ekr(TaskRec_TAK.TarRec[a].Ytek[0]);
    //Рисование контура мишени
    Ris_target(a,x,y);
    //Рисование линии
    InformTarg(a,x,y,0);
    if TaskRec_TAK.TarRec[a].ColPoints>0 then begin
      Image3.Canvas.MoveTo(x,y);
      for b:= 1 to TaskRec_TAK.TarRec[a].ColPoints do begin
        x:=Count_X_m_ekr(TaskRec_TAK.TarRec[a].Xtek[b]-round((stolbDX1+stolbLeft)/ DDD));
        y:=Count_Y_m_ekr(TaskRec_TAK.TarRec[a].Ytek[b]);
        Image3.Canvas.LineTo(x,y);
        InformTarg(a,x,y,b);
        Image3.Canvas.MoveTo(x,y);
      end;
    end;
  end;// a:=1
  for a:=1 to Col_Model do begin
    x:=Count_X_m_ekr(Target_Model_Isx[a].Xtek[0]-round((stolbDX1+stolbLeft)/ DDD));
    y:=Count_Y_m_ekr(Target_Model_Isx[a].Ytek[0]);
    //Рисование контура мишени
    Ris_target(COL_MAX_MICH_TAK+a,x,y);
    //Рисование линии
    InformTarg(COL_MAX_MICH_TAK+a,x,y,0);
    if Target_Model_Isx[a].ColPoints>0 then begin
      Image3.Canvas.MoveTo(x,y);
      for b:= 1 to Target_Model_Isx[a].ColPoints do begin
        x:=Count_X_m_ekr(Target_Model_Isx[a].Xtek[b]-round((stolbDX1+stolbLeft)/ DDD));
        y:=Count_Y_m_ekr(Target_Model_Isx[a].Ytek[b]);
        Image3.Canvas.LineTo(x,y);
        InformTarg(COL_MAX_MICH_TAK+a,x,y,b);
        Image3.Canvas.MoveTo(x,y);
      end;
    end;
  end;// a:=1
end;

procedure TEdit_Tak.InformTarg(a,x,y,b: integer);//мишень, x,y, N точки
var
dr,tr,xr,yr,vr: real;
s: string;
//a: TFontStyles;
begin
    RisPoint(x,y);
    if a<=COL_MAX_MICH_TAK then begin
      s:=Inttostr(TaskRec_TAK.TarRec[a].Ytek[b]);
    end
    else begin
      s:=Inttostr(Target_Model_Isx[a-COL_MAX_MICH_TAK].Ytek[b]);
    end;
    if inform then begin
      Image3.Canvas.TextOut(x+5,y+5,s);
      Image3.Canvas.MoveTo(x+5,y+17);
      Image3.Canvas.LineTo(x+30,y+17);
    end;
    // Расчёт времени
    if b=0 then begin
      if a<=COL_MAX_MICH_TAK then begin
        TaskRec_TAK.TarRec[a].Tend:=TaskRec_TAK.TarRec[a].Tst+TaskRec_TAK.TarRec[a].Tstop[0];
        s:=Inttostr(TaskRec_TAK.TarRec[a].Tst)+'-'+Inttostr(TaskRec_TAK.TarRec[a].Tend);
      end
      else begin
        Target_Model_Isx[a-COL_MAX_MICH_TAK].Tend:=
                   Target_Model_Isx[a-COL_MAX_MICH_TAK].Tst+Target_Model_Isx[a-COL_MAX_MICH_TAK].Tstop[0];
        s:=Inttostr(Target_Model_Isx[a-COL_MAX_MICH_TAK].Tst)+'-'+Inttostr(Target_Model_Isx[a-COL_MAX_MICH_TAK].Tend);
      end;
    end
    else begin
      if a<=COL_MAX_MICH_TAK then begin
        xr:=TaskRec_TAK.TarRec[a].Xtek[b]-TaskRec_TAK.TarRec[a].Xtek[b-1];
        yr:=TaskRec_TAK.TarRec[a].Ytek[b]-TaskRec_TAK.TarRec[a].Ytek[b-1];
        dr:=sqrt(xr*xr+yr*yr);       // Расстояние от точки до точки
        vr:=TaskRec_TAK.TarRec[a].Skor[b];
        vr:=vr*10/36;                //Перевод км/час в м/с
        tr:=dr/vr;                   // Время на участке
        // Время прихода в точку
        TaskRec_TAK.TarRec[a].Tend:=TaskRec_TAK.TarRec[a].Tend+round(tr);
        s:=Inttostr(TaskRec_TAK.TarRec[a].Tend);
        if TaskRec_TAK.TarRec[a].Tstop[b]>0 then begin
          TaskRec_TAK.TarRec[a].Tend:=TaskRec_TAK.TarRec[a].Tend+TaskRec_TAK.TarRec[a].Tstop[b];
          s:=s+'-'+Inttostr(TaskRec_TAK.TarRec[a].Tend);
        end;
      end
      else begin
        xr:=Target_Model_Isx[a-COL_MAX_MICH_TAK].Xtek[b]-Target_Model_Isx[a-COL_MAX_MICH_TAK].Xtek[b-1];
        yr:=Target_Model_Isx[a-COL_MAX_MICH_TAK].Ytek[b]-Target_Model_Isx[a-COL_MAX_MICH_TAK].Ytek[b-1];
        dr:=sqrt(xr*xr+yr*yr);       // Расстояние от точки до точки
        vr:=Target_Model_Isx[a-COL_MAX_MICH_TAK].Skor[b];
        vr:=vr*10/36;                //Перевод км/час в м/с
        tr:=dr/vr;                   // Время на участке
        // Время прихода в точку
        Target_Model_Isx[a-COL_MAX_MICH_TAK].Tend:=Target_Model_Isx[a-COL_MAX_MICH_TAK].Tend+round(tr);
        s:=Inttostr(Target_Model_Isx[a-COL_MAX_MICH_TAK].Tend);
        if Target_Model_Isx[a-COL_MAX_MICH_TAK].Tstop[b]>0 then begin
          Target_Model_Isx[a-COL_MAX_MICH_TAK].Tend:=
                      Target_Model_Isx[a-COL_MAX_MICH_TAK].Tend+Target_Model_Isx[a-COL_MAX_MICH_TAK].Tstop[b];
          s:=s+'-'+Inttostr(Target_Model_Isx[a-COL_MAX_MICH_TAK].Tend);
        end;
      end;
    end;
    if inform then Image3.Canvas.TextOut(x+5,y+19,s);
end;

procedure TEdit_Tak.RisPoint(x,y: integer);
begin
  Image3.Canvas.MoveTo(x-1,y-1);
  Image3.Canvas.LineTo(x-1,y+1);
  Image3.Canvas.LineTo(x+1,y+1);
  Image3.Canvas.LineTo(x+1,y-1);
  Image3.Canvas.LineTo(x-2,y-2);
  Image3.Canvas.LineTo(x-2,y+2);
  Image3.Canvas.LineTo(x+2,y+2);
  Image3.Canvas.LineTo(x+2,y-2);
  Image3.Canvas.LineTo(x-2,y-2);
end;

procedure TEdit_Tak.RisPointMov(x,y: integer);
begin
  Image3.Canvas.Pen.Mode:=pmNotXor;
  Image3.Canvas.MoveTo(x-1,y-1);
  Image3.Canvas.LineTo(x-1,y+1);
  Image3.Canvas.LineTo(x+1,y+1);
  Image3.Canvas.LineTo(x+1,y-1);
  Image3.Canvas.LineTo(x-2,y-2);
  Image3.Canvas.LineTo(x-2,y+2);
  Image3.Canvas.LineTo(x+2,y+2);
  Image3.Canvas.LineTo(x+2,y-2);
  Image3.Canvas.LineTo(x-2,y-2);
  Image3.Canvas.Pen.Mode:=pmCopy;
end;

(*******Рисование перемещаемого прям-ка*****)
procedure TEdit_Tak.RectLine(Rects: TRect);
begin
  Image3.Canvas.Pen.Mode:=pmNotXor;
  Image3.Canvas.MoveTo(Rects.Left,Rects.Top);
  Image3.Canvas.LineTo(Rects.Right,Rects.Top);
  Image3.Canvas.LineTo(Rects.Right,Rects.Bottom);
  Image3.Canvas.LineTo(Rects.Left,Rects.Bottom);
  Image3.Canvas.LineTo(Rects.Left,Rects.Top);
  Image3.Canvas.Pen.Mode:=pmCopy;
end;

(******** Рисование мишени *******)
procedure TEdit_Tak.Ris_target(a,x,y: integer);
var c: integer;
b: real;
begin
    x:=x-Rects[a].Right div 2;             // Вычисление текущих координат
    y:=y-Rects[a].Bottom-2;                // c учётом размеров мишени
    RectsRis[a].Left:=x;                   // Координаты перемещаемого
    RectsRis[a].Right:=x+Rects[a].Right+2; // описывающего прямоугольника
    RectsRis[a].Top:=y;
    RectsRis[a].Bottom:=y+Rects[a].Bottom+2;

    b:=Mich[a][1].x;
    Mich[0][1].x:=x+round(b/Kmich);
    b:=Mich[a][1].y;
    Mich[0][1].y:=y+round(b/Kmich);
    for c:=2 to col_tch_targ[a] do begin
      b:=Mich[a][c].x;
      Mich[0][c].x:=Mich[0][c-1].x+round(b/Kmich);
      b:=Mich[a][c].y;
      Mich[0][c].y:=Mich[0][c-1].y+round(b/Kmich);
    end;
    for c:=col_tch_targ[a]+1 to COL_MAX_TCHK_MICH do begin
      Mich[0][c].x:=Mich[0][c-1].x;
      Mich[0][c].y:=Mich[0][c-1].y;
    end;
    Image3.Canvas.Brush.Color:=$0;
    Image3.Canvas.Polygon(Mich[0]);
    Image3.Canvas.Brush.Color:=clWhite;
end;

(*********Загрузка рисунка мишени*********)
procedure TEdit_Tak.LoadTarget(Num,Np: integer);
var  F: TextFile;
     S: String;
     a: integer;
     c: real;
begin
  case num of
    1..30: S:='12';
    31..40: S:='14';
    41..50: S:='13';
    51..60: S:='25';
  end;
  S:=DirBase+'res\Target\Targ_'+S+'.txt';
  if not FileExists(s) then begin
    MessageDlg('Нет файла '+s, mtInformation,[mbOk], 0);
    exit;
  end;
  AssignFile(F,S);  {Связывание файла с именем}
  Reset(F);
  ReadLn(F, S);
  col_tch_targ[Np]:=strtoint(copy(S,1,Pos(' ',s)-1));//Количество точек мишени
  for a:=1 to col_tch_targ[Np] do begin
    ReadLn(F, S);         //Координаты точек, описывающих контур мишени
    Mich[Np][a].x:=strtoint(copy(S,1,Pos(' ',s)-1));
    delete(S,1,Pos(' ',s));
    Mich[Np][a].y:=strtoint(copy(S,1,Pos(' ',s)-1));
  end;
  ReadLn(F, S);           //Координаты точек описывающего прямоугольника
  Rects[Np].Right:=strtoint(copy(S,1,Pos(' ',s)-1));
  delete(S,1,Pos(' ',s));
  Rects[Np].Bottom:=strtoint(copy(S,1,Pos(' ',s)-1));
  c:=Rects[Np].Right;                           // Пересчёт размеров описывающего
  Rects[Np].Right:=round(c/Kmich);                 // прямоугольника
  c:=Rects[Np].Bottom;
  Rects[Np].Bottom:=round(c/Kmich);
  CloseFile(F);
end;

(****************Выбор мишени****************)
procedure TEdit_Tak.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var a,b,n1,Xp,Yp: integer;
begin
  if Vvod_orient>0 then exit;
  x_mem:=x;
  y_mem:=y;
  PopupMenu:=nil;
  for a:=1 to Orient.Col_orient do begin
    xp:=Count_X_m_ekr(round(Orient.Xorient[a]-(stolbDX1+stolbLeft)/ DDD));
    yp:=Count_Y_m_ekr(round(Orient.Yorient[a])-round(stolbBottom+STOLB_DY_R)div DDD);
    if (X>Xp-8)and(Y>Yp-8)and(X<Xp+8)and(Y<Yp+8)then begin
      Move_orient:=a;
      Screen.Cursor:=crDrag;   // Изменение формы курсора
      PopupMenu:=PopupMenu3;
      exit;
    end;
  end;
  for a:=1 to TaskRec_TAK.Col_targ do begin //Выбор мишени
    if (X>RectsRis[a].Left)and(Y>RectsRis[a].Top)and
         (X<RectsRis[a].Right)and(Y<RectsRis[a].Bottom)then begin
      RectLine(RectsRis[a]);   //Рисуем прям-к вокруг мишени
      mov_targ:=true;
      NAktiv:=a;               // Запоминаем номер выбранной мишени
      NAktiv_Point:=0;
      PopupMenu:=PopupMenu1;
      exit;
    end
    else begin
      for b:=1 to TaskRec_TAK.TarRec[a].ColPoints do begin
        Xp:=Count_X_m_ekr(TaskRec_TAK.TarRec[a].Xtek[b]-round((stolbDX1+stolbLeft)/ DDD));
        Yp:=Count_Y_m_ekr(TaskRec_TAK.TarRec[a].Ytek[b]);
        if (X>Xp-5)and(Y>Yp-5)and(X<Xp+5)and(Y<Yp+5)then begin
           mov_targ:=true;
           NAktiv:=a;               // Запоминаем номер выбранной мишени
           NAktiv_Point:=b;
           PopupMenu:=PopupMenu1;
           Xtek:=X;
           Ytek:=Y;
           x_mem:=Xp-X;
           y_mem:=Yp-Y;
           exit;
        end;
      end;
    end;
  end;
  for a:=1 to Col_Model do begin //Выбор мишени
    if (X>RectsRis[COL_MAX_MICH_TAK+a].Left)and(Y>RectsRis[COL_MAX_MICH_TAK+a].Top)and
         (X<RectsRis[COL_MAX_MICH_TAK+a].Right)and(Y<RectsRis[COL_MAX_MICH_TAK+a].Bottom)then begin
      RectLine(RectsRis[COL_MAX_MICH_TAK+a]);   //Рисуем прям-к вокруг мишени
      mov_targ:=true;
      NAktiv:=COL_MAX_MICH_TAK+a;          // Запоминаем номер выбранной мишени
      NAktiv_Point:=0;
      PopupMenu:=PopupMenu1;
      exit;
    end
    else begin
      for b:=1 to Target_Model_isx[a].ColPoints do begin
        Xp:=Count_X_m_ekr(Target_Model_isx[a].Xtek[b]-round((stolbDX1+stolbLeft)/ DDD));
        Yp:=Count_Y_m_ekr(Target_Model_isx[a].Ytek[b]);
        if (X>Xp-5)and(Y>Yp-5)and(X<Xp+5)and(Y<Yp+5)then begin
           mov_targ:=true;
           NAktiv:=COL_MAX_MICH_TAK+a;     // Запоминаем номер выбранной мишени
           NAktiv_Point:=b;
           PopupMenu:=PopupMenu1;
           Xtek:=X;
           Ytek:=Y;
           x_mem:=Xp-X;
           y_mem:=Yp-Y;
           exit;
        end;
      end;
    end;
  end;
  PopupMenu:=PopupMenu2;
end;

(********Перемещение прямоугольника по мишенному полю********)
procedure TEdit_Tak.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var dX,dY,n: integer;
begin
  if Move_orient>0 then exit;
  if (mov_targ) and (X>RectWhite.Left+10) and
       (X<RectWhite.Right-10)and (Y>RectWhite.Top+10)
       and (Y<RectWhite.Bottom-60)  then begin // Если выбрана мишень
    if NAktiv_Point=0 then begin
      dX:=x_mem-X;                   //Пересчёт координат нового прям-ка
      x_mem:=X;
      dY:=y_mem-Y;
      y_mem:=Y;
      RectLine(RectsRis[NAktiv]); // Стираем старый прям-к
      RectsRis[NAktiv].Left:=RectsRis[NAktiv].Left-dX;
      RectsRis[NAktiv].Right:=RectsRis[NAktiv].Right-dX;
      RectsRis[NAktiv].Top:=RectsRis[NAktiv].Top-dY;
      RectsRis[NAktiv].Bottom:=RectsRis[NAktiv].Bottom-dY;
      RectLine(RectsRis[NAktiv]);  // Рисуем новый прям-к
    end
    else begin
      RisPointMov(Xtek+x_mem,Ytek+y_mem);
      Xtek:=X;
      Ytek:=y;
      RisPointMov(Xtek+x_mem,Ytek+y_mem);
    end;
  end;
end;

(***Отпускание левой клавиши/ Фикскация положения мишени***************)
procedure TEdit_Tak.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var a,d,n: integer;
begin
  if Move_orient>0 then begin  // Перемещение ориентиров
    Orient.Xorient[Move_orient]:=Orient.Xorient[Move_orient]+
               Count_X_ekr_m(X)- Count_X_ekr_m(x_mem);
    Orient.Yorient[Move_orient]:=Orient.Yorient[Move_orient]+
               (Count_Y_ekr_m(Y)-Count_Y_ekr_m(y_mem));
    if Orient.Yorient[Move_orient]<MIN_DALN_ORIENT then Orient.Yorient[Move_orient]:=MIN_DALN_ORIENT;
    if Button=mbLeft then Move_orient:=0;
    RePaint_My;
    Screen.Cursor:=crArrow;   // Восстановление формы курсора
    Sort_List;
    exit;
  end;
  if Vvod_orient>0 then begin  // Ввод ориентиров
    inc(Orient.Col_orient);
    Edit2.Text:=inttostr(Orient.Col_orient);
    Orient.Typ_orient[Orient.Col_orient]:=Vvod_orient;
    Orient.Xorient[Orient.Col_orient]:=
         Count_X_ekr_m(X)+(round(stolbDX1)+round(stolbLeft))div DDD;
    Orient.Yorient[Orient.Col_orient]:=Count_Y_ekr_m(Y)+round(stolbBottom+STOLB_DY_R)div DDD;
    if Orient.Yorient[Orient.Col_orient]<MIN_DALN_ORIENT then Orient.Yorient[Orient.Col_orient]:=MIN_DALN_ORIENT;
    Vvod_orient:=0;
    SpeedButton12.Down:=true; // Отпускание кнопки
    Screen.Cursor:=crArrow;   // Восстановление формы курсора
    Sort_List;
    exit;
  end;
  if (NAktiv>0) and mov_targ then begin
    if NAktiv_Point=0 then begin
      // Если выделена мишень
      // Определяем центр мишени
      d:=(RectsRis[NAktiv].Right-RectsRis[NAktiv].Left) div 2-2;
      // Пересчитываем новые координаты мишени
      if NAktiv<=COL_MAX_MICH_TAK then begin
        TaskRec_TAK.TarRec[NAktiv].Xtek[0]:=Count_X_ekr_m(RectsRis[NAktiv].Left+d)
           +(round(stolbDX1)+round(stolbLeft))div DDD;
        d:=(RectsRis[NAktiv].Bottom-RectsRis[NAktiv].Top);
        TaskRec_TAK.TarRec[NAktiv].Ytek[0]:=Count_Y_ekr_m(RectsRis[NAktiv].Top+d);
      end
      else begin
        Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Xtek[0]:=Count_X_ekr_m(RectsRis[NAktiv].Left+d)+
            (round(stolbDX1)+round(stolbLeft))div DDD;
        d:=(RectsRis[NAktiv].Bottom-RectsRis[NAktiv].Top);
        Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Ytek[0]:=Count_Y_ekr_m(RectsRis[NAktiv].Top+d);
      end;
    end
    else begin
     // Если выделена точка
      if NAktiv<=COL_MAX_MICH_TAK then begin
        a:=Count_X_ekr_m(X+x_mem)+(round(stolbDX1)+round(stolbLeft))div DDD;
        if a>0 then TaskRec_TAK.TarRec[NAktiv].Xtek[NAktiv_point]:=a
               else TaskRec_TAK.TarRec[NAktiv].Xtek[NAktiv_point]:=0;
        TaskRec_TAK.TarRec[NAktiv].Ytek[NAktiv_point]:=Count_Y_ekr_m(Y+y_mem);
      end
      else begin
        a:=Count_X_ekr_m(X+x_mem)+(round(stolbDX1)+round(stolbLeft))div DDD;
        if a>0 then Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Xtek[NAktiv_point]:=a
               else Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Xtek[NAktiv_point]:=0;
        Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Ytek[NAktiv_point]:=Count_Y_ekr_m(Y+y_mem);
      end;

    end;
    // Обнуляем выбор мишени
    mov_targ:=false;
    if Button=mbLeft then begin
      NAktiv:=0;
      NAktiv_point:=0;
    end;
    // Перерисовываем мишенное поле
    RePaint_My;
  end;
  Screen.Cursor:=crArrow;   // Восстановление формы курсора
end;

(**************Ввод боеприпасов*************)
procedure TEdit_Tak.BitBtn3Click(Sender: TObject);
begin
  Application.CreateForm(TOKBottomDlg5, OKBottomDlg5);
  OKBottomDlg5.SpinEdit4.Value:=Task.Bk.Col_Upr;  // Упр
  if OKBottomDlg5.ShowModal=mrOk then begin;
    Task.Bk.Col_Upr:=OKBottomDlg5.SpinEdit4.Value;  // Упр
  end;
  OKBottomDlg5.Free;
end;

(***********Восстановление старой задачи************)
procedure TEdit_Tak.BitBtn4Click(Sender: TObject);
begin
  Load_Task(true);
  Init;
  RePaint_My;
end;

(********Редактировать мишень**********)
procedure TEdit_Tak.N1Click(Sender: TObject);
begin
  Application.CreateForm(TTar_Tak, Tar_Tak);
//  Tar_Tak.Label1.Visible:=false;
//  Tar_Tak.ComboBox1.Visible:=false;
  if NAktiv<=COL_MAX_MICH_TAK then begin
    Tar_Tak.ComboBox1.ItemIndex:=0;
    Tar_Tak.SpinEdit1.Text:=IntToStr(TaskRec_TAK.TarRec[NAktiv].Tst);
    if Tar_Tak.ShowModal=mrOk then begin;
      TaskRec_TAK.TarRec[NAktiv].Tst:=StrToInt(Tar_Tak.SpinEdit1.Text);
      TaskRec_TAK.TarRec[NAktiv].Color_Mask:=Tar_Tak.Color_Mask;
      LoadTarget(TaskRec_TAK.TarRec[NAktiv].Num,NAktiv);
      RePaint_My;
    end;
  end
  else if NAktiv>COL_MAX_MICH_TAK then begin
    Tar_Tak.ComboBox1.ItemIndex:=Tar_Tak.GetModelNum(Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Num);
    Tar_Tak.SpinEdit1.Text:=IntToStr(Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Tst);
    if Tar_Tak.ShowModal=mrOk then begin;
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Tst:=StrToInt(Tar_Tak.SpinEdit1.Text);
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Color_Mask:=Tar_Tak.Color_Mask;
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Num:=Tar_Tak.Num_Tar_Tak;
      LoadTarget(Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Num,NAktiv);
      RePaint_My;
    end;
  end;
  Tar_Tak.Free;
  NAktiv:=0;
  NAktiv_point:=0;
end;

(********Редактировать точку**********)
procedure TEdit_Tak.N3Click(Sender: TObject);
var n:word;
begin
  Application.CreateForm(TOKBottomDlg7, OKBottomDlg7);
  if NAktiv<=COL_MAX_MICH_TAK then begin
    OKBottomDlg7.SpinEdit1.Value:=TaskRec_TAK.TarRec[NAktiv].Xtek[NAktiv_Point];
    OKBottomDlg7.SpinEdit2.Value:=TaskRec_TAK.TarRec[NAktiv].Ytek[NAktiv_Point];
    OKBottomDlg7.SpinEdit3.Value:=TaskRec_TAK.TarRec[NAktiv].Htek[NAktiv_Point];
    OKBottomDlg7.SpinEdit4.Value:= TaskRec_TAK.TarRec[NAktiv].Tstop[NAktiv_Point];
    if NAktiv_Point>0 then begin
      OKBottomDlg7.CheckBox1.Checked:=not TaskRec_TAK.TarRec[NAktiv].Visible[NAktiv_Point];
      OKBottomDlg7.SpinEdit5.Value:=TaskRec_TAK.TarRec[NAktiv].Skor[NAktiv_Point];
    end
    else begin
      // если нулевая точка то скорость  и видимость участка - заблокировать
      OKBottomDlg7.SpinEdit5.Visible:=false;
      OKBottomDlg7.Label5.Visible:=false;
      OKBottomDlg7.CheckBox1.Visible:=false;
    end;
    if OKBottomDlg7.ShowModal=mrOk then begin;
      if OKBottomDlg7.SpinEdit5.Value>0 then begin
        TaskRec_TAK.TarRec[NAktiv].Skor[NAktiv_Point]:=OKBottomDlg7.SpinEdit5.Value
      end
      else begin
      // Message
      end;
      TaskRec_TAK.TarRec[NAktiv].Xtek[NAktiv_Point]:=OKBottomDlg7.SpinEdit1.Value;
      TaskRec_TAK.TarRec[NAktiv].Ytek[NAktiv_Point]:=OKBottomDlg7.SpinEdit2.Value;
      TaskRec_TAK.TarRec[NAktiv].Htek[NAktiv_Point]:=OKBottomDlg7.SpinEdit3.Value;
      TaskRec_TAK.TarRec[NAktiv].Tstop[NAktiv_Point]:=OKBottomDlg7.SpinEdit4.Value;
      if NAktiv_Point=0 then TaskRec_TAK.TarRec[NAktiv].Tend:=TaskRec_TAK.TarRec[NAktiv].Tstop[0];
      if OKBottomDlg7.CheckBox1.Checked then TaskRec_TAK.TarRec[NAktiv].Visible[NAktiv_Point]:=false
                                        else TaskRec_TAK.TarRec[NAktiv].Visible[NAktiv_Point]:=true;
    end;
  end
  else begin
    OKBottomDlg7.SpinEdit1.Value:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Xtek[NAktiv_Point];
    OKBottomDlg7.SpinEdit2.Value:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Ytek[NAktiv_Point];
    OKBottomDlg7.SpinEdit3.Value:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Htek[NAktiv_Point];
    OKBottomDlg7.SpinEdit4.Value:= Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Tstop[NAktiv_Point];
    if NAktiv_Point>0 then begin
      OKBottomDlg7.CheckBox1.Checked:=not Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Visible[NAktiv_Point];
      OKBottomDlg7.SpinEdit5.Value:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Skor[NAktiv_Point];
    end
    else begin
      // если нулевая точка то скорость  и видимость участка - заблокировать
      OKBottomDlg7.SpinEdit5.Visible:=false;
      OKBottomDlg7.Label5.Visible:=false;
      OKBottomDlg7.CheckBox1.Visible:=false;
    end;
    if OKBottomDlg7.ShowModal=mrOk then begin;
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Skor[NAktiv_Point]:=OKBottomDlg7.SpinEdit5.Value;
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Xtek[NAktiv_Point]:=OKBottomDlg7.SpinEdit1.Value;
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Ytek[NAktiv_Point]:=OKBottomDlg7.SpinEdit2.Value;
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Htek[NAktiv_Point]:=OKBottomDlg7.SpinEdit3.Value;
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Tstop[NAktiv_Point]:=OKBottomDlg7.SpinEdit4.Value;
      if NAktiv_Point=0 then
         Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Tend:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Tstop[0];
      if OKBottomDlg7.CheckBox1.Checked
                   then Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Visible[NAktiv_Point]:=false
                   else Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Visible[NAktiv_Point]:=true;
    end;
  end;
  OKBottomDlg7.Free;
  NAktiv:=0;
  NAktiv_point:=0;
  RePaint_My;
end;

(********Удалить точку**********)
procedure TEdit_Tak.N4Click(Sender: TObject);
var a: integer;
begin
  if NAktiv_point=0 then exit;
  if NAktiv<=COL_MAX_MICH_TAK then begin
    for a:=NAktiv_point to TaskRec_TAK.TarRec[NAktiv].ColPoints-1 do begin
      TaskRec_TAK.TarRec[NAktiv].Xtek[a]:=TaskRec_TAK.TarRec[NAktiv].Xtek[a+1];
      TaskRec_TAK.TarRec[NAktiv].Ytek[a]:=TaskRec_TAK.TarRec[NAktiv].Ytek[a+1];
      TaskRec_TAK.TarRec[NAktiv].Htek[a]:=TaskRec_TAK.TarRec[NAktiv].Htek[a+1];
      TaskRec_TAK.TarRec[NAktiv].Skor[a]:=TaskRec_TAK.TarRec[NAktiv].Skor[a+1];
      TaskRec_TAK.TarRec[NAktiv].Tstop[a]:=TaskRec_TAK.TarRec[NAktiv].Tstop[a+1];
      TaskRec_TAK.TarRec[NAktiv].Visible[a]:=TaskRec_TAK.TarRec[NAktiv].Visible[a+1];
    end;
    dec(TaskRec_TAK.TarRec[NAktiv].ColPoints);
  end
  else begin
    for a:=NAktiv_point to Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].ColPoints-1 do begin
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Xtek[a]:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Xtek[a+1];
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Ytek[a]:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Ytek[a+1];
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Htek[a]:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Htek[a+1];
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Skor[a]:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Skor[a+1];
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Tstop[a]:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Tstop[a+1];
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Visible[a]:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Visible[a+1];
    end;
    dec(Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].ColPoints);
  end;
  NAktiv:=0;
  NAktiv_point:=0;
  RePaint_My;
end;

(********Добавить точку**********)
procedure TEdit_Tak.N5Click(Sender: TObject);
var a:integer;
begin
  if NAktiv<=COL_MAX_MICH_TAK then begin
    if TaskRec_TAK.TarRec[NAktiv].ColPoints<COL_MAX_POINTS_TAK then begin
      a:=TaskRec_TAK.TarRec[NAktiv].ColPoints+1;
      TaskRec_TAK.TarRec[NAktiv].Xtek[a]:=TaskRec_TAK.TarRec[NAktiv].Xtek[a-1];
      if TaskRec_TAK.TarRec[NAktiv].Ytek[a]>200 then
          TaskRec_TAK.TarRec[NAktiv].Ytek[a]:=TaskRec_TAK.TarRec[NAktiv].Ytek[a-1]-200
           else TaskRec_TAK.TarRec[NAktiv].Ytek[a]:=0;
      TaskRec_TAK.TarRec[NAktiv].Htek[a]:=TaskRec_TAK.TarRec[NAktiv].Htek[a-1];
      if a=1 then begin
        if TaskRec_TAK.TarRec[NAktiv].Num>5 then TaskRec_TAK.TarRec[NAktiv].Skor[a]:=15
                                            else TaskRec_TAK.TarRec[NAktiv].Skor[a]:=5;
      end
      else TaskRec_TAK.TarRec[NAktiv].Skor[a]:=TaskRec_TAK.TarRec[NAktiv].Skor[a-1];
      TaskRec_TAK.TarRec[NAktiv].Tstop[a]:=TaskRec_TAK.TarRec[NAktiv].Tstop[a-1];
      TaskRec_TAK.TarRec[NAktiv].Visible[a]:=true;
      inc(TaskRec_TAK.TarRec[NAktiv].ColPoints);
      RePaint_My;
    end
    else begin
      // Message
      MessageDlg('Количество точек больше максимального', mtInformation,[mbOk], 0);
    end;
  end
  else begin
    if Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].ColPoints<COL_MAX_POINTS_TAK_TEX then begin
      a:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].ColPoints+1;
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Xtek[a]:=
                 Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Xtek[a-1];
      if Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Ytek[a]>200 then
            Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Ytek[a]:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Ytek[a-1]-200
                    else Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Ytek[a]:=0;
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Htek[a]:=
                 Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Htek[a-1];
      if a=1 then begin
        if Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Num>5 then Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Skor[a]:=15
                                            else Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Skor[a]:=5;
      end
      else Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Skor[a]:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Skor[a-1];
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Tstop[a]:=Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Tstop[a-1];
      Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].Visible[a]:=true;
      inc(Target_Model_isx[NAktiv-COL_MAX_MICH_TAK].ColPoints);
      RePaint_My;
    end
  end;
  NAktiv:=0;
  NAktiv_point:=0;
end;

(************** Удаление мишени ************)
procedure TEdit_Tak.N2Click(Sender: TObject);
var a,b: integer;
begin
  if NAktiv<TaskRec_TAK.Col_targ then begin
    for a:=NAktiv to TaskRec_TAK.Col_targ-1 do begin
      TaskRec_TAK.TarRec[a].Num:=TaskRec_TAK.TarRec[a+1].Num;
      TaskRec_TAK.TarRec[a].Tst:=TaskRec_TAK.TarRec[a+1].Tst;
      TaskRec_TAK.TarRec[a].Tend:=TaskRec_TAK.TarRec[a+1].Tend;
      TaskRec_TAK.TarRec[a].ColPoints:=TaskRec_TAK.TarRec[a+1].ColPoints;
      Rects[a].Right:=Rects[a+1].Right;
      Rects[a].Bottom:=Rects[a+1].Bottom;
      for b:=0 to TaskRec_TAK.TarRec[a].ColPoints do begin
        TaskRec_TAK.TarRec[a].Xtek[b]:=TaskRec_TAK.TarRec[a+1].Xtek[b];
        TaskRec_TAK.TarRec[a].Ytek[b]:=TaskRec_TAK.TarRec[a+1].Ytek[b];
        TaskRec_TAK.TarRec[a].Htek[b]:=TaskRec_TAK.TarRec[a+1].Htek[b];
        TaskRec_TAK.TarRec[a].Skor[b]:=TaskRec_TAK.TarRec[a+1].Skor[b];
        TaskRec_TAK.TarRec[a].Tstop[b]:=TaskRec_TAK.TarRec[a+1].Tstop[b];
        TaskRec_TAK.TarRec[a].Visible[b]:=TaskRec_TAK.TarRec[a+1].Visible[b];
      end;
      for b:=1 to COL_MAX_TCHK_MICH do begin
        Mich[a][b].x:=Mich[a+1][b].x;
        Mich[a][b].y:=Mich[a+1][b].y;
      end;
    end;
    dec(TaskRec_TAK.Col_targ);
  end;
//        Target_Model_isx[NAktiv-COL_MAX_MICH_TAK]
  if NAktiv>COL_MAX_MICH_TAK then begin
    for a:=NAktiv-COL_MAX_MICH_TAK to Col_Model-1 do begin
      Target_Model_isx[a].Num:=Target_Model_isx[a+1].Num;
      Target_Model_isx[a].Tst:=Target_Model_isx[a+1].Tst;
      Target_Model_isx[a].Tend:=Target_Model_isx[a+1].Tend;
      Target_Model_isx[a].ColPoints:=Target_Model_isx[a+1].ColPoints;
      Rects[a].Right:=Rects[a+1].Right;
      Rects[a].Bottom:=Rects[a+1].Bottom;
      for b:=0 to Target_Model_isx[a].ColPoints do begin
        Target_Model_isx[a].Xtek[b]:=Target_Model_isx[a+1].Xtek[b];
        Target_Model_isx[a].Ytek[b]:=Target_Model_isx[a+1].Ytek[b];
        Target_Model_isx[a].Htek[b]:=Target_Model_isx[a+1].Htek[b];
        Target_Model_isx[a].Skor[b]:=Target_Model_isx[a+1].Skor[b];
        Target_Model_isx[a].Tstop[b]:=Target_Model_isx[a+1].Tstop[b];
        Target_Model_isx[a].Visible[b]:=Target_Model_isx[a+1].Visible[b];
      end;
      for b:=1 to COL_MAX_TCHK_MICH do begin
        Mich[a+COL_MAX_MICH_TAK][b].x:=Mich[a+COL_MAX_MICH_TAK+1][b].x;
        Mich[a+COL_MAX_MICH_TAK][b].y:=Mich[a+COL_MAX_MICH_TAK+1][b].y;
      end;
    end;
    dec(Col_Model);
  end;
  edit1.Text:=inttostr(Col_Model);
  NAktiv:=0;
  NAktiv_point:=0;
  RePaint_My;
end;

procedure TEdit_Tak.N8Click(Sender: TObject);
begin
  if Task.m_index <6000 then begin
    Application.CreateForm(TTar_Tak, Tar_Tak);
    Tar_Tak.SpinEdit1.Text:='0';
    if Tar_Tak.ShowModal=mrOk then begin;
        if Col_Model<COL_MAX_OBJEKT_TAK_TEX then begin
          inc(Col_Model);
          /// Номер мишени
          Target_Model_isx[Col_Model].Num:=Tar_Tak.Num_Tar_Tak;
          // Цвет маски
          Target_Model_isx[Col_Model].Color_Mask:=Tar_Tak.Color_Mask;
          /// Время первого показа
          Target_Model_isx[Col_Model].Tst:=StrToInt(Tar_Tak.SpinEdit1.Text);
          /// Время конца
          Target_Model_isx[Col_Model].Tstop[0]:=Target_Model_isx[Col_Model].Tst+MIN_T_MICH;
          // координаты
          Target_Model_isx[Col_Model].Xtek[0]:=x_mem*CMR_X div (MASHT_X*Mascht);
          Target_Model_isx[Col_Model].Ytek[0]:=Count_Y_ekr_m(y_mem);
          Target_Model_isx[Col_Model].ColPoints:=0;
          // Рисунок мишени
          LoadTarget(Target_Model_isx[Col_Model].Num,COL_MAX_MICH_TAK+Col_Model);
        end
        else begin
          MessageDlg('Количество мишеней больше максимального', mtInformation,[mbOk], 0);
      end;
      RePaint_My;
    end;
    Tar_Tak.Free;
  end;
  edit1.Text:=inttostr(Col_Model);
end;

procedure TEdit_Tak.N9Click(Sender: TObject);
begin
  Application.CreateForm(TOKBottomDlg7, OKBottomDlg7);
  OKBottomDlg7.SpinEdit1.visible:=false;
  OKBottomDlg7.SpinEdit2.visible:=false;
  OKBottomDlg7.SpinEdit3.visible:=false;
  OKBottomDlg7.SpinEdit4.Value:=TaskRec_TAK.Tstr;
  OKBottomDlg7.SpinEdit5.visible:=false;
  OKBottomDlg7.Label1.Visible:=false;
  OKBottomDlg7.Label2.Visible:=false;
  OKBottomDlg7.Label3.Visible:=false;
  OKBottomDlg7.Label5.Visible:=false;
  OKBottomDlg7.CheckBox1.Visible:=false;
  OKBottomDlg7.Caption:='Время выполнения упражнения';
  OKBottomDlg7.Label4.Caption:='Время выполнения,сек.';
  if OKBottomDlg7.ShowModal=mrOk then begin;
    if OKBottomDlg7.SpinEdit4.Value<1 then OKBottomDlg7.SpinEdit4.Value:=60;
    TaskRec_TAK.Tstr:=OKBottomDlg7.SpinEdit4.Value;
    Task.Tstr:=TaskRec_TAK.Tstr;
  end;
  OKBottomDlg7.Free;
  RePaint_My;

end;

procedure TEdit_Tak.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_ESCAPE then close;
end;

procedure TEdit_Tak.SpeedButton12Click(Sender: TObject);
begin
  Screen.Cursor:=crArrow;// Восстановление формы курсора
  Vvod_orient:=0;
end;


procedure TEdit_Tak.FormDestroy(Sender: TObject);
var a: integer;
begin
  Risunok[1][1].Free;
end;

procedure TEdit_Tak.Draw_Simvol(x,y,num: integer);
var a,b: integer;
begin
  for b:=0 to 15 do begin
    for a:=0 to 15 do begin
      if(SIMVOL[num][b] shl a)and $8000 >0 then Image3.Canvas.Pixels[x+a-8,y+b-12]:=$0;       // Чёрный
    end;
  end;
end;

procedure TEdit_Tak.Draw_Orientirs;
var a,x,y: integer;
begin
  for a:=1 to Orient.Col_orient do begin
    x:=Count_X_m_ekr(round(Orient.Xorient[a]-(stolbDX1+stolbLeft)/ DDD));
    y:=Count_Y_m_ekr(round(Orient.Yorient[a])-round(stolbBottom+STOLB_DY_R)div DDD);
    Draw_Simvol(x,y,Orient.Typ_orient[a]);
  end;
end;

procedure TEdit_Tak.SpeedButton1Click(Sender: TObject);
begin
  if Orient.Col_orient>MAX_COL_ORIENT-1 then begin
    Vvod_orient:=0;
    SpeedButton12.Down:=true; // Отпускание кнопки
    MessageDlg('Количество ориентиров больше максимального', mtInformation,[mbOk], 0);
    SpeedButton12.Down:=true; // Отпускание кнопки
    exit;
  end;
  Screen.Cursor:=crDrag;// Изменение формы курсора
  if Sender=SpeedButton1 then  Vvod_orient:=5;  //
  if Sender=SpeedButton3 then  Vvod_orient:=4; //
  if Sender=SpeedButton4 then  Vvod_orient:=3;  //
  if Sender=SpeedButton5 then  Vvod_orient:=7;  //
  if Sender=SpeedButton7 then  Vvod_orient:=10;  //
  if Sender=SpeedButton9 then  Vvod_orient:=11; //
  if Sender=SpeedButton11 then  Vvod_orient:=1; //
end;

// Удаление ориентира
procedure TEdit_Tak.N12Click(Sender: TObject);
var a: integer;
begin
  if (Move_orient<=Orient.Col_orient)and(Move_orient>0) then begin
    if Move_orient<Orient.Col_orient then for a:=Move_orient to Orient.Col_orient-1 do begin
      Orient.Typ_orient[a]:=Orient.Typ_orient[a+1];
      Orient.Xorient[a]:= Orient.Xorient[a+1];
      Orient.Yorient[a]:= Orient.Yorient[a+1];
      Orient.Horient[a]:= Orient.Horient[a+1];
    end;
    dec(Orient.Col_orient);
    Edit2.Text:=inttostr(Orient.Col_orient);
  end;
  Move_orient:=0;
  RePaint_My;
end;

procedure TEdit_Tak.Sort_List;
var a,b,n: integer;
y: real;
begin
  for a:=1 to Orient.Col_orient do begin
    Orient_Temp.Typ_orient[a]:=Orient.Typ_orient[a];
    Orient_Temp.Xorient[a]:=Orient.Xorient[a];
    Orient_Temp.Yorient[a]:=Orient.Yorient[a]
  end;
  for n:=1 to Orient.Col_orient do begin // Определение максимального числа
    y:=0;
    b:=0;
    for a:=1 to Orient.Col_orient do begin // Определение максимального числа
      if (Orient_Temp.Yorient[a]>y)and(Orient_Temp.Typ_orient[a]>0) then begin
        y:=Orient_Temp.Yorient[a];
        b:=a;
      end;
    end;
    Orient.Typ_orient[n]:=Orient_Temp.Typ_orient[b];
    Orient.Xorient[n]:=Orient_Temp.Xorient[b];
    Orient.Yorient[n]:=Orient_Temp.Yorient[b];
    Orient_Temp.Typ_orient[b]:=0;
  end;
end;

function TEdit_Tak.Count_dX(n: integer): integer;
begin
  result:=0;
  case n of
    1: result:=-round(stolbDX1/ DDD);
    2: result:=0;
    3: result:=round(stolbDX2/ DDD);
  end;
end;
procedure TEdit_Tak.FormActivate(Sender: TObject);
begin
  RePaint_My;
end;

procedure TEdit_Tak.Button2Click(Sender: TObject);
begin
  TaskRec_TAK.Tstr:=SpinEdit4.Value;
  Save_Task;
end;

procedure TEdit_Tak.Button3Click(Sender: TObject);
begin
  inform:=not inform;
  RePaint_My;
end;

procedure TEdit_Tak.Button4Click(Sender: TObject);
begin
  if  mrOk=MessageDlg('Очистить задачу?', mtInformation,[mbOk,mbCancel], 0) then begin
    TaskRec_TAK.Col_targ:=0;
    Orient.Col_orient:=0;
    Col_Model:=0;
    RePaint_My;
    edit1.Text:=inttostr(Col_Model);
  end;
  Save_Task;
end;

procedure TEdit_Tak.SpeedButton14Click(Sender: TObject);
begin
  if Task.m_index <6000 then begin
    Application.CreateForm(TTar_Tak, Tar_Tak);
    Tar_Tak.SpinEdit1.Text:='0';
    if Tar_Tak.ShowModal=mrOk then begin;
        if Col_Model<COL_MAX_OBJEKT_TAK_TEX then begin
          inc(Col_Model);
          /// Номер мишени
          Target_Model_isx[Col_Model].Num:=Tar_Tak.Num_Tar_Tak;
          // Цвет маски
          Target_Model_isx[Col_Model].Color_Mask:=Tar_Tak.Color_Mask;
          /// Время первого показа
          Target_Model_isx[Col_Model].Tst:=StrToInt(Tar_Tak.SpinEdit1.Text);
          /// Время конца
          Target_Model_isx[Col_Model].Tstop[0]:=Target_Model_isx[Col_Model].Tst+MIN_T_MICH;
          // координаты
          Target_Model_isx[Col_Model].Xtek[0]:=330;
          Target_Model_isx[Col_Model].Ytek[0]:=1800;
          Target_Model_isx[Col_Model].ColPoints:=0;
          // Рисунок мишени
          LoadTarget(Target_Model_isx[Col_Model].Num,COL_MAX_MICH_TAK+Col_Model);
        end
        else begin
          MessageDlg('Количество мишеней больше максимального', mtInformation,[mbOk], 0);
        end;
      RePaint_My;
    end;
    Tar_Tak.Free;
  end;
  edit1.Text:=inttostr(Col_Model);
end;

procedure TEdit_Tak.ComboBox1Change(Sender: TObject);
begin
  Aktivnost:=ComboBox1.ItemIndex;
end;

end.

