unit UnReadIni;  //Чтение из ини файла и формирование констант для дальнейшей работы

interface

uses
  Windows, Messages,
  SysUtils, Classes,
  Graphics, Controls,
  Forms, Dialogs,
  IniFiles, UnOther,
  Main;

const
  NAME_INI='Viewer.ini';

procedure LoadIniTables;

implementation

procedure LoadIniTables;
Var
      MemIni      : TIniFile;
      IniFileName : string;
      i           : integer;
      s           : string;
begin
  IniFileName :=  (GetCurrentDir+'\'+Name_INI);
  MemIni      :=  TIniFile.Create(IniFileName);

  with MemIni do begin
    
    s:=ReadString('TARGET_TERRA','BTR_80','N');                         // Формирование допустимых в тренировке моделей 
    if (s='Y') or (s='y') then Task.enableModel[MODEL_BTR80]:=true
                          else Task.enableModel[MODEL_BTR80]:=false;
    s:=ReadString('TARGET_TERRA','BMP_1','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_BMP1]:=true
                          else Task.enableModel[MODEL_BMP1]:=false;
    s:=ReadString('TARGET_TERRA','BMP_2','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_BMP2]:=true
                          else Task.enableModel[MODEL_BMP2]:=false;
    s:=ReadString('TARGET_TERRA','T_55','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_T55]:=true
                          else Task.enableModel[MODEL_T55]:=false;
    s:=ReadString('TARGET_TERRA','T_72','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_T72]:=true
                          else Task.enableModel[MODEL_T72]:=false;
    s:=ReadString('TARGET_TERRA','T_80','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_T80]:=true
                          else Task.enableModel[MODEL_T80]:=false;
    s:=ReadString('TARGET_TERRA','T_90','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_T90]:=true
                          else Task.enableModel[MODEL_T90]:=false;
    s:=ReadString('TARGET_TERRA','M_113','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_M113]:=true
                          else Task.enableModel[MODEL_M113]:=false;
    s:=ReadString('TARGET_TERRA','M_2','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_M2]:=true
                          else Task.enableModel[MODEL_M2]:=false;
    s:=ReadString('TARGET_TERRA','LEOPARD','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_LEOPARD]:=true
                          else Task.enableModel[MODEL_LEOPARD]:=false;
    s:=ReadString('TARGET_TERRA','M_1A1','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_M1A1]:=true
                          else Task.enableModel[MODEL_M1A1]:=false;
    s:=ReadString('TARGET_TERRA','M_48','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_M48]:=true
                          else Task.enableModel[MODEL_M48]:=false;
    s:=ReadString('TARGET_TERRA','T_84','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_T84]:=true
                          else Task.enableModel[MODEL_T84]:=false;
    s:=ReadString('TARGET_TERRA','VJAYANTA','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_VJAYANTA]:=true
                          else Task.enableModel[MODEL_VJAYANTA]:=false;
    s:=ReadString('TARGET_TERRA','ARJUN','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_ARJUN]:=true
                          else Task.enableModel[MODEL_ARJUN]:=false;
    s:=ReadString('TARGET_TERRA','T_59','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_T59]:=true
                          else Task.enableModel[MODEL_T59]:=false;
    s:=ReadString('TARGET_TERRA','T_69','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_T69]:=true
                          else Task.enableModel[MODEL_T69]:=false;
    s:=ReadString('TARGET_TERRA','BUNKER','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_BUNKER]:=true
                          else Task.enableModel[MODEL_BUNKER]:=false;
    s:=ReadString('TARGET_TERRA','KAMAZ','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_KAMAZ]:=true
                          else Task.enableModel[MODEL_KAMAZ]:=false;
    s:=ReadString('TARGET_TERRA','UAZ_469','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_UAZ469]:=true
                          else Task.enableModel[MODEL_UAZ469]:=false;
    // воздушные цели
    s:=ReadString('TARGET_AIR','SAPSAN','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_SAPSAN]:=true
                          else Task.enableModel[MODEL_SAPSAN]:=false;
    s:=ReadString('TARGET_AIR','APACH','N');
    if (s='Y') or (s='y') then Task.enableModel[MODEL_APACH]:=true
                          else Task.enableModel[MODEL_APACH]:=false;
  end;
  MemIni.free;
end;

end.
{
Содержание файла  'Viewer.ini'
[MAIN]
NUM_EKIP=2
NUM_RM=0
MONITOR_ROTATION=N  
ZERKALO=N  
ZERKALO_VERT=N  
MOVE_X=0  
MOVE_Y=-100  

[NIGHT]
SURFACE=30
SKY=5

[TARGET_TERRA]
BTR_80=Y
BMP_1=Y
BMP_2=Y
T_55=Y
T_72=Y
T_80=Y
T_90=Y
M_113=N
M_2=N
LEOPARD=N
M_1A1=N
M_48=N
T_84=N
VJAYANTA=N
ARJUN=N
T_59=N
T_69=N
BUNKER=N
KAMAZ=N
UAZ_469=N

[TARGET_AIR]
SAPSAN=N
APACH=N


; 0  Руководитель
; 1  Наводчик-БПК
; 2  Наводчик-9Ш113
; 3  Командир-1ПЗ-3
; 4  Командир-ТКН
; 5   Мех  
; 7  Наводчик- Дополнительный
; 8  Командир- Дополнительный
 }
