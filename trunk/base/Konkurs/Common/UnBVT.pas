unit UnBVT;

interface

uses classes, graphics, windows, UnGeom, Math;


type
 TBVT_Nod = record               //узел двоичного дерева видимости
          left, right : pointer; //указатели на левую и правую ветвь
          i1,j1,i2,j2 : word;    //координаты левого нижнего и праваго верхнего патчей
 end;
 TpBVT_Nod = ^TBVT_Nod;

 TBVT = class (TObject)          //двоичноe деревo видимости
 Patchs  : word;                 //всего патчей
 Visio   : array of boolean;     //истина, если патч виден
 dx,dy   : array of integer;     //смещение при прорисовке в патчах (для бесконечных поверхностей)
 constructor Make(ai,aj,ni,nj : word; finit : boolean; a : real);
//ni,nj - количество патчей по х и у, сторона патча = 1, wi,wj - зона видимости в патчах по х и у (длина сторон квадрата, лучше брать степени 2), finit - истина если поверхность незамкнута, а = половина угла наблюдения в градусах
 destructor Terminate;
 procedure Draw_Level(n : byte; Cnvs : TCanvas); //рисование разбиения n-ого уровня
 procedure CalcView(p0 : koord; a : real); //рассчет видимости p0-точка стояния, a-угол оси наблюдения
 procedure SetViewAngl(a : real); //а = половина угла наблюдения в градусах
 private
 Alx,Aly : word;   //количество патчей по х и у всего
 Nx,Ny   : word;  //количество патчей по х и у в зоне видимости
 Alpha   : real;   //половина угла наблюдения в градусах
 Fin     : boolean; //истина если поверхность незамкнута
 root    : TBVT_Nod;  //корневой узел
 vl,vr   : Vektor;    //левой и правый орты
 cosa    : real;      // косинус половины угла наблюдения
 Visible : array of array of boolean;     //истина, если патч виден
 i0,j0   : word;  //патч cтояния
 procedure Creat_Nods(var n : TBVT_Nod); //рекурсивное создание узлов дерева
 procedure Delete_Nods(var n : TBVT_Nod); //рекурсивное удаление узлов дерева
 procedure Draw_Nod_Level(n : byte; Cnvs : TCanvas; nod : TBVT_Nod); //рисование разбиения n-ого уровня
 procedure Visio_Nod(n : TBVT_Nod); //рекурсивная проверка видимости узлов дерева
 procedure Next_Visio_Nod(n : TBVT_Nod); //рекурсивная проверка видимости узлов дерева
 public
 FillColor : TColor;
 p       : array[0..5] of koord; //0-точка стояния, 1-орт оси наблюдения, 2 и 3 -точки пересечения левого и правого лучей с границей полигона, 4 и 5 - левая нижняя и правая верхняя точки описанного прямоугольника
 end;

implementation
constructor TBVT.Make(ai,aj,ni,nj : word; finit : boolean; a : real);
var k,n : word;
begin
 if ni>2*ai then ni:=2*ai;
 if nj>2*aj then nj:=2*aj;
 Nx:=ni;
 Ny:=nj;
 Alx:=ai;
 Aly:=aj;
 Patchs:=ai*aj;
 Fin:=finit;
 SetViewAngl(a);
 root.i1:=1;
 root.j1:=1;
 root.i2:=Nx;
 root.j2:=Ny;
 root.left:=nil;
 root.right:=nil;
 Creat_Nods(root);
 SetLength(Visible,Nx+1);
 for k:=0 to Nx do SetLength(Visible[k],Ny+1);
 for k:=0 to Nx do
 for n:=0 to Ny do Visible[k,n]:=false;
 SetLength(Visio,Patchs+1);
 SetLength(dx,Patchs+1);
 SetLength(dy,Patchs+1);
 for k:=0 to Patchs do
 begin
  Visio[k]:=false;
  dx[k]:=0;
  dy[k]:=0;
 end;
end;

procedure TBVT.Creat_Nods(var n : TBVT_Nod); //рекурсивное создание узлов дерева
var dx,dy,dd : word;
    New_Nod  : TpBVT_Nod;
begin
 dx:=n.i2-n.i1;
 dy:=n.j2-n.j1;
 if dx+dy=0 then exit;
 if dx>dy then
 begin
  dd:=dx div 2;
  New(New_Nod);
  New_Nod^.i1:=n.i1;
  New_Nod^.i2:=n.i1+dd;
  New_Nod^.j1:=n.j1;
  New_Nod^.j2:=n.j2;
  New_Nod^.left:=nil;
  New_Nod^.right:=nil;
  n.left:=New_Nod;
  Creat_Nods(New_Nod^);
  New(New_Nod);
  New_Nod^.i1:=n.i1+dd+1;
  New_Nod^.i2:=n.i2;
  New_Nod^.j1:=n.j1;
  New_Nod^.j2:=n.j2;
  New_Nod^.left:=nil;
  New_Nod^.right:=nil;
  n.right:=New_Nod;
  Creat_Nods(New_Nod^);
 end
 else
 begin
  dd:=dy div 2;
  New(New_Nod);
  New_Nod^.i1:=n.i1;
  New_Nod^.i2:=n.i2;
  New_Nod^.j1:=n.j1;
  New_Nod^.j2:=n.j1+dd;
  New_Nod^.left:=nil;
  New_Nod^.right:=nil;
  n.left:=New_Nod;
  Creat_Nods(New_Nod^);
  New(New_Nod);
  New_Nod^.i1:=n.i1;
  New_Nod^.i2:=n.i2;
  New_Nod^.j1:=n.j1+dd+1;
  New_Nod^.j2:=n.j2;
  New_Nod^.left:=nil;
  New_Nod^.right:=nil;
  n.right:=New_Nod;
  Creat_Nods(New_Nod^);
 end;
end;

procedure TBVT.Delete_Nods(var n : TBVT_Nod); //рекурсивное удаление узлов дерева
var nextnod : TpBVT_Nod;
begin
 if n.left<> nil then
 begin
  nextnod:=n.left;
  Delete_Nods(nextnod^);
  Dispose(nextnod);
  n.left:=nil;
 end;
 if n.right<> nil then
 begin
  nextnod:=n.right;
  Delete_Nods(nextnod^);
  Dispose(nextnod);
  n.right:=nil;
 end;
end;

procedure TBVT.Draw_Level(n : byte; Cnvs : TCanvas); //рисование разбиения n-ого уровня
begin
 Draw_Nod_Level(n,Cnvs,root); //рисование разбиения n-ого уровня
end;

procedure TBVT.Draw_Nod_Level(n : byte; Cnvs : TCanvas; nod : TBVT_Nod); //рисование разбиения n-ого уровня
var nextnod : TpBVT_Nod;
    r : TRect;
begin
 if (n=0) or ((nod.left=nil) and (nod.right=nil)) then
 begin
  r.Left:=(nod.i1-1)*40;
  r.Bottom:=(nod.j1-1)*40;
  r.Right:=nod.i2*40;
  r.Top:=nod.j2*40;
  FillColor:=FillColor+50;
  Cnvs.Brush.Color:=FillColor;
//  Cnvs.FillRect(r);
  Cnvs.Rectangle(r);
 end
 else
 begin
  Dec(n);
  if nod.left<>nil then
  begin
   nextnod:=nod.left;
   Draw_Nod_Level(n,Cnvs,nextnod^);
  end;
  if nod.right<>nil then
  begin
   nextnod:=nod.right;
   Draw_Nod_Level(n,Cnvs,nextnod^);
  end;
 end;
end;

procedure TBVT.CalcView(p0 : koord; a : real); //рассчет видимости p0-точка стояния, a-угол оси наблюдения
var temp : real;
    tv : Vektor;
    i,j,n : word;
    coner,tp1,tp2 : koord;
    ax,ay,ddx,ddy,dnx,dny : integer;
begin
 dnx:=Trunc(p0.X/Alx)*Alx;
 if p0.X-dnx<0 then dnx:=dnx-Alx;
 p0.X:=p0.X-dnx;
 dny:=Trunc(p0.Y/Aly)*Aly;
 if p0.Y-dny<0 then dny:=dny-Aly;
 p0.Y:=p0.Y-dny;
 i0:=1+Trunc(p0.X);
 j0:=1+Trunc(p0.Y);
 p0.X:=Nx/2+p0.X-i0;
 p0.Y:=Ny/2+p0.Y-j0;
 p[0]:=p0;
 p[1].X:=cos(a);
 p[1].Y:=sin(a);
 temp:=sqrt(p[1].X*p[1].X+p[1].Y*p[1].Y);
 if temp=0 then exit;
 p[1].X:=p[1].X/temp;
 p[1].Y:=p[1].Y/temp;
 temp:=sqrt(1-cosa*cosa);
 vl:=NulV;
 vr:=NulV;
 if abs(p[1].X)>abs(p[1].Y) then
 begin
  vl.Y:=cosa*p[1].Y+temp*p[1].X;
  vl.X:=(cosa-p[1].Y*vl.Y)/p[1].X;
  vr.Y:=cosa*p[1].Y-temp*p[1].X;
  vr.X:=(cosa-p[1].Y*vr.Y)/p[1].X;
 end
 else
 begin
  vl.X:=cosa*p[1].X+temp*p[1].Y;
  vl.Y:=(cosa-p[1].X*vl.X)/p[1].Y;
  vr.X:=cosa*p[1].X-temp*p[1].Y;
  vr.Y:=(cosa-p[1].X*vr.X)/p[1].Y;
 end;
 if VektorM(vl,vr).H>0 then
 begin
  tv:=vl;
  vl:=vr;
  vr:=tv;
 end;
 p[2].X:=vl.X;
 p[2].Y:=vl.Y;
 p[3].X:=vr.X;
 p[3].Y:=vr.Y;
 for i:=2 to 3 do
 begin
  if p[i].X>=0 then coner.X:=Nx else coner.X:=0;
  if p[i].Y>=0 then coner.Y:=Ny else coner.Y:=0;
  tp1.X:=abs(coner.X-p[0].X);
  tp1.Y:=abs(coner.Y-p[0].Y);
  tp2.X:=abs(p[i].X);
  tp2.Y:=abs(p[i].Y);
  if tp1.X*tp2.Y>tp1.Y*tp2.X then
  begin
   p[i].X:=p[0].X+p[i].X*(coner.Y-p[0].Y)/p[i].Y;
   p[i].Y:=coner.Y;
  end
  else
  begin
   p[i].Y:=p[0].Y+p[i].Y*(coner.X-p[0].X)/p[i].X;
   p[i].X:=coner.X;
  end;
 end;
 p[4].X:=min(p[2].X,p[3].X);
 p[4].X:=min(p[0].X,p[4].X);
 p[4].Y:=min(p[2].Y,p[3].Y);
 p[4].Y:=min(p[0].Y,p[4].Y);
 p[5].X:=max(p[2].X,p[3].X);
 p[5].X:=max(p[0].X,p[5].X);
 p[5].Y:=max(p[2].Y,p[3].Y);
 p[5].Y:=max(p[0].Y,p[5].Y);
 if (p[4].X<>0) and (p[5].X<>Nx) then
 begin
  if p[0].X=p[4].X then p[5].X:=Nx;
  if p[0].X=p[5].X then p[4].X:=0;
 end;
 if (p[4].Y<>0) and (p[5].Y<>Ny) then
 begin
  if p[0].Y=p[4].Y then p[5].Y:=Ny;
  if p[0].Y=p[5].Y then p[4].Y:=0;
 end;
 for i:=0 to Patchs do
 begin
  Visio[i]:=false;
  dx[i]:=-dnx;
  dy[i]:=-dny;
 end;
 for i:=0 to Nx do
 for j:=0 to Ny do Visible[i,j]:=false;
 Visio_Nod(root);
 for i:=0 to Nx do
 for j:=0 to Ny do
 if Visible[i,j] then
 begin
  ax:=i0-Round(Nx/2)+i;
  ay:=j0-Round(Ny/2)+j;
  if Fin then
  begin
   n:=ax+(ay-1)*Alx;
   Visio[n]:=true;
   dx[n]:=0;
   dy[n]:=0;
   if ax>Alx then Visio[n]:=false;
   if ax<1 then Visio[n]:=false;
   if ay>Aly then Visio[n]:=false;
   if ay<1 then Visio[n]:=false;
  end
  else
  begin
   ddx:=ax;
   ddy:=ay;
   if ax>Alx then ddx:=ax-Alx;
   if ax<1 then ddx:=ax+Alx;
   if ay>Aly then ddy:=ay-Aly;
   if ay<1 then ddy:=ay+Aly;
   n:=ddx+(ddy-1)*Alx;
   Visio[n]:=true;
   dx[n]:=dx[n]+ddx-ax;
   dy[n]:=dy[n]+ddy-ay;
  end;
 end;
end;

procedure TBVT.Visio_Nod(n : TBVT_Nod); //рекурсивная проверка видимости узлов дерева
var vert : array [1..4] of koord;
    i,i1,j1 : byte;
    tv : Vektor;
    vin : array [1..4] of boolean;
    tl,tr : array [1..4] of real;
begin
 if (n.i1-1>p[5].X) or (n.j1-1>p[5].Y) or (n.i2<p[4].X) or (n.j2<p[4].Y) then exit;
 if ((n.i1-1<=p[4].X) and (n.i2>=p[5].X)) or ((n.j1-1<=p[4].Y) and (n.j2>=p[5].Y)) then
 begin
  Next_Visio_Nod(n);
  exit;
 end;
 vert[1].X:=n.i1-1;
 vert[2].X:=n.i2;
 vert[3].X:=n.i2;
 vert[4].X:=n.i1-1;
 vert[1].Y:=n.j1-1;
 vert[2].Y:=n.j1-1;
 vert[3].Y:=n.j2;
 vert[4].Y:=n.j2;
 for i:=1 to 4 do
 begin
  if vert[i].X<p[4].X then vert[i].X:=p[4].X;
  if vert[i].X>p[5].X then vert[i].X:=p[5].X;
  if vert[i].Y<p[4].Y then vert[i].Y:=p[4].Y;
  if vert[i].Y>p[5].Y then vert[i].Y:=p[5].Y;
 end;
 if (vert[1].X=vert[3].X) or (vert[1].Y=vert[3].Y) then exit;
 for i:=1 to 4 do
 begin
  tv.X:=vert[i].X-p[0].X;
  tv.Y:=vert[i].Y-p[0].Y;
  tv.H:=0;
  vin[i]:=false;
  tl[i]:=VektorM(vl,tv).H;
  tr[i]:=VektorM(tv,vr).H;
  if tl[i]*tr[i]>0 then vin[i]:=true;
  if (i>1) and ((tl[i-1]*tr[i]>=0) or (vin[i]<>vin[i-1])) then
  begin
   Next_Visio_Nod(n);
   exit;
  end;
  if (i=4) and vin[i] then
  begin
   for i1:=n.i1 to n.i2 do
   for j1:=n.j1 to n.j2 do
   Visible[i1,j1]:=true;
   exit;
  end;
 end;
end;

procedure TBVT.Next_Visio_Nod(n : TBVT_Nod); //рекурсивная проверка видимости узлов дерева
var nextnod : TpBVT_Nod;
begin
  if (n.left=nil) and (n.right=nil) then Visible[n.i1,n.j1]:=true;
  if n.left<>nil then
  begin
   nextnod:=n.left;
   Visio_Nod(nextnod^);
  end;
  if n.right<>nil then
  begin
   nextnod:=n.right;
   Visio_Nod(nextnod^);
  end;
end;

procedure TBVT.SetViewAngl(a : real); //а = половина угла наблюдения в градусах
begin
 Alpha:=a;
 cosa:=cos(Pi*a/180);
end;

destructor TBVT.Terminate;
var i, k : word;
begin
  for k:=0 to Nx do finalize(Visible[k]);
  finalize(Visible);
  FreeMem(Visible);
  finalize(Visio);
  FreeMem(Visio);
  finalize(dx);
  FreeMem(dx);
  finalize(dy);
  FreeMem(dy);

 { for i:=0 to Nx do Visible[i]:=nil;
  Visible:=nil;
  Visio:=nil;
  dx:=nil;
  dy:=nil;  }
  Delete_Nods(root);
end;

end.

