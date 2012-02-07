unit UnMissile;

interface

uses
  Math, classes,
  Graphics, UnGeom,
  UnBuildSetka,
  UnBuildKoordObject;

const
G               = 10;             {��������� ���������� �������}
L_Step          = 5;         {��� ������������ �����}
L_dStep         = 0.1;      {��� �������������� ������������ �����}
MASHT_RIS_M     = 10;       // ����������� ��������� ������� � ����� ����� ������� �����
NUM_CTRL_POINTS = 10;   //���-�� ����������� ����� �� ������� ���������� �� ���� ���
MAX_DIN_OBJ_R   = 50;     {������ ������������� ������������ ������� �� ������}

type

TChanal = record     {�������������� ������� ���������� 2-������ 1-����}
           Vizir    : Vektor;{��� ��������� �����������}
           dX       : real;  {���������� �� ������� �� ��������� �����������}
           Vn       : real;  {�������� ����������� ������� � ��������� �����������}
           M_upr    : real;  {����������� ������}
          end;

TMissile = class (TObject)
{������� ���������}
 Mode       : byte;     {0-� ����������, 1-�������������, 2- I ���� ������, 3- II ���� ������, 4-���� ������������� 5-����}
 X          : Vektor;   {���������� �.}
 V          : Vektor;     {�������� �/���}
 A          : Vektor;   {��������� �/���.���}
 F          : Vektor;     {���������������� ���}
 Tang       : Vektor;   {���� ���.}
 Vtang      : Vektor;   {������� �������� ���/���}
 ATang      : Vektor;   {������� ��������� ���/���/���}
 M          : Vektor;   {������ ���}
 M_key      : Vektor;   {����������� ������}
 PU         : Vektor;   {���������� ��}
 Chanals    : array[1..2] of TChanal;
 Patch      : integer; {����� �������� �����}
 otkaz      : array[1..8] of boolean; {�������������}
{���������� ��������������}
 Massa      : real;     {����� �����������}
 V0         : real;     {��������� �������� m/s}
 Ft         : real;     {���� ����}
 Max_M      : real;     {������������ ����������� ������}
 T_flash    : real;     {����� ������������� ���������� ������}
 T_I_II     : real;     {����� ���������� �������}
 Iw         : Vektor;   {������� ������� � ��*�*�}
 Cdrag      : real;     {���������� ������������� �������}
 Num_destroy: integer;     // ����� ������ ������ ��� ����
 Patch_destroy: integer;   // ���� ������ ������ ��� ����

 constructor Init(X0,Tang0 : Vektor);

 destructor Destruct;

 procedure InitPosition(X0,Tang0 : Vektor);
 procedure Pusk;
 procedure Start;
 procedure Move(dT : real);  {�������� �� ����� dT}

private
 XYZ      : TXYZ;             {��������� ������� ���������}
 S        : real;             {���������� �� ������� �� ��}
 T        : real;             {����� ������}
 Snar     : Vektor;           {������ ������������ �� �� �� ������}
 X_Ctrl   : array [1..NUM_CTRL_POINTS] of Vektor;   {���������� �. ����������� �����}
 Step_Ort : Vektor;           {��� ����������� ������ �� ������� ����}
 X_Tank   : Vektor;           {���������� ���������� ����}
 XYZ_Tank : TXYZ;             {��������� ������� ��������� ���������� ����}
 procedure GetOrts_Tank(num : byte);     {���������� �������� �������, ������������� � �������� ��� ���������� ����}
 procedure UprI;
 procedure Upr1II;
 procedure Upr2II;
 function  StandColligion(Step : byte) : boolean; {������ �������� ��� ������������ ��������}
 function  DinColligion(Step : byte) : boolean;   {������ �������� ��� ������������ ��������}
 procedure Calc_Collizion;
 procedure Shut_TargetR(num : byte; var error : byte; var holl : Vektor);   //�������� ��������� � ������� ������ ����� num
 procedure Shut_Model(num : byte; var error : byte; var holl : Vektor);     //�������� ��������� � �������� ������ ����� num
public
 Polygon_4: TList;    //���������� ��������������� ����
protected
end;


var Missile : TMissile;

implementation
uses SysUtils, UnBuildServer, UnOther, main, UnOrgan;

constructor TMissile.Init(X0,Tang0 : Vektor);
var i : byte;
    p : pVektor;
begin
 Mode       :=  0;
 X          :=  X0;
 Tang       :=  Tang0;
 XYZ        :=  Angels2XYZ(Tang);
 V          :=  NulV;     {�������� �/���}
 F          :=  NulV;
 Vtang      :=  NulV;   {������� �������� ���/���}
 M          :=  NulV;   {������� ��������� ���/���/���}
{���������� ��������������}
 Massa      :=  14.5;     {����� �����������}
 V0         :=  400;
 Ft         :=  8000;
 Max_M      :=  1.5;
 T_I_II     :=  0.0;
 Iw.X       :=  0.3;
 Iw.Y       :=  0.3;
 Iw.H       :=  0.3;
 Cdrag      :=  0.2;     {���������� ������������� �������}
 Polygon_4  :=  TList.Create;
 for i:=0 to 3 do
 begin
  New(p);
  Polygon_4.Add(p);
 end;
end;

destructor TMissile.Destruct;
var i : byte;
    p : pVektor;
begin
 for i:=0 to 3 do
 begin
  p:=Polygon_4.Items[i];
  Dispose(p);
 end;
 Polygon_4.Clear;
 Polygon_4.Free;
end;

procedure TMissile.GetOrts_Tank(num : byte);     {���������� �������� �������, ������������� � �������� ��� ���������� ����}
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

procedure TMissile.Pusk;
begin
 if (Mode=0) and not Missile.otkaz[STARTER] then
 begin
  Mode:=1;
  T_flash:=0.1;
  V:=NulV;
  VTang:=NulV;
  A:=NulV;
  ATang:=NulV;
 end;
end;

procedure TMissile.Start;
var temp,temp2 : Vektor;
    a : real;
begin
 if Mode=1 then
 begin
  Mode:=2;
  temp:=VektorM(Chanals[1].Vizir,Chanals[2].Vizir);
  temp2:=temp;
  temp2.H:=0;
  V:=aV(V0,temp);
  X:=SumV(1,PU,-0.5,Chanals[2].Vizir);
  Tang:=NulV;
  a:=Norma(temp2);
  if a<0.000001 then Tang.Y:=Pi/2 else
  begin
   temp2:=aV(1/a,temp2);
   temp:=VektorM(temp2,temp);
   a:=Norma(temp);
   Tang.Y:=-arcsin(a);
   if temp2.x>0 then Tang.H:=arcsin(temp2.y)
                 else Tang.H:=Pi-arcsin(temp2.y);
  end;
  S:=0;
  T:=0;
 end;
end;

procedure TMissile.UprI;
begin
//  if T<T_I_II then Chanals[2].M_upr:=-Max_M else Chanals[2].M_upr:=Max_M;
//  if (T>T_I_II) and (Chanals[2].dX<1) then
  if not otkaz[ENGINE] then
  begin
   Mode:=3;
   Chanals[2].M_upr:=0;
  end;
end;

procedure TMissile.Upr1II;
begin
  if otkaz[ENGINE] then exit;
  Chanals[1].M_upr:=-(Chanals[1].dX+0.03*Chanals[1].Vn);
  if Chanals[1].M_upr>0 then Chanals[1].M_upr:=Max_M;
  if Chanals[1].M_upr<0 then Chanals[1].M_upr:=-Max_M;
  if otkaz[CAT] then Chanals[1].M_upr:=5*Max_M*(Random-0.5);
end;

procedure TMissile.Upr2II;
begin
  if otkaz[ENGINE] then exit;
  Chanals[2].M_upr:=(Chanals[2].dX+0.03*Chanals[2].Vn);
  if Chanals[2].M_upr>0 then Chanals[2].M_upr:=Max_M;
  if Chanals[2].M_upr<0 then Chanals[2].M_upr:=-Max_M;
  if otkaz[CAT] then Chanals[2].M_upr:=5*Max_M*(Random-0.5);
end;

procedure TMissile.Move(dT : real);  {�������� �� ����� dT}
var Fdrag,Vloc,temp : Vektor;
    ss : string;
    i : byte;
begin
if Mode in [1,2,3,4] then
begin
 if Mode=1 then
 begin
  T_flash:=T_flash-dT;
  if T_flash<0 then Start;
 end;
 XYZ:=Angels2XYZ(Tang);
 if Mode in [2,3] then
 begin
  T:=T+dT;
  Snar:=SumV(1,X,-1,PU);
  S:=Norma(Snar);
  if S>4000 then Mode:=5;
  for i:=1 to 2 do
  begin
   Chanals[i].dX:=ScalM(Snar,Chanals[i].Vizir);
   Chanals[i].Vn:=ScalM(V,Chanals[i].Vizir);
  end;
  if otkaz[IR_GAUGE] then
  begin
   Chanals[1].dx:=0.1;
   Chanals[2].dx:=1;
  end;
  if otkaz[IR_HANDICAP] then
  begin
   Chanals[1].dx:=-0.1;
   Chanals[2].dx:=-1;
  end; 
  case Mode of
  2 : UprI;
  3 : Upr2II;
  end;
  Upr1II;
  M_key.X:=0;
  M_key.Y:=Chanals[2].M_upr;
  M_key.H:=Chanals[1].M_upr;
  F:=NulV;
  if otkaz[ENGINE] then F.H:=-Massa*G;
  if otkaz[CAT] then F.H:=-Massa*G/10;
  Fdrag:=aV(-Cdrag*Norma(V),V);
  F:=SumV(1,F,1,Fdrag);
  Vloc:=Glob2Loc(V,XYZ);
  temp:=NulV;
  temp.X:=1;
  M:=VektorM(temp,Vloc);
  if not otkaz[ENGINE] then temp.X:=Ft;
  temp:=Loc2Glob(temp,XYZ);
  F:=SumV(1,F,1,temp);
  M:=SumV(1,M,1,M_key);
  A:=aV(1/Massa,F);
  ATang:=DivV(M,Iw);
 end;
 V:=SumV(1,V,dT,A);
 X_Ctrl[1]:=X;
 X:=SumV(1,X,dT,V);
 X_Ctrl[NUM_CTRL_POINTS]:=X;
 Patch:=CountPatch(X.X/MASHT_RIS_M,X.Y/MASHT_RIS_M);
 VTang:=SumV(1,VTang,dT,ATang);
 Tang:=SumV(1,Tang,dT,VTang);
 if Mode in [2,3,4] then Calc_Collizion;
end;
end;

function TMissile.StandColligion(Step : byte) : boolean; {������ �������� ��� ������������ ��������}
var  i,j,ii,jj,k : integer;
     p : PMestnik;
     pp : pkoord;
     point : koord;
     temp : boolean;
begin
      StandColligion:=false;
      for i:=-1 to 1 do
      for j:=-1 to 1 do
      begin
       k:=Patch+i*colPatchX+j;
       ii:=Patch div colPatchX;
       jj:=k div colPatchX;
       if ((abs(ii-jj)<2) and (k>0) and (k<=colPatchSurface)) then
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
{�����}        1: if ((Abs(X_Ctrl[Step].X-point.X)<0.6) and (Abs(X_Ctrl[Step].Y-point.Y)<0.6)) then temp:=true;
{����������}   2: if PointInCircl(X_Ctrl[Step].X/MASHT_RIS_M,X_Ctrl[Step].Y/MASHT_RIS_M,p^.Curver) then temp:=true;
{�������������}3: if PointInRect(X_Ctrl[Step].X/MASHT_RIS_M,X_Ctrl[Step].Y/MASHT_RIS_M,p^.Curver) then temp:=true;
{�������}      4: if CrossLine(X_Ctrl[Step-1].X/MASHT_RIS_M,X_Ctrl[Step-1].Y/MASHT_RIS_M,X_Ctrl[Step].X/MASHT_RIS_M,X_Ctrl[Step].Y/MASHT_RIS_M,p^.Curver) then temp:=true;
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

function TMissile.DinColligion(Step : byte) : boolean; {������ �������� ��� ������������ ��������}
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
{�����}        1: if ((Abs(X_Ctrl[Step].X-point.X)<0.6) and (Abs(X_Ctrl[Step].Y-point.Y)<0.6)) then temp:=true;
{����������}   2: if PointInCircl(X_Ctrl[Step].X/MASHT_RIS_M,X_Ctrl[Step].Y/MASHT_RIS_M,p^.Curver) then temp:=true;
{�������������}3: if PointInRect(X_Ctrl[Step].X/MASHT_RIS_M,X_Ctrl[Step].Y/MASHT_RIS_M,p^.Curver) then temp:=true;
{�������}      4: if CrossLine(X_Ctrl[Step-1].X/MASHT_RIS_M,X_Ctrl[Step-1].Y/MASHT_RIS_M,X_Ctrl[Step].X/MASHT_RIS_M,X_Ctrl[Step].Y/MASHT_RIS_M,p^.Curver) then temp:=true;
        end;
        if temp then DinColligion:=true;
       end;
      end;
end;

procedure TMissile.Shut_TargetR(num : byte; var error : byte; var holl : Vektor);  //�������� ��������� � ������� ������ ����� num
var    p : pVektor;
begin
  error:=2;
  if ((Abs(X_Ctrl[NUM_CTRL_POINTS].X-targets[Num_BMP,num].xTek*10)<6) and
      (Abs(X_Ctrl[NUM_CTRL_POINTS].Y-targets[Num_BMP,num].yTek*10)<6)) OR
      ((Abs(X_Ctrl[1].X-targets[Num_BMP,num].xTek*10)<6) and
       (Abs(X_Ctrl[1].Y-targets[Num_BMP,num].yTek*10)<6)) then
  begin
   p:=Polygon_4.Items[0];
   p^.X:=(targets[Num_BMP,num].xTek-X_Targ[num])*10;
   p^.Y:=targets[Num_BMP,num].yTek*10;
   p^.H:=targets[Num_BMP,num].hTek*10;
   p:=Polygon_4.Items[1];
   p^.X:=(targets[Num_BMP,num].xTek+X_Targ[num])*10;
   p^.Y:=targets[Num_BMP,num].yTek*10;
   p^.H:=targets[Num_BMP,num].hTek*10;
   p:=Polygon_4.Items[2];
   p^.X:=(targets[Num_BMP,num].xTek+X_Targ[num])*10;
   p^.Y:=targets[Num_BMP,num].yTek*10;
   p^.H:=(targets[Num_BMP,num].hTek+H_Targ[num])*10;
   p:=Polygon_4.Items[3];
   p^.X:=(targets[Num_BMP,num].xTek-X_Targ[num])*10;
   p^.Y:=targets[Num_BMP,num].yTek*10;
   p^.H:=(targets[Num_BMP,num].hTek+H_Targ[num])*10;
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

procedure TMissile.Shut_Model(num : byte; var error : byte; var holl : Vektor);  //�������� ��������� � �������� ������ ����� num
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
   for i:=1 to 2 do  //����� ��������������
   begin
    X1.X:=Box_Tank[Model[num].Typ,i].x1_box*10;
    X1.Y:=Box_Tank[Model[num].Typ,i].y1_box*10;
    X1.H:=Box_Tank[Model[num].Typ,i].h1_box*10;
    X2.X:=Box_Tank[Model[num].Typ,i].x2_box*10;
    X2.Y:=Box_Tank[Model[num].Typ,i].y2_box*10;
    X2.H:=Box_Tank[Model[num].Typ,i].h2_box*10;
    dX:=SumV(1,X2,-1,X1);
    for j:=1 to 6 do  //����� �����
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
  //���������� ������� ����������� �����
  Step_Ort:=aV(1/Step_L,Step_V);   //��� ������� ����������
  Step_V:=aV(Step_L/NUM_CTRL_POINTS,Step_Ort);
  for i:=2 to NUM_CTRL_POINTS-1 do
  X_Ctrl[i]:=SumV(1,X_Ctrl[i-1],1,Step_V);
   //�������� �� ������������ � �������� ��������
  for j:=1 to Task.Col_targ do
  if not Poraj[Num_BMP,j] and (targets[Num_BMP,j].enableTarget) then
  begin
   Shut_TargetR(j,error,holl);
   if error=0 then X:=holl;
  end;
  //�������� �� ������������ � ���������������� ������ ��� � ��
  for j:=1 to COL_TEXNIKA_MODEL do
  if Model[j].Typ>0 then
  begin
   Shut_Model(j,error,holl);
   if error=0 then X:=holl;
  end;
  //�������� �� ������������ � ������������ �����,������������� � ������������� ���������
  for i:=2 to NUM_CTRL_POINTS do
  begin
   if (X_Ctrl[i].H<=(CountHeightMetr(X_Ctrl[i].X,X_Ctrl[i].Y)+0.1)) then
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

procedure TMissile.InitPosition(X0,Tang0 : Vektor);
begin
 Mode:=0;
 X:=X0;
 Tang:=Tang0;
// GetOrts_Snar;
// V:=NulV;     {�������� �/���}
// A:=NulV;
// F:=NulV;
// Vtang:=NulV;   {������� �������� ���/���}
// M:=NulV;   {������� ��������� ���/���/���}
end;

end.

