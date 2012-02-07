unit UnReadIni;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IniFiles, UnOther, Main;

const
  NAME_INI='Viewer.ini';

procedure LoadIniTables;

implementation

procedure LoadIniTables;
Var  MemIni:TIniFile;
     IniFileName:string;
     i: integer;
     s: string;
begin
  IniFileName:=(GetCurrentDir+'\'+Name_INI);
  MemIni:=TIniFile.Create(IniFileName);
  with MemIni do begin
    // ������
    s:=ReadString('TARGET_TERRA','BTR_80','N');
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
    // ��������� ����
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

