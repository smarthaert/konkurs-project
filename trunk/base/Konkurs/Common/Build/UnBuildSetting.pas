// ��������� ��������� OpenGL
// � ������������ ���������
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

// ��������� OpenGL
procedure SettingOpenGL;
begin
  //��������� ����� ������� �����
  glEnable(GL_DEPTH_TEST);
  // ��������� ���������� ������
  glEnable (GL_BLEND);
  // ����� ������� ����������
  glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  //����������� ������������ ����� �����
  glAlphaFunc(GL_GEQUAL,0.8);
  // ��������� ��������� �������
  glEnable(GL_TEXTURE_2D);
  // ��������� ��������� ��������
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
  //��������� �����
  SettingLights;
  SettingFog;
end;

// �������� � ����� ������ ���������
// ������������� ����, �����������, ������ ����, ���������
// ���������� �����
procedure SettingLights;
const
  // ��������� ���������� �����
  ATTENUATION_NAV=0.1;
  ATTENUATION_MV=0.3;
  EXPONENT=127;
  // ������ ����
  SPOT_CUTOFF_MV=8.0;
  SPOT_CUTOFF_NAV=1.9;
  //��� ����� ���������
  tempLight: Array [0..3] of GLFloat = (0,0,0,1);
  //��������� ������
  posLight0 : Array [0..3] of GLFloat = (75, 25, 25, 1);
  dirLight0 : Array [0..2] of GLFloat = (-0.2, -1, -0.2);

  //��������� ���������
  posFaraI : Array [0..3] of GLFloat = (0, 0.1, 0, 1);
  //����������� ���������
  naprFaraI : Array [0..2] of GLFloat = (0, 0.001, -2);
  //��������� ���� ��
  posFaraMV : Array [0..3] of GLFloat = (0, 0.1, 0, 1);
  //����������� ��������� ��
  naprFarMV : Array [0..2] of GLFloat = (0, -0.2, -2);
begin
  // ��������� ���������
  glEnable(GL_LIGHTING);
  // ������ ��������� (��������� ����� ������ ������������)
  glLightModelf(GL_LIGHT_MODEL_TWO_SIDE, 1);
  // ��������� �����
  //  GL_LIGHT0- ������� �������� ����� ����/����
  glLightfv(GL_LIGHT0, GL_POSITION, @posLight0);
  glLightfv(GL_LIGHT4,GL_SPOT_DIRECTION,@dirLight0);
  //  GL_LIGHT2- ��������� ����
  glLightfv(GL_LIGHT2, GL_AMBIENT, @tempLight);
  // ����� ���� ���������
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
  //  GL_LIGHT5- ���� ����� � 1
  glLightfv(GL_LIGHT5, GL_DIFFUSE, @tempLight);
  glLightfv(GL_LIGHT5, GL_SPECULAR, @tempLight);
  glLightfv(GL_LIGHT5, GL_AMBIENT, @tempLight);

  glLightfv(GL_LIGHT5, GL_POSITION, @posFaraMV);
  glLightf(GL_LIGHT5,GL_SPOT_CUTOFF,SPOT_CUTOFF_MV);
  glLightfv(GL_LIGHT5,GL_SPOT_DIRECTION,@naprFaraI);
  glLightf(GL_LIGHT5,GL_SPOT_EXPONENT, EXPONENT);
  glLightf(GL_LIGHT5,GL_LINEAR_ATTENUATION, ATTENUATION_MV);
  //  GL_LIGHT6- ���� ����� � 2
  glLightfv(GL_LIGHT6, GL_DIFFUSE, @tempLight);
  glLightfv(GL_LIGHT6, GL_SPECULAR, @tempLight);
  glLightfv(GL_LIGHT6, GL_AMBIENT, @tempLight);

  glLightfv(GL_LIGHT6, GL_POSITION, @posFaraMV);
  glLightf(GL_LIGHT6,GL_SPOT_CUTOFF,SPOT_CUTOFF_MV);
  glLightfv(GL_LIGHT6,GL_SPOT_DIRECTION,@naprFaraI);
  glLightf(GL_LIGHT6,GL_SPOT_EXPONENT, EXPONENT);
  glLightf(GL_LIGHT6,GL_LINEAR_ATTENUATION, ATTENUATION_MV);
  //  GL_LIGHT7- ���� ����� � 3
  glLightfv(GL_LIGHT7, GL_DIFFUSE, @tempLight);
  glLightfv(GL_LIGHT7, GL_SPECULAR, @tempLight);
  glLightfv(GL_LIGHT7, GL_AMBIENT, @tempLight);

  glLightfv(GL_LIGHT7, GL_POSITION, @posFaraMV);
  glLightf(GL_LIGHT7,GL_SPOT_CUTOFF,SPOT_CUTOFF_MV);
  glLightfv(GL_LIGHT7,GL_SPOT_DIRECTION,@naprFaraI);
  glLightf(GL_LIGHT7,GL_SPOT_EXPONENT, EXPONENT);
  glLightf(GL_LIGHT7,GL_LINEAR_ATTENUATION, ATTENUATION_MV);
end;

// ��������� �������� ���������
// ����/����,��� ���/����, ���� �� ���/����, ������������� ������ � %
procedure SettingDayLight(timeDay: word; pnv,akt: boolean; intensivFog: word);
const
  colorLight : Array [0..3] of GLFloat = (0,0,0,1);
begin
  // �������� ������� �������� �� ���������� ��������(��>100%)
  if timeDay=0 then timeDay:=DAY;
  if intensivFog>100 then intensivFog:=100;
  pnvColorGreen:=pnv;        // ������� ������, � UnDraw �� � ������ �����
  //======= ���������� ���� ����=========
  case Task.Temp of
    DAY: begin  // ����
      if pnv then begin                // ������� ������
         // ����- ������
         glClearColor(0.4, 0.8, 0.4, 1.0);                           //���� ����
      end
      else begin
        case Task.m_inten_fog of         //  � ����������� �� ������ ������
          0..9: glClearColor(0.5, 0.8, 0.9, 1.0);
          10..19: glClearColor(0.6, 0.8, 0.9, 1.0);
          20..100: glClearColor(0.7, 0.7, 0.7, 1.0);
          else glClearColor(0.7, 0.7, 0.7, 1.0);
        end;
      end;
    end;
    GLOAMING: begin
      case Task.m_inten_fog of         //  � ����������� �� ������ ������
        0: glClearColor(0.1, 0.25, 0.4, 1.0);                           //���� ����
        10: glClearColor(0.2, 0.25, 0.4, 1.0);                           //���� ����
        20..100: glClearColor(0.4, 0.4, 0.4, 1.0);                   //���� ����
        else glClearColor(0.2, 0.25, 0.4, 1.0);
      end;
    end;
    NIGHT: begin
      if pnv then glClearColor(0.1, 0.2, 0.1, 1.0)  // ����- ������, �����
             else glClearColor(skyNight, skyNight, skyNight*2, 1.0);   // ����
    end;
  end;
  //========= ���������� ���� � ���� �������� ���������, ����� ========
  if pnv then begin
    // ������� ���
    // ���������� ��������
    LIGHT_EMMISS_ON[0]:=0; LIGHT_EMMISS_ON[1]:=1; LIGHT_EMMISS_ON[2]:=0;
    // ���� � ������������� ������
    colorLight[0]:=0;
    colorLight[1]:=0.1;
    colorLight[2]:=0;
    glFogfv (GL_FOG_COLOR, @colorLight);
    glFogf (GL_FOG_DENSITY, intensivFog/500);
    if timeDay=DAY then begin
      // ����
      colorLight[0]:=0.7;
      colorLight[1]:=0.7;
      colorLight[2]:=0.7;
      glLightfv(GL_LIGHT0, GL_AMBIENT, @colorLight);
      glLightfv(GL_LIGHT0, GL_DIFFUSE, @colorLight);
      glLightfv(GL_LIGHT0, GL_SPECULAR, @colorLight);
    end
    else begin
      // ����
      colorLight[0]:=0.15;
      colorLight[1]:=0.2;
      colorLight[2]:=0.15;
      glLightfv(GL_LIGHT0, GL_AMBIENT, @colorLight);
      glLightfv(GL_LIGHT0, GL_DIFFUSE, @colorLight);
      glLightfv(GL_LIGHT0, GL_SPECULAR, @colorLight);
    end;
  end
  else begin
    // �������� ���
    // ���������� ��������
    LIGHT_EMMISS_ON[0]:=1; LIGHT_EMMISS_ON[1]:=1; LIGHT_EMMISS_ON[2]:=1;
    if timeDay=DAY then begin
      // ����
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
      // ���� � ������������� ������
      colorLight[0]:=0.7;
      colorLight[1]:=0.7;
      colorLight[2]:=0.7;
      glFogfv (GL_FOG_COLOR, @colorLight);
      glFogf (GL_FOG_DENSITY, intensivFog/5000);
    end
    else begin
      // ����
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
      // ���� � ������������� ������
      colorLight[0]:=0.1;
      colorLight[1]:=0.1;
      colorLight[2]:=0.2;
      glFogfv (GL_FOG_COLOR, @colorLight);
      glFogf (GL_FOG_DENSITY, intensivFog/1000);
    end;
  end;
  // ��������� �� ���� ���������
  if akt and (timeDay=NIGHT) then glEnable(GL_LIGHT4) else  glDisable(GL_LIGHT4);
end;

// ��������� ������� ���� � ���� ������
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
  /// �������� �����
  glEnable(GL_FOG);
  // ��������� ������ ������������� �� ����������
  glFogi (GL_FOG_MODE, GL_EXP);
end;

end.



