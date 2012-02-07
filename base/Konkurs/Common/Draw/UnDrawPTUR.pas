unit UnDrawPTUR;

interface

uses
   UnBuildTank, dglOpenGL, UnOther, UnDraw;


  procedure Draw_Missile;
  procedure Draw_Trass_Ptur;
  procedure Move_Trass_Ptur;
  procedure Isx_Trass_Ptur;

implementation

type

  TSmock=record
    x_tek: real;
    y_tek: real;
    h_tek: real;
    vx_tek: real;
    vy_tek: real;
    vh_tek: real;
    mat_tek: real;
    vmat_tek: real;
    angle: real;
    vangle: real;
    sca: real;
    vsca: real;
  end;

var
  Az_Trass: real;
  Smock: array[1..20] of TSmock;
  Pos_Smock: word;
  Pos_Fire: word;


procedure Draw_Missile;
var i : byte;
begin
  glPushMatrix;
    glTranslatef(BMP[Num_BMP].X_PTUR, BMP[Num_BMP].H_PTUR, BMP[Num_BMP].Y_PTUR);
    Az_Trass:=90-BMP[Num_BMP].Tang_H;
    glRotatef (-Az_Trass, 0.0, 1.0, 0.0);
    glRotatef (-BMP[Num_BMP].Tang_Y, 0.0, 0.0, 1.0);
    glRotatef (BMP[Num_BMP].Tang_X, 1.0, 0.0, 0.0);
//    glCallList(MISSILE_PTUR);
    inc(Pos_Fire);
    if Pos_Fire>3 then Pos_Fire:=1;
    glTranslatef(0, 0, 0.4);
    glRotatef (Az_Trass-az_result, 0.0, 1.0, 0.0);
    glScalef(1+abs(3*sin((Az_Trass-az_result)/57.3)),1,1);
    glCallList(FIRE_PTUR[Pos_Fire]);
  glPopMatrix;
end;

procedure Draw_Trass_Ptur;
const mat: array [0..3] of GLFloat =( 1, 1, 1, 1);
var a: word;
begin
  for a:=1 to 20 do begin
    if Smock[a].mat_tek>0.09 then begin
      mat[3]:=Smock[a].mat_tek;
      glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);//Меняем прозрачность материала
      glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
      glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
      glPushMatrix;
        glTranslatef(Smock[a].x_tek, Smock[a].h_tek, Smock[a].y_tek);
        glRotatef (-az_result, 0.0, 1.0, 0.0);
        glScalef(Smock[a].sca+abs(30*sin((Az_Trass-az_result)/57.3)),Smock[a].sca,1);
        if Smock[a].sca=1.8 then
                            else glCallList(TRASSA_PTUR[a]);
      glPopMatrix;
    end;
  end;
end;

procedure Move_Trass_Ptur;
var a: word;
a_torm,vmat_tek:real;
begin
  inc(Pos_Smock);
  if Pos_Smock>20 then Pos_Smock:=1;
  Smock[Pos_Smock].x_tek:=BMP[Num_BMP].X_PTUR;
  Smock[Pos_Smock].y_tek:=BMP[Num_BMP].Y_PTUR;
  Smock[Pos_Smock].h_tek:=BMP[Num_BMP].H_PTUR;
  Smock[Pos_Smock].mat_tek:=0.160;
  Smock[Pos_Smock].vmat_tek:=1.07;
  vmat_tek:=1.07;
  a_torm:=1.1;
  for a:=1 to 20 do begin
    Smock[a].x_tek:=Smock[a].x_tek+Smock[a].vx_tek;
    Smock[a].y_tek:=Smock[a].y_tek+Smock[a].vy_tek;
    Smock[a].h_tek:=Smock[a].h_tek+Smock[a].vh_tek;
    Smock[a].vx_tek:=Smock[a].vx_tek/a_torm;
    Smock[a].vy_tek:=Smock[a].vy_tek/a_torm;
    Smock[a].vh_tek:=Smock[a].vh_tek/a_torm;
    Smock[a].mat_tek:=Smock[a].mat_tek/vmat_tek;
//    Smock[a].angle:=Smock[a].angle+Smock[a].vangle;
    Smock[a].sca:=Smock[a].sca+Smock[a].vsca;
  end;
  Smock[Pos_Smock].sca:=0.9;
  Smock[Pos_Smock].vsca:=1.9;
end;

procedure Isx_Trass_Ptur;
var a: word;
begin
  for a:=1 to 20 do begin
    Smock[a].mat_tek:=0;
  end;
  Pos_Fire:=0;
end;

end.
