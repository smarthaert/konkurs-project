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
    // Переменные содержат начальные значения очередного слоя
    enable: boolean;
    xEffectIni: real;                // Начальное положение слоя
    hEffectIni: real;
    yEffectIni: real;
    azEffect: real;                  // для поворота лицом к наблюдателю
    // Переменные содержат текущие значения каждого слоя
    xEffectTek: array [0..COL_MAX_LAYER] of real;      // Текущее положение слоя
    hEffectTek: array [0..COL_MAX_LAYER] of real;
    yEffectTek: array [0..COL_MAX_LAYER] of real;
    xScaEffectTek: array [0..COL_MAX_LAYER] of real;   // Текущий размер слоя
    hScaEffectTek: array [0..COL_MAX_LAYER] of real;
    rotEffectTek: array [0..COL_MAX_LAYER] of real;    // Текущий поворот слоя
    ScaRandomEffectTek: array [0..COL_MAX_LAYER] of real;   // Текущая скорость размер слоя
    rotRandomEffectTek: array [0..COL_MAX_LAYER] of real;    // Текущая скорость поворота слоя
    matEffectTek: array [0..COL_MAX_LAYER] of real;    // Текущая прозрачность слоя
    procedure InitEffectTDA;
    procedure CountLayers;
    procedure NewLayer(num: word);
    procedure DrawLayers;

  public
    // Переменные содержат постоянные начальные значения, которые задаются для
    // эффектов один раз
    colLayer: word;                         // Количество слоёв
    indexLayer: word;                       // Текущий номер нового слоя
    timeNewLayer: word;                     // Время между слоями = timeLayer div colLayer
    timeNewLayerTek: word;                  // Время между слоями текущее
    xMoveEffect: real;                      // Смещение
    hMoveEffect: real;
    yMoveEffect: real;
    xDeltaEffect: real;                     // Скорость перемещения
    hDeltaEffect: real;
    yDeltaEffect: real;
    xScaDeltaEffectBegin: real;             // Скорость нарастания размера
    hScaDeltaEffectBegin: real;
    xScaDeltaEffectEnd: real;
    hScaDeltaEffectEnd: real;
    rotDeltaEffect: real;                    // Скорость вращения
    matDeltaEffect: real;                    // Скорость таяния
    matEffectIni: real;                      // Начальная прозрачность слоя
    xScaBegin: real;
    xScaEffectIni: real;                     // Начальный размер слоя
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
  // Переменные содержат постоянные начальные значения
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
  // Если поток дыма имеет направление, то вектор здесь:
  xDeltaEffect:=Dym_V_X/2;// Ветер;
  hDeltaEffect:=0;
  yDeltaEffect:=Dym_V_Y/2;// Ветер;
  CountLayers;
end;

procedure EffectClass.DrawEffect;
begin
  if enable then begin
    glDisable(GL_ALPHA_TEST);
    glDisable(GL_COLOR_MATERIAL);  //Разрешаем менять прозрачность материала
    DrawLayers;
    glEnable(GL_ALPHA_TEST);
    glEnable(GL_COLOR_MATERIAL);  //Разрешаем менять прозрачность материала
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
  matEffectTek[num]:=matEffectIni;      // Прозрачность
  xScaEffectTek[num]:=xScaEffectIni;    // Размер
  hScaEffectTek[num]:=hScaEffectIni;
  rotEffectTek[num]:=0;
  xEffectTek[num]:=xEffectIni;          // Положение
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
   // Вращаем, перемещаем и увеличиваем пыль
    glPushMatrix;
      glTranslatef(xEffectTek[a],hEffectTek[a],-yEffectTek[a]);
      glRotatef (-azEffect, 0.0, 1.0, 0.0);  // Всегда фронтом к наблюдателю
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
    // Инициализация в UnBuild
    Proba:=EffectClass.InitEffect(1);

    // Вызов размещать в UnDraw
    if TDA then Proba.InitPosition(BMP[2].Xtek, BMP[2].Htek, BMP[2].Ytek, az_result);
    Proba.DrawEffect;
    // Перед строкой:
    glDepthMask(true);

