unit UnDraw;

interface

uses
  dglOpenGL, UnGeom, UnBVT, UnGLSL, UnBuildSurface,UnBuildBuilding, UnDrawMan,
  UnDrawTank, Main, SysUtils,UnBuildSetka, UnOther, UnDrawExplos, UnDrawEffect;

  // Рисование главной сцены
  procedure DrawScene(angleAxisX, angleAxisH, angleAxisY, posX, posH, posY, sc: GLFloat);

var
  az_result: real;
  okopDraw: boolean;

implementation

uses UnVarConstOpenGL, UnBuildIndex, UnBuild, UnDrawModel,UnDrawPricelKonkurs,
     UnDrawPTUR, UnMichen;

const
 mat : Array [0..3] of GLFloat = (0.91,0.91,0.91,1);

procedure DrawScene(angleAxisX, angleAxisH, angleAxisY, posX, posH, posY, sc: GLFloat);
var
  a, n: integer;
  sector,patch: integer;
  az: real;
  p0: koord;
  visA: Vektor;
  visK: TXYZ;
begin
  visA.X:=angleAxisY/57.3;
  visA.Y:=angleAxisX/57.3;
  visA.H:=angleAxisH-90;
  if visA.H<0 then visA.H:=visA.H+360;
  visA.H:=visA.H/57.3;
  visK:= Angels2XYZ(visA);

  // Очистка кадра
  glClear( GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT );
  // Внешний источник света
  glEnable(GL_LIGHT0);
  glPushMatrix;
    if task.temp=DAY then glCallList(GORIZONT);
    gluLookAt(posX, posH, -posY,
              visK.VForward.X+posX,
              visK.VForward.H+posH,
              visK.VForward.Y-posY,
              visK.Normal.X,    visK.Normal.H,    visK.Normal.Y);

    eyePos[0]:=posX;
    eyePos[1]:=posH;
    eyePos[2]:=-posY;
    GLSL.Bind;
      GLSL.SetUniformVector4D('eyePos',@eyePos);
    GLSL.UnBind;
    az_result:=angleAxisH;
    // Расчёт сектора куда смотрим и патча где стоим для дерева видимости
    az:=angleAxisH+colDegree/2;
    if az>=360 then az:=az-360;
    if az<0 then az:=az+360;
    sector:=trunc(az/colDegree)+1;
    patch:=CountPatch(posX, posY);
    p0.X:=posX/20;
    p0.Y:=posY/20;
    BVT.CalcView(p0,(90-angleAxisH)/57.3);
    if (Task.Mestn=GORA) then begin
      if Task.Temp=DAY then glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
      if Task.m_index<6000 then begin
        glCallList(GORIZONT_GORA[0]);
      end
      else begin
        glTranslatef(-posX, -posH, posY);
        glCallList(GORIZONT_GORA[sector]);
        glTranslatef(posX, posH, -posY);
      end;
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
    end;

    for a:=1 to BVT.Patchs do if BVT.Visio[a] then  begin
//      glCallList(OKOP_BAZA+a);
    end;
    GLSL.Bind;
    for a:=1 to BVT.Patchs do if BVT.Visio[a] then  begin
      glCallList(SURFACE_BAZA+Surface.CountLevelPatch(posX, posY, a));
    end;
    GLSL.UnBind;
    glEnable(GL_ALPHA_TEST);
    for a:=1 to BVT.Patchs do if BVT.Visio[a] then  begin
      glCallList(SCENE_BAZA+a);
    end;
    // Столбики и ограничители
//    if PNV_off then glColorMask(false,true,false,true);
    if Task.m_index<5000 then glCallList(STOLB);
//    if PNV_off then glColorMask(true,true,true,true);
    Draw_BMP(2);
    Draw_Model;
    // Мишени
    Draw_Mishen;
    DrawSoldiers;
    glDepthMask(false);
    glDisable(GL_ALPHA_TEST);
    // Облака
    Draw_Oblako;
    // Траектория ПТУР
    if BMP[Num_BMP].Start_PTUR then begin
      Move_Trass_Ptur;
      Draw_Trass_Ptur;
      glEnable(GL_ALPHA_TEST);
      glDepthMask(true);
      Draw_Missile;
      glDisable(GL_ALPHA_TEST);
      glDepthMask(false);
    end;

    Draw_Vzryv_PTUR;

    // Чёрный дым
    for n:=1 to COL_TEXNIKA_MODEL do begin
      if (Model[n].Typ>0)then begin
        Draw_Pyl(n);
 //       Draw_Pyl_Black(n);
      end;
      if (Model[n].Typ>0)and(Model[n].Akt>$0f) then Draw_Dym_Black(n);
    end;

     glDepthMask(true);
  glPopMatrix;
  glDisable(GL_LIGHT0);

  Draw_Pricel;
end;

end.


