unit UnReadIni;

interface

uses
  Windows, Messages,
  SysUtils, Classes,
  Graphics, Controls,
  Forms, Dialogs,
  IniFiles, UnOther;

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
    num_BMP :=  ReadInteger('MAIN','NUM_EKIP',2);
  end;
  MemIni.free;
end;

end.

{ Содержание файла  Viewer.ini
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
