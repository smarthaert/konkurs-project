unit UnBuildMan;

interface

uses
  UnBuildSetka,
  UnBuildModel3Dmax;

const
  MAX_COL_SOLDIER=30;
  COL_ACTION_MAX=40;        // ���������� ��������
  COL_FRAME_MAX=400;        // ���������� ������
  COL_ELEMENT_MAX=40;       // ���������� ��������� ��������
  COL_MAX_ACTION_ORDER=30;  // ���������� �������� � �������


type
  TVector=record
    x: real;
    y: real;
    z: real;
  end;

  TMan = record
    rotTors:   array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotTaz:    array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotHandR1: array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotHandR2: array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotHandR3: array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotHandL1: array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotHandL2: array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotHandL3: array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotLegR1:  array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotLegR2:  array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotLegL1:  array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotLegL2:  array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotFootR:  array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotFootL:  array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotNeck:   array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotHead:   array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    rotGun:    array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;

    posTors:   array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posTaz:    array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posHandR1: array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posHandR2: array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posHandR3: array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posHandL1: array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posHandL2: array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posHandL3: array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posLegR1:  array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posLegR2:  array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posLegL1:  array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posLegL2:  array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posFootR:  array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posFootL:  array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posNeck:   array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posHead:   array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
    posGun:    array[0..COL_ACTION_MAX,0..COL_FRAME_MAX] of TVector;
  end;

  TAnimaMan=record
    nameFile    : string;
    colAction   : word;
    colVertex   : word;
    colFrame    : array[0..COL_ACTION_MAX+1] of word;
    nameAction  : array[0..COL_ACTION_MAX+1] of string;
    cyklAction  : array[0..COL_ACTION_MAX+1] of boolean;
  end;
  TAnimaElement=record
    position  : TVector;
    rotation  : TVector;
  end;
  TSoldier=record
    tekX        : real;       // ������� ���������
    tekY        : real;
    tekH        : real;
    rotateCenter: real;     // ������� �� �������
    action      : word;     // ��������
    frame       : word;     // ����� �����
    enable      : boolean;
  end;

  procedure InitAnimation;
  procedure LoadAnimationInterpol;
  procedure BuildMan;
  procedure SendAnimation(action, frame: word);
  procedure InitMan;

var
  Soldier       : array[1..MAX_COL_SOLDIER] of TSoldier;
  Man           : TMan;
  AnimaMan      : TAnimaMan;
  AnimaElement  : array[0..COL_ACTION_MAX+1, 0..COL_FRAME_MAX+1, 0..COL_ELEMENT_MAX+1] of TAnimaElement;
  brushLeft     : array[0..COL_ACTION_MAX+1, 0..COL_FRAME_MAX+1] of word;
  brushRight    : array[0..COL_ACTION_MAX+1, 0..COL_FRAME_MAX+1] of word;
  Interpol      : array[0..COL_ACTION_MAX+1] of word;

var
  TORS    : integer;
  HAND_L1 : integer;
  HAND_L2 : integer;
  HAND_L3 : integer;
  HAND_R1 : integer;
  HAND_R2 : integer;
  HAND_R3 : integer;
  LEG_L1  : integer;
  LEG_L2  : integer;
  LEG_R1  : integer;
  LEG_R2  : integer;
  FOOT_L  : integer;
  FOOT_R  : integer;
  NECK    : integer;
  HEAD    : integer;
  TAZ     : integer;
  CENTER  : integer;
  GUN     : integer;

implementation

uses
  UnOther;
procedure InitAnimation;
var
  a : word;
  b : word;
begin
  AnimaMan.nameFile:='res/man/Animation.shp';
  LoadAnimationInterpol;
  for a:=1 to COL_ACTION_MAX do begin
    for b:=1 to COL_FRAME_MAX do begin
      SendAnimation(a, b);
    end;
  end;
  InitMan;
end;

procedure LoadAnimationInterpol;   // �������� �������� �������� ��������
var
  s     : string;
  f     : textfile;
  a,b,c : word;
begin
//  S:=DirBase+AnimaMan.nameFile;
//  AssignFile(F,S);  {���������� ����� � ������}
//  Reset(F);
//  ReadLn(F,AnimaMan.colAction);
//  for a:=1 to AnimaMan.colAction do begin
//    ReadLn(F,AnimaMan.nameAction[a]);
//    ReadLn(F,AnimaMan.colFrame[a]);
//    ReadLn(F,S);
//    if S='TRUE' then AnimaMan.cyklAction[a]:=true
//                else AnimaMan.cyklAction[a]:=false;
 //   for b:=1 to AnimaMan.colFrame[a] do begin
//      ReadLn(F,AnimaMan.colVertex);
//      for c:=1 to AnimaMan.colVertex do begin
//        ReadLn(F,AnimaElement[a][b][c].position.x);
//        ReadLn(F,AnimaElement[a][b][c].position.y);
//        ReadLn(F,AnimaElement[a][b][c].position.z);
//        ReadLn(F,AnimaElement[a][b][c].rotation.x);
//        ReadLn(F,AnimaElement[a][b][c].rotation.y);
//        ReadLn(F,AnimaElement[a][b][c].rotation.z);
//      end;
//      ReadLn(F,brushLeft[a,b]);
//      ReadLn(F,brushRight[a,b]);
//    end;
                //    ReadLn(F, s);
                //    // ���� ���� �������� �������
                //    if AnimaMan.cyklAction[a] then colFrameAll[a]:=Interpol[a]*AnimaMan.colFrame[a]
                //                              else colFrameAll[a]:=Interpol[a]*(AnimaMan.colFrame[a]-1)+1;
//  end;
//  CloseFile(F);
end;

procedure BuildMan;
begin
  MakObject3Dmax('res\man\Tors.shp', TORS);

  MakObject3Dmax('res\man\Hand_L1.shp', HAND_L1);
  MakObject3Dmax('res\man\Hand_L2.shp', HAND_L2);
  MakObject3Dmax('res\man\Hand_L3.shp', HAND_L3);

  MakObject3DMax('res\man\Hand_R1.shp', HAND_R1);
  MakObject3DMax('res\man\Hand_R2.shp', HAND_R2);
  MakObject3DMax('res\man\Hand_R3.shp', HAND_R3);

  MakObject3Dmax('res\man\Leg_L1.shp', LEG_L1);
  MakObject3Dmax('res\man\Leg_L2.shp', LEG_L2);
  MakObject3Dmax('res\man\Foot_L.shp', FOOT_L);
  MakObject3Dmax('res\man\Leg_R1.shp', LEG_R1);
  MakObject3Dmax('res\man\Leg_R2.shp', LEG_R2);
  MakObject3Dmax('res\man\Foot_R.shp', FOOT_R);

  MakObject3Dmax('res\man\Neck2.shp', NECK);
  MakObject3Dmax('res\man\Center.shp', CENTER);
  MakObject3Dmax('res\man\Head.shp', HEAD);
  MakObject3Dmax('res\man\Taz.shp', TAZ);
  MakObject3Dmax('res\man\Gun.shp', GUN);
end;

procedure SendAnimation(action, frame: word);
begin
    man.rotHead[action][frame].x :=AnimaElement[action][frame][1].rotation.x;
    man.rotHead[action][frame].y :=AnimaElement[action][frame][1].rotation.y;
    man.rotHead[action][frame].z :=AnimaElement[action][frame][1].rotation.z;

    man.rotNeck[action][frame].x :=AnimaElement[action][frame][2].rotation.x;
    man.rotNeck[action][frame].y :=AnimaElement[action][frame][2].rotation.y;
    man.rotNeck[action][frame].z :=AnimaElement[action][frame][2].rotation.z;

    man.rotTors[action][frame].x:=AnimaElement[action][frame][3].rotation.x;
    man.rotTors[action][frame].y:=AnimaElement[action][frame][3].rotation.y;
    man.rotTors[action][frame].z:=AnimaElement[action][frame][3].rotation.z;

    man.rotTaz[action][frame].x:=AnimaElement[action][frame][4].rotation.x;
    man.rotTaz[action][frame].y:=AnimaElement[action][frame][4].rotation.y;
    man.rotTaz[action][frame].z:=AnimaElement[action][frame][4].rotation.z;

    man.rotLegL1[action][frame].x:=AnimaElement[action][frame][5].rotation.x;
    man.rotLegL1[action][frame].y:=AnimaElement[action][frame][5].rotation.y;
    man.rotLegL1[action][frame].z:=AnimaElement[action][frame][5].rotation.z;

    man.rotLegR1[action][frame].x:=AnimaElement[action][frame][6].rotation.x;
    man.rotLegR1[action][frame].y:=AnimaElement[action][frame][6].rotation.y;
    man.rotLegR1[action][frame].z:=AnimaElement[action][frame][6].rotation.z;

    man.rotLegL2[action][frame].x:=AnimaElement[action][frame][7].rotation.x;
    man.rotLegL2[action][frame].y:=AnimaElement[action][frame][7].rotation.y;
    man.rotLegL2[action][frame].z:=AnimaElement[action][frame][7].rotation.z;

    man.rotLegR2[action][frame].x:=AnimaElement[action][frame][8].rotation.x;
    man.rotLegR2[action][frame].y:=AnimaElement[action][frame][8].rotation.y;
    man.rotLegR2[action][frame].z:=AnimaElement[action][frame][8].rotation.z;

    man.rotFootL[action][frame].x :=AnimaElement[action][frame][9].rotation.x;
    man.rotFootL[action][frame].y :=AnimaElement[action][frame][9].rotation.y;
    man.rotFootL[action][frame].z :=AnimaElement[action][frame][9].rotation.z;

    man.rotFootR[action][frame].x :=AnimaElement[action][frame][10].rotation.x;
    man.rotFootR[action][frame].y :=AnimaElement[action][frame][10].rotation.y;
    man.rotFootR[action][frame].z :=AnimaElement[action][frame][10].rotation.z;


    man.rotHandL1[action][frame].x:=AnimaElement[action][frame][11].rotation.x;
    man.rotHandL1[action][frame].y:=AnimaElement[action][frame][11].rotation.y;
    man.rotHandL1[action][frame].z:=AnimaElement[action][frame][11].rotation.z;

    man.rotHandR1[action][frame].x:=AnimaElement[action][frame][12].rotation.x;
    man.rotHandR1[action][frame].y:=AnimaElement[action][frame][12].rotation.y;
    man.rotHandR1[action][frame].z:=AnimaElement[action][frame][12].rotation.z;

    man.rotHandL2[action][frame].x:=AnimaElement[action][frame][13].rotation.x;
    man.rotHandL2[action][frame].y:=AnimaElement[action][frame][13].rotation.y;
    man.rotHandL2[action][frame].z:=AnimaElement[action][frame][13].rotation.z;

    man.rotHandR2[action][frame].x:=AnimaElement[action][frame][14].rotation.x;
    man.rotHandR2[action][frame].y:=AnimaElement[action][frame][14].rotation.y;
    man.rotHandR2[action][frame].z:=AnimaElement[action][frame][14].rotation.z;

    man.rotHandL3[action][frame].x:=AnimaElement[action][frame][15].rotation.x;
    man.rotHandL3[action][frame].y:=AnimaElement[action][frame][15].rotation.y;
    man.rotHandL3[action][frame].z:=AnimaElement[action][frame][15].rotation.z;

    man.rotHandR3[action][frame].x:=AnimaElement[action][frame][16].rotation.x;
    man.rotHandR3[action][frame].y:=AnimaElement[action][frame][16].rotation.y;
    man.rotHandR3[action][frame].z:=AnimaElement[action][frame][16].rotation.z;

    //�����
    man.rotGun[action][frame].x:=AnimaElement[action][frame][17].rotation.x;
    man.rotGun[action][frame].y:=AnimaElement[action][frame][17].rotation.y;
    man.rotGun[action][frame].z:=AnimaElement[action][frame][17].rotation.z;

    man.posHead[action][frame].x:=AnimaElement[action][frame][1].position.x;
    man.posHead[action][frame].y:=AnimaElement[action][frame][1].position.y;
    man.posHead[action][frame].z:=AnimaElement[action][frame][1].position.z;

    man.posNeck[action][frame].x:=AnimaElement[action][frame][2].position.x;
    man.posNeck[action][frame].y:=AnimaElement[action][frame][2].position.y;
    man.posNeck[action][frame].z:=AnimaElement[action][frame][2].position.z;

    man.posTors[action][frame].x:=AnimaElement[action][frame][3].position.x;
    man.posTors[action][frame].y:=AnimaElement[action][frame][3].position.y;
    man.posTors[action][frame].z:=AnimaElement[action][frame][3].position.z;

    man.posTaz[action][frame].x:=AnimaElement[action][frame][4].position.x;
    man.posTaz[action][frame].y:=AnimaElement[action][frame][4].position.y;
    man.posTaz[action][frame].z:=AnimaElement[action][frame][4].position.z;

    man.posLegL1[action][frame].x:=AnimaElement[action][frame][5].position.x;
    man.posLegL1[action][frame].y:=AnimaElement[action][frame][5].position.y;
    man.posLegL1[action][frame].z:=AnimaElement[action][frame][5].position.z;

    man.posLegR1[action][frame].x:=AnimaElement[action][frame][6].position.x;
    man.posLegR1[action][frame].y:=AnimaElement[action][frame][6].position.y;
    man.posLegR1[action][frame].z:=AnimaElement[action][frame][6].position.z;

    man.posLegL2[action][frame].x:=AnimaElement[action][frame][7].position.x;
    man.posLegL2[action][frame].y:=AnimaElement[action][frame][7].position.y;
    man.posLegL2[action][frame].z:=AnimaElement[action][frame][7].position.z;

    man.posLegR2[action][frame].x:=AnimaElement[action][frame][8].position.x;
    man.posLegR2[action][frame].y:=AnimaElement[action][frame][8].position.y;
    man.posLegR2[action][frame].z:=AnimaElement[action][frame][8].position.z;

    man.posFootL[action][frame].x:=AnimaElement[action][frame][9].position.x;
    man.posFootL[action][frame].y:=AnimaElement[action][frame][9].position.y;
    man.posFootL[action][frame].z:=AnimaElement[action][frame][9].position.z;

    man.posFootR[action][frame].x:=AnimaElement[action][frame][10].position.x;
    man.posFootR[action][frame].y:=AnimaElement[action][frame][10].position.y;
    man.posFootR[action][frame].z:=AnimaElement[action][frame][10].position.z;

    man.posHandL1[action][frame].x:=AnimaElement[action][frame][11].position.x;
    man.posHandL1[action][frame].y:=AnimaElement[action][frame][11].position.y;
    man.posHandL1[action][frame].z:=AnimaElement[action][frame][11].position.z;

    man.posHandR1[action][frame].x:=AnimaElement[action][frame][12].position.x;
    man.posHandR1[action][frame].y:=AnimaElement[action][frame][12].position.y;
    man.posHandR1[action][frame].z:=AnimaElement[action][frame][12].position.z;

    man.posHandL2[action][frame].x:=AnimaElement[action][frame][13].position.x;
    man.posHandL2[action][frame].y:=AnimaElement[action][frame][13].position.y;
    man.posHandL2[action][frame].z:=AnimaElement[action][frame][13].position.z;

    man.posHandR2[action][frame].x:=AnimaElement[action][frame][14].position.x;
    man.posHandR2[action][frame].y:=AnimaElement[action][frame][14].position.y;
    man.posHandR2[action][frame].z:=AnimaElement[action][frame][14].position.z;

    man.posHandL3[action][frame].x:=AnimaElement[action][frame][15].position.x;
    man.posHandL3[action][frame].y:=AnimaElement[action][frame][15].position.y;
    man.posHandL3[action][frame].z:=AnimaElement[action][frame][15].position.z;

    man.posHandR3[action][frame].x:=AnimaElement[action][frame][16].position.x;
    man.posHandR3[action][frame].y:=AnimaElement[action][frame][16].position.y;
    man.posHandR3[action][frame].z:=AnimaElement[action][frame][16].position.z;

    //�����
    man.posGun[action][frame].x:=AnimaElement[action][frame][17].position.x;
    man.posGun[action][frame].y:=AnimaElement[action][frame][17].position.y;
    man.posGun[action][frame].z:=AnimaElement[action][frame][17].position.z;
end;

procedure InitMan;
var
  a: word;
begin
  for a:=1 to 2 do begin
    Soldier[a].tekX:=37+a;
    Soldier[a].tekY:=20;
    Soldier[a].tekH:=CountHeight(Soldier[a].tekX, Soldier[a].tekY);
    Soldier[a].frame:=a;
    Soldier[a].action:=2;
    Soldier[a].enable:=true;
  end;
end;
end.

