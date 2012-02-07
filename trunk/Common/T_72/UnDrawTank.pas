unit UnDrawTank;

interface
uses
  UnBuild, dglOpenGL, UnBuildTank, UnOther, UnVarConstOpenGL,Main;

procedure  Draw_BMP(n: integer);
procedure Draw_Tank(n: integer);
procedure Draw_Tank_Destroy(n: integer);
procedure Draw_Tank_Ten_Base(n: integer);
procedure Draw_Tank_Ten_Stvol(n: integer);
procedure  Draw_Fara(n: integer);

implementation

const
  // инфра фара
  PosFaraI : Array [0..3] of GLFloat = (0, 0.1, 0, 1); //Положение осветителя
  PosFaraMV : Array [0..3] of GLFloat = (0, 0.1, 0, 1); //Положение осветителя
  NaprFaraI : Array [0..2] of GLFloat = (0, 0.001, -2); //Направл
  NaprFaraMV : Array [0..2] of GLFloat = (0, -0.2, -2); //Направл

var
  baz_rot_tank: array[1..COL_EKIP]of boolean;

/// Тень 1 на земле
procedure Draw_Tank_Ten_Base(n: integer);
begin
  if BMP[n].Patch_tek in [43,44,53,54]then exit;
  glDisable(GL_ALPHA_TEST);
  glDisable(GL_DEPTH_TEST);     //Выключить буфер глубины
  glDisable(GL_TEXTURE_2D);      // Отключить текстуры
  glDisable(GL_LIGHTING);        // Отключить освещение
  glColor4f(0, 0, 0, 0.3);       // Цвет тени (серая, прозрачность)
  glPushMatrix;
    glTranslatef(BMP[n].Xtek+0.06, BMP[n].Htek-0.099, -BMP[n].Ytek-0.02);
    glRotatef (270-BMP[n].AzBase, 0, 1.0, 0);
    glCallList(TANK_KORPUS_TEN);
    glScalef(1,0,1);
    glTranslatef(-0.08,0,0);
    glRotatef (-BMP[n].AzBashn,0,1,0);
    glTranslatef(-0.20,0,0);
    glRotatef (BMP[n].UmPushka,0,0,1);
    glRotatef (270, 0, 1.0, 0);
    glCallList(TANK_STVOL_TEN);
  glPopMatrix;
  if Task.Temp=NIGHT then glColor4f(0.3, 0.3, 0.3, 1)
                    else glColor4f(1, 1, 1, 1);

  glEnable(GL_LIGHTING);
  glEnable(GL_TEXTURE_2D);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_ALPHA_TEST);
end;

/// Тень 2 на танке
procedure Draw_Tank_Ten_Stvol(n: integer);
begin
  glDisable(GL_ALPHA_TEST);
  glDisable(GL_TEXTURE_2D);      // Отключить текстуры
  glDisable(GL_LIGHTING);        // Отключить освещение
  glColor4f(0, 0, 0, 0.3);       // Цвет тени (серая, прозрачность)
  glPushMatrix;
    glTranslatef(0,-0.018,-0.2);
    glRotatef (270, 0, 1.0, 0);
    glTranslatef(-0.21,0.057,0);
    glCallList(TANK_STVOL_TEN);
  glPopMatrix;
  if Task.Temp=NIGHT then glColor4f(0.3, 0.3, 0.3, 1)
                    else glColor4f(1, 1, 1, 1);
  glEnable(GL_LIGHTING);
  glEnable(GL_TEXTURE_2D);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_ALPHA_TEST);
end;

procedure  Draw_Fara(n: integer);
begin
  glPushMatrix;
    glTranslatef(BMP[n].Xtek, BMP[n].Htek, -BMP[n].Ytek);
    glRotatef (270-BMP[n].AzBase, 0, 1.0, 0);
    glRotatef (BMP[n].UmBase, 0.0, 0.0, 1);
    glRotatef (-BMP[n].Tangage, 1, 0, 0);
    // Свет фары
    if (Task.Temp=NIGHT) then
    if (((BMP[n].vod_imp[0] and $30) in [$10,$20]) or (BMP[n].vod_imp[0] and $08=$00) or
        (BMP[Num_BMP].PNV_MV and ((BMP[n].vod_imp[1] and $30) in [$10,$20]))) then
    begin
      glRotatef (-270, 0, 1.0, 0);
        glEnable(GL_LIGHT4+n);
        glLightfv(GL_LIGHT4+n,GL_SPOT_DIRECTION,@NaprFaraI);
        glLightfv(GL_LIGHT4+n, GL_POSITION, @PosFaraI);
      glRotatef (270, 0, 1.0, 0);
    end
    else
    glDisable(GL_LIGHT4+n);
  glPopMatrix;
end;

// Танк свой
procedure Draw_Tank(n: integer);
const P:array [0..3] of GLFloat =( 1, 1, 1, 0.5);
begin
  Draw_Tank_Ten_Base(n);
  glPushMatrix;
    glTranslatef(BMP[n].Xtek, BMP[n].Htek, -BMP[n].Ytek);
    glRotatef (270-BMP[n].AzBase, 0, 1.0, 0);
    glRotatef (BMP[n].UmBase, 0.0, 0.0, 1);
    glRotatef (-BMP[n].Tangage, 1, 0, 0);
    glCallList(TANK_KORPUS);
    // Включаем собственное свечение лампочек и фар
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);

    case BMP[n].vod_imp[0] and $03 of
      $02:glCallList(TANK_GABAR_ALL);// Габариты все
      $01:glCallList(TANK_GABAR_ARIER);// Габариты задние
    end;

    // Свет фары
    if (Task.Temp=NIGHT) then
    if (((BMP[n].vod_imp[0] and $30) in [$10,$20]) or
        (BMP[n].PNV and
          (((BMP[n].vod_imp[1] and $30) in [$10,$20])or(BMP[n].vod_imp[0] and $08=$08)))) then
    begin
      glRotatef (-270, 0, 1.0, 0);
        glEnable(GL_LIGHT4+n);
        glLightfv(GL_LIGHT4+n,GL_SPOT_DIRECTION,@NaprFaraI);
        glLightfv(GL_LIGHT4+n, GL_POSITION, @PosFaraI);
      glRotatef (270, 0, 1.0, 0);
    end
    else
    glDisable(GL_LIGHT4+n);
    // ИК фара ночью
    if BMP[n].PNV and(Task.Temp=NIGHT) and (BMP[n].vod_imp[0] and $08 =0) then begin
      glCallList(TANK_FARA);
    end;
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
    //  Гусеницы Т-72
    if BMP[n].start then baz_rot_tank[n]:=not baz_rot_tank[n];
    if baz_rot_tank[n] then begin
      glTranslatef(-0.279, BMP[n].Katok[12], 0);
      glCallList(TANK_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[12]+ BMP[n].Katok[1], 0);
      glCallList(TANK_KATOK_L1);
      glTranslatef(0.279-0.195,- BMP[n].Katok[1]+ BMP[n].Katok[11], 0);
      glCallList(TANK_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[11]+ BMP[n].Katok[2], 0);
      glCallList(TANK_KATOK_L1);
      glTranslatef(0.195-0.110, - BMP[n].Katok[2]+ BMP[n].Katok[10], 0);
      glCallList(TANK_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[10]+ BMP[n].Katok[3], 0);
      glCallList(TANK_KATOK_L1);
      glTranslatef(0.110-0.0266, - BMP[n].Katok[3]+ BMP[n].Katok[9], 0);
      glCallList(TANK_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[9]+ BMP[n].Katok[4], 0);
      glCallList(TANK_KATOK_L1);
      glTranslatef(0.0266+0.06, - BMP[n].Katok[4]+ BMP[n].Katok[8], 0);
      glCallList(TANK_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[8]+ BMP[n].Katok[5], 0);
      glCallList(TANK_KATOK_L1);
      glTranslatef(-0.06+0.144, - BMP[n].Katok[5]+ BMP[n].Katok[7], 0);
      glCallList(TANK_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[7]+ BMP[n].Katok[6], 0);
      glCallList(TANK_KATOK_L1);
      glTranslatef(-0.144, - BMP[n].Katok[6], 0);
      glCallList(TANK_BAZA1);
    end
    else begin
      glTranslatef(-0.279, BMP[n].Katok[12], 0);
      glCallList(TANK_KATOK_R2);
      glTranslatef(0,-BMP[n].Katok[12]+ BMP[n].Katok[1], 0);
      glCallList(TANK_KATOK_L2);
      glTranslatef(0.279-0.195,- BMP[n].Katok[1]+ BMP[n].Katok[11], 0);
      glCallList(TANK_KATOK_R2);
      glTranslatef(0,-BMP[n].Katok[11]+ BMP[n].Katok[2], 0);
      glCallList(TANK_KATOK_L2);
      glTranslatef(0.195-0.110, - BMP[n].Katok[2]+ BMP[n].Katok[10], 0);
      glCallList(TANK_KATOK_R2);
      glTranslatef(0,-BMP[n].Katok[10]+ BMP[n].Katok[3], 0);
      glCallList(TANK_KATOK_L2);
      glTranslatef(0.110-0.0266, - BMP[n].Katok[3]+ BMP[n].Katok[9], 0);
      glCallList(TANK_KATOK_R2);
      glTranslatef(0,-BMP[n].Katok[9]+ BMP[n].Katok[4], 0);
      glCallList(TANK_KATOK_L2);
      glTranslatef(0.0266+0.06, - BMP[n].Katok[4]+ BMP[n].Katok[8], 0);
      glCallList(TANK_KATOK_R2);
      glTranslatef(0,-BMP[n].Katok[8]+ BMP[n].Katok[5], 0);
      glCallList(TANK_KATOK_L2);
      glTranslatef(-0.06+0.144, - BMP[n].Katok[5]+ BMP[n].Katok[7], 0);
      glCallList(TANK_KATOK_R2);
      glTranslatef(0,-BMP[n].Katok[7]+ BMP[n].Katok[6], 0);
      glCallList(TANK_KATOK_L2);
      glTranslatef(-0.144, - BMP[n].Katok[6], 0);
      glCallList(TANK_BAZA2);
    end;
      glBegin(GL_QUAD_STRIP);
        glTexCoord2f(0, 0);
        glVertex3f(-0.373, -0.064, -0.164);
        glTexCoord2f(1, 0);
        glVertex3f(-0.373, -0.064, -0.104);

        glTexCoord2f(0,0.06); //1
        glVertex3f(-0.288, BMP[n].Katok[1]-0.143, -0.164);
        glTexCoord2f(1,0.06);
        glVertex3f(-0.288, BMP[n].Katok[1]-0.143, -0.104);

        glTexCoord2f(0, 0.12);//2
        glVertex3f(-0.195, BMP[n].Katok[2]-0.143, -0.164);
        glTexCoord2f(1, 0.12);
        glVertex3f(-0.195, BMP[n].Katok[2]-0.143, -0.104);

        glTexCoord2f(0, 0.18);//3
        glVertex3f(-0.110, BMP[n].Katok[3]-0.143, -0.164);
        glTexCoord2f(1, 0.18);
        glVertex3f(-0.110, BMP[n].Katok[3]-0.143, -0.104);

        glTexCoord2f(0, 0.24);//4
        glVertex3f(-0.0266, BMP[n].Katok[4]-0.143, -0.164);
        glTexCoord2f(1, 0.24);
        glVertex3f(-0.0266, BMP[n].Katok[4]-0.143, -0.104);

        glTexCoord2f(0, 0.30);///5
        glVertex3f(0.06, BMP[n].Katok[5]-0.143, -0.164);
        glTexCoord2f(1, 0.30);
        glVertex3f(0.06, BMP[n].Katok[5]-0.143, -0.104);

        glTexCoord2f(0, 0.36);//6
        glVertex3f(0.152, BMP[n].Katok[6]-0.143, -0.164);
        glTexCoord2f(1, 0.36);
        glVertex3f(0.152, BMP[n].Katok[6]-0.143, -0.104);

        glTexCoord2f(0, 0.42);//
        glVertex3f(0.249, -0.057,-0.164);
        glTexCoord2f(1, 0.42);
        glVertex3f(0.249, -0.057,-0.104);
      glEnd;
      glBegin(GL_QUAD_STRIP);
        glTexCoord2f(0, 0);
        glVertex3f(-0.373, -0.064, 0.164);
        glTexCoord2f(1, 0);
        glVertex3f(-0.373, -0.064, 0.104);

        glTexCoord2f(0,0.06); //1
        glVertex3f(-0.288, BMP[n].Katok[12]-0.143, 0.164);
        glTexCoord2f(1,0.06);
        glVertex3f(-0.288, BMP[n].Katok[12]-0.143, 0.104);

        glTexCoord2f(0, 0.12);//2
        glVertex3f(-0.195, BMP[n].Katok[11]-0.143, 0.164);
        glTexCoord2f(1, 0.12);
        glVertex3f(-0.195, BMP[n].Katok[11]-0.143, 0.104);

        glTexCoord2f(0, 0.18);//3
        glVertex3f(-0.110, BMP[n].Katok[10]-0.143, 0.164);
        glTexCoord2f(1, 0.18);
        glVertex3f(-0.110, BMP[n].Katok[10]-0.143, 0.104);

        glTexCoord2f(0, 0.24);//4
        glVertex3f(-0.0266, BMP[n].Katok[9]-0.143, 0.164);
        glTexCoord2f(1, 0.24);
        glVertex3f(-0.0266, BMP[n].Katok[9]-0.143, 0.104);

        glTexCoord2f(0, 0.30);///5
        glVertex3f(0.06, BMP[n].Katok[8]-0.143, 0.164);
        glTexCoord2f(1, 0.30);
        glVertex3f(0.06, BMP[n].Katok[8]-0.143, 0.104);

        glTexCoord2f(0, 0.36);//6
        glVertex3f(0.152, BMP[n].Katok[7]-0.143, 0.164);
        glTexCoord2f(1, 0.36);
        glVertex3f(0.152, BMP[n].Katok[7]-0.143, 0.104);

        glTexCoord2f(0, 0.42);//
        glVertex3f(0.249, -0.057,0.164);
        glTexCoord2f(1, 0.42);
        glVertex3f(0.249, -0.057,0.104);
      glEnd;             
    //  Башня и ствол Т-72
    glTranslatef(-0.08,0,0);
    glRotatef (-BMP[n].AzBashn,0,1,0);
    glTranslatef(0.08,0,0);
    Draw_Tank_Ten_Stvol(n);
    glCallList(TANK_BASHNA);
    glTranslatef(-0.21,0.057,0);
    glRotatef (BMP[n].UmPushka,0,0,1);
    glRotatef (270, 0, 1.0, 0);
    glTranslatef(0,0,BMP[n].otkat);
    glCallList(TANK_STVOL);
  glPopMatrix;
end;

// Танк свой повреждённый
procedure Draw_Tank_Destroy(n: integer);
var r: real;
begin
  glPushMatrix;
    glTranslatef(BMP[n].Xtek, BMP[n].Htek-0.03,-BMP[n].Ytek);
    glRotatef (270-BMP[n].AzBase-2, 0, 1.0, 0);
    glRotatef (BMP[n].UmBase+3, 0.0, 0.0, 1);
    glRotatef (-BMP[n].Tangage-5, 1, 0, 0);
    r:=0.015;
    glCallList(TANK_KORPUS);
    //  Гусеницы Т-72
      glTranslatef(-0.279, BMP[n].Katok[12]-r, 0);
      glCallList(TANK_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[12]+r+ BMP[n].Katok[1]+r, 0);
      glCallList(TANK_KATOK_L1);
      glTranslatef(0.279-0.195,- BMP[n].Katok[1]-r+ BMP[n].Katok[11]-r, 0);
      glCallList(TANK_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[11]+r+ BMP[n].Katok[2]+r, 0);
      glCallList(TANK_KATOK_L1);
      glTranslatef(0.195-0.110, - BMP[n].Katok[2]-r+ BMP[n].Katok[10]-r, 0);
      glCallList(TANK_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[10]+r+ BMP[n].Katok[3]+r, 0);
      glCallList(TANK_KATOK_L1);
      glTranslatef(0.110-0.0266, - BMP[n].Katok[3]-r+ BMP[n].Katok[9]-r, 0);
      glCallList(TANK_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[9]+r+ BMP[n].Katok[4]+r, 0);
      glCallList(TANK_KATOK_L1);
      glTranslatef(0.0266+0.06, - BMP[n].Katok[4]-r+ BMP[n].Katok[8]-r, 0);
      glCallList(TANK_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[8]+r+ BMP[n].Katok[5]+r, 0);
      glCallList(TANK_KATOK_L1);
      glTranslatef(-0.06+0.144, - BMP[n].Katok[5]-r+ BMP[n].Katok[7]-r, 0);
      glCallList(TANK_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[7]+r+ BMP[n].Katok[6]+r, 0);
      glCallList(TANK_KATOK_L1);
      glTranslatef(-0.144, - BMP[n].Katok[6]-r, 0);
      glCallList(TANK_BAZA1);

      glBegin(GL_QUAD_STRIP);
        glTexCoord2f(0, 0);
        glVertex3f(-0.373, -0.064, -0.164);
        glTexCoord2f(1, 0);
        glVertex3f(-0.373, -0.064, -0.104);

        glTexCoord2f(0,0.06); //1
        glVertex3f(-0.288, BMP[n].Katok[1]+r-0.143, -0.164);
        glTexCoord2f(1,0.06);
        glVertex3f(-0.288, BMP[n].Katok[1]+r-0.143, -0.104);

        glTexCoord2f(0, 0.12);//2
        glVertex3f(-0.195, BMP[n].Katok[2]+r-0.143, -0.164);
        glTexCoord2f(1, 0.12);
        glVertex3f(-0.195, BMP[n].Katok[2]+r-0.143, -0.104);

        glTexCoord2f(0, 0.18);//3
        glVertex3f(-0.110, BMP[n].Katok[3]+r-0.143, -0.164);
        glTexCoord2f(1, 0.18);
        glVertex3f(-0.110, BMP[n].Katok[3]+r-0.143, -0.104);

        glTexCoord2f(0, 0.24);//4
        glVertex3f(-0.0266, BMP[n].Katok[4]+r-0.143, -0.164);
        glTexCoord2f(1, 0.24);
        glVertex3f(-0.0266, BMP[n].Katok[4]+r-0.143, -0.104);

        glTexCoord2f(0, 0.30);///5
        glVertex3f(0.06, BMP[n].Katok[5]+r-0.143, -0.164);
        glTexCoord2f(1, 0.30);
        glVertex3f(0.06, BMP[n].Katok[5]+r-0.143, -0.104);

        glTexCoord2f(0, 0.36);//6
        glVertex3f(0.152, BMP[n].Katok[6]+r-0.143, -0.164);
        glTexCoord2f(1, 0.36);
        glVertex3f(0.152, BMP[n].Katok[6]+r-0.143, -0.104);

        glTexCoord2f(0, 0.42);//
        glVertex3f(0.249, -0.057,-0.164);
        glTexCoord2f(1, 0.42);
        glVertex3f(0.249, -0.057,-0.104);
      glEnd;
      glBegin(GL_QUAD_STRIP);
        glTexCoord2f(0, 0);
        glVertex3f(-0.373, -0.064, 0.164);
        glTexCoord2f(1, 0);
        glVertex3f(-0.373, -0.064, 0.104);

        glTexCoord2f(0,0.06); //1
        glVertex3f(-0.288, BMP[n].Katok[12]-r-0.143, 0.164);
        glTexCoord2f(1,0.06);
        glVertex3f(-0.288, BMP[n].Katok[12]-r-0.143, 0.104);

        glTexCoord2f(0, 0.12);//2
        glVertex3f(-0.195, BMP[n].Katok[11]-r-0.143, 0.164);
        glTexCoord2f(1, 0.12);
        glVertex3f(-0.195, BMP[n].Katok[11]-r-0.143, 0.104);

        glTexCoord2f(0, 0.18);//3
        glVertex3f(-0.110, BMP[n].Katok[10]-r-0.143, 0.164);
        glTexCoord2f(1, 0.18);
        glVertex3f(-0.110, BMP[n].Katok[10]-r-0.143, 0.104);

        glTexCoord2f(0, 0.24);//4
        glVertex3f(-0.0266, BMP[n].Katok[9]-r-0.143, 0.164);
        glTexCoord2f(1, 0.24);
        glVertex3f(-0.0266, BMP[n].Katok[9]-r-0.143, 0.104);

        glTexCoord2f(0, 0.30);///5
        glVertex3f(0.06, BMP[n].Katok[8]-r-0.143, 0.164);
        glTexCoord2f(1, 0.30);
        glVertex3f(0.06, BMP[n].Katok[8]-r-0.143, 0.104);

        glTexCoord2f(0, 0.36);//6
        glVertex3f(0.152, BMP[n].Katok[7]-r-0.143, 0.164);
        glTexCoord2f(1, 0.36);
        glVertex3f(0.152, BMP[n].Katok[7]-r-0.143, 0.104);

        glTexCoord2f(0, 0.42);//
        glVertex3f(0.249, -0.057,0.164);
        glTexCoord2f(1, 0.42);
        glVertex3f(0.249, -0.057,0.104);
      glEnd;
    //  Башня и ствол Т-72
    glRotatef (-BMP[n].AzBashn+10,0,1,0);
    glRotatef (6,0,0,1);
    glTranslatef(-0.1,0.03,0);
    glCallList(TANK_BASHNA);
    glTranslatef(-0.21,0.057,0);
    glRotatef (3,0,0,1);
    glRotatef (270, 0, 1.0, 0);
    glCallList(TANK_STVOL);
  glPopMatrix;
end;

procedure  Draw_BMP(n: integer);
const
  H_KATOK=0.024;
begin
  glPushMatrix;
    glTranslatef(BMP[n].Xtek, BMP[n].Htek+0.117, -BMP[n].Ytek);
    glRotatef (270-BMP[n].AzBase, 0, 1.0, 0);
    glRotatef (BMP[n].UmBase, 0.0, 0.0, 1);
    glRotatef (-BMP[n].Tangage, 1, 0, 0);
    glCallList(BMP_KORPUS);
    // Водоотбой
    if BMP[n].otboy then  glCallList(BMP_OTBOY_2) else  glCallList(BMP_OTBOY_1);
    // Включаем собственное свечение лампочек и фар
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
    case BMP[n].vod_imp[0] and $03 of
      $01:glCallList(BMP_GABAR_ALL);// Габариты все
      $02:glCallList(BMP_GABAR_ARIER);// Габариты задние
    end;
    // Свет фары
    if (Task.Temp=NIGHT) and BMP[n].fara_MV_N and BMP[n].pnv_MV then begin
      glRotatef (-270, 0, 1.0, 0);
        glEnable(GL_LIGHT4+n);
        glLightfv(GL_LIGHT4+n,GL_SPOT_DIRECTION,@NaprFaraI);
        glLightfv(GL_LIGHT4+n, GL_POSITION, @PosFaraMV);
      glRotatef (270, 0, 1.0, 0);
      // ИК фара ночью
      glCallList(BMP_FARA_N);
    end
    else glDisable(GL_LIGHT4+n);
    if (Task.Temp=NIGHT) and BMP[n].fara_MV then begin
      glRotatef (-270, 0, 1.0, 0);
        glEnable(GL_LIGHT5+n);
        glLightfv(GL_LIGHT5+n,GL_SPOT_DIRECTION,@NaprFaraMV);
        glLightfv(GL_LIGHT5+n, GL_POSITION, @PosFaraMV);
      glRotatef (270, 0, 1.0, 0);
     // Простая фара
      glCallList(BMP_FARA);
    end
    else glDisable(GL_LIGHT5+n);

    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
    if BMP[n].start then baz_rot_tank[n]:=not baz_rot_tank[n];
    if baz_rot_tank[n] then begin
      glTranslatef(-0.279, BMP[n].Katok[12]-H_KATOK, 0);
      glCallList(BMP_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[12]+ BMP[n].Katok[1], 0);
      glCallList(BMP_KATOK_L1);
      glTranslatef(0.279-0.204,- BMP[n].Katok[1]+ BMP[n].Katok[11], 0);
      glCallList(BMP_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[11]+ BMP[n].Katok[2], 0);
      glCallList(BMP_KATOK_L1);
      glTranslatef(0.204-0.131, - BMP[n].Katok[2]+ BMP[n].Katok[10], 0);
      glCallList(BMP_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[10]+ BMP[n].Katok[3], 0);
      glCallList(BMP_KATOK_L1);
      glTranslatef(0.131-0.06, - BMP[n].Katok[3]+ BMP[n].Katok[9], 0);
      glCallList(BMP_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[9]+ BMP[n].Katok[4], 0);
      glCallList(BMP_KATOK_L1);
      glTranslatef(0.06+0.012, - BMP[n].Katok[4]+ BMP[n].Katok[8], 0);
      glCallList(BMP_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[8]+ BMP[n].Katok[5], 0);
      glCallList(BMP_KATOK_L1);
      glTranslatef(-0.012+0.084, - BMP[n].Katok[5]+ BMP[n].Katok[7], 0);
      glCallList(BMP_KATOK_R1);
      glTranslatef(0,-BMP[n].Katok[7]+ BMP[n].Katok[6], 0);
      glCallList(BMP_KATOK_L1);
      glTranslatef(-0.084, - BMP[n].Katok[6]+H_KATOK, 0);
      glCallList(BMP_BAZA1);
    end
    else begin
      glTranslatef(-0.279, BMP[n].Katok[12]-H_KATOK, 0);
      glCallList(BMP_KATOK_R2);
      glTranslatef(0,-BMP[n].Katok[12]+ BMP[n].Katok[1], 0);
      glCallList(BMP_KATOK_L2);
      glTranslatef(0.279-0.204,- BMP[n].Katok[1]+ BMP[n].Katok[11], 0);
      glCallList(BMP_KATOK_R2);
      glTranslatef(0,-BMP[n].Katok[11]+ BMP[n].Katok[2], 0);
      glCallList(BMP_KATOK_L2);
      glTranslatef(0.204-0.131, - BMP[n].Katok[2]+ BMP[n].Katok[10], 0);
      glCallList(BMP_KATOK_R2);
      glTranslatef(0,-BMP[n].Katok[10]+ BMP[n].Katok[3], 0);
      glCallList(BMP_KATOK_L2);
      glTranslatef(0.131-0.06, - BMP[n].Katok[3]+ BMP[n].Katok[9], 0);
      glCallList(BMP_KATOK_R2);
      glTranslatef(0,-BMP[n].Katok[9]+ BMP[n].Katok[4], 0);
      glCallList(BMP_KATOK_L2);
      glTranslatef(0.06+0.012, - BMP[n].Katok[4]+ BMP[n].Katok[8], 0);
      glCallList(BMP_KATOK_R2);
      glTranslatef(0,-BMP[n].Katok[8]+ BMP[n].Katok[5], 0);
      glCallList(BMP_KATOK_L2);
      glTranslatef(-0.012+0.084, - BMP[n].Katok[5]+ BMP[n].Katok[7], 0);
      glCallList(BMP_KATOK_R2);
      glTranslatef(0,-BMP[n].Katok[7]+ BMP[n].Katok[6], 0);
      glCallList(BMP_KATOK_L2);
      glTranslatef(-0.084, - BMP[n].Katok[6]+H_KATOK, 0);
      glCallList(BMP_BAZA2);
    end;
      glBegin(GL_QUAD_STRIP);
        glTexCoord2f(0, 0);
        glVertex3f(-0.391, -0.057, -0.156);
        glTexCoord2f(1, 0);
        glVertex3f(-0.391, -0.057, -0.120);

        glTexCoord2f(0,0.06); //1
        glVertex3f(-0.29, BMP[n].Katok[1]-0.143, -0.156);
        glTexCoord2f(1,0.06);
        glVertex3f(-0.29, BMP[n].Katok[1]-0.143, -0.120);

        glTexCoord2f(0, 0.12);//2
        glVertex3f(-0.204, BMP[n].Katok[2]-0.143, -0.156);
        glTexCoord2f(1, 0.12);
        glVertex3f(-0.204, BMP[n].Katok[2]-0.143, -0.120);

        glTexCoord2f(0, 0.18);//3
        glVertex3f(-0.131, BMP[n].Katok[3]-0.143, -0.156);
        glTexCoord2f(1, 0.18);
        glVertex3f(-0.131, BMP[n].Katok[3]-0.143, -0.120);

        glTexCoord2f(0, 0.24);//4
        glVertex3f(-0.06, BMP[n].Katok[4]-0.143, -0.156);
        glTexCoord2f(1, 0.24);
        glVertex3f(-0.06, BMP[n].Katok[4]-0.143, -0.120);

        glTexCoord2f(0, 0.30);///5
        glVertex3f(0.012, BMP[n].Katok[5]-0.143, -0.156);
        glTexCoord2f(1, 0.30);
        glVertex3f(0.012, BMP[n].Katok[5]-0.143, -0.120);

        glTexCoord2f(0, 0.36);//6
        glVertex3f(0.094, BMP[n].Katok[6]-0.143, -0.156);
        glTexCoord2f(1, 0.36);
        glVertex3f(0.094, BMP[n].Katok[6]-0.143, -0.120);

        glTexCoord2f(0, 0.42);//
        glVertex3f(0.185, -0.057,-0.153);
        glTexCoord2f(1, 0.42);
        glVertex3f(0.185, -0.057,-0.120);
      glEnd;
      glBegin(GL_QUAD_STRIP);
        glTexCoord2f(0, 0);
        glVertex3f(-0.391, -0.057, 0.156);
        glTexCoord2f(1, 0);
        glVertex3f(-0.391, -0.057, 0.120);

        glTexCoord2f(0,0.06); //1
        glVertex3f(-0.29, BMP[n].Katok[12]-0.143, 0.156);
        glTexCoord2f(1,0.06);
        glVertex3f(-0.29, BMP[n].Katok[12]-0.143, 0.120);

        glTexCoord2f(0, 0.12);//2
        glVertex3f(-0.204, BMP[n].Katok[11]-0.143, 0.156);
        glTexCoord2f(1, 0.12);
        glVertex3f(-0.204, BMP[n].Katok[11]-0.143, 0.120);

        glTexCoord2f(0, 0.18);//3
        glVertex3f(-0.131, BMP[n].Katok[10]-0.143, 0.156);
        glTexCoord2f(1, 0.18);
        glVertex3f(-0.131, BMP[n].Katok[10]-0.143, 0.120);

        glTexCoord2f(0, 0.24);//4
        glVertex3f(-0.06, BMP[n].Katok[9]-0.143, 0.156);
        glTexCoord2f(1, 0.24);
        glVertex3f(-0.06, BMP[n].Katok[9]-0.143, 0.120);

        glTexCoord2f(0, 0.30);///5
        glVertex3f(0.012, BMP[n].Katok[8]-0.143, 0.156);
        glTexCoord2f(1, 0.30);
        glVertex3f(0.012, BMP[n].Katok[8]-0.143, 0.120);

        glTexCoord2f(0, 0.36);//6
        glVertex3f(0.094, BMP[n].Katok[7]-0.143, 0.156);
        glTexCoord2f(1, 0.36);
        glVertex3f(0.094, BMP[n].Katok[7]-0.143, 0.120);

        glTexCoord2f(0, 0.42);//
        glVertex3f(0.185, -0.06,0.153);
        glTexCoord2f(1, 0.42);
        glVertex3f(0.185, -0.06,0.120);
      glEnd;
//  Башня и ствол
    glTranslatef(-0.035,-0.008, 0);
    glRotatef (-BMP[n].AzBashn,0,1,0);
    glPushMatrix;
      glScalef(0.94,1,0.94);
      glCallList(BMP_BASHNA);
    glPopMatrix;
    glTranslatef(-0.118,0.087,0);
    glRotatef (BMP[n].UmPushka,0,0,1);
    glRotatef (270, 0, 1.0, 0);
    glCallList(BMP_STVOL);
  glPopMatrix;
end;

end.
