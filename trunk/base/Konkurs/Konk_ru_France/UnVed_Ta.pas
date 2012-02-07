unit UnVed_Ta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Printers;

type
  TResult = record
    dolzhn: string[20];
    rang: string[20];
    surname: string[20];
    col_push: string[3];
    col_pkt: string[3];
    res: string[20];
  end;  
  TFVed_Ta = class(TForm)
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
  FVed_Ta: TFVed_Ta;
  DeviceMode : TDevMode;
  Res: array[1..3,1..3] of TResult;
  numpant: integer;
const
  ddx = 1;
  ddy = 1;
  dx = 10;
  dy = 10;

implementation

uses Main,UnOther;

{$R *.DFM}
procedure TFVed_Ta.FormCreate(Sender: TObject);
var a,b: word;
begin
  numpant:=Variant;
  for a:=1 to 3 do begin
    res[a,1].dolzhn:='Chef';
    res[a,2].dolzhn:='Pointeur';
    res[a,3].dolzhn:='Conducteur';
    for b:=1 to 3 do begin
      res[a,b].surname:=Form1.Name[a][b];
      res[a,b].rang:=Form1.Zvanie[a,b];
    end;
    case Povrejden[a] of
      DESTR_COMPL: res[a,2].res:='Поражение танка ';
      DESTR_NAVOD: res[a,2].res:='Повреждён 1А40';
      DESTR_DALN: res[a,2].res:='Повреждён дальномер ';
      DESTR_PRIVOD: res[a,2].res:='Повреждён привод';
      DESTR_PRIVOD_VER: res[a,2].res:='Повреждён верт.привод';
      DESTR_PRIVOD_GOR: res[a,2].res:='Повреждён гор.привод';
      DESTR_STABIL: res[a,2].res:='Повреждён стабилизатор';
      DESTR_AZ: res[a,2].res:='Повреждён автомат зар.';
      DESTR_PNV: res[a,2].res:='Повреждён ночной прицел';
      DESTR_UPR_RAK: res[a,2].res:='Повреждён 1К13';
      DESTR_VOD: res[a,2].res:='Повреждёна базовая машина';
      DESTR_DVIG: res[a,2].res:='Повреждён двигатель';
      DESTR_POVOROT_LEV: res[a,2].res:='Повреждён лев.фрикцион';
      DESTR_POVOROT_PRAV: res[a,2].res:='Повреждён прав.фрикцион';
      DESTR_STARTER: res[a,2].res:='Повреждён стартер';
      DESTR_SCEPLENIE: res[a,2].res:='Повреждёно сцепление';
      else  res[a,2].res:='Sans endommagements';
    end;
  end;
end;

procedure TFVed_Ta.FormPaint(Sender: TObject);
var
  i,j,p: integer;
  razb: real;
  colmish: real;
  systime: TSYSTEMTIME;
begin
  with Canvas do begin
  // Вывод шапки ведомости
    GetLocalTime(systime);
    Font.Size:=12;
/////    brush.Color:=clBtnFace;
    TextOut(50*dx,dy,'Bulletin');
    TextOut(40*dx,3*dy,'Bordereau d''enregistement des resultats de l''execution de l''exercice');
    TextOut(34*dx,6*dy,'"'+TaskName+'"');
    TextOut(45*dx,10*dy,Form1.Rota+' companie , '+Form1.Vzvod+' section , corps de troups  '+Form1.VoenCh);
    TextOut(50*dx,13*dy,IntToStr(systime.wDay)+'.'+IntToStr(systime.wMonth)+'.'+IntToStr(systime.wYear)+' .');

    // Рисование таблицы
    MoveTo(dx,21*dy); LineTo(101*dx,21*dy);////
    MoveTo(dx,33*dy); LineTo(101*dx,33*dy);  // Рисование основных
    MoveTo(dx,45*dy); LineTo(101*dx,45*dy);  // горизонтальных
    MoveTo(dx,57*dy); LineTo(101*dx,57*dy);  // линийй
    MoveTo(dx,69*dy); LineTo(101*dx,69*dy);////
    MoveTo(dx,21*dy); LineTo(dx,69*dy);         ////

    MoveTo(3*dx,21*dy); LineTo(3*dx,69*dy);       //
    MoveTo(28*dx,21*dy); LineTo(28*dx,69*dy);     //
    MoveTo(51*dx,21*dy); LineTo(51*dx,69*dy);     // линий
    MoveTo(73*dx,21*dy); LineTo(73*dx,69*dy);     //
    MoveTo(101*dx,21*dy); LineTo(101*dx,69*dy); ////
    //Заполнение шапки таблицы
    Font.Size:=10;
    TextOut(dx+5*ddx,26*dy,'N');      // Первая графа
    TextOut(6*dx,25*dy,'Poste, grade, ');       //
    TextOut(6*dx,27*dy,'nom, prenom '); ////
    TextOut(31*dx,26*dy,'Quantite de buts ');   // Пятая
    TextOut(34*dx,29*dy,'frappes de canon');   // Пятая
    TextOut(54*dx,26*dy,'Quantite de buts ');
    TextOut(57*dx,29*dy,'frappes de mitrailleuse');
    TextOut(81*dx,26*dy,'Resultat du feu ');
    TextOut(83*dx,29*dy,'de l''adversaire');
    for i:=1 to 3 do begin
      for j:=1 to 3 do begin
        TextOut(4*dx,295+12*dy*(i-1)+4*dy*j,res[i,j].dolzhn);
        TextOut(14*dx,295+12*dy*(i-1)+4*dy*j,res[i,j].rang);
        TextOut(4*dx,310+12*dy*(i-1)+4*dy*j,res[i,j].surname);
        TextOut(39*dx,310+12*dy*(i-1)+4*dy*j,res[i,j].col_push);
        TextOut(62*dx,310+12*dy*(i-1)+4*dy*j,res[i,j].col_pkt);
        TextOut(74*dx,310+12*dy*(i-1)+4*dy*j,res[i,j].res);
        TextOut(2*dx,390+12*dy*(i-1),IntToStr(i));
      end;
    end;
  end;
end;

procedure TFVed_Ta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_ESCAPE then close;
end;

procedure TFVed_Ta.Button2Click(Sender: TObject);
begin
  Button1.Visible:=false;
  Button2.Visible:=false;
  Printer.Orientation:=poLandscape;
  Print;
  Button1.Visible:=true;
  Button2.Visible:=true;
end;

end.

