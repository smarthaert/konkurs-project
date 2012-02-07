unit UnDinam;    // Вся динамика полета 

interface

uses
    Math, classes,
    Graphics, UnGeom;

const
G = 10;               {ускорение свободного падения}
L_Step = 5;           {шаг координатной сетки}
L_dStep = 0.1;        {шаг дополнительной координатной сетки}
MASHT_RIS_M=10;       // Коэффициент пересчета сколько в одном метре оконных точек
NUM_CTRL_POINTS=10;   //Кол-во контрольных точек на участке траектории за один шаг
MAX_DIN_OBJ_R = 50;   {радиус максимального передвижного объекта на трассе}

type

TXYZ = record        {правая тройка ортов}
          Normal     : Vektor;  {вектор нормали}
          VForward   : Vektor;  {вектор, перпендикулярный нормали, направленный вперед}
          Theard     : Vektor;  {третий вектор перпендикулярный первым двум}
       end;

TChanal = record     {характеристики каналов управления 2-тангаж 1-курс}
           Vizir    : Vektor;{орт плоскости визирования}
           dX       : real;  {расстояние от снаряда до плоскости визирования}
           Vn       : real;  {скорость приближения снаряда к плоскости визирования}
           M_upr    : real;  {управляющий момент}
          end;

TMissile = class (TObject)
{текущие параметры}
 Mode       : byte;     {0-в контейнере, 1-воспламенение, 2- I этап полета, 3- II этап полета, 4-срыв сопроваждения 5-упал}
 X          : Vektor;   {координаты м.}
 V          : Vektor;     {скорость м/сек}
 A          : Vektor;   {ускорение м/сек.сек}
 F          : Vektor;     {равнодействующая сил}
 Tang       : Vektor;   {углы рад.}
 Vtang      : Vektor;   {угловые скорости рад/сек}
 ATang      : Vektor;   {угловые ускорения рад/сек/сек}
 M          : Vektor;   {Момент сил}
 M_key      : Vektor;   {управляющий момент}
 PU         : Vektor;   {координаты ПУ}
 Tang_PU    : Vektor;   {углы ПУ}
 Chanals    : array[1..2] of TChanal;
 Patch      : integer; {номер текущего патча}
{постоянные характеристики}
 Massa      : real;     {масса килограммах}
 V0         : real;     {начальная скорость m/s}
 Ft         : real;     {сила тяги}
 Max_M      : real;     {максимальный управляющий момент}
 T_flash    : real;     {время воспламенения порохового заряда}
 T_I_II     : real;     {время стартового участка}
 Iw         : Vektor;   {моменты инерции в кг*м*м}
 Cdrag      : real;     {коэфициент сопротивления воздуха}
 Num_destroy: integer;     // Номер сбитой мишени или дома
 Patch_destroy: integer;   // Патч сбитой мишени или дома
 constructor Init(X0,Tang0 : Vektor);
 destructor Destruct;

 procedure Pusk;
 procedure Start;
 procedure Move(dT : real);  {движение за время dT}

private
 XYZ      : TXYZ;                                   {локальная система координат}
 S        : real;                                   {расстояние от снаряда до ПУ}
 T        : real;                                   {время полета}
 Snar     : Vektor;                                 {вектор направленный от ПУ на снаряд}
 X_Ctrl   : array [1..NUM_CTRL_POINTS] of Vektor;   {координаты м. контрольных точек}
 Step_Ort : Vektor;                                 {орт направления полета на текущем шаге}
 X_Tank   : Vektor;                                 {координаты трехмерной цели}
 XYZ_Tank : TXYZ;                                   {локальная система координат трехмерной цели}
 procedure GetOrts_Snar;                            {вычисление векторов нормали, направляющего и третьего для снаряда}
 procedure GetOrts_PU;                              {вычисление векторов нормали, направляющего и третьего для ПУ}
 procedure GetOrts_Tank(num : byte);                {вычисление векторов нормали, направляющего и третьего для трехмерной цели}
 procedure UprI;
 procedure Upr1II;
 procedure Upr2II;
 function  StandColligion(Step : byte) : boolean;    {расчет коллизий для стационарных объектов}
 function  DinColligion(Step : byte) : boolean;      {расчет коллизий для динамических объектов}
 procedure Calc_Collizion;
 procedure Shut_TargetR(num : byte; var error : byte; var holl : Vektor);   //проверка попадания в плоскую мишень номер num
 procedure Shut_Model(num : byte; var error : byte; var holl : Vektor);     //проверка попадания в объемную мишень номер num
public
 Polygon_4: TList;  //координаты четырехугольной цели
protected
end;

function GetH(Xi,Yi : real) : real;   //////////////////////////////

var
  Missile : TMissile;

implementation

uses
  SysUtils, UnBuild,
  UnOther, main;
/////////////////////////////////////////////////////////////////////////
function CountPatch(Xi,Yi : real) : integer;
var
    a,b : integer;
begin
    a           :=  trunc(Xi/MASHT_RIS_M/Dlina_Patch_X);
    b           :=  trunc(Yi/MASHT_RIS_M/Dlina_Patch_Y);
    CountPatch  :=  b*Col_Patch_X+a+1
end;

{*************Расчёт высот прямоугольника, содержащего точкy X,Y *************}
procedure CountVert(Xi,Yi: real; var h1,h2,h3,h4,L : real);
var
  delta_x,
  delta_y : real;
  a,b,
  index_X,
  index_Y,
  num,i,j : integer;
  HRec    : Pdopy;
begin
  if Xi>=Dlina_Surf_X*10 then Xi:=Dlina_Surf_X*10-0.1;
  if Xi<0 then Xi:=0.1;
  if Yi>=Dlina_Surf_Y*10 then Yi:=Dlina_Surf_Y*10-0.1;
  if Yi<0 then Yi:=0.1;

   i:=Trunc(Xi/L_Step);
   j:=Trunc(Yi/L_Step);
   if coydop[i,j]<>nil then
   begin
    HRec:=coydop[i,j];
    if HRec^.NetType=0 then   //регулярная сетка
    begin
     a:=Trunc((Xi-i*L_Step)*10);
     b:=Trunc((Yi-j*L_Step)*10);
     h1:=HRec^.regular[a+1,b]*MASHT_RIS_M;
     h2:=HRec^.regular[a+1,b+1]*MASHT_RIS_M;
     h3:=HRec^.regular[a,b+1]*MASHT_RIS_M;
     h4:=HRec^.regular[a,b]*MASHT_RIS_M;
     L:=L_dStep;
    end;
    if HRec^.NetType=1 then   //четырехугольная прямая призма
    begin
     L:=0;
     HRec:=coydop[HRec^.BaseX,HRec^.BaseY];
     delta_x:=Xi-HRec^.BaseX*L_Step;
     delta_y:=Yi-HRec^.BaseY*L_Step;
     h1:=HRec^.HBase*MASHT_RIS_M;
     if PointInRect(delta_x,delta_y,HRec^.irregular) then
     h1:=h1+HRec^.HDelta;
    end;
    if HRec^.NetType=2 then   //конус
    begin
     L:=0;
     HRec:=coydop[HRec^.BaseX,HRec^.BaseY];
     delta_x:=Xi-(HRec^.BaseX+0.5)*L_Step;
     delta_y:=Yi-(HRec^.BaseY+0.5)*L_Step;
     delta_x:=Sqrt(delta_x*delta_x+delta_y*delta_y);
     h1:=HRec^.HBase*MASHT_RIS_M;
     if delta_x<HRec^.HDelta then
     h1:=h1-HRec^.HDelta+delta_x;
    end;
   end
   else
   begin
    // Определение номера патча
    a:=trunc(Xi/MASHT_RIS_M/Dlina_Patch_X);
    b:=trunc(Yi/MASHT_RIS_M/Dlina_Patch_Y);
    num:=b*Col_Patch_X+a+1;
    delta_x:=Xi-(Dlina_Patch_X*MASHT_RIS_M*a);  // Определение отступа от начала патча по X
    delta_y:=Yi-(Dlina_Patch_Y*MASHT_RIS_M*b);  // Определение отступа от начала патча по Y
    index_X:=trunc(delta_x/SHAG_X/MASHT_RIS_M);  // Определение номера прямоугольника
    index_Y:=trunc(delta_y/SHAG_Y/MASHT_RIS_M);
    h1:=MASHT_RIS_M*coy[num][index_X+1][index_Y];
    h2:=MASHT_RIS_M*coy[num][index_X+1][index_Y+1];
    h3:=MASHT_RIS_M*coy[num][index_X][index_Y+1];
    h4:=MASHT_RIS_M*coy[num][index_X][index_Y];
    L:=L_Step;
   end;
end;

///////////////////////////////////////////////////////////////////////////////////
function GetH(Xi,Yi : real) : real;
 var
    h1,h2,h3,h4,
    wh,LocX,LocY,L : real;
 begin
   CountVert(Xi,Yi,h1,h2,h3,h4,L);
   if L=0 then wh:=h1 else
   begin
    LocX  :=  Xi-L*Trunc(Xi/L);
    LocY  :=  Yi-L*Trunc(Yi/L);
    if LocX>=LocY then wh :=  h4+(LocX*(h1-h4)+LocY*(h2-h1))/L
                  else wh :=  h4+(LocX*(h2-h3)+LocY*(h3-h4))/L;
   end;
   GetH :=  wh;
 end;

 ///////////////////////////////////////////////////////////////////////////////
function Loc2Glob(x : Vektor; XYZ : TXYZ) : Vektor; {перевод из локальных координат в глобальные}
var
  tempV : Vektor;
begin
  tempV   :=  SumV(x.X,XYZ.VForward,x.Y,XYZ.Theard);
  Loc2Glob:=  SumV(1,tempV,x.H,XYZ.Normal);
end;

///////////////////////////////////////////////////////////////////////////////////
function Glob2Loc(x : Vektor; XYZ : TXYZ) : Vektor; {перевод из глобальных координат в локальные}
begin
 Glob2Loc.X :=  ScalM(x,XYZ.VForward);
 Glob2Loc.Y :=  ScalM(x,XYZ.Theard);
 Glob2Loc.H :=  ScalM(x,XYZ.Normal);
end;
///////////////////////////////////////////////////////////////////////////////
constructor TMissile.Init(X0,Tang0 : Vektor);
var
    i : byte;
    p : pVektor;
begin
 Mode       :=  0;
 X          :=  X0;
 Tang       :=  Tang0;
 GetOrts_Snar;
 V          :=  NulV;     {скорость м/сек}
 F          :=  NulV;
 Vtang      :=  NulV;   {угловые скорости рад/сек}
 M          :=  NulV;   {угловые ускорения рад/сек/сек}
{постоянные характеристики}
 Massa      :=  14.5;     {масса килограммах}
 V0         :=  200;
 Ft         :=  21000;
 Max_M      :=  20;
 T_I_II     := 0.3;
 Iw.X       :=  1;
 Iw.Y       :=  1;
 Iw.H       :=  1;
 Cdrag      :=  0.5;     {коэфициент сопротивления воздуха}
 Polygon_4  :=  TList.Create;
 for i:=0 to 3 do
 begin
  New(p);
  Polygon_4.Add(p);
 end;
end;

///////////////////////////////////////////////////////////////////////////////
destructor TMissile.Destruct;
var
    i : byte;
    p : pVektor;
begin
 for i:=0 to 3 do
 begin
  p :=  Polygon_4.Items[i];
  Dispose(p);
 end;
 Polygon_4.Clear;
 Polygon_4.Free;
end;
///////////////////////////////////////////////////////////////////////////////
procedure TMissile.GetOrts_Snar;     {вычисление векторов нормали, направляющего и третьего для снаряда}
var
  siny,
  cosy,
  sinh,
  cosh : real;
begin
 siny           :=  sin(Tang.Y);
 cosy           :=  cos(Tang.Y);
 sinh           :=  sin(Tang.H);
 cosh           :=  cos(Tang.H);
 XYZ.VForward.X :=  cosy*cosh;
 XYZ.VForward.Y :=  cosy*sinh;
 XYZ.VForward.H :=  siny;
 XYZ.Theard.X   :=  -sinh;
 XYZ.Theard.Y   :=  cosh;
 XYZ.Theard.H   :=  0;
// XYZ.Normal:=VektorM(XYZ.Theard,XYZ.VForward);
 XYZ.Normal     :=  VektorM(XYZ.VForward,XYZ.Theard);
end;
////////////////////////////////////////////////////////////////////////////////
procedure TMissile.GetOrts_PU;     {вычисление векторов нормали, направляющего и третьего}
var
  siny,
  cosy,
  sinh,
  cosh : real;
  temp : Vektor;
begin
 siny               :=  sin(Tang_PU.Y);
 cosy               :=  cos(Tang_PU.Y);
 sinh               :=  sin(Tang_PU.H);
 cosh               :=  cos(Tang_PU.H);
 Chanals[1].Vizir.X :=  -sinh;
 Chanals[1].Vizir.Y :=  cosh;
 Chanals[1].Vizir.H :=  0;
 temp.X             :=  cosh*cosy;
 temp.Y             :=  sinh*cosy;
 temp.H             :=  siny;
 Chanals[2].Vizir   :=  VektorM(temp,Chanals[1].Vizir);
 Chanals[2].Vizir   :=  NormV(Chanals[2].Vizir);
end;
////////////////////////////////////////////////////////////////////////////////
procedure TMissile.GetOrts_Tank(num : byte);     {вычисление векторов нормали, направляющего и третьего для трехмерной цели}
var  sinx,cosx,siny,cosy,sinh,cosh : real;
     temp : Vektor;
begin
 temp.X:=-Model[num].Kren/57.3;
 temp.Y:=-Model[num].UmBase/57.3;
 temp.H:=(90-Model[num].AzBase)/57.3;
 sinx:=sin(temp.X);
 cosx:=cos(temp.X);
 siny:=sin(temp.Y);
 cosy:=cos(temp.Y);
 sinh:=sin(temp.H);
 cosh:=cos(temp.H);
 XYZ_Tank.VForward.X:=cosy*cosh-siny*sinx*sinh;
 XYZ_Tank.VForward.Y:=cosy*sinh+siny*sinx*cosh;
 XYZ_Tank.VForward.H:=-siny*cosx;
 XYZ_Tank.Theard.X:=-cosx*sinh;
 XYZ_Tank.Theard.Y:=cosx*cosh;
 XYZ_Tank.Theard.H:=sinx;
 XYZ_Tank.Normal.X:=siny*cosh+cosy*sinx*sinh;
 XYZ_Tank.Normal.Y:=siny*sinh-cosy*sinx*cosh;
 XYZ_Tank.Normal.H:=cosy*cosx;
end;

//////////// Пуск ракеты //////////////
procedure TMissile.Pusk;          {Mode=0-в контейнере}{ 4-срыв сопроваждения 5-упал}
begin
 if Mode=0 then
 begin
  Mode    :=  1;              {Mode= 1-воспламенение,}
  T_flash :=  0.1;
 end;
end;

////////////////////////////////////
procedure TMissile.Start;
var
  temp : Vektor;
begin
 if Mode=1 then
 begin
  Mode    :=  2;                      {Mode= 2- I этап полета}
  temp.X  :=  V0;
  temp.Y  :=  0;
  temp.H  :=  0;
  Tang.Y  :=  Tang_PU.Y+0.12;
  GetOrts_Snar;
  V       :=  Loc2Glob(temp,XYZ);
  PU      :=  X;                                      
  S       :=  0;
  T       :=  0;
 end;
end;
{-------------------------------------------------------------------------------}
//////////////////////////  УПРАВЛЯЕМЫЙ ПОЛЕТ/////////////////////////////////////////////
procedure TMissile.UprI;
begin
  if T < T_I_II then Chanals[2].M_upr :=  -Max_M else Chanals[2].M_upr  :=  Max_M;
  if (T > T_I_II) and (Chanals[2].dX  < 1) then
  begin
   Mode             :=  3;                           {Mode= 3- II этап полета,}
   Chanals[2].M_upr :=  0;
  end;
end;

procedure TMissile.Upr1II;
begin
  Chanals[1].M_upr  :=  -(Chanals[1].dX+0.2*Chanals[1].Vn);
  if Chanals[1].M_upr > 0 then Chanals[1].M_upr :=  Max_M/6;
  if Chanals[1].M_upr < 0 then Chanals[1].M_upr :=  -Max_M/6.2;
end;

procedure TMissile.Upr2II;
begin
  Chanals[2].M_upr  :=  -(Chanals[2].dX+0.2*Chanals[2].Vn);
  if Chanals[2].M_upr > 0 then Chanals[2].M_upr :=  Max_M/4;
  if Chanals[2].M_upr < 0 then Chanals[2].M_upr :=  -Max_M/6;
end;
{-------------------------------------------------------------------------------}
procedure TMissile.Move(dT : real);  {движение за время dT}
var
    Fdrag,
    Vloc,
    temp  : Vektor;
    ss    : string;
    i     : byte;
begin
  if Mode<5 then
    begin
      GetOrts_Snar;
      GetOrts_PU;
      if Mode = 1 then
        begin
          T_flash :=  T_flash-dT;
          if T_flash<0 then Start;
        end;
      if Mode in [2,3] then
        begin
          T     :=  T+dT;
          Snar  :=  SumV(1,X,-1,PU);
          S     :=  Norma(Snar);
        if S>4000 then Mode:=5;
        for i:=1 to 2 do
          begin
            Chanals[i].dX :=  ScalM(Snar,Chanals[i].Vizir);
            Chanals[i].Vn :=  ScalM(V,Chanals[i].Vizir);
          end;
         case Mode of
           2 : UprI;
           3 : Upr2II;
         end;
      Upr1II;
      M_key.X :=  0;
      M_key.Y :=  Chanals[2].M_upr;
      M_key.H :=  Chanals[1].M_upr;
      F       :=  NulV;
      Fdrag   :=  aV(-Cdrag*Norma(V),V);
      F       :=  SumV(1,F,1,Fdrag);
      Vloc    :=  Glob2Loc(V,XYZ);
      temp    :=  NulV;
      temp.X  :=  1;
      M       :=  VektorM(temp,Vloc);
      M.Y     :=  -M.Y;
      temp.X  :=  Ft;
      temp    :=  Loc2Glob(temp,XYZ);
      F       :=  SumV(1,F,1,temp);
      M       :=  SumV(1,M,1,M_key);
      A       :=  aV(1/Massa,F);
      ATang   :=  DivV(M,Iw);

    end;
      V         :=  SumV(1,V,dT,A);
      X_Ctrl[1] :=  X;
      X         :=  SumV(1,X,dT,V);
      X_Ctrl[NUM_CTRL_POINTS]:=X;
      Patch     :=  CountPatch(X.X,X.Y);
      VTang     :=  SumV(1,VTang,dT,ATang);
      Tang      :=  SumV(1,Tang,dT,VTang);
 if Mode in [2,3,4] then Calc_Collizion;
  end;
end;

{-------------------------------------------------------------------------------}

function TMissile.StandColligion(Step : byte) : boolean; {расчет коллизий для стационарных объектов}
var  i,j,ii,jj,k : integer;
     p : PMestnik;
     pp : pkoord;
     point : koord;
     temp : boolean;
begin
      StandColligion:=false;
      for i:= -1 to 1 do
      for j:= -1 to 1 do
      begin
       k  :=  Patch+i*Col_Patch_X+j;
       ii :=  Patch div Col_Patch_X;
       jj :=  k div Col_Patch_X;
       if ((abs(ii-jj)<2) and (k>0) and (k<=Col_Patch)) then
       if Mestniks[k]<>nil then
       for ii:=0 to Mestniks[k].Count-1 do
       begin
        p:=Mestniks[k].Items[ii];
        if ((p^.Type_Action>0) and (p^.Az_Paden=-1)) then
        begin
         temp:=false;
         pp:=p^.Curver.Items[0];
         point.X:=pp^.X*MASHT_RIS_M;
         point.Y:=pp^.Y*MASHT_RIS_M;
         case p^.Type_Objekt of
{точка}        1: if ((Abs(X_Ctrl[Step].X-point.X)<0.6) and (Abs(X_Ctrl[Step].Y-point.Y)<0.6)) then temp:=true;
{окружность}   2: if PointInCircl(X_Ctrl[Step].X/MASHT_RIS_M,X_Ctrl[Step].Y/MASHT_RIS_M,p^.Curver) then temp:=true;
{прямоугольник}3: if PointInRect(X_Ctrl[Step].X/MASHT_RIS_M,X_Ctrl[Step].Y/MASHT_RIS_M,p^.Curver) then temp:=true;
{отрезок}      4: if CrossLine(X_Ctrl[Step-1].X/MASHT_RIS_M,X_Ctrl[Step-1].Y/MASHT_RIS_M,X_Ctrl[Step].X/MASHT_RIS_M,X_Ctrl[Step].Y/MASHT_RIS_M,p^.Curver) then temp:=true;
         end;
         if temp then
         begin
          StandColligion:=true;
          Patch_Destroy:=k;
          Num_Destroy:=ii;
         end;
        end;
       end;
      end;
end;

function TMissile.DinColligion(Step : byte) : boolean; {расчет коллизий для динамических объектов}
var ii : byte;
     p : PMestnik;
     pp : pkoord;
     point : koord;
     temp : boolean;
begin
      DinColligion:=false;
      if DinamicObj<>nil then
      if DinamicObj.Count>0 then
      for ii:=0 to DinamicObj.Count-1 do
      begin
       p:=DinamicObj.Items[ii];
       if ((Abs(p^.X-X.X/MASHT_RIS_M)<MAX_DIN_OBJ_R) or (Abs(p^.Y-X.Y/MASHT_RIS_M)<MAX_DIN_OBJ_R)) then
       begin
        pp:=p^.Curver.Items[0];
        point.X:=pp^.X*MASHT_RIS_M;
        point.Y:=pp^.Y*MASHT_RIS_M;
        case p^.Type_Objekt of
{точка}        1: if ((Abs(X_Ctrl[Step].X-point.X)<0.6) and (Abs(X_Ctrl[Step].Y-point.Y)<0.6)) then temp:=true;
{окружность}   2: if PointInCircl(X_Ctrl[Step].X/MASHT_RIS_M,X_Ctrl[Step].Y/MASHT_RIS_M,p^.Curver) then temp:=true;
{прямоугольник}3: if PointInRect(X_Ctrl[Step].X/MASHT_RIS_M,X_Ctrl[Step].Y/MASHT_RIS_M,p^.Curver) then temp:=true;
{отрезок}      4: if CrossLine(X_Ctrl[Step-1].X/MASHT_RIS_M,X_Ctrl[Step-1].Y/MASHT_RIS_M,X_Ctrl[Step].X/MASHT_RIS_M,X_Ctrl[Step].Y/MASHT_RIS_M,p^.Curver) then temp:=true;
        end;
        if temp then DinColligion:=true;
       end;
      end;
end;

procedure TMissile.Shut_TargetR(num : byte; var error : byte; var holl : Vektor);  //проверка попадания в плоскую мишень номер num
var    p : pVektor;
begin
  error:=2;
  if ((Abs(X_Ctrl[NUM_CTRL_POINTS].X-TargetR[num].Xtek[Num_BMP,0]*10)<6) and
      (Abs(X_Ctrl[NUM_CTRL_POINTS].Y-TargetR[num].ytek[Num_BMP,0]*10)<6)) OR
      ((Abs(X_Ctrl[1].X-TargetR[num].Xtek[Num_BMP,0]*10)<6) and
       (Abs(X_Ctrl[1].Y-TargetR[num].ytek[Num_BMP,0]*10)<6)) then
  begin
   p:=Polygon_4.Items[0];
   p^.X:=(TargetR[num].Xtek[Num_BMP,0]-X_Targ[num])*10;
   p^.Y:=TargetR[num].Ytek[Num_BMP,0]*10;
   p^.H:=TargetR[num].Htek[Num_BMP,0]*10;
   p:=Polygon_4.Items[1];
   p^.X:=(TargetR[num].Xtek[Num_BMP,0]+X_Targ[num])*10;
   p^.Y:=TargetR[num].Ytek[Num_BMP,0]*10;
   p^.H:=TargetR[num].Htek[Num_BMP,0]*10;
   p:=Polygon_4.Items[2];
   p^.X:=(TargetR[num].Xtek[Num_BMP,0]+X_Targ[num])*10;
   p^.Y:=TargetR[num].Ytek[Num_BMP,0]*10;
   p^.H:=(TargetR[num].Htek[Num_BMP,0]+H_Targ[num])*10;
   p:=Polygon_4.Items[3];
   p^.X:=(TargetR[num].Xtek[Num_BMP,0]-X_Targ[num])*10;
   p^.Y:=TargetR[num].Ytek[Num_BMP,0]*10;
   p^.H:=(TargetR[num].Htek[Num_BMP,0]+H_Targ[num])*10;
   ShortCrossPoligon(X_Ctrl[1],X_Ctrl[NUM_CTRL_POINTS],Step_Ort,Polygon_4,error,holl);
   if error=0 then
   begin
//    Form1.Label98.Caption:=IntToStr(num)+'  '+floattostr(holl.H);
    Mode:=6;
    Num_destroy:=num;
    exit;
   end
   else
   begin
//    Form1.Label98.Caption:=IntToStr(error);
    error:=2;
   end;
  end;
end;

procedure TMissile.Shut_Model(num : byte; var error : byte; var holl : Vektor);  //проверка попадания в объемную мишень номер num
type THoll = record
              X : Vektor;
              kub,gran : byte;
             end;
var d,temp,d_min   : real;
    i,j,k,n_holl : byte;
    coners : array [1..4] of Vektor;
    X1,X2,dX : Vektor;
    sig : integer;
    p : pVektor;
    holls : array [1..4] of THoll;
    num_holls : byte;
    s : string;
begin
  error:=2;
  X_Tank.X:=Model[num].Xtek*10;
  X_Tank.Y:=Model[num].Ytek*10;
  X_Tank.H:=Model[num].Htek*10;
  d:=6;
  if PointNearPoint(X_Ctrl[1],X_Tank,d) OR PointNearPoint(X_Ctrl[NUM_CTRL_POINTS],X_Tank,d) then
  begin
   GetOrts_Tank(num);
   num_holls:=0;
   for i:=1 to 2 do  //номер паралелепипеда
   begin
    X1.X:=Box_Tank[Model[num].Typ,i].x1_box*10;
    X1.Y:=Box_Tank[Model[num].Typ,i].y1_box*10;
    X1.H:=Box_Tank[Model[num].Typ,i].h1_box*10;
    X2.X:=Box_Tank[Model[num].Typ,i].x2_box*10;
    X2.Y:=Box_Tank[Model[num].Typ,i].y2_box*10;
    X2.H:=Box_Tank[Model[num].Typ,i].h2_box*10;
    dX:=SumV(1,X2,-1,X1);
    for j:=1 to 6 do  //номер грани
    begin
     if j<4 then
     begin
      for k:=1 to 4 do coners[k]:=X1;
      sig:=1;
     end
     else
     begin
      for k:=1 to 4 do coners[k]:=X2;
      sig:=-1;
     end;
     case j of
     1,4: begin
           coners[2].X:=coners[1].X+sig*dX.X;
           coners[3].X:=coners[1].X+sig*dX.X;
           coners[3].Y:=coners[1].Y+sig*dX.Y;
           coners[4].Y:=coners[1].Y+sig*dX.Y;
          end;
     2,5: begin
           coners[2].X:=coners[1].X+sig*dX.X;
           coners[3].X:=coners[1].X+sig*dX.X;
           coners[3].H:=coners[1].H+sig*dX.H;
           coners[4].H:=coners[1].H+sig*dX.H;
          end;
     3,6: begin
           coners[2].Y:=coners[1].Y+sig*dX.Y;
           coners[3].Y:=coners[1].Y+sig*dX.Y;
           coners[3].H:=coners[1].H+sig*dX.H;
           coners[4].H:=coners[1].H+sig*dX.H;
          end;
     end;
     for k:=1 to 4 do
     begin
      p:=Polygon_4.Items[k-1];
      p^:=SumV(1,X_Tank,-coners[k].X,XYZ_Tank.VForward);
      p^:=SumV(1,p^,coners[k].Y,XYZ_Tank.Theard);
      p^:=SumV(1,p^,coners[k].H,XYZ_Tank.Normal);
     end;
     ShortCrossPoligon(X_Ctrl[1],X_Ctrl[NUM_CTRL_POINTS],Step_Ort,Polygon_4,error,holl);
     if error=0 then
     begin
      Inc(num_holls);
      holls[num_holls].X:=holl;
      holls[num_holls].kub:=i;
      holls[num_holls].gran:=j;
      Num_destroy:=num;
      Mode:=7;
     end;
    end;
   end;
   if num_holls>0 then
   begin
    d_min:=1e5;
    for k:=1 to num_holls do
    begin
     temp:=Norma(SumV(1,holls[k].X,-1,X_Ctrl[1]));
     if temp<d_min then
     begin
      d_min:=temp;
      n_holl:=k;
      holl:=holls[k].X;
     end;
    end;
    holl:=holls[n_holl].X;
    str(holl.H:2:1,s);
//    Form1.Label98.Caption:=IntToStr(num)+' '+IntToStr(holls[n_holl].kub)+' '+IntToStr(holls[n_holl].gran)+'  '+s;
    str(X_Tank.H:2:1,s);
//    Form1.Label98.Caption:=Form1.Label98.Caption+'  '+s;
   end;
  end
  else
  error:=2;
end;

procedure TMissile.Calc_Collizion;
var Step_V,holl : Vektor;
    Step_L,temp : real;
    i,j : byte;
    error : byte;
begin
 Step_V:=SumV(1,X_Ctrl[NUM_CTRL_POINTS],-1,X_Ctrl[1]);
 Step_L:=Norma(Step_V);
 if Step_L>0 then
 begin
  //заполнение массива контрольных точек
  Step_Ort:=aV(1/Step_L,Step_V);   //орт отрезка траектории
  Step_V:=aV(Step_L/NUM_CTRL_POINTS,Step_Ort);
  for i:=2 to NUM_CTRL_POINTS-1 do
  X_Ctrl[i]:=SumV(1,X_Ctrl[i-1],1,Step_V);
   
  for j:=1 to 10 do                                         //проверка на столкновение с плоскими мишенями
  if Angle_Paden[Num_BMP,j]>ANGL_PADEN then
  begin
   Shut_TargetR(j,error,holl);
   if error=0 then X:=holl;
  end;
  
  for j:=1 to COL_MAX_OBJEKT_TAK_TEX do                     //проверка на столкновение с паралелепипедами танков бмп и тд
  if Model[j].Typ>0 then
  begin
   Shut_Model(j,error,holl);
   if error=0 then X:=holl;
  end;
  
  for i:=2 to NUM_CTRL_POINTS do                           //проверка на столкновение с поверхностью земли,стационарными и динамическими объектами
  begin
   if (X_Ctrl[i].H<=GetH(X_Ctrl[i].X,X_Ctrl[i].Y)+0.1) then
   begin
    X:=X_Ctrl[i];
    Mode:=5;
    exit;
   end;
   if StandColligion(i){ or DinColligion(i)} then
   begin
    X:=X_Ctrl[i];
    Mode:=7;
    exit;
   end;
  end;
 end;
end;

end.

