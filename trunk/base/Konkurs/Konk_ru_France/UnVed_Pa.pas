unit UnVed_Pa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Printers;

type
  TResult = record
    dolzhn: string[20];
    rang: string[20];
    surname: string[20];
    time: string[16];
    mistakes: string[3];
    mark: string[2];
  end;  
  TFVed_Pa = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FVed_Pa: TFVed_Pa;
  Res: array[1..3,1..3] of TResult;
  numpant: integer;
const
  ddx = 1;
  ddy = 1;
  deltax = 100;
  deltay = 100;
  dx = 10;
  dy = 10;

implementation

uses Main, UnPant;

{$R *.DFM}
procedure TFVed_Pa.FormCreate(Sender: TObject);
var a, m, s: word;
begin
  numpant:=Variant;
  for a:=1 to 3 do begin
    res[a,2].dolzhn:='Наводчик';
    res[a,2].surname:=Form1.Name[a][2];
    res[a,2].rang:=Form1.Zvanie[a,2];
    m:=Time_Indiv[a] div 60;
    s:=Time_Indiv[a] mod 60;
    res[a,2].time:=inttostr(m)+' мин. '+inttostr(s)+' сек.';
    res[a,2].mistakes:=inttostr(Col_err_Pant[a]);
    res[a,2].mark:=inttostr(Ocenka[a].Oc);
  end;
end;

procedure TFVed_Pa.FormPaint(Sender: TObject);
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
  systime: TSYSTEMTIME;
begin
  razb:=0;
  summast1:=0;
  summast2:=0;
  summast3:=0;
  summast4:=0;
  with Canvas do begin
  // Вывод шапки ведомости
    GetLocalTime(systime);
    Font.Size:=12;
    brush.Color:=clWhite;
    TextOut(50*dx,dy,'ВЕДОМОСТЬ');
    TextOut(31*dx,3*dy,'учета результатов выполнения упражнения с пантографом N ');
    TextOut(79*dx,3*dy,inttostr(numpant));
    TextOut(45*dx,7*dy,Form1.Rota+' рота, '+Form1.Vzvod+' взвод, в/ч '+Form1.VoenCh);
    TextOut(48*dx,10*dy,IntToStr(systime.wDay)+'.'+IntToStr(systime.wMonth)+'.'+IntToStr(systime.wYear)+'г.');

    // Рисование таблицы

    MoveTo(dx,21*dy); LineTo(101*dx,21*dy);////
    MoveTo(dx,33*dy); LineTo(101*dx,33*dy);  // Рисование основных
    MoveTo(dx,45*dy); LineTo(101*dx,45*dy);  // горизонтальных
    MoveTo(dx,57*dy); LineTo(101*dx,57*dy);  // линийй
    MoveTo(dx,69*dy); LineTo(101*dx,69*dy);////
    MoveTo(dx,21*dy); LineTo(dx,69*dy);         ////
    MoveTo(3*dx,21*dy); LineTo(3*dx,69*dy);       //

    MoveTo(28*dx,21*dy); LineTo(28*dx,69*dy);     //
    MoveTo(53*dx,21*dy); LineTo(53*dx,69*dy);     // линий
    MoveTo(78*dx,21*dy); LineTo(78*dx,69*dy);     //
    MoveTo(101*dx,21*dy); LineTo(101*dx,69*dy); ////
    //Заполнение шапки таблицы
    Font.Size:=10;
    TextOut(dx+5*ddx,26*dy,'N');      // Первая графа
    TextOut(6*dx,25*dy,'Должность,воинское звание,');       //
    TextOut(6*dx,27*dy,'фамилия и инициалы'); ////
    TextOut(34*dx,26*dy,'Время выполнения');   // Пятая
    TextOut(60*dx,26*dy,'Количество ошибок');
    TextOut(88*dx,26*dy,'Оценка');
    j:=2;// Наводчик
    for i:=1 to 3 do begin
      TextOut(4*dx,295+12*dy*(i-1)+4*dy*j,res[i,j].dolzhn);
      TextOut(4*dx,310+12*dy*(i-1)+4*dy*j,res[i,j].rang);
      TextOut(4*dx,325+12*dy*(i-1)+4*dy*j,res[i,j].surname);
      TextOut(35*dx,310+12*dy*(i-1)+4*dy*j,res[i,j].time);
      TextOut(65*dx,310+12*dy*(i-1)+4*dy*j,res[i,j].mistakes);
      TextOut(90*dx,310+12*dy*(i-1)+4*dy*j,res[i,j].mark);
      TextOut(2*dx,390+12*dy*(i-1),IntToStr(i));
    end;
  end;
end;


procedure TFVed_Pa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_ESCAPE then close;
end;

procedure TFVed_Pa.Button2Click(Sender: TObject);
begin
  Button1.Visible:=false;
  Button2.Visible:=false;
  Printer.Orientation:=poLandscape;
  Print;
  Button1.Visible:=true;
  Button2.Visible:=true;
end;

end.
