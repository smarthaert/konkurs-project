unit UnEffect;

interface
uses
  Windows, Classes, OpenGL, Main, Graphics, SysUtils, UnBuild, UnOther, Math, UnGeom;

const
  COL_MAX_LAYER=20;


type

  EffectClass = class(TObject)
    constructor InitEffect(num: word);
    destructor FreeEffect;
  private
    // ���������� �������� ��������� �������� ���������� ����
    enable: boolean;
    xEffectIni: real;                // ��������� ��������� ����
    hEffectIni: real;
    yEffectIni: real;
    azEffect: real;                  // ��� �������� ����� � �����������
    // ���������� �������� ������� �������� ������� ����
    xEffectTek: array [0..COL_MAX_LAYER] of real;      // ������� ��������� ����
    hEffectTek: array [0..COL_MAX_LAYER] of real;
    yEffectTek: array [0..COL_MAX_LAYER] of real;
    xScaEffectTek: array [0..COL_MAX_LAYER] of real;   // ������� ������ ����
    hScaEffectTek: array [0..COL_MAX_LAYER] of real;
    rotEffectTek: array [0..COL_MAX_LAYER] of real;    // ������� ������� ����
    ScaRandomEffectTek: array [0..COL_MAX_LAYER] of real;   // ������� �������� ������ ����
    rotRandomEffectTek: array [0..COL_MAX_LAYER] of real;    // ������� �������� �������� ����
    matEffectTek: array [0..COL_MAX_LAYER] of real;    // ������� ������������ ����
    procedure InitEffectTDA;
    procedure CountLayers;
    procedure NewLayer(num: word);
    procedure DrawLayers;

  public
    // ���������� �������� ���������� ��������� ��������, ������� �������� ���
    // �������� ���� ���
    colLayer: word;                         // ���������� ����
    indexLayer: word;                       // ������� ����� ������ ����
    timeNewLayer: word;                     // ����� ����� ������ = timeLayer div colLayer
    timeNewLayerTek: word;                  // ����� ����� ������ �������
    xMoveEffect: real;                      // ��������
    hMoveEffect: real;
    yMoveEffect: real;
    xDeltaEffect: real;                     // �������� �����������
    hDeltaEffect: real;
    yDeltaEffect: real;
    xScaDeltaEffectBegin: real;             // �������� ���������� �������
    hScaDeltaEffectBegin: real;
    xScaDeltaEffectEnd: real;
    hScaDeltaEffectEnd: real;
    rotDeltaEffect: real;                    // �������� ��������
    matDeltaEffect: real;                    // �������� ������
    matEffectIni: real;                      // ��������� ������������ ����
    xScaBegin: real;
    xScaEffectIni: real;                     // ��������� ������ ����
    hScaEffectIni: real;
    procedure InitPosition(x, h, y, az: real);
    procedure DrawEffect;
  end;

  var Proba: EffectClass;

implementation

constructor EffectClass.InitEffect(num: word);
begin
  case num of
    1: InitEffectTDA;
  end;
end;

procedure EffectClass.InitEffectTDA;
begin
  // ���������� �������� ���������� ��������� ��������
  xDeltaEffect:=0.00416666663877886+Dym_V_X/2;// ?????;
  hDeltaEffect:=0;
  yDeltaEffect:=4.82077176612841E-7+Dym_V_Y/2;// ?????;
  xScaEffectIni:=0.1;
  hScaEffectIni:=0.1;
  xMoveEffect:=0;
  hMoveEffect:=0;
  yMoveEffect:=0;
  xScaDeltaEffectBegin:=0.06;
  hScaDeltaEffectBegin:=0.05;
  xScaDeltaEffectEnd:=0.015;
  hScaDeltaEffectEnd:=0.012;
  rotDeltaEffect:=1;
  matDeltaEffect:=0.004;
  xScaBegin:=0.9;
  timeNewLayer:=30;
  colLayer:=20;
  matEffectIni:=0.8;
end;

procedure EffectClass.InitPosition(x, h, y, az: real);
begin
  xEffectIni:=x+xMoveEffect;
  hEffectIni:=h+hMoveEffect;
  yEffectIni:=y+yMoveEffect;
  azEffect:=az;
  // ���� ����� ���� ����� �����������, �� ������ �����:
  xDeltaEffect:=Dym_V_X/2;// �����;
  hDeltaEffect:=0;
  yDeltaEffect:=Dym_V_Y/2;// �����;
  CountLayers;
end;

procedure EffectClass.DrawEffect;
begin
  if enable then begin
    glDisable(GL_ALPHA_TEST);
    glDisable(GL_COLOR_MATERIAL);  //��������� ������ ������������ ���������
    DrawLayers;
    glEnable(GL_ALPHA_TEST);
    glEnable(GL_COLOR_MATERIAL);  //��������� ������ ������������ ���������
  end;
end;

procedure EffectClass.CountLayers;
begin
  enable:=true;
  if timeNewLayerTek>0 then begin
    dec(timeNewLayerTek);
  end
  else begin
    timeNewLayerTek:=timeNewLayer-1;
    NewLayer(indexLayer);
    inc(indexLayer);
    if indexLayer>=colLayer then indexLayer:=0;
  end;
end;

procedure EffectClass.NewLayer(num: word);
begin
  matEffectTek[num]:=matEffectIni;      // ������������
  xScaEffectTek[num]:=xScaEffectIni;    // ������
  hScaEffectTek[num]:=hScaEffectIni;
  rotEffectTek[num]:=0;
  xEffectTek[num]:=xEffectIni;          // ���������
  hEffectTek[num]:=hEffectIni;
  yEffectTek[num]:=yEffectIni;

  ScaRandomEffectTek[num]:=0.5+Random;
  rotRandomEffectTek[num]:=Random;
end;

procedure EffectClass.DrawLayers;
const
  mat: array[0..3] of GLFloat=(1,1,1,1);
var
  a: word;
  b: boolean;
begin
  b:=false;
  for a:=0 to colLayer-1 do begin
    matEffectTek[a]:=matEffectTek[a]/(1+matDeltaEffect);
    if matEffectTek[a] > 0.01 then b:=true;
    mat[3]:=matEffectTek[a];
    glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);

    rotEffectTek[a]:=rotEffectTek[a]+rotDeltaEffect;
//    if rotEffectTek[a]>=360 then begin
//      rotEffectTek[a]:=rotEffectTek[a]-360;
//    end;
    if xScaEffectTek[a]<xScaBegin then begin
      xScaEffectTek[a]:=xScaEffectTek[a]+xScaDeltaEffectBegin*ScaRandomEffectTek[a];
      hScaEffectTek[a]:=hScaEffectTek[a]+hScaDeltaEffectBegin*ScaRandomEffectTek[a];
    end
    else begin
      xScaEffectTek[a]:=xScaEffectTek[a]+xScaDeltaEffectEnd*ScaRandomEffectTek[a];
      hScaEffectTek[a]:=hScaEffectTek[a]+hScaDeltaEffectEnd*ScaRandomEffectTek[a];
    end;

    xEffectTek[a]:=xEffectTek[a]+xDeltaEffect;
    hEffectTek[a]:=hEffectTek[a]+hDeltaEffect;
    yEffectTek[a]:=yEffectTek[a]+yDeltaEffect;
   // �������, ���������� � ����������� ����
    glPushMatrix;
      glTranslatef(xEffectTek[a],hEffectTek[a],-yEffectTek[a]);
      glRotatef (-azEffect, 0.0, 1.0, 0.0);  // ������ ������� � �����������
      glScalef(xScaEffectTek[a],hScaEffectTek[a],1);
      glRotatef (-rotEffectTek[a]*rotRandomEffectTek[a], 0.0, 0.0, 1.0);
      glCallList(SPRITE_PYL);
    glPopMatrix;
  end;
  enable:=b;
end;

destructor EffectClass.FreeEffect;
begin
end;

end.
    // ������������� � UnBuild
    Proba:=EffectClass.InitEffect(1);

    // ����� ��������� � UnDraw
    if TDA then Proba.InitPosition(BMP[2].Xtek, BMP[2].Htek, BMP[2].Ytek, az_result);
    Proba.DrawEffect;
    // ����� �������:
    glDepthMask(true);

