// Начальные установки OpenGL
// и переключение освещения
unit UnBuildSetting;

interface

uses
  Windows, dglOpenGL, Main, UnVarConstOpenGL, UnOther;
  procedure SettingOpenGL;
  procedure SettingLights;
  procedure SettingDayLight(timeDay: word; pnv,akt: boolean; intensivFog: word);
  procedure SettingViewport(angVis, clientWH:real; begX, endX, begY, endY: integer);
  procedure SettingFog;

implementation

// Установки OpenGL
procedure SettingOpenGL;
begin
  //Включение теста глубины сцены
  glEnable(GL_DEPTH_TEST);
  // Разрешить смешивание цветов
  glEnable (GL_BLEND);
  // Выбор способа смешивания
  glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  //Коэффициент прозрачности альфа теста
  glAlphaFunc(GL_GEQUAL,0.8);
  // Разрешить наложение текстур
  glEnable(GL_TEXTURE_2D);
  // Параметры наложения текстуры
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
  //Источники света
  SettingLights;
  SettingFog;
end;

// Включает и задаёт модель освещения
// Устанавливает цвет, направление, ширину луча, затухание
// источников света
procedure SettingLights;
const
  // Затухание источников света
  ATTENUATION_NAV=0.1;
  ATTENUATION_MV=0.3;
  EXPONENT=127;
  // Ширина луча
  SPOT_CUTOFF_MV=8.0;
  SPOT_CUTOFF_NAV=1.9;
  //для цвета освещения
  tempLight: Array [0..3] of GLFloat = (0,0,0,1);
  //Положение солнца
  posLight0 : Array [0..3] of GLFloat = (75, 25, 25, 1);
  dirLight0 : Array [0..2] of GLFloat = (-0.2, -1, -0.2);

  //Положение инфрафары
  posFaraI : Array [0..3] of GLFloat = (0, 0.1, 0, 1);
  //Направление инфрафары
  naprFaraI : Array [0..2] of GLFloat = (0, 0.001, -2);
  //Положение фары МВ
  posFaraMV : Array [0..3] of GLFloat = (0, 0.1, 0, 1);
  //Направление инфрафары МВ
  naprFarMV : Array [0..2] of GLFloat = (0, -0.2, -2);
begin
  // Включение освещения
  glEnable(GL_LIGHTING);
  // Модель освещения (Освещение обеих сторон поверхностей)
  glLightModelf(GL_LIGHT_MODEL_TWO_SIDE, 1);
  // Источники света
  //  GL_LIGHT0- Внешний источник света день/ночь
  glLightfv(GL_LIGHT0, GL_POSITION, @posLight0);
  glLightfv(GL_LIGHT4,GL_SPOT_DIRECTION,@dirLight0);
  //  GL_LIGHT2- Подсветка шкал
  glLightfv(GL_LIGHT2, GL_AMBIENT, @tempLight);
  // Инфра фара наводчика
  tempLight[0]:=0.4;tempLight[1]:=1;tempLight[2]:=0.4;
  glLightfv(GL_LIGHT4, GL_DIFFUSE, @tempLight);
  glLightfv(GL_LIGHT4, GL_SPECULAR, @tempLight);
  glLightfv(GL_LIGHT4, GL_AMBIENT, @tempLight);

  glLightfv(GL_LIGHT4, GL_POSITION, @posFaraI);
  glLightf(GL_LIGHT4,GL_SPOT_CUTOFF,SPOT_CUTOFF_NAV);
  glLightfv(GL_LIGHT4,GL_SPOT_DIRECTION,@naprFaraI);
  glLightf(GL_LIGHT4,GL_SPOT_EXPONENT, EXPONENT);
  glLightf(GL_LIGHT4,GL_LINEAR_ATTENUATION, ATTENUATION_NAV);

  tempLight[0]:=0.56;tempLight[1]:=0.56;tempLight[2]:=0.56;
  //  GL_LIGHT5- Фары танка № 1
  glLightfv(GL_LIGHT5, GL_DIFFUSE, @tempLight);
  glLightfv(GL_LIGHT5, GL_SPECULAR, @tempLight);
  glLightfv(GL_LIGHT5, GL_AMBIENT, @tempLight);

  glLightfv(GL_LIGHT5, GL_POSITION, @posFaraMV);
  glLightf(GL_LIGHT5,GL_SPOT_CUTOFF,SPOT_CUTOFF_MV);
  glLightfv(GL_LIGHT5,GL_SPOT_DIRECTION,@naprFaraI);
  glLightf(GL_LIGHT5,GL_SPOT_EXPONENT, EXPONENT);
  glLightf(GL_LIGHT5,GL_LINEAR_ATTENUATION, ATTENUATION_MV);
  //  GL_LIGHT6- Фары танка № 2
  glLightfv(GL_LIGHT6, GL_DIFFUSE, @tempLight);
  glLightfv(GL_LIGHT6, GL_SPECULAR, @tempLight);
  glLightfv(GL_LIGHT6, GL_AMBIENT, @tempLight);

  glLightfv(GL_LIGHT6, GL_POSITION, @posFaraMV);
  glLightf(GL_LIGHT6,GL_SPOT_CUTOFF,SPOT_CUTOFF_MV);
  glLightfv(GL_LIGHT6,GL_SPOT_DIRECTION,@naprFaraI);
  glLightf(GL_LIGHT6,GL_SPOT_EXPONENT, EXPONENT);
  glLightf(GL_LIGHT6,GL_LINEAR_ATTENUATION, ATTENUATION_MV);
  //  GL_LIGHT7- Фары танка № 3
  glLightfv(GL_LIGHT7, GL_DIFFUSE, @tempLight);
  glLightfv(GL_LIGHT7, GL_SPECULAR, @tempLight);
  glLightfv(GL_LIGHT7, GL_AMBIENT, @tempLight);

  glLightfv(GL_LIGHT7, GL_POSITION, @posFaraMV);
  glLightf(GL_LIGHT7,GL_SPOT_CUTOFF,SPOT_CUTOFF_MV);
  glLightfv(GL_LIGHT7,GL_SPOT_DIRECTION,@naprFaraI);
  glLightf(GL_LIGHT7,GL_SPOT_EXPONENT, EXPONENT);
  glLightf(GL_LIGHT7,GL_LINEAR_ATTENUATION, ATTENUATION_MV);
end;

// Установка внешнего освещения
// День/ночь,ПНВ вкл/выкл, фара ИК вкл/выкл, интенсивность тумана в %
procedure SettingDayLight(timeDay: word; pnv,akt: boolean; intensivFog: word);
const
  colorLight : Array [0..3] of GLFloat = (0,0,0,1);
begin
  // Проверка входной величины на допустимое значение(не>100%)
  if timeDay=0 then timeDay:=DAY;
  if intensivFog>100 then intensivFog:=100;
  pnvColorGreen:=pnv;        // Включен прибор, в UnDraw всё в зелёном свете
  //======= Определяем цвет фона=========
  case Task.Temp of
    DAY: begin  // День
      if pnv then begin                // Включен прибор
         // День- пассив
         glClearColor(0.4, 0.8, 0.4, 1.0);                           //Цвет фона
      end
      else begin
        case Task.m_inten_fog of         //  В зависимости от тумана меняем
          0..9: glClearColor(0.5, 0.8, 0.9, 1.0);
          10..19: glClearColor(0.6, 0.8, 0.9, 1.0);
          20..100: glClearColor(0.7, 0.7, 0.7, 1.0);
          else glClearColor(0.7, 0.7, 0.7, 1.0);
        end;
      end;
    end;
    GLOAMING: begin
      case Task.m_inten_fog of         //  В зависимости от тумана меняем
        0: glClearColor(0.1, 0.25, 0.4, 1.0);                           //Цвет фона
        10: glClearColor(0.2, 0.25, 0.4, 1.0);                           //Цвет фона
        20..100: glClearColor(0.4, 0.4, 0.4, 1.0);                   //Цвет фона
        else glClearColor(0.2, 0.25, 0.4, 1.0);
      end;
    end;
    NIGHT: begin
      if pnv then glClearColor(0.1, 0.2, 0.1, 1.0)  // Ночь- пассив, актив
             else glClearColor(skyNight, skyNight, skyNight*2, 1.0);   // Ночь
    end;
  end;
  //========= Определяем цвет и силу внешнего освещения, туман ========
  if pnv then begin
    // Включен ПНВ
    // Светящиеся предметы
    LIGHT_EMMISS_ON[0]:=0; LIGHT_EMMISS_ON[1]:=1; LIGHT_EMMISS_ON[2]:=0;
    // Цвет и интенсивность тумана
    colorLight[0]:=0;
    colorLight[1]:=0.1;
    colorLight[2]:=0;
    glFogfv (GL_FOG_COLOR, @colorLight);
    glFogf (GL_FOG_DENSITY, intensivFog/500);
    if timeDay=DAY then begin
      // День
      colorLight[0]:=0.7;
      colorLight[1]:=0.7;
      colorLight[2]:=0.7;
      glLightfv(GL_LIGHT0, GL_AMBIENT, @colorLight);
      glLightfv(GL_LIGHT0, GL_DIFFUSE, @colorLight);
      glLightfv(GL_LIGHT0, GL_SPECULAR, @colorLight);
    end
    else begin
      // Ночь
      colorLight[0]:=0.15;
      colorLight[1]:=0.2;
      colorLight[2]:=0.15;
      glLightfv(GL_LIGHT0, GL_AMBIENT, @colorLight);
      glLightfv(GL_LIGHT0, GL_DIFFUSE, @colorLight);
      glLightfv(GL_LIGHT0, GL_SPECULAR, @colorLight);
    end;
  end
  else begin
    // Выключен ПНВ
    // Светящиеся предметы
    LIGHT_EMMISS_ON[0]:=1; LIGHT_EMMISS_ON[1]:=1; LIGHT_EMMISS_ON[2]:=1;
    if timeDay=DAY then begin
      // День
      colorLight[0]:=1;
      colorLight[1]:=1;
      colorLight[2]:=1;
      glLightfv(GL_LIGHT0, GL_AMBIENT, @colorLight);
      colorLight[0]:=0.7;
      colorLight[1]:=0.7;
      colorLight[2]:=0.7;
      glLightfv(GL_LIGHT0, GL_DIFFUSE, @colorLight);
      colorLight[0]:=0.5;
      colorLight[1]:=0.5;
      colorLight[2]:=0.5;
      glLightfv(GL_LIGHT0, GL_SPECULAR, @colorLight);
      // Цвет и интенсивность тумана
      colorLight[0]:=0.7;
      colorLight[1]:=0.7;
      colorLight[2]:=0.7;
      glFogfv (GL_FOG_COLOR, @colorLight);
      glFogf (GL_FOG_DENSITY, intensivFog/5000);
    end
    else begin
      // Ночь
      colorLight[0]:=0.001;
      colorLight[1]:=0.001;
      colorLight[2]:=0.001;
      glLightfv(GL_LIGHT0, GL_AMBIENT, @colorLight);
      colorLight[0]:=0.003;
      colorLight[1]:=0.003;
      colorLight[2]:=0.003;
      glLightfv(GL_LIGHT0, GL_DIFFUSE, @colorLight);
      colorLight[0]:=0.005;
      colorLight[1]:=0.005;
      colorLight[2]:=0.005;
      glLightfv(GL_LIGHT0, GL_SPECULAR, @colorLight);
      // Цвет и интенсивность тумана
      colorLight[0]:=0.1;
      colorLight[1]:=0.1;
      colorLight[2]:=0.2;
      glFogfv (GL_FOG_COLOR, @colorLight);
      glFogf (GL_FOG_DENSITY, intensivFog/1000);
    end;
  end;
  // Включение ИК фары наводчика
  if akt and (timeDay=NIGHT) then glEnable(GL_LIGHT4) else  glDisable(GL_LIGHT4);
end;

// Установка размера окна и угла зрения
procedure SettingViewport(angVis, clientWH:real; begX, endX, begY, endY: integer);
begin
  glViewport( begX, begY, endX,  endY);
  glMatrixMode (GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(angVis, clientWH, 0.049, 1001);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
end;

procedure SettingFog;
begin
  /// Включить туман
  glEnable(GL_FOG);
  // Плотность тумана увеличивается по экспоненте
  glFogi (GL_FOG_MODE, GL_EXP);
end;

end.



