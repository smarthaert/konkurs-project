unit UnDrawPricelKonkurs;

interface

uses
  dglOpenGL, UnBuildPricelBMP2, UnOther, UnVarConstOpenGL;

  // Оптическая часть
  procedure Draw_Pricel;
  procedure PricelNavodPTU;
  //пыль и запотевание
  procedure Clear_Dust;
  procedure Add_Dust(intens : real);
  procedure Draw_Dust;
  procedure Draw_ZAPOT_NAV(transp: real);

implementation

type
  TDustPoint=record
    x: word;
    y: word;
    size : word;
  end;

const
  DUST_X = 512;
  DUST_Y = 384;
  DUST_COUNT = 20000;

var
  Dust_Exist : boolean = false;  //false если триплекс чистый
  Dust : array[1..DUST_COUNT] of TDustPoint;

const
 LIGHT_TEMP: Array [0..3] of GLFloat = (1, 0.8, 0, 1.0);

// Оптическая часть для разных РМ разная
procedure Draw_Pricel;
begin
  glDisable(GL_FOG);
  glDisable(GL_DEPTH_TEST);
  glDisable(GL_ALPHA_TEST);
  glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
  case otobr_RM of
    RM_RUKOVOD:;
    RM_NAVOD_PTU:  PricelNavodPTU;
  end;
  glEnable(GL_ALPHA_TEST);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_FOG);
end;

procedure PricelNavodPTU;
begin
  if Povrejden[Num_BMP]=DESTR_COMPL then begin
    glCallList(SHTORKA);
    exit;
  end;
  if  BMP[Num_BMP].Zaslon_9CH then   glCallList(SHTORKA);
  glCallList(KRUG3); // Круг больших размеров
  if BMP[Num_BMP].filtr then begin
//    glDepthMask(false);
    glCallList(FILTR1);
//    glDepthMask(true);
  end;

  glCallList(PRICEL_PTUR);
  glCallList(PRICEL_PTUR_ALT);
  glEnable(GL_LIGHT2);                          // Осветитель сетки прицела ПТУР
  LIGHT_TEMP[1]:=0;

  if BMP[Num_BMP].Start_PTUR then begin
    LIGHT_TEMP[0]:=BMP[Num_BMP].Lumen_PTR/255;
    glLightfv(GL_LIGHT2, GL_AMBIENT, @LIGHT_TEMP); // Цвет сетки прицела ПТУР
  end
  else begin
    LIGHT_TEMP[0]:=0;
    glLightfv(GL_LIGHT2, GL_AMBIENT, @LIGHT_TEMP); // Цвет сетки прицела ТПН
  end;
  glCallList(PRICEL_PTUR_MARKA);
  glDisable(GL_LIGHT2);
end;


procedure Clear_Dust;
var
  i: integer;
begin
  Dust_Exist:=false;
  for i:=1 to DUST_COUNT do Dust[i].size:=0;
end;

procedure Add_Dust(intens : real);
var k,Count,n : integer;
begin
  Dust_Exist:=true;
  Count:=Round(DUST_COUNT*intens);
  for k:=0 to Count-1 do begin
    n:=1+Round(Random*(DUST_COUNT-1));
    if Dust[n].size=0 then  begin
      Dust[n].x:=Round(Random*(DUST_X-1));
      Dust[n].y:=Round(Random*(DUST_Y-1));
    end;
    Inc(Dust[n].size);
  end;
end;

procedure Draw_Dust;
const
    mat:  Array [0..3] of GLFloat=(1,1,1,1);
var i : integer;
    a,b : glFloat;
begin
  if not Dust_Exist then exit;
  glPointSize(1);
  glDisable(GL_TEXTURE_2D);  //Разрешаем менять прозрачность материала
  glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);//Меняем прозрачность материала
  glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
  glPushMatrix;
    glTranslatef(0, 0.0002, -0.049);
    for i:=1 to DUST_COUNT do if Dust[i].size>0 then begin
      glPointSize(Dust[i].size);
      a:=(2-4*Dust[i].x/DUST_X)/128;
      b:=(1-2*Dust[i].y/DUST_Y-0.02)/92;
      glBegin(GL_POINTS);
        glVertex2f(a,b);
      glEnd;
    end;
  glPopMatrix;
  glEnable(GL_TEXTURE_2D);
end;

procedure Draw_ZAPOT_NAV(transp: real);
const
  mat:array [0..3] of GLFloat =( 1, 1, 1, 1);
begin
  //Меняем прозрачность материала
  mat[3]:=transp;
  // Разрешаем менять прозрачность материала
  glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
  glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
  glCallList(ZAPOT_NAV);
  // Восстанавливаем состояние
  mat[3]:=1;
  glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
  glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
end;

procedure Draw_ZAPOT_MV(transp: real);
const
  mat:array [0..3] of GLFloat =( 1, 1, 1, 1);
begin
  //Меняем прозрачность материала
  mat[3]:=transp;
  // Разрешаем менять прозрачность материала
  glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
  glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
  glCallList(ZAPOT_MV);
  // Восстанавливаем состояние
  mat[3]:=1;
  glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
  glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
end;

end.
