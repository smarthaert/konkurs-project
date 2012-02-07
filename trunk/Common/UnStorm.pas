unit UnStorm;

interface

uses  SysUtils, OpenGL, UnBuild, Main, UnOther;

const
  COL_STORM=30;
  GRANICA_STORM=15;
  procedure BuildStorm;
  procedure DrawStorm(X,Y,H,windX, windY, stormAsimut : real);

implementation
var
  stormAngle: array[1..COL_STORM] of real;
  stormDeltaAngle: array[1..COL_STORM] of real;
  stormX: array[1..COL_STORM] of real;
  stormY: array[1..COL_STORM] of real;
  stormH: array[1..COL_STORM] of real;
  stormMat: array[1..COL_STORM] of real;
  stormSca: array[1..COL_STORM] of real;
//  stormDeltaSca: array[1..COL_STORM] of real;
  stormBeginIndex: word;
  stormPeriod: word;

procedure DrawStorm(X,Y,H,windX, windY, stormAsimut: real);
const
  mat: array [0..3] of GLFloat =( 1, 0.8, 0.6, 1);
  mat_sp: array [0..3] of GLFloat =( 0, 0, 0, 1);
  fogColor: array [0..3] of GLFloat =( 0.6, 0.5, 0.4, 1);
var
  speedWind: real;
  a: integer;
  stormEnable: boolean;
begin
//  form1.Label98.Caption:=floattostr(speedWind);
  stormEnable:=false;
  speedWind:=windX*windX+windY*windY;
  if speedWind>0.0017  then begin
    glClearColor(0.7, 0.6, 0.5, 1);
    Task.m_inten_fog:=20;
    intensiv_fog:=speedWind*80;
    stormEnable:=true;
  end
  else begin
    if speedWind>0.0006  then begin
      glClearColor(0.65, 0.6, 0.55, 1);
      Task.m_inten_fog:=20;
      intensiv_fog:=speedWind*100;
      stormEnable:=true;
    end;
  end;
  glFogf (GL_FOG_DENSITY, intensiv_fog);
  glFogfv (GL_FOG_COLOR, @fogColor);

  inc(stormPeriod);
  if stormEnable then begin //минимальная сила ветра, при которой появляется пыль
    if  stormPeriod>45 then begin
      stormPeriod:=0;
      inc(stormBeginIndex);
      if stormBeginIndex>COL_STORM then stormBeginIndex:=1;
      stormH[stormBeginIndex]:=-H-0.5;
      stormDeltaAngle[stormBeginIndex]:=(random(100)-50)/20;
      stormMat[stormBeginIndex]:=speedWind*900;
      if stormMat[stormBeginIndex]>1 then stormMat[stormBeginIndex]:=1;
      stormSca[stormBeginIndex]:=random(7)+10;
    end;
    glDisable(GL_COLOR_MATERIAL);  //Разрешаем менять прозрачность материала
    for a:=1 to COL_STORM do begin
      glPushMatrix;
        mat[3]:=stormMat[a];
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
        glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat_sp);
        // Вращаем, перемещаем и увеличиваем пыль
        glTranslatef(-X+stormX[a],stormH[a],-Y-stormY[a]);
        glRotatef (-stormAsimut, 0.0, 1.0, 0.0);
        glRotatef (-stormAngle[a], 0.0, 0.0, 1.0);
        glScale(stormSca[a],stormSca[a]/2,stormSca[a]);
        glCallList(SPRITE_PYL);
        stormAngle[a]:=stormAngle[a]+stormDeltaAngle[a];
        if stormAngle[a]>=360 then stormAngle[a]:=stormAngle[a]-360
                              else if stormAngle[a]<0 then stormAngle[a]:=stormAngle[a]+360;
        stormX[a]:=stormX[a]+windX;
        if stormX[a]>GRANICA_STORM then stormX[a]:=-GRANICA_STORM
                                   else if stormX[a]<-GRANICA_STORM then stormX[a]:=GRANICA_STORM;
        stormY[a]:=stormY[a]+windY;
        if stormY[a]>GRANICA_STORM then stormY[a]:=-GRANICA_STORM
                                   else if stormY[a]<-GRANICA_STORM then stormY[a]:=GRANICA_STORM;
      glPopMatrix;
    end;
    glEnable(GL_COLOR_MATERIAL);
  end;
end;

procedure BuildStorm;
var
  a: integer;
begin
  for a:=1 to COL_STORM do begin
    stormX[a]:=random(GRANICA_STORM*2)-GRANICA_STORM;
    stormY[a]:=random(GRANICA_STORM*2)-GRANICA_STORM;
  end;
end;

end.
