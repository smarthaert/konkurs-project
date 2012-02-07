// Оптическая часть
unit UnBuildPricel;

interface
  procedure BuildPricel;
  procedure BuildSetka;
  procedure BuildKrug(num: integer);
  procedure BuildShtorka;
  procedure BuildDiafragma;
  procedure BuildFiltr;

implementation

uses dglOpenGL,UnBuildIndex,UnVarConstOpenGL,SysUtils, Dialogs,
     UnBuildTexture;

// Оптическая часть для разных РМ разная
procedure BuildPricel;
begin
  BuildSetka;
  BuildShtorka;
  BuildDiafragma;
  BuildFiltr;
  BuildKrug(1);
  BuildKrug(2);
  BuildKrug(4);
  BuildKrug(5);
end;

procedure BuildSetka;
var a,b,c: real;
begin
  // Шкалы наводчика
  // Вращающаяся верхняя шкала часть 1
  glNewList (PRICEL, GL_COMPILE);
    prepareImage ('Pricel\Pric_T72.bmp',4,0);
    a:=0.00232;
    glBegin(GL_QUADS);
      glTexCoord2f(0, 0);
      glVertex3f(-a, -a, -0.05);
      glTexCoord2f( 0, 1);
      glVertex3f(-a, a, -0.05);
      glTexCoord2f(1, 1);
      glVertex3f(a, a, -0.05);
      glTexCoord2f(1, 0);
      glVertex3f(a, -a, -0.05);
    glEnd;
  glEndList;
  // Вращающаяся верхняя шкала часть 2
  glNewList (PRICEL4, GL_COMPILE);
    prepareImage ('Pricel\Pric_T72a.bmp',4,0);
    a:=0.00232;
    glBegin(GL_QUADS);
      glTexCoord2f(0, 0);
      glVertex3f(-a, -a, -0.05);
      glTexCoord2f( 0, 1);
      glVertex3f(-a, a, -0.05);
      glTexCoord2f(1, 1);
      glVertex3f(a, a, -0.05);
      glTexCoord2f(1, 0);
      glVertex3f(a, -a, -0.05);
    glEnd;
  glEndList;
  // Круг с риской, прикрывающий вращающуюся шкалу
  glNewList (KRUG3, GL_COMPILE);
    prepareImage ('Pricel\Krug3.bmp',4,0);
    a:=0.00234;
    glPushMatrix;
      glTranslatef(0, 0.00327, 0);
      glScalef(1.5,0.7,1);
      glBegin(GL_QUADS);
        glTexCoord2f(0, 0);
        glVertex3f(-a, -a/2, -0.04995);
        glTexCoord2f( 0, 1);
        glVertex3f(-a, a/2, -0.04995);
        glTexCoord2f(1, 1);
        glVertex3f(a, a/2, -0.04995);
        glTexCoord2f(1, 0);
        glVertex3f(a, -a/2, -0.04995);
      glEnd;
    glPopMatrix;
  glEndList;
  // Шкала с азимутальными метками перемещающаяся
  glNewList (PRICEL2, GL_COMPILE);
    PrepareImage ('Pricel\Pric2.bmp',4,0);
    a:=0.00182;
    b:=-0.00139;
    glBegin(GL_QUADS);
      glTexCoord2f(0, 0);
      glVertex3f(-a, -a+b, -0.04998);
      glTexCoord2f( 0, 1);
      glVertex3f(-a, a+b, -0.04998);
      glTexCoord2f(1, 1);
      glVertex3f(a, a+b, -0.04998);
      glTexCoord2f(1, 0);
      glVertex3f(a, -a+b, -0.04998);
    glEnd;
  glEndList;
  // Шкала для измерения дальности по базе
  glNewList (PRICEL3, GL_COMPILE);
    PrepareImage ('Pricel\Pric3.bmp',4,0);
    a:=0.0006132;
    b:=0.0010632;
    glBegin(GL_QUADS);
      glTexCoord2f(0, 0);
      glVertex3f(-b+0.0017, -a+0.0014, -0.04997);
      glTexCoord2f( 0, 1);
      glVertex3f(-b+0.0017, a+0.0014, -0.04997);
      glTexCoord2f(1, 1);
      glVertex3f(b+0.0017, a+0.0014, -0.04997);
      glTexCoord2f(1, 0);
      glVertex3f(b+0.0017, -a+0.0014, -0.04997);
    glEnd;
  glEndList;
  // Шкала 1К13
  glNewList (PRICEL1, GL_COMPILE);
    PrepareImage ('Pricel\Pric_PTU.bmp',4,0);
    a:=0.00232;
    glBegin(GL_QUADS);
      glTexCoord2f(0, 0);
      glVertex3f(-a, -a, -0.04996);
      glTexCoord2f( 0, 1);
      glVertex3f(-a, a, -0.04996);
      glTexCoord2f(1, 1);
      glVertex3f(a, a, -0.04996);
      glTexCoord2f(1, 0);
      glVertex3f(a, -a, -0.04996);
    glEnd;
  glEndList;
  // Выверочный квадрат
  glNewList (PRICEL_VYV,GL_COMPILE);
    PrepareImage ('Pricel\Pric_Vyv.bmp',4,0);
    a:=0.000645;
    glBegin(GL_QUADS);
      glTexCoord2f(0, 0);
      glVertex3f(-a, -a, -0.04997);
      glTexCoord2f( 0, 1);
      glVertex3f(-a, a, -0.04997);
      glTexCoord2f(1, 1);
      glVertex3f(a, a, -0.04997);
      glTexCoord2f(1, 0);
      glVertex3f(a, -a, -0.04997);
    glEnd;
  glEndList;

  // Ночные шкалы
  glNewList (PRICEL_TPN,GL_COMPILE);
    PrepareImage ('Pricel\Pri_TPN.bmp',4,0);
    a:=0.002;
    glBegin(GL_QUADS);
      glTexCoord2f(0, 0);
      glVertex3f(-a, -a, -0.04996);
      glTexCoord2f( 0, 1);
      glVertex3f(-a, a, -0.04996);
      glTexCoord2f(1, 1);
      glVertex3f(a, a, -0.04996);
      glTexCoord2f(1, 0);
      glVertex3f(a, -a, -0.04996);
    glEnd;
  glEndList;
  // Марка дальномера
  glNewList (MARKA_DALNOMER1, GL_COMPILE);
    prepareImage ('Pricel\Yellow.BMP',1,0);
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
    glPushMatrix;
      glTranslatef(0, -0.00061, -0.1);
      gluDisk(Quadric, 0.00008, 0.00012 ,12,1);
    glPopMatrix;
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
  glEndList;
  // Красная марка (Пушка заряжена)
  glNewList (MARKA_TPD_GOTOV, GL_COMPILE);
    prepareImage ('Pricel\Red.bmp',1,0);
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
    glPushMatrix;
      glTranslatef(0,  0.0032,  -0.0499);
      gluDisk(Quadric, 0, 0.00008,12,1);
    glPopMatrix;
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
  glEndList;
  // Измерительная точка лазера
  glNewList (MARKA_IZM, GL_COMPILE);
    prepareImage ('Pricel\Red.bmp',1,0);
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
    glTranslatef(0, -0.00061, 0);
    glPointSize(2);
    glBegin(GL_Points);
      glTexCoord2f(0.5, 0.5);
      glVertex3f(0, 0, 0);
    glEnd;
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
  glEndList;
  // Марка Готов ППН (Заряжена управляемая ракета)
  glNewList (MARKA_PPN_GOTOV, GL_COMPILE);
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
    prepareImage ('Pricel\Yellow.bmp',1,0);
    glPushMatrix;
      glTranslatef(0.002, 0.003, -0.07);
      gluDisk(Quadric, 0, 0.00008,12,1);
    glPopMatrix;
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
  glEndList;
  // Марка Ночь ППН (ПНВ включен)
  glNewList (MARKA_PPN_NUIT, GL_COMPILE);
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
    prepareImage ('Pricel\Red.bmp',1,0);
    glPushMatrix;
      glTranslatef(0.002, 0.003, -0.07);
      gluDisk(Quadric, 0, 0.00008,12,1);
    glPopMatrix;
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
  glEndList;
  // Сетка ТКН-3 командира
  glNewList (PRICEL_KOM, GL_COMPILE);
    prepareImage ('Pricel\Pric4.bmp',4,0);
    a:=0.00525;
    glBegin(GL_QUADS);
      glTexCoord2f(0, 0);
      glVertex3f(-a, -a, -0.05);
      glTexCoord2f( 0, 1);
      glVertex3f(-a, a, -0.05);
      glTexCoord2f(1, 1);
      glVertex3f(a, a, -0.05);
      glTexCoord2f(1, 0);
      glVertex3f(a, -a, -0.05);
    glEnd;
  glEndList;
    glNewList (UKAZ_AZ_TANK, GL_COMPILE);
    prepareImage ('Pricel\tank.bmp',6,0);
    a:=0.00075;
    b:=-0.0048;
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
    glBegin(GL_QUADS);
      glTexCoord2f(0, 0);
      glVertex3f(-a+b, -a+b, -0.04903);
      glTexCoord2f( 0, 1);
      glVertex3f(-a+b, a+b, -0.04903);
      glTexCoord2f(1, 1);
      glVertex3f(a+b, a+b, -0.04903);
      glTexCoord2f(1, 0);
      glVertex3f(a+b, -a+b, -0.04903);
    glEnd;
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
  glEndList;
  glNewList (UKAZ_AZ_BASH, GL_COMPILE);
    prepareImage ('Pricel\bash.bmp',6,0);
    a:=0.00075;
    b:=0.0004;
    c:=0.0004;
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
    glBegin(GL_QUADS);
      glTexCoord2f(0, 0);
      glVertex3f(-a, -a+b, -0.04902);
      glTexCoord2f( 0, 1);
      glVertex3f(-a, a+b, -0.04902);
      glTexCoord2f(1, 1);
      glVertex3f(a, a+b, -0.04902);
      glTexCoord2f(1, 0);
      glVertex3f(a, -a+b, -0.04902);
    glEnd;
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
  glEndList;
  glNewList (UKAZ_AZ_STRE, GL_COMPILE);
    prepareImage ('Pricel\strel.bmp',6,0);
    a:=0.00075;
    b:=0.0002;
    c:=0.0002;
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
    glBegin(GL_QUADS);
      glTexCoord2f(0, 0);
      glVertex3f(-a/3, -a/2+b, -0.04901);
      glTexCoord2f( 0, 1);
      glVertex3f(-a/3, a/2+b, -0.04901);
      glTexCoord2f(1, 1);
      glVertex3f(a/3, a/2+b, -0.04901);
      glTexCoord2f(1, 0);
      glVertex3f(a/3, -a/2+b, -0.04901);
    glEnd;
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
  glEndList;
end;

procedure BuildKrug(num: integer);
const
 mat : Array [0..3] of GLFloat = (1,1,1,1); //
 Level = 15;    // уровень детализации
 x=0.5;
 y=0.5;
var
 i: 0 .. Level - 1;
 radius: real;  // радиус отверстия
begin
  glNewList (num, GL_COMPILE);
    glDisable(GL_TEXTURE_2D);
    glColor3f(0.0, 0.0, 0.0);
    glPushMatrix;
      case num of
        1: begin // Круг больших размеров для наводчика
          radius:= 0.5;
          glScalef(0.007,0.007,1);
        end;
        2: begin // Круг 1К13
          radius:= 0.3;
          glScalef(0.0107,0.0107,1);
        end;
        4: begin   // Круг больших размеров для командира
          radius:= 0.5;
          glScalef(0.0132,0.0132,1);
        end;
        5: begin   // Круг малых размеров для командира
          radius:= 0.42;
          glScalef(0.0176,0.0176,1);
        end;
      end;
      glBegin(GL_QUAD_STRIP);
        // верхняя четверть
        for i := 0 to Level - 1 do begin
          glVertex3f(radius * sin (Pi * i / (2 * Level) - Pi /4),
                    radius * cos (Pi * i / (2 * Level) - Pi /4), -0.0499);
          glVertex3f(i / Level - x, y, -0.0499);
          glVertex3f(radius * sin (Pi * (i + 1) / (2 * Level) - Pi /4),
                      radius * cos (Pi * (i + 1) / (2 * Level) - Pi /4), -0.0499);
          glVertex3f((i + 1) / Level - x, y, -0.0499);
        end;
      glEnd;
      // правая четверть
      glBegin(GL_QUAD_STRIP);
        for i := 0 to Level - 1 do begin
          glVertex3f(radius * sin (Pi * i / (2 * Level) + Pi / 4),
                  radius * cos (Pi * i / (2 * Level) + Pi / 4), -0.0499);
          glVertex3f(x, y - i / Level, -0.0499);
          glVertex3f(radius * sin (Pi * (i + 1) / (2 * Level) + Pi / 4),
                   radius * cos (Pi * (i + 1) / (2 * Level) + Pi / 4), -0.0499);
          glVertex3f(x, y - (i + 1)/ Level, -0.0499);
        end;
      glEnd;
      // левая четверть
      glBegin(GL_QUAD_STRIP);
        for i := 0 to Level - 1 do begin
          glVertex3f(radius * sin (Pi * i / (2 * Level) - 3 * Pi / 4 ),
                 radius * cos (Pi * i / (2 * Level) - 3 * Pi / 4), -0.0499);
          glVertex3f(-x, i / Level - y, -0.0499);
          glVertex3f(radius * sin (Pi * (i + 1) / (2 * Level) - 3 * Pi / 4 ),
                 radius * cos (Pi * (i + 1) / (2 * Level) - 3 * Pi / 4), -0.0499);
          glVertex3f(-x, (i + 1) / Level - y, -0.0499);
        end;
      glEnd;
      // нижняя четверть
      glBegin(GL_QUAD_STRIP);
        for i := 0 to Level - 1 do begin
          glVertex3f(radius * sin (Pi * i / (2 * Level) + 3 * Pi / 4 ),
                 radius * cos (Pi * i / (2 * Level) + 3 * Pi / 4), -0.0499);
          glVertex3f(x - i / Level, -y, -0.0499);
          glVertex3f(radius * sin (Pi * (i + 1) / (2 * Level) + 3 * Pi / 4),
                 radius * cos (Pi * (i + 1) / (2 * Level) + 3 * Pi / 4), -0.0499);
          glVertex3f(x - (i + 1) / Level, -y, -0.0499);
        end;
      glEnd;
    glPopMatrix;
    glColor3f(1.0, 1.0, 1.0);
    glEnable(GL_TEXTURE_2D);
  glEndList;
end;

procedure BuildShtorka;
const
  mat : Array [0..3] of GLFloat = (0,0,0,1);
begin
  glNewList (SHTORKA, GL_COMPILE);
    glDisable(GL_COLOR_MATERIAL);
    glDisable(GL_TEXTURE_2D);
    glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
    glPushMatrix;
      glBegin(GL_QUADS);
        glTexCoord2f(0,0);
        glVertex3f(-0.018, 0.007, -0.0502);
        glTexCoord2f(1,0);
        glVertex3f(0.018, 0.007, -0.0502);
        glTexCoord2f(1,1);
        glVertex3f(0.018, 0.03, -0.0502);
        glTexCoord2f(0,1);
        glVertex3f(-0.018, 0.03, -0.0502);
      glEnd;
    glPopMatrix;
    glEnable(GL_TEXTURE_2D);
    glEnable(GL_COLOR_MATERIAL);
  glEndList ;
end;

procedure BuildDiafragma;
begin
  glNewList (DIAFRAGMA, GL_COMPILE);
    glDisable(GL_TEXTURE_2D);
    glPushMatrix;
      glTranslatef(0, 0, -0.0502);
      gluDisk(Quadric, 0, 0.008,16,1);
    glPopMatrix;
    glEnable(GL_TEXTURE_2D);
  glEndList ;
end;

procedure BuildFiltr;
const
  mat: Array [0..3] of GLFloat = (0,1,1,0.3);
begin
  glNewList (FILTR, GL_COMPILE);
    glDisable(GL_TEXTURE_2D);
    glDisable(GL_COLOR_MATERIAL);
    glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
    glPushMatrix;
      glTranslatef(0, 0, -0.0501);
      gluDisk(Quadric, 0, 0.0055,16,1);
    glPopMatrix;
    glEnable(GL_COLOR_MATERIAL);
    glEnable(GL_TEXTURE_2D);
  glEndList ;
end;

end.
