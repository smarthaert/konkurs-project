
unit UnEdit; // Редактор наземной и воздушной обстановки
            // Координаты мишеней относительно середины начала дорожек
            // Координаты ориентиров относительно левого ближнего края поверхности
interface

uses Windows, SysUtils, Classes, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Main, Menus, Graphics, Dialogs,UnOther,UnBuildSetka, Spin;

type
  PTask=^TTask;
  POrient=^TOrient;            // Описано в Form1

  TOKBottomDlg4 = class(TForm)
    BitBtn4: TBitBtn;
    Image1: TImage;
    Image2: TImage;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    Image3: TImage;
    Edit2: TEdit;
    BitBtn6: TBitBtn;
    PopupMenu3: TPopupMenu;
    N12: TMenuItem;
    Panel1: TPanel;
    SpeedButton12: TSpeedButton;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton11: TSpeedButton;
    Label2: TLabel;
    Edit1: TEdit;
    SpeedButton14: TSpeedButton;
    Label3: TLabel;
    BitBtn3: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label4: TLabel;
    SpinEdit4: TSpinEdit;
    Label5: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Scale_top;
    procedure Scale_left;
    procedure RePaint_My;
    procedure Ris_task;
    procedure Init;
    procedure LoadTarget(Num,Np: integer);
    procedure Ris_target(a,x,y,n: integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
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
    function Count_dX(n: integer): integer;
    procedure InformTarg(a,x,y,n,b: integer);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure RisPoint(x,y: integer; col: TColor);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure Draw_Simvol(x,y, num: integer);
    procedure Draw_Orientirs;
    procedure BitBtn6Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure Image_Draw;
    procedure Sort_List;
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    x_delta: integer;// Смещение поля по Х в метрах
    y_delta: integer;// Смещение поля по Y в метрах
    x_mem, y_mem: integer; //
    xc, yc: integer;
    xtek, ytek, xpolig_max, ypolig_max, masht_y: integer;
    x_ris_tek, y_ris_tek: integer;
    mov,mov_targ: boolean;
  public
    Edit_Task: PTask;
    Orient: POrient;            // Описано в Form1
    Orient_Temp: TOrient;
  end;
const
  MASHT_X=3;
  MASHT_Y_1=1;
  MASHT_Y_2=2;
  RIS_X=45;        // Cмещение рисунка с дорогами по X вправо
  RIS_Y=173;        // Cмещение рисунка с дорогами по Y вниз
  RIS_Y2=23;        // Cмещение рисунка с дорогами по Y вниз
  CMR_X=10;         // Цена младшего разряда шкалы
  CMR_Y=50;
  DY_NEW_POINT=200;  // Смещение новой точки
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
  OKBottomDlg4: TOKBottomDlg4;
  Mich: array[0..COL_MAX_MICH,1..COL_MAX_TCHK_MICH] of TPoint;// Координаты 10 мишений
                                                         //на 30 точек
  col_tch_targ: array[0..COL_MAX_MICH] of integer;   //кол-во точек
  Rects: array[1..COL_MAX_MICH] of TRect;     // Описывающий мишень пр-к
  RectsRis: array[1..3,1..COL_MAX_MICH] of TRect;  // Перемещаемый пр-к
  Kmich: integer;         // Коэфф. пересчёта размера мишени
  NAktiv,NAktiv_point,NAktiv_bmp, NAktiv_bmp_alt: integer;     // N выбранной мишени
  RectWhite: TRect;    //Белое поле
  Risunok: array[1..3,1..3] of  TBitmap;
  mode_otobr: boolean;
  Vvod_orient,Move_orient: word;
  Mascht: word;
implementation

uses UnEkip, UnBoepr, UnTarget, UnPoint, UnTask;

{$R *.DFM}

procedure TOKBottomDlg4.FormCreate(Sender: TObject);
var a:word;
begin
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
  if ((Task.m_index>1400)and(Task.m_index<1500)) or
     (Task.m_index<1300)  then masht_y:=MASHT_Y_2 else masht_y:=MASHT_Y_1;
  RectWhite.Left:=0; // Поле, где находятся мишени
  RectWhite.Right:=Image3.Width;
  RectWhite.Top:=0;
  RectWhite.Bottom:=Image3.Height;
  if Task.m_index <5000 then begin
    // Стрельба
   for a:=1 to 3 do begin
      Risunok[a][1]:=TBitmap.Create;
      Risunok[a][1].LoadFromFile(DirBase+'bmp\edit\Pole_be'+inttostr(a)+'.BMP');
      Risunok[a][2]:=TBitmap.Create;
      Risunok[a][2].LoadFromFile(DirBase+'bmp\edit\Pole_en'+inttostr(a)+'.BMP');
      Risunok[a][3]:=TBitmap.Create;
      Risunok[a][3].LoadFromFile(DirBase+'bmp\edit\Okop'+inttostr(a)+'.BMP');
    end;
//  if Task.Mestn=RAVNINA then BitBtn6.Enabled:=false else BitBtn6.Enabled:=true;
    if Task.m_index>2000 then BitBtn4.Enabled:=false else BitBtn4.Enabled:=true;
  end
  else begin  // Тактика
    if Task.m_index <6000 then begin
      Risunok[1][1]:=TBitmap.Create;
      Risunok[1][1].LoadFromFile(DirBase+'bmp\edit\Kleto3s.BMP');
      BitBtn6.Enabled:=false;
    end;
  end;
  Mascht:=8;
end;

procedure TOKBottomDlg4.Init;
var a,n: integer;
begin
  for n:=1 to 3 do  for a:=1 to Edit_Task.Col_targ do begin             //Загрузка мишенней
    LoadTarget(Edit_Task.Target[n][a].Num,a);
  end;
  edit1.Text:=inttostr(Edit_Task.Col_targ);
  edit2.Text:=inttostr(Orient.Col_orient);
  SpinEdit4.Value:=Edit_Task.Tstr;
end;

procedure TOKBottomDlg4.RePaint_My;
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

procedure TOKBottomDlg4.Image_Draw;
var a: integer;
d: integer;
begin
  if Task.m_index <5000 then begin
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
  end
  else Image3.Canvas.Draw(0,0,Risunok[1][1]);

end;

// Рисование верхней шкалы
procedure TOKBottomDlg4.Scale_top;
var x, y, xmin, ymin, xmax, ymax, xst: integer;
begin
  xmin:=Image1.Left+2;
  xmax:=Image1.Left+Image1.Width-2;
  ymin:=Image1.Top+2;
  ymax:=Image1.Top+Image1.Height;      // Размеры шкалы по размерам Bevel
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
procedure TOKBottomDlg4.Scale_left;
var x, y, xmin, ymin, xmax, ymax, yst: integer;
begin
  xmin:=Image2.Left+2;
  xmax:=Image2.Left+Image2.Width-2;
  ymin:=Image2.Top+2;
  ymax:=Image2.Top+Image2.Height-2;
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
end;

// Щелчок по верхней шкале
procedure TOKBottomDlg4.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  x_mem:=x;
  xtek:=x_delta;
  y_mem:=y;
  mov:=true;
end;

// Перемещение по верхней шкале
procedure TOKBottomDlg4.Image1MouseMove(Sender: TObject;
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
procedure TOKBottomDlg4.Image1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mov:=false;
  RePaint_My;
end;

// Щелчок по нижней шкале
procedure TOKBottomDlg4.Image2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  y_mem:=y;
  ytek:=y_delta;
  mov:=true;
end;

// Перемещение по нижней шкале
procedure TOKBottomDlg4.Image2MouseMove(Sender: TObject;
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
procedure TOKBottomDlg4.Image2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mov:=false;
  RePaint_My;
end;


// Перевод положения объектов в метрах в экранные координаты
function TOKBottomDlg4.Count_X_m_ekr(x: integer): integer;
var a: real;
begin
// -200  т.к. начало отсчёта по х находится по координате=0, а при
// визуализации по левому краю .
  a:=x*MASHT_X*Mascht;
  result:=round(xc+a/CMR_X);
end;

// Перевод положения объектов в метрах в экранные координаты
function TOKBottomDlg4.Count_Y_m_ekr(y: integer): integer;
var a: real;
begin
  a:=y*(masht_y*Mascht);
  result:=round(yc-a/CMR_Y);
end;

function TOKBottomDlg4.Count_X_ekr_m(x: integer): integer;
begin
  result:=(X-xc)*CMR_X div (MASHT_X*Mascht);
end;

// Перевод положения объектов в метрах в экранные координаты
function TOKBottomDlg4.Count_Y_ekr_m(y: integer): integer;
begin
  result:=(yc-y)*CMR_Y div (masht_y*Mascht);
end;

procedure TOKBottomDlg4.Ris_task;
var a,b,n,x,y: integer;
begin
  for n:=1 to 3 do begin
    for a:=1 to Edit_Task.Col_targ do begin
      if (Task.m_index>1300)and(Task.m_index<1400)// Требуется выставить одну мишень
          then x:=Count_X_m_ekr(Edit_Task.Target[n][a].Xtek[0])
          else x:=Count_X_m_ekr(Edit_Task.Target[n][a].Xtek[0]+Count_dX(n));
      y:=Count_Y_m_ekr(Edit_Task.Target[n][a].Ytek[0]);
      //Рисование контура мишени
        Ris_target(a,x,y,n);
        //Рисование линии
        InformTarg(a,x,y,n,0);
        if Edit_Task.Target[n][a].ColPoints>0 then begin
          Image3.Canvas.MoveTo(x,y);
          for b:= 1 to Edit_Task.Target[n][a].ColPoints do begin
            x:=Count_X_m_ekr(Edit_Task.Target[n][a].Xtek[b]+Count_dX(n));
            y:=Count_Y_m_ekr(Edit_Task.Target[n][a].Ytek[b]);
            Image3.Canvas.LineTo(x,y);
            InformTarg(a,x,y,n,b);
            Image3.Canvas.MoveTo(x,y);
          end;
        end;
    end;// a:=1
  end; //n:=1
end;

procedure TOKBottomDlg4.InformTarg(a,x,y,n,b: integer);//мишень, x,y, N БТР, N точки
var
dr,tr,xr,yr,vr: real;
s: string;
//a: TFontStyles;
begin
    RisPoint(x,y, clBlack);
    s:=Inttostr(Edit_Task.Target[N][a].Ytek[b]);
    Image3.Canvas.TextOut(x+5,y+5,s);
    Image3.Canvas.MoveTo(x+5,y+17);
    Image3.Canvas.LineTo(x+30,y+17);
    // Расчёт времени
    if b=0 then begin
      Edit_Task.Target[N][a].Tend:=Edit_Task.Target[N][a].Tst+Edit_Task.Target[N][a].Tstop[0];
      s:=Inttostr(Edit_Task.Target[N][a].Tst)+'-'
                    +Inttostr(Edit_Task.Target[N][a].Tend);
    end
    else begin
      xr:=Edit_Task.Target[N][a].Xtek[b]-Edit_Task.Target[N][a].Xtek[b-1];
      yr:=Edit_Task.Target[N][a].Ytek[b]-Edit_Task.Target[N][a].Ytek[b-1];
      dr:=sqrt(xr*xr+yr*yr);       // Расстояние от точки до точки
      vr:=Edit_Task.Target[N][a].Skor[b];
      vr:=vr*10/36;                //Перевод км/час в м/с
      tr:=dr/vr;                   // Время на участке
      // Время прихода в точку
      Edit_Task.Target[N][a].Tend:=Edit_Task.Target[N][a].Tend+round(tr);
      s:=Inttostr(Edit_Task.Target[N][a].Tend);
      if Edit_Task.Target[N][a].Tstop[b]>0 then begin
        Edit_Task.Target[N][a].Tend:=Edit_Task.Target[N][a].Tend+Edit_Task.Target[N][a].Tstop[b];
        s:=s+'-'+Inttostr(Edit_Task.Target[N][a].Tend);
      end;
    end;
    Image3.Canvas.TextOut(x+5,y+19,s);
end;

procedure TOKBottomDlg4.RisPoint(x,y: integer; col: TColor);
begin
    Image3.Canvas.Pen.Color:=col;
    Image3.Canvas.MoveTo(x-1,y-1);
    Image3.Canvas.LineTo(x-1,y+1);
    Image3.Canvas.LineTo(x+1,y+1);
    Image3.Canvas.LineTo(x+1,y-1);
    Image3.Canvas.LineTo(x-2,y-2);
    Image3.Canvas.LineTo(x-2,y+2);
    Image3.Canvas.LineTo(x+2,y+2);
    Image3.Canvas.LineTo(x+2,y-2);
    Image3.Canvas.LineTo(x-2,y-2);
    Image3.Canvas.Pen.Color:=clBlack;
end;


(******** Рисование мишени *******)
procedure TOKBottomDlg4.Ris_target(a,x,y,n: integer);
var c: integer;
b: real;
begin
    x:=x-Rects[a].Right div 2; //Вычисление текущих координат
    y:=y-Rects[a].Bottom-2; // c учётом размеров мишени
    RectsRis[n][a].Left:=x;          //Координаты перемещаемого
    RectsRis[n][a].Right:=x+Rects[a].Right+2; // описывающего прямоугольника
    RectsRis[n][a].Top:=y;
    RectsRis[n][a].Bottom:=y+Rects[a].Bottom+2;

    b:=Mich[a][1].x;
    Mich[0][1].x:=x+round(b/Kmich);
    b:=Mich[a][1].y;
    Mich[0][1].y:=y+round(b/Kmich);
    for c:=2 to col_tch_targ[a]{COL_MAX_TCHK_MICH} do begin
      b:=Mich[a][c].x;
      Mich[0][c].x:=Mich[0][c-1].x+round(b/Kmich);
      b:=Mich[a][c].y;
      Mich[0][c].y:=Mich[0][c-1].y+round(b/Kmich);
    end;
    for c:=col_tch_targ[a]+1 to COL_MAX_TCHK_MICH do begin
      Mich[0][c].x:=Mich[0][c-1].x;
      Mich[0][c].y:=Mich[0][c-1].y;
    end;
    case n of
    1: Image3.Canvas.Brush.Color:=$0;
    2: Image3.Canvas.Brush.Color:=$999999;
    3: Image3.Canvas.Brush.Color:=$f0f0f0;
    end;
    Image3.Canvas.Polygon(Mich[0]);
    Image3.Canvas.Brush.Color:=clWhite;
end;

(*********Загрузка рисунка мишени*********)
procedure TOKBottomDlg4.LoadTarget(Num,Np: integer);
var  F: TextFile;
     S: String;
     a: integer;
     c: real;
begin
  S:=dirBase+'res\Target\Targ_'+Name_Target(Num)+'.txt';
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
procedure TOKBottomDlg4.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var a,b,n,n1,Xp,Yp: integer;
begin
  if Vvod_orient>0 then exit;
  x_mem:=x;
  y_mem:=y;
  PopupMenu:=nil;
  for a:=1 to Orient.Col_orient do begin
    xp:=Count_X_m_ekr(round(Orient.Xorient[a]-(stolbDX1+stolbLeft)/ DDD));
    yp:=Count_Y_m_ekr(round(Orient.Yorient[a])-round((stolbBottom+STOLB_DY_R))div DDD);
    if (X>Xp-8)and(Y>Yp-8)and(X<Xp+8)and(Y<Yp+8)then begin
      Move_orient:=a;
      Screen.Cursor:=crDrag;   // Изменение формы курсора
      PopupMenu:=PopupMenu3;
      exit;
    end;
  end;
  for n:=1 to 3 do begin
    for a:=1 to Edit_Task.Col_targ do begin //Выбор мишени
      if (X>RectsRis[n][a].Left)and(Y>RectsRis[n][a].Top)and
           (X<RectsRis[n][a].Right)and(Y<RectsRis[n][a].Bottom)then begin
        if (HiWord(GetKeyState(VK_CONTROL))=0) or (Task.Mestn=RAVNINA) then begin
            for n1:=1 to 3 do begin
            NAktiv_bmp:=0;//Ctrl не нажат
            RectLine(RectsRis[n1][a]);   //Рисуем прям-к вокруг мишени
          end;
        end
        else begin
          NAktiv_bmp:=n;
          RectLine(RectsRis[n][a]);   //Рисуем прям-к вокруг мишени
        end;
        mov_targ:=true;
        NAktiv:=a;               // Запоминаем номер выбранной мишени
        NAktiv_Point:=0;
        PopupMenu:=PopupMenu1;
        exit;
      end
      else begin
        for b:=1 to Edit_Task.Target[n][a].ColPoints do begin
          Xp:=Count_X_m_ekr(Edit_Task.Target[n][a].Xtek[b]+Count_dX(n));
          Yp:=Count_Y_m_ekr(Edit_Task.Target[n][a].Ytek[b]);
          if (X>Xp-5)and(Y>Yp-5)and(X<Xp+5)and(Y<Yp+5)then begin
             mov_targ:=true;
             NAktiv:=a;               // Запоминаем номер выбранной мишени
             if (HiWord(GetKeyState(VK_CONTROL))=0) or (Task.Mestn=RAVNINA) then begin
               NAktiv_bmp:=0;
               NAktiv_bmp_alt:=n;
             end
             else NAktiv_bmp:=n;
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
  end;
//  PopupMenu:=PopupMenu2;
end;

(********Перемещение прямоугольника по мишенному полю********)
procedure TOKBottomDlg4.FormMouseMove(Sender: TObject; Shift: TShiftState;
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
      if NAktiv_BMP>0 then begin
        RectLine(RectsRis[NAktiv_bmp][NAktiv]); // Стираем старый прям-к
        RectsRis[NAktiv_bmp][NAktiv].Left:=RectsRis[NAktiv_bmp][NAktiv].Left-dX;
        RectsRis[NAktiv_bmp][NAktiv].Right:=RectsRis[NAktiv_bmp][NAktiv].Right-dX;
        RectsRis[NAktiv_bmp][NAktiv].Top:=RectsRis[NAktiv_bmp][NAktiv].Top-dY;
        RectsRis[NAktiv_bmp][NAktiv].Bottom:=RectsRis[NAktiv_bmp][NAktiv].Bottom-dY;
        RectLine(RectsRis[NAktiv_bmp][NAktiv]);  // Рисуем новый прям-к
      end
      else begin
        for n:=1 to 3 do begin
          RectLine(RectsRis[N][NAktiv]); // Стираем старый прям-к
          RectsRis[N][NAktiv].Left:=RectsRis[N][NAktiv].Left-dX;
          RectsRis[N][NAktiv].Right:=RectsRis[N][NAktiv].Right-dX;
          RectsRis[N][NAktiv].Top:=RectsRis[N][NAktiv].Top-dY;
          RectsRis[N][NAktiv].Bottom:=RectsRis[N][NAktiv].Bottom-dY;
          RectLine(RectsRis[N][NAktiv]);  // Рисуем новый прям-к
        end;
      end;
    end
    else begin
      RisPoint(Xtek+x_mem,Ytek+y_mem,clWhite);
      Xtek:=X;
      Ytek:=y;
      RisPoint(Xtek+x_mem,Ytek+y_mem,clBlack);
    end;
  end;
end;

(*******Рисование перемещаемого прям-ка*****)
procedure TOKBottomDlg4.RectLine(Rects: TRect);
begin
  Image3.Canvas.Pen.Mode:=pmNotXor;
  Image3.Canvas.MoveTo(Rects.Left,Rects.Top);
  Image3.Canvas.LineTo(Rects.Right,Rects.Top);
  Image3.Canvas.LineTo(Rects.Right,Rects.Bottom);
  Image3.Canvas.LineTo(Rects.Left,Rects.Bottom);
  Image3.Canvas.LineTo(Rects.Left,Rects.Top);
  Image3.Canvas.Pen.Mode:=pmCopy;
end;

(***Отпускание левой клавиши/ Фикскация положения мишени***************)
procedure TOKBottomDlg4.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var d,n: integer;
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
    Orient.Xorient[Orient.Col_orient]:=Count_X_ekr_m(X)+(round(stolbDX1)+round(stolbLeft))div DDD;
    Orient.Yorient[Orient.Col_orient]:=Count_Y_ekr_m(Y)+round((stolbBottom+STOLB_DY_R))div DDD;
    if Orient.Yorient[Orient.Col_orient]<MIN_DALN_ORIENT then Orient.Yorient[Orient.Col_orient]:=MIN_DALN_ORIENT;
    Vvod_orient:=0;
    SpeedButton12.Down:=true; // Отпускание кнопки
    RePaint_My;
    Screen.Cursor:=crArrow;   // Восстановление формы курсора
    Sort_List;
    exit;
  end;
  if (NAktiv>0) and mov_targ then begin
    if NAktiv_Point=0 then begin
      // Если выделена мишень
      if NAktiv_bmp>0 then begin
        // Определяем центр мишени
        d:=(RectsRis[NAktiv_bmp][NAktiv].Right-RectsRis[NAktiv_bmp][NAktiv].Left) div 2-2;
        // Пересчитываем новые координаты мишени
        Edit_Task.Target[NAktiv_bmp][NAktiv].Xtek[0]:=
                      Count_X_ekr_m(RectsRis[NAktiv_bmp][NAktiv].Left+d)-Count_dX(NAktiv_bmp);
        d:=(RectsRis[NAktiv_bmp][NAktiv].Bottom-RectsRis[NAktiv_bmp][NAktiv].Top);
        Edit_Task.Target[NAktiv_bmp][NAktiv].Ytek[0]:=Count_Y_ekr_m(RectsRis[NAktiv_bmp][NAktiv].Top+d);
      end
      else begin
        for n:=1 to 3 do begin
          // Определяем центр мишени
          d:=(RectsRis[N][NAktiv].Right-RectsRis[N][NAktiv].Left) div 2-2;
          // Пересчитываем новые координаты мишени
          Edit_Task.Target[N][NAktiv].Xtek[0]:=Count_X_ekr_m(RectsRis[N][NAktiv].Left+d)-Count_dX(n);
          d:=(RectsRis[N][NAktiv].Bottom-RectsRis[N][NAktiv].Top);
          Edit_Task.Target[N][NAktiv].Ytek[0]:=Count_Y_ekr_m(RectsRis[N][NAktiv].Top+d);
        end;
        if Task.mestn=RAVNINA then BitBtn6Click(Sender);
      end;
    end
    else begin
      // Если выделена точка
      if NAktiv_bmp>0 then begin
        Edit_Task.Target[NAktiv_bmp][NAktiv].Xtek[NAktiv_point]:=
                        Count_X_ekr_m(X+x_mem)-Count_dX(NAktiv_bmp);
        Edit_Task.Target[NAktiv_bmp][NAktiv].Ytek[NAktiv_point]:=Count_Y_ekr_m(Y+y_mem);
      end
      else begin
        for n:=1 to 3 do begin
          Edit_Task.Target[N][NAktiv].Xtek[NAktiv_point]:=
                        Count_X_ekr_m(X+x_mem)-Count_dX(NAktiv_bmp_alt);
          Edit_Task.Target[N][NAktiv].Ytek[NAktiv_point]:=Count_Y_ekr_m(Y+y_mem);
        end;
      end;
    end;
    // Обнуляем выбор мишени
    mov_targ:=false;
    if Button=mbLeft then begin
      NAktiv:=0;
      NAktiv_bmp:=0;
      NAktiv_point:=0;
      NAktiv_bmp_alt:=0
    end;
    // Перерисовываем мишенное поле
    RePaint_My;
  end;
  Screen.Cursor:=crArrow;   // Восстановление формы курсора
end;

(**************Ввод боеприпасов*************)
procedure TOKBottomDlg4.BitBtn3Click(Sender: TObject);
begin
  Application.CreateForm(TOKBottomDlg5, OKBottomDlg5);
  OKBottomDlg5.SpinEdit4.Value:=Edit_Task.Bk.Col_Upr;  // Упр
  if OKBottomDlg5.ShowModal=mrOk then begin;
    Edit_Task.Bk.Col_Upr:=OKBottomDlg5.SpinEdit4.Value;  // Упр
  end;
  OKBottomDlg5.Free;
end;

(***********Восстановление старой задачи************)
procedure TOKBottomDlg4.BitBtn4Click(Sender: TObject);
begin
  Load_Task(true);
  Init;
  RePaint_My;
end;

procedure TOKBottomDlg4.N1Click(Sender: TObject);
var n: word;
begin
  Application.CreateForm(TOKBottomDlg6, OKBottomDlg6);
  if (Edit_Task.Target[1][NAktiv].Num-1)<9 then Edit_Task.Target[1][NAktiv].Num:=9;
  OKBottomDlg6.ComboBox1.ItemIndex:=Edit_Task.Target[1][NAktiv].Num-10;
  OKBottomDlg6.SpinEdit1.Text:=IntToStr(Edit_Task.Target[1][NAktiv].Tst);
  OKBottomDlg6.Color_Mask:=Edit_Task.Target[1][NAktiv].Color_Mask;
  if OKBottomDlg6.ShowModal=mrOk then begin;
    for n:=1 to 3 do begin
      Edit_Task.Target[N][NAktiv].Num:=OKBottomDlg6.ComboBox1.ItemIndex+10;
      Edit_Task.Target[N][NAktiv].Tst:=StrToInt(OKBottomDlg6.SpinEdit1.Text);
      Edit_Task.Target[N][NAktiv].Color_Mask:=OKBottomDlg6.Color_Mask;
    end;
    LoadTarget(Edit_Task.Target[1][NAktiv].Num,NAktiv);
    RePaint_My;
  end;
  OKBottomDlg6.Free;
  NAktiv:=0;
  NAktiv_bmp:=0;
  NAktiv_point:=0;
  NAktiv_bmp_alt:=0
end;

(********Редактировать точку**********)
procedure TOKBottomDlg4.N3Click(Sender: TObject);
var n:word;
begin
  Application.CreateForm(TOKBottomDlg7, OKBottomDlg7);
  if NAktiv_bmp>0 then begin
    OKBottomDlg7.SpinEdit1.Value:=Edit_Task.Target[NAktiv_bmp][NAktiv].Xtek[NAktiv_Point];
    OKBottomDlg7.SpinEdit2.Value:=Edit_Task.Target[NAktiv_bmp][NAktiv].Ytek[NAktiv_Point];
    OKBottomDlg7.SpinEdit3.Value:=Edit_Task.Target[NAktiv_bmp][NAktiv].Htek[NAktiv_Point];
  end
  else begin
    OKBottomDlg7.SpinEdit1.Value:=Edit_Task.Target[1][NAktiv].Xtek[NAktiv_Point];
    OKBottomDlg7.SpinEdit2.Value:=Edit_Task.Target[1][NAktiv].Ytek[NAktiv_Point];
    OKBottomDlg7.SpinEdit3.Value:=Edit_Task.Target[1][NAktiv].Htek[NAktiv_Point];
  end;
  OKBottomDlg7.SpinEdit4.Value:= Edit_Task.Target[1][NAktiv].Tstop[NAktiv_Point];
  if NAktiv_Point>0 then begin
    OKBottomDlg7.CheckBox1.Checked:=not Edit_Task.Target[1][NAktiv].Visible[NAktiv_Point];
    OKBottomDlg7.SpinEdit5.Value:=Edit_Task.Target[1][NAktiv].Skor[NAktiv_Point];
  end
  else begin
     // если нулевая точка то скорость  и видимость участка - заблокировать
    OKBottomDlg7.SpinEdit5.Visible:=false;
    OKBottomDlg7.Label5.Visible:=false;
    OKBottomDlg7.CheckBox1.Visible:=false;
  end;
  if OKBottomDlg7.ShowModal=mrOk then begin;
    for n:=1 to 3 do begin
      if OKBottomDlg7.SpinEdit5.Value>0 then begin
        Edit_Task.Target[N][NAktiv].Skor[NAktiv_Point]:=OKBottomDlg7.SpinEdit5.Value
      end
      else begin
      // Message
      end;
      if NAktiv_bmp>0 then begin
        Edit_Task.Target[NAktiv_bmp][NAktiv].Xtek[NAktiv_Point]:=OKBottomDlg7.SpinEdit1.Value;
        Edit_Task.Target[NAktiv_bmp][NAktiv].Ytek[NAktiv_Point]:=OKBottomDlg7.SpinEdit2.Value;
        Edit_Task.Target[NAktiv_bmp][NAktiv].Htek[NAktiv_Point]:=OKBottomDlg7.SpinEdit3.Value;
      end
      else begin
        Edit_Task.Target[N][NAktiv].Xtek[NAktiv_Point]:=OKBottomDlg7.SpinEdit1.Value;
        Edit_Task.Target[N][NAktiv].Ytek[NAktiv_Point]:=OKBottomDlg7.SpinEdit2.Value;
        Edit_Task.Target[N][NAktiv].Htek[NAktiv_Point]:=OKBottomDlg7.SpinEdit3.Value;
      end;
      Edit_Task.Target[N][NAktiv].Tstop[NAktiv_Point]:=OKBottomDlg7.SpinEdit4.Value;
      if NAktiv_Point=0 then Edit_Task.Target[N][NAktiv].Tend:=Edit_Task.Target[N][NAktiv].Tstop[0];
      if OKBottomDlg7.CheckBox1.Checked then Edit_Task.Target[N][NAktiv].Visible[NAktiv_Point]:=false
                                        else Edit_Task.Target[N][NAktiv].Visible[NAktiv_Point]:=true;
    end;
  end;
  OKBottomDlg7.Free;
  NAktiv:=0;
  NAktiv_bmp:=0;
  NAktiv_point:=0;
  NAktiv_bmp_alt:=0;
  RePaint_My;
end;

(********Удалить точку**********)
procedure TOKBottomDlg4.N4Click(Sender: TObject);
var a,N: integer;
begin
  if NAktiv_point=0 then exit;
  for n:=1 to 3 do begin
    for a:=NAktiv_point to Edit_Task.Target[N][NAktiv].ColPoints-1 do begin
      Edit_Task.Target[N][NAktiv].Xtek[a]:=Edit_Task.Target[N][NAktiv].Xtek[a+1];
      Edit_Task.Target[N][NAktiv].Ytek[a]:=Edit_Task.Target[N][NAktiv].Ytek[a+1];
      Edit_Task.Target[N][NAktiv].Htek[a]:=Edit_Task.Target[N][NAktiv].Htek[a+1];
      Edit_Task.Target[N][NAktiv].Skor[a]:=Edit_Task.Target[N][NAktiv].Skor[a+1];
      Edit_Task.Target[N][NAktiv].Tstop[a]:=Edit_Task.Target[N][NAktiv].Tstop[a+1];
      Edit_Task.Target[N][NAktiv].Visible[a]:=Edit_Task.Target[N][NAktiv].Visible[a+1];
    end;
    dec(Edit_Task.Target[N][NAktiv].ColPoints);
  end;
  NAktiv:=0;
  NAktiv_bmp:=0;
  NAktiv_point:=0;
  NAktiv_bmp_alt:=0;
  RePaint_My;
end;

(********Добавить точку**********)
procedure TOKBottomDlg4.N5Click(Sender: TObject);
var a,n: integer;
begin
  for n:=1 to 3 do begin
    if Edit_Task.Target[N][NAktiv].ColPoints<COL_MAX_POINTS then begin
      a:=Edit_Task.Target[N][NAktiv].ColPoints+1;
      Edit_Task.Target[N][NAktiv].Xtek[a]:=Edit_Task.Target[N][NAktiv].Xtek[a-1];
      Edit_Task.Target[N][NAktiv].Ytek[a]:=Edit_Task.Target[N][NAktiv].Ytek[a-1]-200;
      Edit_Task.Target[N][NAktiv].Htek[a]:=Edit_Task.Target[N][NAktiv].Htek[a-1];
      if a=1 then begin
        if Edit_Task.Target[N][NAktiv].Num>5 then Edit_Task.Target[N][NAktiv].Skor[a]:=15
                                        else Edit_Task.Target[N][NAktiv].Skor[a]:=5;
//        Edit_Task.Target[N][NAktiv].Mov:=true;
      end
      else Edit_Task.Target[N][NAktiv].Skor[a]:=Edit_Task.Target[N][NAktiv].Skor[a-1];
      Edit_Task.Target[N][NAktiv].Tstop[a]:=Edit_Task.Target[N][NAktiv].Tstop[a-1];
      Edit_Task.Target[N][NAktiv].Visible[a]:=true;
      inc(Edit_Task.Target[N][NAktiv].ColPoints);
      RePaint_My;
    end
    else begin
      // Message
      MessageDlg('Количество точек больше максимального', mtInformation,[mbOk], 0);
    end;
  end;
  NAktiv:=0;
  NAktiv_bmp:=0;
  NAktiv_bmp_alt:=0;
  NAktiv_point:=0;
end;

(************** Удаление мишени ************)
procedure TOKBottomDlg4.N2Click(Sender: TObject);
var a,b,n: integer;
begin
  if NAktiv<Edit_Task.Col_targ then begin
    for a:=NAktiv to Edit_Task.Col_targ-1 do begin
      for n:=1 to 3 do begin
        Edit_Task.Target[n][a].Num:=Edit_Task.Target[n][a+1].Num;
//        Edit_Task.Target[n][a].Mov:=Edit_Task.Target[n][a+1].Mov;
//        Edit_Task.Target[n][a].Air:=Edit_Task.Target[n][a+1].Air;
        Edit_Task.Target[n][a].Tst:=Edit_Task.Target[n][a+1].Tst;
        Edit_Task.Target[n][a].Tend:=Edit_Task.Target[n][a+1].Tend;
        Edit_Task.Target[n][a].ColPoints:=Edit_Task.Target[n][a+1].ColPoints;
        Rects[a].Right:=Rects[a+1].Right;
        Rects[a].Bottom:=Rects[a+1].Bottom;
        for b:=0 to Edit_Task.Target[n][a].ColPoints do begin
          Edit_Task.Target[n][a].Xtek[b]:=Edit_Task.Target[n][a+1].Xtek[b];
          Edit_Task.Target[n][a].Ytek[b]:=Edit_Task.Target[n][a+1].Ytek[b];
          Edit_Task.Target[n][a].Htek[b]:=Edit_Task.Target[n][a+1].Htek[b];
          Edit_Task.Target[n][a].Skor[b]:=Edit_Task.Target[n][a+1].Skor[b];
          Edit_Task.Target[n][a].Tstop[b]:=Edit_Task.Target[n][a+1].Tstop[b];
          Edit_Task.Target[n][a].Visible[b]:=Edit_Task.Target[n][a+1].Visible[b];
        end;
      end;
      for b:=1 to COL_MAX_TCHK_MICH do begin
        Mich[a][b].x:=Mich[a+1][b].x;
        Mich[a][b].y:=Mich[a+1][b].y;
      end;
    end;
  end;
  dec(Edit_Task.Col_targ);
  Edit1.Text:=inttostr(Edit_Task.Col_targ);
  NAktiv:=0;
  NAktiv_bmp:=0;
  NAktiv_point:=0;
  NAktiv_bmp_alt:=0;
  RePaint_My;
end;



procedure TOKBottomDlg4.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: close;
    107:begin
      if Mascht<18 then Mascht:=Mascht+2;
      RePaint_My;
    end;
    109:begin
      if Mascht>6 then Mascht:=Mascht -2;
      RePaint_My;
    end;
  end;
end;

procedure TOKBottomDlg4.SpeedButton12Click(Sender: TObject);
begin
  Screen.Cursor:=crArrow;// Восстановление формы курсора
  Vvod_orient:=0;
end;


procedure TOKBottomDlg4.Draw_Simvol(x,y,num: integer);
var a,b: integer;
begin
  for b:=0 to 15 do begin
    for a:=0 to 15 do begin
      if(SIMVOL[num][b] shl a)and$8000 >0 then Image3.Canvas.Pixels[x+a-8,y+b-12]:=$0;       // Чёрный
    end;
  end;
end;

procedure TOKBottomDlg4.Draw_Orientirs;
var a,x,y: integer;
begin
  for a:=1 to Orient.Col_orient do begin
    x:=Count_X_m_ekr(round(Orient.Xorient[a]-(stolbDX1+stolbLeft)/ DDD));
    y:=Count_Y_m_ekr(round(Orient.Yorient[a])-round(stolbBottom+STOLB_DY_R)div DDD);
    Draw_Simvol(x,y,Orient.Typ_orient[a]);
  end;
end;

procedure TOKBottomDlg4.BitBtn6Click(Sender: TObject);
var a, b, n:word;
begin
  for a:=1 to Edit_Task.Col_targ do begin
    n:=1;
    for b:=0 to Edit_Task.Target[n][a].ColPoints do begin
      Edit_Task.Target[n][a].Xtek[b]:=Edit_Task.Target[2][a].Xtek[b];
      Edit_Task.Target[n][a].Ytek[b]:=Edit_Task.Target[2][a].Ytek[b];
      Edit_Task.Target[n][a].Htek[b]:=Edit_Task.Target[2][a].Htek[b];
    end;
    n:=3;
    for b:=0 to Edit_Task.Target[n][a].ColPoints do begin
      Edit_Task.Target[n][a].Xtek[b]:=Edit_Task.Target[2][a].Xtek[b];
      Edit_Task.Target[n][a].Ytek[b]:=Edit_Task.Target[2][a].Ytek[b];
      Edit_Task.Target[n][a].Htek[b]:=Edit_Task.Target[2][a].Htek[b];
    end;
  end;// a:=1
  RePaint_My;
end;

function TOKBottomDlg4.Count_dX(n: integer): integer;
begin
  result:=0;
  case n of
    1: result:=-round(stolbDX1/ DDD);
    2: result:=0;
    3: result:=round(stolbDX2/ DDD);
  end;
end;

procedure TOKBottomDlg4.SpeedButton1Click(Sender: TObject);
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
///  if Sender=SpeedButton2 then  Vvod_orient:=6;  //
  if Sender=SpeedButton3 then  Vvod_orient:=4; //
  if Sender=SpeedButton4 then  Vvod_orient:=3;  //
  if Sender=SpeedButton5 then  Vvod_orient:=7;  //
//  if Sender=SpeedButton6 then  Vvod_orient:=8;  //
  if Sender=SpeedButton7 then  Vvod_orient:=10;  //
//  if Sender=SpeedButton8 then  Vvod_orient:=9; //
  if Sender=SpeedButton9 then  Vvod_orient:=11; //
//  if Sender=SpeedButton10 then  Vvod_orient:=2; //
  if Sender=SpeedButton11 then  Vvod_orient:=1; //
//  if Sender=SpeedButton13 then  Vvod_orient:=12;
end;

// Удаление ориентира
procedure TOKBottomDlg4.N12Click(Sender: TObject);
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

procedure TOKBottomDlg4.Sort_List;
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

procedure TOKBottomDlg4.SpeedButton14Click(Sender: TObject);
var n: word;
begin
  Application.CreateForm(TOKBottomDlg6, OKBottomDlg6);
  OKBottomDlg6.ComboBox1.ItemIndex:=0;
  OKBottomDlg6.SpinEdit1.Text:='0';
  OKBottomDlg6.Color_Mask:=0;
  if OKBottomDlg6.ShowModal=mrOk then begin;
    if Edit_Task.Col_targ<COL_MAX_MICH then begin
      inc(Edit_Task.Col_targ);
      for n:=1 to 3 do begin
        Edit_Task.Target[n][Edit_Task.Col_targ].Num:=OKBottomDlg6.ComboBox1.ItemIndex+10;
        Edit_Task.Target[n][Edit_Task.Col_targ].Color_Mask:=OKBottomDlg6.Color_Mask;
        Edit_Task.Target[n][Edit_Task.Col_targ].Tst:=StrToInt(OKBottomDlg6.SpinEdit1.Text);
        Edit_Task.Target[n][Edit_Task.Col_targ].Tstop[0]:=Edit_Task.Target[n][Edit_Task.Col_targ].Tst+MIN_T_MICH;
        Edit_Task.Target[n][Edit_Task.Col_targ].Xtek[0]:=0;
        Edit_Task.Target[n][Edit_Task.Col_targ].Ytek[0]:=600;
        Edit_Task.Target[n][Edit_Task.Col_targ].ColPoints:=0;
        Edit_Task.Target[n][Edit_Task.Col_targ].Mov:=false;
        Edit_Task.Target[n][Edit_Task.Col_targ].Air:=false;
      end;
      LoadTarget(Edit_Task.Target[1][Edit_Task.Col_targ].Num,Edit_Task.Col_targ);
      RePaint_My;
    end
    else begin
      MessageDlg('Количество мишеней больше максимального', mtInformation,[mbOk], 0);
    end;
  end;
  Edit1.Text:=inttostr(Edit_Task.Col_targ);
  OKBottomDlg6.Free;
end;

procedure TOKBottomDlg4.SpeedButton15Click(Sender: TObject);
begin
  Application.CreateForm(TOKBottomDlg7, OKBottomDlg7);
  OKBottomDlg7.SpinEdit1.visible:=false;
  OKBottomDlg7.SpinEdit2.visible:=false;
  OKBottomDlg7.SpinEdit3.visible:=false;
  OKBottomDlg7.SpinEdit4.Value:=Edit_Task.Tstr;
  OKBottomDlg7.SpinEdit5.visible:=false;
  OKBottomDlg7.Label1.Visible:=false;
  OKBottomDlg7.Label2.Visible:=false;
  OKBottomDlg7.Label3.Visible:=false;
  OKBottomDlg7.Label5.Visible:=false;
  OKBottomDlg7.CheckBox1.Visible:=false;
  OKBottomDlg7.Label6.Visible:=true;
  OKBottomDlg7.Caption:='Время выполнения упражнения';
  OKBottomDlg7.Label4.Caption:='Время выполнения,сек.';
  OKBottomDlg7.Label6.Caption:=inttostr(Edit_Task.Tstr div 60)+' мин.'+inttostr(Edit_Task.Tstr mod 60)+' сек.';
  if OKBottomDlg7.ShowModal=mrOk then begin;
    if OKBottomDlg7.SpinEdit4.Value<1 then OKBottomDlg7.SpinEdit4.Value:=60;
    Edit_Task.Tstr:=OKBottomDlg7.SpinEdit4.Value;
  end;
  OKBottomDlg7.Free;
  RePaint_My;
end;

procedure TOKBottomDlg4.Button2Click(Sender: TObject);
begin
  Edit_Task.Tstr:=SpinEdit4.Value;
  Save_Task;
end;

procedure TOKBottomDlg4.FormActivate(Sender: TObject);
begin
  RePaint_My;
end;

end.

