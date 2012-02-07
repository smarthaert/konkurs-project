unit UnMineLight;

interface

uses
  Windows, Classes, dglOpenGL, UnBuild, UnLVS, UnOther;

const
  COL_MAX_MINE_LIGHT=3;
type
  TMine=record
    positionMine : Array [0..3] of GLfloat;
    speedMine : Array [0..3] of GLfloat;
    arcing: word;
    time: word;
    enable: boolean;
    cycle: boolean;
  end;

procedure BuildMineLight;
procedure StartMine(a: word; x, y: real; cycle: boolean);// x,y- направление ветра
procedure EndMine(a: word);
procedure IsxPosMine(a: word);
procedure EnableLigtingMine;
procedure DrawMineLight;
procedure MoveMineTik;
procedure MoveMineSek;
procedure TransMine;
procedure Isx_Pol_Mine;

var
  MineLight:  array[1..COL_MAX_MINE_LIGHT] of TMine;
  xVet: real;
  yVet: real;


implementation

procedure EnableLigtingMine;
begin
  if MineLight[1].enable then glEnable(GL_LIGHT5)
                         else glDisable(GL_LIGHT5);
  if MineLight[2].enable then glEnable(GL_LIGHT6)
                         else glDisable(GL_LIGHT6);
  if MineLight[3].enable then glEnable(GL_LIGHT7)
                         else glDisable(GL_LIGHT7);
end;

procedure BuildMineLight;
const
  LightFara : Array [0..3] of GLFloat = (0.2, 0.4, 0.2, 1); //Цвет фары
  Napr: Array [0..2] of GLFloat = (0, -1, 0);
begin
  // Осветительная ракета
  LightFara[0]:=0.35;LightFara[1]:=0.35;LightFara[2]:=0.9;
  glLightfv(GL_LIGHT5, GL_DIFFUSE, @LightFara);
  glLightfv(GL_LIGHT5, GL_SPECULAR, @LightFara);
  glLightfv(GL_LIGHT5, GL_AMBIENT, @LightFara);
  glLightfv(GL_LIGHT5, GL_POSITION, @MineLight[1].positionMine);
  glLightf(GL_LIGHT5,GL_SPOT_CUTOFF,90.0);// Ширина луча
  glLightfv(GL_LIGHT5,GL_SPOT_DIRECTION,@Napr);
  glLightf(GL_LIGHT5,GL_SPOT_EXPONENT, 0.5);//
  glLightf(GL_LIGHT5,GL_LINEAR_ATTENUATION, 0);////Затухание


  // Осветительная ракета
  LightFara[0]:=0.35;LightFara[1]:=0.35;LightFara[2]:=0.9;
  glLightfv(GL_LIGHT6, GL_DIFFUSE, @LightFara);
  glLightfv(GL_LIGHT6, GL_SPECULAR, @LightFara);
  glLightfv(GL_LIGHT6, GL_AMBIENT, @LightFara);
  glLightfv(GL_LIGHT6, GL_POSITION, @MineLight[2].positionMine);
  glLightf(GL_LIGHT6,GL_SPOT_CUTOFF,90.0);// Ширина луча
  glLightfv(GL_LIGHT6,GL_SPOT_DIRECTION,@Napr);
  glLightf(GL_LIGHT6,GL_SPOT_EXPONENT, 0.5);//
  glLightf(GL_LIGHT6,GL_LINEAR_ATTENUATION, 0);////Затухание


  // Осветительная ракета
  LightFara[0]:=0.35;LightFara[1]:=0.35;LightFara[2]:=0.9;
  glLightfv(GL_LIGHT7, GL_DIFFUSE, @LightFara);
  glLightfv(GL_LIGHT7, GL_SPECULAR, @LightFara);
  glLightfv(GL_LIGHT7, GL_AMBIENT, @LightFara);
  glLightfv(GL_LIGHT7, GL_POSITION, @MineLight[3].positionMine);
  glLightf(GL_LIGHT7,GL_SPOT_CUTOFF,90.0);// Ширина луча
  glLightfv(GL_LIGHT7,GL_SPOT_DIRECTION,@Napr);
  glLightf(GL_LIGHT7,GL_SPOT_EXPONENT, 0.5);//
  glLightf(GL_LIGHT7,GL_LINEAR_ATTENUATION, 0);////Затухание

  glNewList (MINE_LIGHT, GL_COMPILE);                       // Трассер ПТУР
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
    glDisable(GL_TEXTURE_2D);
    glPushMatrix;
      gluSphere(Quadric, 0.051,12,12);
      glTranslatef(0,0.06,0);
      gluSphere(Quadric, 0.025,12,12);
      glTranslatef(0,0.03,0);
      gluSphere(Quadric, 0.015,12,12);
    glPopMatrix;
    glEnable(GL_TEXTURE_2D);
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
  glEndList;
end;

procedure DrawMineLight;
const
  LightMine: array[0..3] of GLfloat=(1,1,1,1);
var
  a: word;
  r: real;
begin
  for a:=1 to  COL_MAX_MINE_LIGHT do begin
    if MineLight[a].enable then begin
      // Осветительная мина
      r:=MineLight[a].arcing/60;
      glLightfv(GL_LIGHT4+a, GL_POSITION, @MineLight[a].positionMine);
      LightMine[0]:=0.35+r;LightMine[1]:=0.35+r;LightMine[2]:=0.9+r;
      glLightfv(GL_LIGHT4+a, GL_DIFFUSE, @LightMine);
      glLightfv(GL_LIGHT4+a, GL_SPECULAR, @LightMine);
      glLightfv(GL_LIGHT4+a, GL_AMBIENT, @LightMine);
      glPushMatrix;
        glTranslatef(MineLight[a].positionMine[0],MineLight[a].positionMine[1],
                                                  MineLight[a].positionMine[2]);
        r:=r*5+1;
        glScalef(r,r,r);
        glCallList(MINE_LIGHT);
      glPopMatrix;
    end;
  end;
end;

procedure MoveMineTik;
var
  a: word;
  tr: boolean;
begin
  tr:=false;
  for a:=1 to 3 do begin
    if MineLight[a].enable then begin
      MineLight[a].arcing:=random(7);
      MineLight[a].positionMine[0]:=MineLight[a].positionMine[0]-MineLight[a].speedMine[0];
      MineLight[a].positionMine[1]:=MineLight[a].positionMine[1]-0.035;
      MineLight[a].positionMine[2]:=MineLight[a].positionMine[2]-MineLight[a].speedMine[1];
      tr:=true;
    end;
  end;
  if tr then TransMine;
end;

procedure StartMine(a: word; x, y: real; cycle: boolean);
begin
  xVet:=x;
  yVet:=y;
  IsxPosMine(a);
  MineLight[a].enable:=true;
  MineLight[a].cycle:=cycle;
  TransMine;
end;

procedure IsxPosMine(a: word);
begin
  MineLight[a].time:=21;
  MineLight[a].positionMine[0]:=random(60)+20;
  MineLight[a].positionMine[2]:=-(random(70)+40);
  MineLight[a].positionMine[1]:=CountVertexYTri(MineLight[a].positionMine[0],
                                                 -MineLight[a].positionMine[2])+13;
  MineLight[a].positionMine[3]:=1;
  MineLight[a].speedMine[0]:=(random(4)-2)/200+xVet;
  MineLight[a].speedMine[1]:=(random(4)-2)/200+yVet;
end;

procedure MoveMineSek;
var
  a: word;
begin
  for a:=1 to COL_MAX_MINE_LIGHT do begin
    if MineLight[a].enable then begin
      if MineLight[a].time>0 then begin
        dec(MineLight[a].time)
      end
      else begin
        if MineLight[a].cycle then begin
          IsxPosMine(a);
        end
        else begin
          MineLight[a].enable:=false;
        end;
        TransMine;
      end;
    end;
  end;
end;

procedure TransMine;
begin
  MoveMemory(@BuffTr[endO],@MineLight,LVS_MINE);
  potok[endO,1]:=1; potok[endO,2]:=1;  potok[endO,3]:=14;
  inc(endO); endO:=endO and $3f;
end;

procedure EndMine(a: word);
begin
  IsxPosMine(a);
  MineLight[a].enable:=false;
  TransMine;
end;

procedure Isx_Pol_Mine;
var
  a: word;
begin
  for a:=1 to COL_MAX_MINE_LIGHT do begin
    EndMine(a);
  end;
end;

end.

// вставить в UnLVS в процедуру send
  14: Form1.NMUDP1.SendBuffer(BuffTr[n_buf],LVS_MINE);

// вставить в UnBuild
   MINE_LIGHT=69;
   BuildMineLight;

// вставить в UnDraw
   EnableLigtingMine;
   DrawMineLight;

// вставить в таймеры
   MoveMineTik;
   MoveMineSek;

