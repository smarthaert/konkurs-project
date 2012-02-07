unit UnBuild;

interface

uses
  Windows, dglOpenGL, Main, Graphics, SysUtils, classes, Dialogs, UnBVT,
  UnShader, UnVarConstOpenGL, UnMichen, UnBuildMan,UnBuildTank,
  UnDrawExplos, UnBuildEffect;

  procedure StartOpenGL;
  procedure StopOpenGL;
  procedure MakeLists;

var
  BVT : TBVT;  //�������� ������ ���������

implementation

uses
  UnBuildOpenGL, UnBuildSetting, UnOther, UnBuildBuilding,
   UnBuildPricelBMP2, UnBuildSetka, UnBuildModel,UnBuildSurface, UnBuildTexture;

procedure startOpenGL;
begin
  // ����������� OPEN_GL
  Creat_OpenGL;
  InitVar;
  // ��������� OpenGL
  SettingOpenGL;
  // ��������� �������� ���������
  SettingDayLight(Task.Temp,False,False,10);
  // �������� ������
  BuildShader(Task.Temp, Task.Ceson)   ;
  // �������� ����������� � ������ ���������
  Surface:=SurfaceClass.InitSuface(4001,Task.mestn);
  BVT:=TBVT.Make(ColPatchX, ColPatchY, 8, 40, false, angleVisual*0.75);
  // �������� ������� ��������
  MakeLists;
  // �������� ���������
  SetDimensionDirectris(SUMMER,RAVNINA);
  posH:=posHvis-CountHeight(posX, posY);
  // �������� 3D ��������
    // ��������� ���������� ��� �������� ����
  if Task.m_index<5000 then Build_Mishen;
  BuildModel;
  Build_BMP;
  Build_PTUR;
  BuildBuilding(Task.Ceson,Task.mestn);
  BuildPricel;
  BuildMan;
  InitAnimation;
  Build_Vzryv_PTUR;
  BuildEffect;
end;

procedure StopOpenGL;
begin
  Surface.FreeSurface;
  BVT.Terminate;
  FreeShader;
  Reset_OpenGL;
end;

procedure MakeLists;
var
  a: word;
begin
  // �������� ������ ������� ��������
  SetLength(Mestniks, colPatchSurface+1);
  if TypesOfOrient<>nil then TypesOfOrient.Free;
  TypesOfOrient:=TList.Create;
  for a:=1 to colPatchSurface do  begin
    if Mestniks[a]<>nil then Mestniks[a].Free;
    Mestniks[a]:=TList.Create;
  end;
  if Grand_Mestniks<>nil then Grand_Mestniks.Free;
  Grand_Mestniks:=TList.Create;
end;

end.


