unit UnBuildEffect;

interface
uses
  dglOpenGL,  UnBuildTexture, UnVarConstOpenGL,SysUtils, UnBuildObject, UnOther;

type
  TCoord_Obl = record
    Typ: word;
    Num: word;
    X,Y,H : glFloat;
  end;

const
  KOL_TYPE_OBLAKO=5;
  COL_MAX_OBL=150;
  GRANICA_OBL=1000;

var
  SPRITE_PYL: integer;
  FIRE: array[0..11] of integer;
  OBLAKO:  array[0..KOL_TYPE_OBLAKO] of integer;
  Coord_Obl: array[0..COL_MAX_OBL+1] of TCoord_Obl;

procedure BuildEffect;
procedure Build_Pyl;
procedure Build_Fire;
procedure BuildOblako;
procedure CountOblako;

implementation

procedure BuildEffect;
begin
  BuildOblako;
  Build_Pyl;
  Build_Fire;
end;

procedure Build_Pyl;
const mat: array [0..3] of GLFloat =( 0, 0, 0, 1);
var x,y,z: real;
begin
  x:=0.3;
  y:=0.3;
  z:=0.03;
  SPRITE_PYL:=glGenLists(1);
  numTexture:=CreateTexture('Sprite\Pyl\pyl1.bmp',3, TEXTURE_FILTR_ON);//текстура накладывается
  glNewList (SPRITE_PYL, GL_COMPILE);
    glBindTexture(GL_TEXTURE_2D, numTexture);
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
      glBegin(GL_QUADS);            //Четырёхугольник
        glTexCoord2f(0,0);
        glNormal3f(0, 0, 1);
        glVertex3f(-x, y, z);
        glTexCoord2f(1,0);
        glNormal3f(0, 0, 1);
        glVertex3f(x, y, z);
        glTexCoord2f(1,1);
        glNormal3f(0, 0, 1);
        glVertex3f(x, -y, z);
        glTexCoord2f(0,1);
        glNormal3f(0, 0, 1);
        glVertex3f(-x, -y, z);
      glEnd;
  glEndList;
end;

procedure Build_Fire;
const
  mat: array [0..3] of GLFloat = (1, 1, 1, 1);
var
  a: integer;
  x,y,z,d: real;
begin
  FIRE[0]:=glGenLists(12);
  for a:=0 to 11 do begin
    FIRE[a]:=FIRE[0]+a;
    numTexture:=CreateTexture('Fire\Fire'+inttostr(a+1)+'.bmp',8, TEXTURE_FILTR_ON);//текстура накладывается
    glNewList (FIRE[a], GL_COMPILE);
      glBindTexture(GL_TEXTURE_2D, numTexture);
      z:=0.32;
      x:=0.18;
      y:=0;
      d:=0.0;
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
//      glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
//      glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
//      glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
      glBegin(GL_QUADS);
        glTexCoord2f(0.0, 0.0);
        glVertex3f(-x, y, d);
        glTexCoord2f( 0.0, 1.0);
        glVertex3f(-x, y+z/1.2, d);
        glTexCoord2f(1.0, 1.0);
        glVertex3f(x, y+z/1.2, d);
        glTexCoord2f(1.0, 0.0);
        glVertex3f(x, y, d);
      glEnd;
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
    glEndList;
  end;
end;

procedure BuildOblako;
var a: word;
begin
  // Создание облаков
  for a:=1 to KOL_TYPE_OBLAKO do begin
    MontObject('res/Oblaka/Oblako'+inttostr(a)+'.shp',OBLAKO[a]);
  end;
  CountOblako;
end;

procedure CountOblako;
var a: word;
az, d: real;
begin
  // Расстановка облаков на небе
  RandSeed:=3;// Чтобы разброс был всегда одинаков
  for a:=1 to COL_MAX_OBL do begin
    if (Task.Mestn=GORA) and (Task.m_index>6000) then begin
      if a<(COL_MAX_OBL-100) then begin
        Coord_Obl[a].X:=random(GRANICA_OBL )-GRANICA_OBL/2;
        Coord_Obl[a].Y:=random(GRANICA_OBL )-GRANICA_OBL/2;
        Coord_Obl[a].H:=random(30)+120;
      end
      else begin
        Coord_Obl[a].X:=GRANICA_OBL;
        Coord_Obl[a].Y:=GRANICA_OBL;
        Coord_Obl[a].H:=0;
      end;
    end
    else begin
      Coord_Obl[a].X:=random(GRANICA_OBL*2)-GRANICA_OBL;
      Coord_Obl[a].Y:=random(GRANICA_OBL*2)-GRANICA_OBL;
      Coord_Obl[a].H:=random(30)+80;
    end;
    Coord_Obl[a].Typ:=random(KOL_TYPE_OBLAKO)+1;
    Coord_Obl[a].X:=Coord_Obl[a].X+Dym_V_X;
    Coord_Obl[a].Y:=Coord_Obl[a].Y+Dym_V_Y;
  end;
  // распределение облаков по секторам видимости
//  Obl_Draw: array[0..COL_SECTOR,0..COL_OBL_SECTOR] of word;
end;

end.
