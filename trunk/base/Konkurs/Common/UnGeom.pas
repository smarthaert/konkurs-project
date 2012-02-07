unit UnGeom;   //Вычисления на плоскости и в пространстве

interface

uses classes;

const
SIN_TAB : array[0..90] of real =
(0.00000000000000E+0000, 1.74524064372835E-0002, 3.48994967025010E-0002, 5.23359562429438E-0002, 6.97564737441253E-0002, 8.71557427476582E-0002, 1.04528463267653E-0001, 1.21869343405147E-0001, 1.39173100960065E-0001, 1.56434465040231E-0001,
 1.73648177666930E-0001, 1.90808995376545E-0001, 2.07911690817759E-0001, 2.24951054343865E-0001, 2.41921895599668E-0001, 2.58819045102521E-0001, 2.75637355816999E-0001, 2.92371704722737E-0001, 3.09016994374947E-0001, 3.25568154457157E-0001,
 3.42020143325669E-0001, 3.58367949545300E-0001, 3.74606593415912E-0001, 3.90731128489274E-0001, 4.06736643075800E-0001, 4.22618261740699E-0001, 4.38371146789077E-0001, 4.53990499739547E-0001, 4.69471562785891E-0001, 4.84809620246337E-0001,
 5.00000000000000E-0001, 5.15038074910054E-0001, 5.29919264233205E-0001, 5.44639035015027E-0001, 5.59192903470747E-0001, 5.73576436351046E-0001, 5.87785252292473E-0001, 6.01815023152048E-0001, 6.15661475325658E-0001, 6.29320391049838E-0001,
 6.42787609686539E-0001, 6.56059028990507E-0001, 6.69130606358858E-0001, 6.81998360062499E-0001, 6.94658370458997E-0001, 7.07106781186547E-0001, 7.19339800338651E-0001, 7.31353701619170E-0001, 7.43144825477394E-0001, 7.54709580222772E-0001,
 7.66044443118978E-0001, 7.77145961456971E-0001, 7.88010753606722E-0001, 7.98635510047293E-0001, 8.09016994374947E-0001, 8.19152044288992E-0001, 8.29037572555042E-0001, 8.38670567945424E-0001, 8.48048096156426E-0001, 8.57167300702112E-0001,
 8.66025403784439E-0001, 8.74619707139396E-0001, 8.82947592858927E-0001, 8.91006524188368E-0001, 8.98794046299167E-0001, 9.06307787036650E-0001, 9.13545457642601E-0001, 9.20504853452440E-0001, 9.27183854566787E-0001, 9.33580426497202E-0001,
 9.39692620785908E-0001, 9.45518575599317E-0001, 9.51056516295154E-0001, 9.56304755963035E-0001, 9.61261695938319E-0001, 9.65925826289068E-0001, 9.70295726275996E-0001, 9.74370064785235E-0001, 9.78147600733806E-0001, 9.81627183447664E-0001,
 9.84807753012208E-0001, 9.87688340595138E-0001, 9.90268068741570E-0001, 9.92546151641322E-0001, 9.94521895368273E-0001, 9.96194698091746E-0001, 9.97564050259824E-0001, 9.98629534754574E-0001, 9.99390827019096E-0001, 9.99847695156391E-0001,
 1.0);
COS_TAB : array[0..90] of real =
(1.00000000000000E+0000, 9.99847695156391E-0001, 9.99390827019096E-0001, 9.98629534754574E-0001, 9.97564050259824E-0001, 9.96194698091746E-0001, 9.94521895368273E-0001, 9.92546151641322E-0001, 9.90268068741570E-0001, 9.87688340595138E-0001,
 9.84807753012208E-0001, 9.81627183447664E-0001, 9.78147600733806E-0001, 9.74370064785235E-0001, 9.70295726275996E-0001, 9.65925826289068E-0001, 9.61261695938319E-0001, 9.56304755963035E-0001, 9.51056516295153E-0001, 9.45518575599317E-0001,
 9.39692620785908E-0001, 9.33580426497202E-0001, 9.27183854566787E-0001, 9.20504853452440E-0001, 9.13545457642601E-0001, 9.06307787036650E-0001, 8.98794046299167E-0001, 8.91006524188368E-0001, 8.82947592858927E-0001, 8.74619707139396E-0001,
 8.66025403784439E-0001, 8.57167300702112E-0001, 8.48048096156426E-0001, 8.38670567945424E-0001, 8.29037572555042E-0001, 8.19152044288992E-0001, 8.09016994374947E-0001, 7.98635510047293E-0001, 7.88010753606722E-0001, 7.77145961456971E-0001,
 7.66044443118978E-0001, 7.54709580222772E-0001, 7.43144825477394E-0001, 7.31353701619170E-0001, 7.19339800338651E-0001, 7.07106781186548E-0001, 6.94658370458997E-0001, 6.81998360062499E-0001, 6.69130606358858E-0001, 6.56059028990507E-0001,
 6.42787609686539E-0001, 6.29320391049838E-0001, 6.15661475325658E-0001, 6.01815023152048E-0001, 5.87785252292473E-0001, 5.73576436351046E-0001, 5.59192903470747E-0001, 5.44639035015027E-0001, 5.29919264233205E-0001, 5.15038074910054E-0001,
 5.00000000000000E-0001, 4.84809620246337E-0001, 4.69471562785891E-0001, 4.53990499739547E-0001, 4.38371146789078E-0001, 4.22618261740699E-0001, 4.06736643075800E-0001, 3.90731128489274E-0001, 3.74606593415912E-0001, 3.58367949545300E-0001,
 3.42020143325669E-0001, 3.25568154457157E-0001, 3.09016994374947E-0001, 2.92371704722737E-0001, 2.75637355816999E-0001, 2.58819045102521E-0001, 2.41921895599668E-0001, 2.24951054343865E-0001, 2.07911690817759E-0001, 1.90808995376545E-0001,
 1.73648177666930E-0001, 1.56434465040231E-0001, 1.39173100960065E-0001, 1.21869343405147E-0001, 1.04528463267653E-0001, 8.71557427476581E-0002, 6.97564737441252E-0002, 5.23359562429437E-0002, 3.48994967025011E-0002, 1.74524064372834E-0002,
 0.0);
TAN_TAB : array[0..90] of real =
(0.00000000000000E+0000, 1.74550649282176E-0002, 3.49207694917477E-0002, 5.24077792830412E-0002, 6.99268119435104E-0002, 8.74886635259240E-0002, 1.05104235265676E-0001, 1.22784560902904E-0001, 1.40540834702391E-0001, 1.58384440324536E-0001,
 1.76326980708465E-0001, 1.94380309137718E-0001, 2.12556561670022E-0001, 2.30868191125563E-0001, 2.49328002843181E-0001, 2.67949192431123E-0001, 2.86745385758808E-0001, 3.05730681458660E-0001, 3.24919696232906E-0001, 3.44327613289665E-0001,
 3.63970234266202E-0001, 3.83864035035416E-0001, 4.04026225835157E-0001, 4.24474816209605E-0001, 4.45228685308536E-0001, 4.66307658154999E-0001, 4.87732588565861E-0001, 5.09525449494429E-0001, 5.31709431661479E-0001, 5.54309051452769E-0001,
 5.77350269189626E-0001, 6.00860619027560E-0001, 6.24869351909327E-0001, 6.49407593197511E-0001, 6.74508516842427E-0001, 7.00207538209710E-0001, 7.26542528005361E-0001, 7.53554050102794E-0001, 7.81285626506717E-0001, 8.09784033195007E-0001,
 8.39099631177280E-0001, 8.69286737816227E-0001, 9.00404044297840E-0001, 9.32515086137662E-0001, 9.65688774807074E-0001, 1.00000000000000E+0000, 1.03553031379057E+0000, 1.07236871002468E+0000, 1.11061251482919E+0000, 1.15036840722101E+0000,
 1.19175359259421E+0000, 1.23489715653505E+0000, 1.27994163219308E+0000, 1.32704482162041E+0000, 1.37638192047117E+0000, 1.42814800674211E+0000, 1.48256096851274E+0000, 1.53986496381458E+0000, 1.60033452904105E+0000, 1.66427948235052E+0000,
 1.73205080756888E+0000, 1.80404775527142E+0000, 1.88072646534633E+0000, 1.96261050550515E+0000, 2.05030384157930E+0000, 2.14450692050956E+0000, 2.24603677390422E+0000, 2.35585236582375E+0000, 2.47508685341630E+0000, 2.60508906469380E+0000,
 2.74747741945462E+0000, 2.90421087767582E+0000, 3.07768353717526E+0000, 3.27085261848414E+0000, 3.48741444384091E+0000, 3.73205080756888E+0000, 4.01078093353585E+0000, 4.33147587428415E+0000, 4.70463010947846E+0000, 5.14455401597031E+0000,
 5.67128181961771E+0000, 6.31375151467504E+0000, 7.11536972238421E+0000, 8.14434642797459E+0000, 9.51436445422259E+0000, 1.14300523027613E+0001, 1.43006662567119E+0001, 1.90811366877282E+0001, 2.86362532829155E+0001, 5.72899616307599E+0001,
 1e308);
type

Vektor = record
          X,Y,H : real;
         end;
 PVektor  = ^Vektor;
 Matrica  = array[1..3] of Vektor;  //вектор - строка матрицы
 Matrix   = array[1..3,1..3] of real;
 Koord    = record
          X,Y : real;
          end;
 PKoord = ^Koord;
TXYZ = record        {правая тройка ортов}
          Normal     : Vektor;  {вектор нормали}
          VForward   : Vektor;  {вектор, перпендикулярный нормали, направленный вперед}
          Theard     : Vektor;  {третий вектор перпендикулярный первым двум}
       end;

function Sign(x : real) : integer;
function ArcSinTab(x : real) : real;                                //вычисляет арксинус по таблице
function ArcCosTab(x : real) : real;                                //вычисляет арккосинус по таблице
function ArcTanTab(x : real) : real;                                //вычисляет арктангенс по таблице
{--------------------ГЕОМЕТРИЯ НА ПЛОСКОСТИ-------------------------------------}
function Angle(x,y,x1,y1 : real) : real;                            //возвращает азимут направления с точки (х,у) на точку (х1,у1)
function PointInPolygon(x,y : real; Polygon : TList) : boolean;     //возвращает истину если точка (х,у) лежит внутри многоугольника Polygon
function PointInRect(x,y : real; Polygon : TList) : boolean;        //возвращает истину если точка (х,у) лежит внутри выпуклого четырехугольника Polygon
function CirclInRect(x,y,r : real; Polygon : TList) : boolean;      //возвращает истину если окружность (х,у,r) пересекается с выпуклым четырехугольником Polygon
function CrossLine(x1,y1,x2,y2 : real; Polygon : TList) : boolean;  //возвращает истину если отрезок [(х1,у1),(x2,y2)] пересекает ломаную линию Polygon
function CrossPolygon(Point1,Point2 : Koord; Polygon : TList) : boolean; //возвращает истину если отрезок [(х1,у1),(x2,y2)] пересекает многоугольник Polygon
function PointInCircl(x,y : real; Polygon : TList) : boolean;       //возвращает истину если точка (х,у) лежит внутри окружности Polygon
procedure Coners(x,y,a,L,W : real; dir : integer; Polygon : TList); //пересчитывает координаты углов базы Polygon длиной L и шириной W при повороте на угол а в точке x,y, dir=0 - вся база, -1 - задняя половина, 1 - передняя половина
procedure Coners56cm(x,y,a,L,W : real; dir : integer; Polygon : TList); //пересчитывает координаты углов базы Polygon длиной L и шириной W при повороте на угол а в точке x,y, dir=0 - вся база, -1 - задняя половина, 1 - передняя половина
procedure ConersXYcm(x,y,a,Lf,Lb,W : real; Polygon : TList);          //пересчитывает координаты углов базы Polygon длиной L и шириной W при повороте на угол а в точке x,y, dir=0 - вся база, -1 - задняя половина, 1 - передняя половина
function CrossGate(x1,y1,x2,y2,x3,y3,x4,y4 : real) : boolean;         //возвращает истину если отрезок [(х1,у1),(x2,y2)] пересекает отрезок [(х3,у3),(x4,y4)]
function CrossGateTrue(x1,y1,x2,y2,x3,y3,x4,y4 : real) : boolean;     //возвращает истину если направленный отрезок [(х1,у1),(x2,y2)] пересекает отрезок [(х3,у3),(x4,y4)], так что точка (х3,у3) остается слева
procedure RotateAxis(var x : PKoord; a : PKoord; Alpha : real);       //поворачивает точку х относительно точки а на угол Аlpha рад.
function GetDir(x1,x2 : koord) : koord;                               //вычисление орта направленного из x1 в x2
procedure Line_2D(x1,x2,y1,y2 : real; var a,b,c : real);              //уравнение прямой на плоскости через 2 точки
function D_Point_To_Line_2D(x,y,a,b,c : real) : real;                 //возвращает расстояние от точки до прямой на плоскости
{-----------------------ГЕОМЕТРИЯ В ПРОСТРАНСТВЕ------------------------------}
function ScalM(a,b : Vektor) : real;                                //возвращает скалярное произведение векторов a и b
function VektorM(a,b : Vektor) : Vektor;                            //возвращает векторное произведение векторов a и b
function ScaleV(a,b : Vektor) : Vektor;                             //возвращает вектор a масштабированный по вектору b
function DivV(a,b : Vektor) : Vektor;                               //возвращает покоординатное частное а на b
function aV(a :real; V : Vektor) : Vektor;                          //возвращает a*V
function SumV(Na :real; a : Vektor; Nb :real; b : Vektor) : Vektor; //возвращает композицию векторов Na*a+Nb*b
function Norma(a : Vektor) : real;                                  //возвращает норму вектора
function NormV(a : Vektor) : Vektor;                                //возвращает нормированный вектор
function Rotate(m : Matrica; a : Vektor) : Vektor;                  //умноженеие матрици на вектор
function PointNearPoint(X,Y : Vektor; Var d : real) : boolean;      //возвращает истину если точка X лежит ближе d от точки Y
function PointNearShortLine(X,X1,X2,a : Vektor; Var d : real) : boolean; //возвращает истину если точка X лежит ближе d от отрезка [X1,X2] с направляющим ортом a
procedure ShortCrossPoligon(x1,x2,a : Vektor; Polygon : TList; var error : byte; var X : Vektor); //выч точку пересечения отрезка [х1,х2] с направляющим ортом а и многоугльника Polygon, возвращает error=0 если есть точка пересечения и ее координаты в х error=1 - первые 3 точки многоугольника лежат на одной прямой error=2 - нет пересечения
function Angels2MatrixRotate(Tang : Vektor) : Matrix;               {возвращает матрицу поворота по углам наклона}
function Angels2XYZ(Tang : Vektor) : TXYZ;                          {возвращает локальную систему координат по углам наклона}
function Angels2Forward(Tang : Vektor) : Vektor;                    {возвращает орт локальной системы координат направленный вперед по углам наклона}
procedure RotateXYZ(Tang : real; N : byte; var XYZ : TXYZ );        {поворачивает локальную систему координат на угол Tang вокруг оси номер N}
function Loc2Glob(x : Vektor; XYZ : TXYZ) : Vektor;                 {перевод из локальных координат в глобальные}
function Glob2Loc(x : Vektor; XYZ : TXYZ) : Vektor;                 {перевод из глобальных координат в локальные}
function GetDirOrt(x1,x2 : Vektor) : Vektor;                        //вычисление орта направленного из x1 в x2

var NulV : Vektor = (X:0;Y:0;H:0);

implementation

uses Math;

function Sign(x : real) : integer;
begin
 if x=0 then Sign:=0
        else Sign:=Round(x/Abs(x))
end;

function ScalM(a,b : Vektor) : real;
begin
 ScalM:=a.X*b.X+a.Y*b.Y+a.H*b.H
end;

function VektorM(a,b : Vektor) : Vektor;
begin
 VektorM.X:=a.Y*b.H-a.H*b.Y;
 VektorM.Y:=a.H*b.X-a.X*b.H;
 VektorM.H:=a.X*b.Y-a.Y*b.X;
end;

function ScaleV(a,b : Vektor) : Vektor;  //возвращает вектор a масштабированный по вектору b
begin
 ScaleV.X:=a.X*b.X;
 ScaleV.Y:=a.Y*b.Y;
 ScaleV.H:=a.H*b.H;
end;

function DivV(a,b : Vektor) : Vektor;  //возвращает покоординатное частное а на b
begin
 if b.X=0 then DivV.X:=0 else DivV.X:=a.X/b.X;
 if b.Y=0 then DivV.Y:=0 else DivV.Y:=a.Y/b.Y;
 if b.H=0 then DivV.H:=0 else DivV.H:=a.H/b.H;
end;

function aV(a :real; V : Vektor) : Vektor; //возвращает a*V
begin;
 aV.X:=a*V.X;
 aV.Y:=a*V.Y;
 aV.H:=a*V.H;
end;

function SumV(Na :real; a : Vektor; Nb :real; b : Vektor) : Vektor;
begin;
 SumV.X:=Na*a.X+Nb*b.X;
 SumV.Y:=Na*a.Y+Nb*b.Y;
 SumV.H:=Na*a.H+Nb*b.H;
end;

function Norma(a : Vektor) : real; //возвращает норму вектора
begin
 Norma:=sqrt(a.X*a.X+a.Y*a.Y+a.H*a.H);
end;

function NormV(a : Vektor) : Vektor; //возвращает нормированный вектор
var temp : real;
begin
 temp:=Norma(a);
 if temp=0 then NormV:=nulV else
 NormV:=aV(1/temp,a);
end;

function Rotate(m : Matrica; a : Vektor) : Vektor; //умноженеие матрици на вектор
begin
 Rotate.X:=ScalM(m[1],a);
 Rotate.Y:=ScalM(m[2],a);
 Rotate.H:=ScalM(m[3],a);
end;

function Angle(x,y,x1,y1 : real) : real; //возвращает азимут направления с точки (х,у) на точку (х1,у1)
var i4 : integer;   //номер четверти
begin
  if ((x-x1>=0) and (y-y1>=0)) then i4:=1;
  if ((x-x1<=0) and (y-y1>=0)) then i4:=2;
  if ((x-x1<=0) and (y-y1<=0)) then i4:=3;
  if ((x-x1>=0) and (y-y1<=0)) then i4:=4;
  if x-x1=0 then
  if y-y1>0 then Angle:=Pi/2 else Angle:=3*Pi/2
  else
  case i4 of
  1: Angle:=Pi+arctan((y-y1)/(x-x1));
  2: Angle:=2*Pi+arctan((y-y1)/(x-x1));
  3: Angle:=arctan((y-y1)/(x-x1));
  4: Angle:=Pi+arctan((y-y1)/(x-x1));
  end;
end;

function PointInPolygon(x,y : real; Polygon : TList) : boolean; //возвращает истину если точка (х,у) лежит внутри многоугольника Polygon
var i : integer;
    a,a1,a2,s,x1,y1 : real;
    p : pkoord;
begin
 s:=0;
 for i:=0 to Polygon.Count-1 do
 begin
  p:=Polygon.Items[i];
  x1:=p^.X;
  y1:=p^.Y;
  a1:=Angle(x,y,x1,y1);
  if i=Polygon.Count-1 then
  p:=Polygon.Items[0]
  else
  p:=Polygon.Items[i+1];
  x1:=p^.X;
  y1:=p^.Y;
  a2:=Angle(x,y,x1,y1);
  a:=a2-a1;
  if a>Pi then a:=a-Pi;
  if a<-Pi then a:=a+Pi;
  s:=s+a;
 end;
 if Abs(s)>3 then PointInPolygon:=true
        else PointInPolygon:=false;
end;

function PointInRect(x,y : real; Polygon : TList) : boolean; //возвращает истину если точка (х,у) лежит внутри выпуклого четырехугольника Polygon
var i : integer;
    s1,s2,x1,y1,x2,y2 : real;
    p : pkoord;
    a : array[0..3] of real;
begin
 for i:=0 to Polygon.Count-1 do
 begin
  p:=Polygon.Items[i];
  x1:=p^.X;
  y1:=p^.Y;
  if i=Polygon.Count-1 then
  p:=Polygon.Items[0]
  else
  p:=Polygon.Items[i+1];
  x2:=p^.X;
  y2:=p^.Y;
  a[i]:=(x-x1)*(y2-y1)-(y-y1)*(x2-x1);
 end;
 s1:=a[0]*a[2];
 s2:=a[1]*a[3];
 if ((s1>=0) and (s2>=0)) then PointInRect:=true
        else PointInRect:=false;
end;

function CirclInRect(x,y,r : real; Polygon : TList) : boolean; //возвращает истину если окружность (х,у,r) пересекается с выпуклым четырехугольником Polygon
var i : integer;
    s1,s2,x1,y1,x2,y2 : real;
    p : pkoord;
    a : array[0..3] of real;
begin
 CirclInRect:=false;
 for i:=0 to Polygon.Count-1 do
 begin
  p:=Polygon.Items[i];
  x1:=p^.X;
  y1:=p^.Y;
  if i=Polygon.Count-1 then
  p:=Polygon.Items[0]
  else
  p:=Polygon.Items[i+1];
  x2:=p^.X;
  y2:=p^.Y;
  a[i]:=((x-x1)*(y2-y1)-(y-y1)*(x2-x1))/sqrt((y2-y1)*(y2-y1)+(x2-x1)*(x2-x1));
 end;
 s1:=a[0]*a[2];
 s2:=a[1]*a[3];
 if ((s1>=0) and (s2>=0)) then CirclInRect:=true
 else
 begin
  a[0]:=min(abs(a[0]),abs(a[2]));
  a[1]:=min(abs(a[1]),abs(a[3]));
  if ((s1<0) and (s2>=0) and (a[0]<r)) then CirclInRect:=true;
  if ((s1>=0) and (s2<0) and (a[1]<r)) then CirclInRect:=true;
  if ((s1<0) and (s2<0) and (a[0]<r) and (a[1]<r)) then CirclInRect:=true;
 end;
end;

function CrossLine(x1,y1,x2,y2 : real; Polygon : TList) : boolean; //возвращает истину если отрезок [(х1,у1),(x2,y2)] пересекает ломаную линию Polygon
var i : integer;
    a1,a2,a3,a4,x3,y3,x4,y4 : real;
    p : pkoord;
begin
 CrossLine:=false;
 for i:=0 to Polygon.Count-2 do
 begin
  p:=Polygon.Items[i];
  x3:=p^.X;
  y3:=p^.Y;
  p:=Polygon.Items[i+1];
  x4:=p^.X;
  y4:=p^.Y;
  a1:=(x1-x3)*(y4-y3)-(y1-y3)*(x4-x3);
  a2:=(x2-x3)*(y4-y3)-(y2-y3)*(x4-x3);
  a3:=(x3-x1)*(y2-y1)-(y3-y1)*(x2-x1);
  a4:=(x4-x1)*(y2-y1)-(y4-y1)*(x2-x1);
  if ((a1*a2<=0) and (a3*a4<=0)) then CrossLine:=true;
 end;
end;

function CrossPolygon(Point1,Point2 : Koord; Polygon : TList) : boolean; //возвращает истину если отрезок [(х1,у1),(x2,y2)] пересекает многоугольник Polygon
var i : integer;
    a1,a2,a3,a4,x3,y3,x4,y4 : real;
    p : pkoord;
begin
 CrossPolygon:=false;
 for i:=0 to Polygon.Count-1 do
 begin
  p:=Polygon.Items[i];
  x3:=p^.X;
  y3:=p^.Y;
  if i=Polygon.Count-1 then
  p:=Polygon.Items[0]
  else
  p:=Polygon.Items[i+1];
  x4:=p^.X;
  y4:=p^.Y;
  a1:=(Point1.X-x3)*(y4-y3)-(Point1.Y-y3)*(x4-x3);
  a2:=(Point2.X-x3)*(y4-y3)-(Point2.Y-y3)*(x4-x3);
  a3:=(x3-Point1.X)*(Point2.Y-Point1.Y)-(y3-Point1.Y)*(Point2.X-Point1.X);
  a4:=(x4-Point1.X)*(Point2.Y-Point1.Y)-(y4-Point1.Y)*(Point2.X-Point1.X);
  if ((a1*a2<=0) and (a3*a4<=0)) then CrossPolygon:=true;
 end;
end;

function PointInCircl(x,y : real; Polygon : TList) : boolean; //возвращает истину если точка (х,у) лежит внутри окружности Polygon
var s,x1,y1,x2,y2 : real;
    p : pkoord;
begin
 p:=Polygon.Items[0];
 x1:=p^.X;
 y1:=p^.Y;
 p:=Polygon.Items[1];
 x2:=p^.X;
 s:=(x-x1)*(x-x1)+(y-y1)*(y-y1);
 if s<=x2*x2 then PointInCircl:=true
            else PointInCircl:=false;
end;

procedure Coners(x,y,a,L,W : real; dir : integer; Polygon : TList);
//пересчитывает координаты углов базы Polygon при повороте на угол а в точке x,y
var xx,yy,cosa,sina,Lf,Lb : real;
    p : pkoord;
begin
 case dir of
 -1:begin
     Lf:=0;
     Lb:=-L/2
    end;
  0:begin
     Lf:=L/2;
     Lb:=-L/2
    end;
  1:begin
     Lf:=L/2;
     Lb:=0;
    end;
 end;
 cosa:=cos(a);
 sina:=sin(a);
 p:=Polygon.Items[0];
 xx:=Lf*cosa-W/2*sina;
 yy:=Lf*sina+W/2*cosa;
 p^.X:=x+xx;
 p^.Y:=y+yy;
 p:=Polygon.Items[1];
 xx:=Lf*cosa+W/2*sina;
 yy:=Lf*sina-W/2*cosa;
 p^.X:=x+xx;
 p^.Y:=y+yy;
 p:=Polygon.Items[2];
 xx:=Lb*cosa+W/2*sina;
 yy:=Lb*sina-W/2*cosa;
 p^.X:=x+xx;
 p^.Y:=y+yy;
 p:=Polygon.Items[3];
 xx:=Lb*cosa-W/2*sina;
 yy:=Lb*sina+W/2*cosa;
 p^.X:=x+xx;
 p^.Y:=y+yy;
end;

procedure Coners56cm(x,y,a,L,W : real; dir : integer; Polygon : TList);
//пересчитывает координаты углов базы Polygon при повороте на угол а в точке x,y
var xx,yy,cosa,sina,Lf,Lb : real;
    p : pkoord;
begin
 case dir of
 -1:begin
     Lf:=0;
     Lb:=-L/2+0.56
   end;
  0:begin
     Lf:=L/2+0.56;
     Lb:=-L/2+0.56
    end;
  1:begin
     Lf:=L/2+0.56;
     Lb:=0;
    end;
 end;
 cosa:=cos(a);
 sina:=sin(a);
 p:=Polygon.Items[0];
 xx:=Lf*cosa-W/2*sina;
 yy:=Lf*sina+W/2*cosa;
 p^.X:=x+xx;
 p^.Y:=y+yy;
 p:=Polygon.Items[1];
 xx:=Lf*cosa+W/2*sina;
 yy:=Lf*sina-W/2*cosa;
 p^.X:=x+xx;
 p^.Y:=y+yy;
 p:=Polygon.Items[2];
 xx:=Lb*cosa+W/2*sina;
 yy:=Lb*sina-W/2*cosa;
 p^.X:=x+xx;
 p^.Y:=y+yy;
 p:=Polygon.Items[3];
 xx:=Lb*cosa-W/2*sina;
 yy:=Lb*sina+W/2*cosa;
 p^.X:=x+xx;
 p^.Y:=y+yy;
end;

procedure ConersXYcm(x,y,a,Lf,Lb,W : real; Polygon : TList); //пересчитывает координаты углов базы Polygon длиной L и шириной W при повороте на угол а в точке x,y, dir=0 - вся база, -1 - задняя половина, 1 - передняя половина
//пересчитывает координаты углов базы Polygon при повороте на угол а в точке x,y
var xx,yy,cosa,sina : real;
    p : pkoord;
begin
 cosa:=cos(a);
 sina:=sin(a);
 p:=Polygon.Items[0];
 xx:=Lf*cosa-W*sina;
 yy:=Lf*sina+W*cosa;
 p^.X:=x+xx;
 p^.Y:=y+yy;
 p:=Polygon.Items[1];
 xx:=Lf*cosa+W*sina;
 yy:=Lf*sina-W*cosa;
 p^.X:=x+xx;
 p^.Y:=y+yy;
 p:=Polygon.Items[2];
 xx:=Lb*cosa+W*sina;
 yy:=Lb*sina-W*cosa;
 p^.X:=x+xx;
 p^.Y:=y+yy;
 p:=Polygon.Items[3];
 xx:=Lb*cosa-W*sina;
 yy:=Lb*sina+W*cosa;
 p^.X:=x+xx;
 p^.Y:=y+yy;
end;

function CrossGate(x1,y1,x2,y2,x3,y3,x4,y4 : real) : boolean; //возвращает истину если отрезок [(х1,у1),(x2,y2)] пересекает отрезок [(х3,у3),(x4,y4)]
var i : integer;
    a1,a2,a3,a4 : real;
    p : pkoord;
begin
 CrossGate:=false;
 a1:=(x1-x3)*(y4-y3)-(y1-y3)*(x4-x3);
 a2:=(x2-x3)*(y4-y3)-(y2-y3)*(x4-x3);
 a3:=(x3-x1)*(y2-y1)-(y3-y1)*(x2-x1);
 a4:=(x4-x1)*(y2-y1)-(y4-y1)*(x2-x1);
 if ((a1*a2<=0) and (a3*a4<=0)) then CrossGate:=true;
end;

function CrossGateTrue(x1,y1,x2,y2,x3,y3,x4,y4 : real) : boolean; //возвращает истину если направленный отрезок [(х1,у1),(x2,y2)] пересекает отрезок [(х3,у3),(x4,y4)], так что точка (х3,у3) остается слева
var i : integer;
    a1,a2,a3,a4 : real;
    p : pkoord;
begin
 CrossGateTrue:=false;
 a1:=(x1-x3)*(y4-y3)-(y1-y3)*(x4-x3);
 a2:=(x2-x3)*(y4-y3)-(y2-y3)*(x4-x3);
 a3:=(x3-x1)*(y2-y1)-(y3-y1)*(x2-x1);
 a4:=(x4-x1)*(y2-y1)-(y4-y1)*(x2-x1);
 if ((a1*a2<=0) and (a3*a4<=0) and (a3<0)) then CrossGateTrue:=true;
end;

procedure RotateAxis(var x : PKoord; a : PKoord; Alpha : real);       //поворачивает точку х относительно точки а на угол Аlpha рад.
var xx,yy,cosa,sina : real;
    p : pkoord;
begin
 cosa:=cos(Alpha);
 sina:=sin(Alpha);
 xx:=x^.X-a^.X;
 yy:=x^.Y-a^.Y;
 x^.X:=a^.X+xx*cosa+yy*sina;
 x^.Y:=a^.Y-xx*sina+yy*cosa;
end;

function ArcSinTab(x : real) : real; //вычисляет арксинус по таблице
var y,z : real;
    i,j : byte;
begin
 y:=Abs(x);
 for i:=0 to 89 do
 if (SIN_TAB[i]-y)*(SIN_TAB[i+1]-y)<=0 then
 begin
  j:=i;
  Break;
 end;
 z:=j+(y-SIN_TAB[j])/(SIN_TAB[j+1]-SIN_TAB[j]);
 if x>=0 then ArcSinTab:=z else ArcSinTab:=-z;
end;

function ArcCosTab(x : real) : real; //вычисляет арккосинус по таблице
var y,z : real;
    i,j : byte;
begin
 y:=Abs(x);
 for i:=0 to 89 do
 if (COS_TAB[i]-y)*(COS_TAB[i+1]-y)<=0 then
 begin
  j:=i;
  Break;
 end;
 z:=j+(y-COS_TAB[j])/(COS_TAB[j+1]-COS_TAB[j]);
 if x>=0 then ArcCosTab:=z else ArcCosTab:=180-z;
end;

function ArcTanTab(x : real) : real; //вычисляет арктангенс по таблице
var y,z : real;
    i,j : byte;
begin
 y:=Abs(x);
 for i:=1 to 90 do
 if y<TAN_TAB[i-1] then
 begin
  if x>=0 then ArcTanTab:=i else ArcTanTab:=-i;
  exit;
 end;
end;

function PointNearPoint(X,Y : Vektor; Var d : real) : boolean; //возвращает истину если точка X лежит ближе d от точки Y
var temp : real;
begin
 temp:=max(abs(X.X-Y.X),abs(X.Y-Y.Y));
 temp:=max(temp,abs(X.H-Y.H));
 if temp<=d then
 begin
  PointNearPoint:=true;
  d:=temp;
 end
 else PointNearPoint:=false;
end;

function PointNearShortLine(X,X1,X2,a : Vektor; var d : real) : boolean; //возвращает истину если точка X лежит ближе d от отрезка [X1,X2] с направляющим ортом a
var d1,d2,temp_v : Vektor;
    temp : real;
begin
 PointNearShortLine:=false;
 if PointNearPoint(X,X1,d) then
 begin
  PointNearShortLine:=true;
  exit;
 end;
 if PointNearPoint(X,X2,d) then
 begin
  PointNearShortLine:=true;
  exit;
 end;
 d1:=SumV(1,X,-1,X1);
 temp_v:=VektorM(a,d1);
 temp:=Norma(temp_v);
 if temp<=d then
 begin
  d:=temp;
  temp:=ScalM(d1,a);
  if temp>0 then
  begin
   d2:=SumV(1,X2,-1,X1);
   if temp<Norma(d2) then PointNearShortLine:=true;
  end;
 end
 else d:=temp;
end;

procedure ShortCrossPoligon(x1,x2,a : Vektor; Polygon : TList; var error : byte; var X : Vektor); //выч точку пересечения отрезка [х1,х2] с направляющим ортом а и многоугльника Polygon, возвращает error=0 если есть точка пересечения и ее координаты в х error=1 - первые 3 точки многоугольника лежат на одной прямой error=2 - нет пересечения
var p1,p2,p3 : PVektor;
    v1,v2,v3,n : Vektor;
    temp : real;
    i : byte;
begin
 error:=0;
 p1:=Polygon.Items[0];
 p2:=Polygon.Items[1];
 p3:=Polygon.Items[2];
 v1:=p1^;
 v2:=SumV(1,p2^,-1,v1);
 v3:=SumV(1,p3^,-1,v1);
 v2:=VektorM(v2,v3);
 temp:=Norma(v2);
 if temp=0 then
 begin
  error:=1;
  exit;
 end
 else n:=aV(1/temp,v2);
 v2:=SumV(1,x1,-1,v1);
 v3:=SumV(1,x2,-1,v1);
 if ScalM(v2,n)*ScalM(v3,n)>0 then
 begin
  error:=2;
  exit;
 end;
 temp:=ScalM(a,n);
 if temp=0 then
 begin
  x:=x1;
  exit;
 end;
 if temp<0 then
 begin
  temp:=-temp;
  n:=aV(-1,n);
 end;
 temp:=ScalM(SumV(1,v1,-1,x1),n)/temp;
 x:=SumV(1,x1,temp,a);
 for i:=0 to Polygon.Count-1 do
 begin
  p1:=Polygon.Items[i];
  if i=Polygon.Count-1 then p2:=Polygon.Items[0]
                       else p2:=Polygon.Items[i+1];
  v1:=SumV(1,p1^,-1,x);
  v2:=SumV(1,p2^,-1,x);
  v3:=VektorM(v1,v2);
  if i=0 then n:=v3 else
  if ScalM(n,v3)<0 then
  begin
   error:=2;
   exit;
  end;
 end;
end;

function Angels2MatrixRotate(Tang : Vektor) : Matrix;  {возвращает матрицу поворота по углам наклона}
var  Mr : Matrix;
     sinx,cosx,siny,cosy,sinh,cosh : real;
begin
 sinx:=sin(Tang.X);
 cosx:=cos(Tang.X);
 siny:=sin(Tang.Y);
 cosy:=cos(Tang.Y);
 sinh:=sin(Tang.H);
 cosh:=cos(Tang.H);
 Mr[1,1]:=cosy*cosh-siny*sinx*sinh;
 Mr[2,1]:=cosy*sinh+siny*sinx*cosh;
 Mr[3,1]:=-siny*cosx;
 Mr[1,2]:=-cosx*sinh;
 Mr[2,2]:=cosx*cosh;
 Mr[3,2]:=sinx;
 Mr[1,3]:=siny*cosh+cosy*sinx*sinh;
 Mr[2,3]:=siny*sinh-cosy*sinx*cosh;
 Mr[3,3]:=cosy*cosx;
 Angels2MatrixRotate:=Mr;
end;

function Angels2XYZ(Tang : Vektor) : TXYZ;  {возвращает локальную систему координат по углам наклона}
var  Mr : Matrix;
     XYZ : TXYZ;
begin
 Mr:=Angels2MatrixRotate(Tang);
 XYZ.VForward.X:=Mr[1,1];
 XYZ.VForward.Y:=Mr[2,1];
 XYZ.VForward.H:=Mr[3,1];
 XYZ.Theard.X:=Mr[1,2];
 XYZ.Theard.Y:=Mr[2,2];
 XYZ.Theard.H:=Mr[3,2];
 XYZ.Normal.X:=Mr[1,3];
 XYZ.Normal.Y:=Mr[2,3];
 XYZ.Normal.H:=Mr[3,3];
 Angels2XYZ:=XYZ;
end;

function Angels2Forward(Tang : Vektor) : Vektor;  {возвращает орт локальной системы координат направленный вперед по углам наклона}
var sinx,cosx,siny,cosy,sinh,cosh : real;
begin
 sinx:=sin(Tang.X);
 cosx:=cos(Tang.X);
 siny:=sin(Tang.Y);
 cosy:=cos(Tang.Y);
 sinh:=sin(Tang.H);
 cosh:=cos(Tang.H);
 Angels2Forward.X:=cosy*cosh-siny*sinx*sinh;
 Angels2Forward.Y:=cosy*sinh+siny*sinx*cosh;
 Angels2Forward.H:=-siny*cosx;
end;

procedure RotateXYZ(Tang : real; N : byte; var XYZ : TXYZ );  {поворачивает локальную систему координат на угол Tang вокруг оси номер N}
var  v1,v2 : Vektor;
     sinx,cosx : real;
begin
 if not N in [1,2,3] then exit;
 sinx:=sin(Tang);
 cosx:=cos(Tang);
 case N of
 1: begin
     v1.X:=0;
     v1.Y:=cosx;
     v1.H:=sinx;
     v2.X:=0;
     v2.Y:=-sinx;
     v2.H:=cosx;
    end;
 2: begin
     v1.X:=sinx;
     v1.Y:=0;
     v1.H:=cosx;
     v2.X:=cosx;
     v2.Y:=0;
     v2.H:=-sinx;
    end;
 3: begin
     v1.X:=cosx;
     v1.Y:=sinx;
     v1.H:=0;
     v2.X:=-sinx;
     v2.Y:=cosx;
     v2.H:=0;
    end;
  end;
  v1:=Loc2Glob(v1,XYZ);
  v2:=Loc2Glob(v2,XYZ);
 case N of
 1: begin
     XYZ.Theard:=v1;
     XYZ.Normal:=v2;
    end;
 2: begin
     XYZ.Normal:=v1;
     XYZ.VForward:=v2;
    end;
 3: begin
     XYZ.VForward:=v1;
     XYZ.Theard:=v2;
    end;
  end;
end;

function Loc2Glob(x : Vektor; XYZ : TXYZ) : Vektor; {перевод из локальных координат в глобальные}
var tempV : Vektor;
begin
  tempV:=SumV(x.X,XYZ.VForward,x.Y,XYZ.Theard);
  Loc2Glob:=SumV(1,tempV,x.H,XYZ.Normal);
end;

function Glob2Loc(x : Vektor; XYZ : TXYZ) : Vektor; {перевод из глобальных координат в локальные}
begin
 Glob2Loc.X:=ScalM(x,XYZ.VForward);
 Glob2Loc.Y:=ScalM(x,XYZ.Theard);
 Glob2Loc.H:=ScalM(x,XYZ.Normal);
end;

function GetDir(x1,x2 : koord) : koord;
var temp : koord;
    a : real;
begin
 temp.X:=x2.X-x1.X;
 temp.Y:=x2.Y-x1.Y;
 a:=sqrt(temp.X*temp.X+temp.Y*temp.Y);
 if a=0 then
 begin
  temp.X:=0;
  temp.Y:=0;
 end
 else
 begin
  temp.X:=temp.X/a;
  temp.Y:=temp.Y/a;
 end;
 GetDir:=temp;
end;

function GetDirOrt(x1,x2 : Vektor) : Vektor; //вычисление орта направленного из x1 в x2
var temp : Vektor;
    a : real;
begin
 temp.X:=x2.X-x1.X;
 temp.Y:=x2.Y-x1.Y;
 temp.H:=x2.H-x1.H;
 a:=sqrt(temp.X*temp.X+temp.Y*temp.Y+temp.H*temp.H);
 if a=0 then
 begin
  temp.X:=0;
  temp.Y:=0;
  temp.H:=0;
 end
 else
 begin
  temp.X:=temp.X/a;
  temp.Y:=temp.Y/a;
  temp.H:=temp.Y/a;
 end;
 GetDirOrt:=temp;
end;

procedure Line_2D(x1,x2,y1,y2 : real; var a,b,c : real); //уравнение прямой на плоскости через 2 точки
var dx,dy : real;
begin
 a:=0;
 b:=0;
 c:=0;
 dx:=x2-x1;
 dy:=y2-y1;
 if ((dx=0) and (dy<>0)) then
 begin
  b:=0;
  a:=1;
  c:=-x1;
 end;
 if ((dx<>0) and (dy=0)) then
 begin
  b:=1;
  a:=0;
  c:=-y1;
 end;
 if ((dx<>0) and (dy<>0)) then
 begin
  b:=-1/dy;
  a:=1/dx;
  c:=y1/dy-x1/dx;
 end;
end;

function D_Point_To_Line_2D(x,y,a,b,c : real) : real; //возвращает расстояние от точки до прямой на плоскости
begin
 D_Point_To_Line_2D:=abs(a*x+b*y+c)/sqrt(a*a+b*b);
end;

end.
